import Link from "next/link";
import { getCourses } from "@/lib/content";
import { getSubjects } from "@/lib/content";

const basePath = "/Ambiental";

export default function HomePage() {
  const courses = getCourses();

  return (
    <>
      <section className="bg-gradient-to-b from-moss-100/60 to-white py-16 md:py-24 px-4">
        <div className="max-w-4xl mx-auto text-center">
          <h1 className="text-3xl md:text-5xl font-bold text-moss-800 text-balance leading-tight">
            Portal BTCA
          </h1>
          <p className="text-lg md:text-xl text-moss-600 mt-4 max-w-2xl mx-auto text-balance">
            Bachillerato Técnico en Ciencias Ambientales del MEC de Paraguay.
            Contenido educativo organizado por cursos, asignaturas, unidades y lecciones.
          </p>
          <div className="flex flex-wrap gap-3 justify-center mt-8">
            <Link href={`${basePath}/cursos`} className="btn-primary">
              Explorar cursos
            </Link>
            <Link href={`${basePath}/mapa-web`} className="btn-ghost">
              Mapa del sitio
            </Link>
          </div>
        </div>
      </section>

      <section className="max-w-6xl mx-auto px-4 md:px-6 py-12 md:py-16">
        <h2 className="text-2xl md:text-3xl font-bold text-moss-800 text-center mb-10">Cursos</h2>
        <div className="grid gap-6 md:grid-cols-3">
          {courses.map((course) => {
            const subjects = getSubjects(course.slug);
            return (
              <Link
                key={course.slug}
                href={`${basePath}/cursos/${course.slug}`}
                className="card group block"
              >
                <span className="badge bg-moss-100 text-moss-700 mb-3">
                  {subjects.length} asignaturas
                </span>
                <h3 className="text-xl font-bold text-moss-800 group-hover:text-moss-600 transition-colors">
                  {course.title}
                </h3>
                <p className="text-moss-600 mt-2 text-sm leading-relaxed">{course.description}</p>
                <span className="inline-block mt-4 text-sm font-medium text-lagoon-600 group-hover:text-lagoon-700">
                  Ver asignaturas &rarr;
                </span>
              </Link>
            );
          })}
        </div>
      </section>

      <section className="bg-moss-50 py-12 md:py-16 px-4">
        <div className="max-w-4xl mx-auto">
          <h2 className="text-2xl md:text-3xl font-bold text-moss-800 text-center mb-8">Criterio pedagógico</h2>
          <div className="grid gap-4 md:grid-cols-3 text-center">
            {[
              { icon: "🔍", label: "Aprendizaje visual" },
              { icon: "🤝", label: "Aprendizaje activo" },
              { icon: "🌿", label: "Proyectos ambientales" },
              { icon: "🏘️", label: "Relación con la comunidad" },
              { icon: "🇵🇾", label: "Ejemplos situados en Paraguay" },
            ].map((item) => (
              <div key={item.label} className="card text-center py-6">
                <span className="text-2xl">{item.icon}</span>
                <p className="text-moss-700 font-medium mt-2">{item.label}</p>
              </div>
            ))}
          </div>
        </div>
      </section>
    </>
  );
}
