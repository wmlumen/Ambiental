import fs from "node:fs";
import path from "node:path";
import matter from "gray-matter";

export interface CourseMeta {
  slug: string;
  title: string;
  description: string;
  order: number;
}

export interface SubjectMeta {
  slug: string;
  title: string;
  description: string;
  order: number;
  competencies: string[];
  capacities: string[];
  profileRelation: string[];
  courseSlug: string;
  courseTitle: string;
}

export interface UnitMeta {
  slug: string;
  title: string;
  order: number;
  subjectSlug: string;
  courseSlug: string;
}

export interface LessonMeta {
  slug: string;
  title: string;
  description: string;
  unitTitle: string;
  unitDescription: string;
  unitOrder: number;
  lessonOrder: number;
  topics: string[];
  content: string;
}

const contentDir = path.resolve(process.cwd(), "content");

const COURSES: CourseMeta[] = [
  { slug: "primer-curso", title: "Primer Curso", description: "Fundamentos de ciencias ambientales, agroecología, meteorología y administración ambiental.", order: 1 },
  { slug: "segundo-curso", title: "Segundo Curso", description: "Profundización en educación ambiental, agroecología aplicada, meteorología, biología y administración.", order: 2 },
  { slug: "tercer-curso", title: "Tercer Curso", description: "Gestión ambiental, recursos naturales, evaluación de impacto y proyecto ambiental integrador.", order: 3 },
];

export function getCourses(): CourseMeta[] {
  return COURSES;
}

export function getCourse(slug: string): CourseMeta | null {
  return COURSES.find((c) => c.slug === slug) ?? null;
}

export function getSubjects(courseSlug: string): SubjectMeta[] {
  const courseDir = path.join(contentDir, courseSlug);
  if (!fs.existsSync(courseDir)) return [];
  const entries = fs.readdirSync(courseDir, { withFileTypes: true });
  const subjects: SubjectMeta[] = [];
  const course = getCourse(courseSlug);
  for (const entry of entries) {
    if (!entry.isDirectory()) continue;
    const indexPath = path.join(courseDir, entry.name, "index.md");
    if (!fs.existsSync(indexPath)) continue;
    const raw = fs.readFileSync(indexPath, "utf-8");
    const { data } = matter(raw);
    subjects.push({
      slug: entry.name,
      title: data.title ?? entry.name,
      description: data.description ?? "",
      order: data.order ?? 99,
      competencies: data.competencies ?? [],
      capacities: data.capacities ?? [],
      profileRelation: data.profileRelation ?? [],
      courseSlug,
      courseTitle: course?.title ?? courseSlug,
    });
  }
  subjects.sort((a, b) => a.order - b.order);
  return subjects;
}

export function getSubject(courseSlug: string, subjectSlug: string): SubjectMeta | null {
  return getSubjects(courseSlug).find((s) => s.slug === subjectSlug) ?? null;
}

export function getUnits(courseSlug: string, subjectSlug: string): UnitMeta[] {
  const subjectDir = path.join(contentDir, courseSlug, subjectSlug);
  if (!fs.existsSync(subjectDir)) return [];
  const entries = fs.readdirSync(subjectDir, { withFileTypes: true });
  const units: UnitMeta[] = [];
  for (const entry of entries) {
    if (!entry.isDirectory()) continue;
    const lessonFiles = fs.readdirSync(path.join(subjectDir, entry.name)).filter((f) => f.endsWith(".md"));
    if (lessonFiles.length === 0) continue;
    const firstLesson = path.join(subjectDir, entry.name, lessonFiles[0]);
    const raw = fs.readFileSync(firstLesson, "utf-8");
    const { data } = matter(raw);
    units.push({
      slug: entry.name,
      title: data.unitTitle ?? entry.name,
      order: data.unitOrder ?? 99,
      subjectSlug,
      courseSlug,
    });
  }
  units.sort((a, b) => a.order - b.order);
  return units;
}

export function getLessons(courseSlug: string, subjectSlug: string, unitSlug: string): LessonMeta[] {
  const unitDir = path.join(contentDir, courseSlug, subjectSlug, unitSlug);
  if (!fs.existsSync(unitDir)) return [];
  const entries = fs.readdirSync(unitDir).filter((f) => f.endsWith(".md"));
  const lessons: LessonMeta[] = [];
  for (const entry of entries) {
    const raw = fs.readFileSync(path.join(unitDir, entry), "utf-8");
    const { data, content } = matter(raw);
    const slug = entry.replace(/\.md$/, "");
    lessons.push({
      slug,
      title: data.title ?? slug,
      description: data.description ?? "",
      unitTitle: data.unitTitle ?? "",
      unitDescription: data.unitDescription ?? "",
      unitOrder: data.unitOrder ?? 0,
      lessonOrder: data.lessonOrder ?? 0,
      topics: Array.isArray(data.topics) ? data.topics : [],
      content,
    });
  }
  lessons.sort((a, b) => a.lessonOrder - b.lessonOrder);
  return lessons;
}

export function getLesson(courseSlug: string, subjectSlug: string, unitSlug: string, lessonSlug: string): LessonMeta | null {
  return getLessons(courseSlug, subjectSlug, unitSlug).find((l) => l.slug === lessonSlug) ?? null;
}

export function getAllLessons(): { courseSlug: string; courseTitle: string; subjectSlug: string; subjectTitle: string; unitSlug: string; unitTitle: string; lessonSlug: string; lessonTitle: string }[] {
  const result: ReturnType<typeof getAllLessons> = [];
  for (const course of COURSES) {
    const subjects = getSubjects(course.slug);
    for (const subject of subjects) {
      const units = getUnits(course.slug, subject.slug);
      for (const unit of units) {
        const lessons = getLessons(course.slug, subject.slug, unit.slug);
        for (const lesson of lessons) {
          result.push({
            courseSlug: course.slug,
            courseTitle: course.title,
            subjectSlug: subject.slug,
            subjectTitle: subject.title,
            unitSlug: unit.slug,
            unitTitle: unit.title,
            lessonSlug: lesson.slug,
            lessonTitle: lesson.title,
          });
        }
      }
    }
  }
  return result;
}

export function cleanUnitTitle(title: string): string {
  return title.replace(/^Unidad\s+\d+\s*\|\s*/, "");
}

export function cleanLessonTitle(title: string): string {
  return title.replace(/^Unidad\s+\d+\s*\|[^|]+\|\s*/, "");
}
