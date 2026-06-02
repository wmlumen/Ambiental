import Link from "next/link";
import { getCourses, getSubjects } from "@/lib/content";
import { basePath } from "@/lib/paths";

export default function CursosPage() {
  const courses = getCourses();

  return (
    <div className="max-w-6xl mx-auto px-4 md:px-6 py-12 md:py-16">
      <nav className="text-sm text-moss-500 mb-8">
        <Link href={`${basePath}/`} className="breadcrumb-link">Inicio</Link>
        <span className="mx-2">/</span>
        <span className="text-moss-700 font-medium">Cursos</span>
      </nav>

      <h1 className="text-3xl md:text-4xl font-bold text-moss-800 mb-4">Cursos</h1>
      <p className="text-moss-600 text-lg mb-10 max-w-2xl">
        El Bachillerato Técnico en Ciencias Ambientales se organiza en tres cursos. Cada uno integra asignaturas teóricas, aplicadas y de proyecto.
      </p>

      <div className="space-y-8">
        {courses.map((course) => {
          const subjects = getSubjects(course.slug);
          return (
            <div key={course.slug} className="card">
              <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4 mb-6">
                <div>
                  <h2 className="text-2xl font-bold text-moss-800">{course.title}</h2>
                  <p className="text-moss-600 mt-1">{course.description}</p>
                </div>
                <span className="badge bg-moss-100 text-moss-700 shrink-0">
                  {subjects.length} asignaturas
                </span>
              </div>
              {subjects.length > 0 ? (
                <div className="grid gap-3 md:grid-cols-2 lg:grid-cols-3">
                  {subjects.map((subject) => (
                    <Link
                      key={subject.slug}
                      href={`${basePath}/cursos/${course.slug}/${subject.slug}`}
                      className="block p-4 rounded-xl bg-moss-50 hover:bg-moss-100 transition-colors border border-transparent hover:border-moss-200"
                    >
                      <span className="text-xs text-moss-500 font-mono">
                        {String(subject.order).padStart(2, "0")}
                      </span>
                      <h3 className="font-semibold text-moss-800 mt-1">{subject.title}</h3>
                      <p className="text-xs text-moss-600 mt-1 line-clamp-2">{subject.description}</p>
                    </Link>
                  ))}
                </div>
              ) : (
                <p className="text-moss-500 text-sm">Contenido en preparación.</p>
              )}
            </div>
          );
        })}
      </div>
    </div>
  );
}
