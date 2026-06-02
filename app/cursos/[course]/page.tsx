import Link from "next/link";
import { notFound } from "next/navigation";
import { getCourse, getCourses, getSubjects } from "@/lib/content";

const basePath = "/Ambiental";

export function generateStaticParams() {
  return getCourses().map((c) => ({ course: c.slug }));
}

export default async function CoursePage({ params }: { params: Promise<{ course: string }> }) {
  const { course: courseSlug } = await params;
  const course = getCourse(courseSlug);
  if (!course) notFound();

  const subjects = getSubjects(course.slug);

  return (
    <div className="max-w-6xl mx-auto px-4 md:px-6 py-12 md:py-16">
      <nav className="text-sm text-moss-500 mb-8">
        <Link href={`${basePath}/`} className="breadcrumb-link">Inicio</Link>
        <span className="mx-2">/</span>
        <Link href={`${basePath}/cursos`} className="breadcrumb-link">Cursos</Link>
        <span className="mx-2">/</span>
        <span className="text-moss-700 font-medium">{course.title}</span>
      </nav>

      <h1 className="text-3xl md:text-4xl font-bold text-moss-800 mb-4">{course.title}</h1>
      <p className="text-moss-600 text-lg mb-10 max-w-2xl">{course.description}</p>

      {subjects.length > 0 ? (
        <div className="grid gap-6 md:grid-cols-2">
          {subjects.map((subject) => (
            <Link
              key={subject.slug}
              href={`${basePath}/cursos/${course.slug}/${subject.slug}`}
              className="card group block"
            >
              <span className="text-xs text-moss-500 font-mono">
                Asignatura {String(subject.order).padStart(2, "0")}
              </span>
              <h2 className="text-xl font-bold text-moss-800 mt-2 group-hover:text-moss-600 transition-colors">
                {subject.title}
              </h2>
              <p className="text-moss-600 mt-2 text-sm leading-relaxed">{subject.description}</p>
              <span className="inline-block mt-4 text-sm font-medium text-lagoon-600 group-hover:text-lagoon-700">
                Ver unidades &rarr;
              </span>
            </Link>
          ))}
        </div>
      ) : (
        <div className="card text-center py-12">
          <p className="text-moss-500">Contenido en preparación para este curso.</p>
        </div>
      )}
    </div>
  );
}
