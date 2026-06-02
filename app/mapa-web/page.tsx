import Link from "next/link";
import { getCourses, getSubjects, getUnits, getLessons } from "@/lib/content";

const basePath = "/Ambiental";

export default function MapaWebPage() {
  const courses = getCourses();

  return (
    <div className="max-w-5xl mx-auto px-4 md:px-6 py-12 md:py-16">
      <nav className="text-sm text-moss-500 mb-8">
        <Link href={`${basePath}/`} className="breadcrumb-link">Inicio</Link>
        <span className="mx-2">/</span>
        <span className="text-moss-700 font-medium">Mapa del sitio</span>
      </nav>

      <h1 className="text-3xl md:text-4xl font-bold text-moss-800 mb-4">Mapa del sitio</h1>
      <p className="text-moss-600 mb-10 max-w-2xl">
        Estructura completa del portal. Cada lección contiene dos microlecciones: una de fundamentos y otra de aplicación y proyecto.
      </p>

      <div className="space-y-10">
        {courses.map((course) => {
          const subjects = getSubjects(course.slug);
          return (
            <div key={course.slug}>
              <h2 className="text-2xl font-bold text-moss-800 pb-3 border-b border-moss-200">
                {course.title}
              </h2>
              <div className="mt-4 space-y-6">
                {subjects.map((subject) => {
                  const units = getUnits(course.slug, subject.slug);
                  return (
                    <div key={subject.slug} className="ml-4">
                      <h3 className="text-lg font-semibold text-moss-700 mt-4 mb-2">
                        <Link href={`${basePath}/cursos/${course.slug}/${subject.slug}`} className="hover:text-lagoon-600 transition-colors">
                          {subject.title}
                        </Link>
                      </h3>
                      <ul className="space-y-1 ml-4 border-l-2 border-moss-100 pl-4">
                        {units.map((unit) => {
                          const lessons = getLessons(course.slug, subject.slug, unit.slug);
                          return (
                            <li key={unit.slug}>
                              <span className="text-sm font-medium text-moss-800">
                                {unit.title}
                              </span>
                              <ul className="ml-4 space-y-0.5">
                                {lessons.map((lesson) => (
                                  <li key={lesson.slug}>
                                    <Link
                                      href={`${basePath}/cursos/${course.slug}/${subject.slug}/${unit.slug}/${lesson.slug}`}
                                      className="text-xs text-lagoon-600 hover:text-lagoon-700"
                                    >
                                      {lesson.title}
                                    </Link>
                                  </li>
                                ))}
                              </ul>
                            </li>
                          );
                        })}
                      </ul>
                    </div>
                  );
                })}
              </div>
            </div>
          );
        })}
      </div>
    </div>
  );
}
