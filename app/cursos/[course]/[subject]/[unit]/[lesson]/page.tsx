import Link from "next/link";
import { notFound } from "next/navigation";
import ReactMarkdown from "react-markdown";
import remarkGfm from "remark-gfm";
import { getAllLessons, getLesson, getSubject, getUnits, cleanUnitTitle } from "@/lib/content";
import { basePath } from "@/lib/paths";

export function generateStaticParams() {
  return getAllLessons().map((l) => ({
    course: l.courseSlug,
    subject: l.subjectSlug,
    unit: l.unitSlug,
    lesson: l.lessonSlug,
  }));
}

export default async function LessonPage({ params }: { params: Promise<{ course: string; subject: string; unit: string; lesson: string }> }) {
  const { course, subject: subjectSlug, unit, lesson: lessonSlug } = await params;
  const lesson = getLesson(course, subjectSlug, unit, lessonSlug);
  if (!lesson) notFound();

  const subjectData = getSubject(course, subjectSlug);
  const units = getUnits(course, subjectSlug);
  const currentUnitIdx = units.findIndex((u) => u.slug === unit);
  const prevUnit = currentUnitIdx > 0 ? units[currentUnitIdx - 1] : null;
  const nextUnit = currentUnitIdx < units.length - 1 ? units[currentUnitIdx + 1] : null;

  const isLesson1 = lessonSlug === "leccion-01-fundamentos";
  const otherLesson = isLesson1 ? "leccion-02-aplicacion" : "leccion-01-fundamentos";
  const otherLessonLabel = isLesson1 ? "Lección 2: Aplicación" : "Lección 1: Fundamentos";

  const contentWithoutH1 = lesson.content.replace(/^#\s+.*\n+/, "");

  return (
    <div className="max-w-4xl mx-auto px-4 md:px-6 py-12 md:py-16">
      <nav className="text-sm text-moss-500 mb-8 flex flex-wrap gap-x-2 gap-y-1">
        <Link href={`${basePath}/`} className="breadcrumb-link">Inicio</Link>
        <span>/</span>
        <Link href={`${basePath}/cursos`} className="breadcrumb-link">Cursos</Link>
        <span>/</span>
        <Link href={`${basePath}/cursos/${course}`} className="breadcrumb-link">{subjectData?.courseTitle ?? course}</Link>
        <span>/</span>
        <Link href={`${basePath}/cursos/${course}/${subjectSlug}`} className="breadcrumb-link">{subjectData?.title ?? subjectSlug}</Link>
      </nav>

      <article>
        <header className="mb-8">
          <div className="flex flex-wrap items-center gap-3 mb-3">
            <span className="badge bg-lagoon-100 text-lagoon-700">
              {lesson.unitTitle}
            </span>
            <span className="badge bg-moss-100 text-moss-700">
              {lesson.lessonOrder === 1 ? "Fundamentos" : "Aplicación y proyecto"}
            </span>
          </div>
          <h1 className="text-3xl md:text-4xl font-bold text-moss-800">{lesson.title}</h1>
          <p className="text-moss-600 mt-3 text-lg">{lesson.description}</p>
        </header>

        <div className="flex flex-wrap gap-2 mb-8">
          {lesson.topics.map((t, i) => (
            <span key={i} className="badge bg-moss-50 text-moss-600 border border-moss-200">{t}</span>
          ))}
        </div>

        <div className="prose-content">
          <ReactMarkdown remarkPlugins={[remarkGfm]}>
            {contentWithoutH1}
          </ReactMarkdown>
        </div>

        <div className="flex gap-2 mt-8">
          <Link
            href={`${basePath}/cursos/${course}/${subjectSlug}/${unit}/${otherLesson}`}
            className="btn-ghost text-sm"
          >
            {otherLessonLabel}
          </Link>
        </div>

        <nav className="mt-8 pt-6 border-t border-moss-200 flex flex-col sm:flex-row justify-between gap-4">
          {prevUnit ? (
            <Link
              href={`${basePath}/cursos/${course}/${subjectSlug}/${prevUnit.slug}/leccion-02-aplicacion`}
              className="text-sm text-lagoon-600 hover:text-lagoon-700 flex items-center gap-1"
            >
              &larr; {cleanUnitTitle(prevUnit.title)}
            </Link>
          ) : (
            <span />
          )}
          {nextUnit ? (
            <Link
              href={`${basePath}/cursos/${course}/${subjectSlug}/${nextUnit.slug}/leccion-01-fundamentos`}
              className="text-sm text-lagoon-600 hover:text-lagoon-700 flex items-center gap-1"
            >
              {cleanUnitTitle(nextUnit.title)} &rarr;
            </Link>
          ) : (
            <span />
          )}
        </nav>
      </article>
    </div>
  );
}
