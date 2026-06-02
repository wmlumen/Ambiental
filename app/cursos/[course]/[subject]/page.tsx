import Link from "next/link";
import { notFound } from "next/navigation";
import { getCourses, getSubject, getSubjects, getUnits, cleanUnitTitle } from "@/lib/content";
import { basePath } from "@/lib/paths";

export function generateStaticParams() {
  const params: { course: string; subject: string }[] = [];
  for (const course of getCourses()) {
    for (const subject of getSubjects(course.slug)) {
      params.push({ course: course.slug, subject: subject.slug });
    }
  }
  return params;
}

export default async function SubjectPage({ params }: { params: Promise<{ course: string; subject: string }> }) {
  const { course, subject: subjectSlug } = await params;
  const subject = getSubject(course, subjectSlug);
  if (!subject) notFound();

  const units = getUnits(subject.courseSlug, subject.slug);

  return (
    <div className="max-w-6xl mx-auto px-4 md:px-6 py-12 md:py-16">
      <nav className="text-sm text-moss-500 mb-8">
        <Link href={`${basePath}/`} className="breadcrumb-link">Inicio</Link>
        <span className="mx-2">/</span>
        <Link href={`${basePath}/cursos`} className="breadcrumb-link">Cursos</Link>
        <span className="mx-2">/</span>
        <Link href={`${basePath}/cursos/${subject.courseSlug}`} className="breadcrumb-link">{subject.courseTitle}</Link>
        <span className="mx-2">/</span>
        <span className="text-moss-700 font-medium">{subject.title}</span>
      </nav>

      <header className="mb-10">
        <span className="text-xs text-moss-500 font-mono">Asignatura {String(subject.order).padStart(2, "0")}</span>
        <h1 className="text-3xl md:text-4xl font-bold text-moss-800 mt-2">{subject.title}</h1>
        <p className="text-moss-600 text-lg mt-3 max-w-3xl">{subject.description}</p>
      </header>

      <div className="grid gap-8 md:grid-cols-2">
        <div>
          <h2 className="text-xl font-bold text-moss-800 mb-4">Unidades didácticas</h2>
          {units.length > 0 ? (
            <div className="space-y-3">
              {units.map((unit) => (
                <div key={unit.slug} className="card py-4 px-5">
                  <span className="text-xs text-moss-500 font-medium">Unidad {unit.order}</span>
                  <h3 className="font-semibold text-moss-800 mt-1">{unit.title}</h3>
                  <div className="flex gap-2 mt-3">
                    <Link
                      href={`${basePath}/cursos/${subject.courseSlug}/${subject.slug}/${unit.slug}/leccion-01-fundamentos`}
                      className="text-xs font-medium text-lagoon-600 hover:text-lagoon-700"
                    >
                      Lección 1: Fundamentos
                    </Link>
                    <span className="text-moss-300">|</span>
                    <Link
                      href={`${basePath}/cursos/${subject.courseSlug}/${subject.slug}/${unit.slug}/leccion-02-aplicacion`}
                      className="text-xs font-medium text-lagoon-600 hover:text-lagoon-700"
                    >
                      Lección 2: Aplicación
                    </Link>
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-moss-500 text-sm">Unidades en preparación.</p>
          )}
        </div>

        <div className="space-y-6">
          {subject.competencies.length > 0 && (
            <div className="card">
              <h3 className="font-bold text-moss-800 mb-3">Competencias</h3>
              <ul className="space-y-1.5">
                {subject.competencies.map((c, i) => (
                  <li key={i} className="text-sm text-moss-700 flex gap-2">
                    <span className="text-lagoon-500 shrink-0">&bull;</span>
                    {c}
                  </li>
                ))}
              </ul>
            </div>
          )}
          {subject.capacities.length > 0 && (
            <div className="card">
              <h3 className="font-bold text-moss-800 mb-3">Capacidades</h3>
              <ul className="space-y-1.5">
                {subject.capacities.map((c, i) => (
                  <li key={i} className="text-sm text-moss-700 flex gap-2">
                    <span className="text-clay-500 shrink-0">&bull;</span>
                    {c}
                  </li>
                ))}
              </ul>
            </div>
          )}
          {subject.profileRelation.length > 0 && (
            <div className="card">
              <h3 className="font-bold text-moss-800 mb-3">Perfil de egreso</h3>
              <ul className="space-y-1.5">
                {subject.profileRelation.map((p, i) => (
                  <li key={i} className="text-sm text-moss-700 flex gap-2">
                    <span className="text-moss-500 shrink-0">&bull;</span>
                    {p}
                  </li>
                ))}
              </ul>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}
