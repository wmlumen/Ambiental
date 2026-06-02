import Link from "next/link";
import { basePath } from "@/lib/paths";

export default function ArquitecturaPage() {
  return (
    <div className="max-w-4xl mx-auto px-4 md:px-6 py-12 md:py-16">
      <nav className="text-sm text-moss-500 mb-8">
        <Link href={`${basePath}/`} className="breadcrumb-link">Inicio</Link>
        <span className="mx-2">/</span>
        <span className="text-moss-700 font-medium">Arquitectura</span>
      </nav>

      <h1 className="text-3xl md:text-4xl font-bold text-moss-800 mb-6">Arquitectura del portal</h1>

      <div className="card mb-8">
        <h2 className="text-xl font-bold text-moss-800 mb-4">Stack tecnológico</h2>
        <div className="grid gap-3 md:grid-cols-2">
          {[
            { label: "Framework", value: "Next.js 15 (App Router)" },
            { label: "Renderizado", value: "Estático (SSG)" },
            { label: "Contenido", value: "Markdown + Frontmatter" },
            { label: "Estilos", value: "Tailwind CSS + Typography" },
            { label: "Markdown", value: "react-markdown + remark-gfm" },
            { label: "Despliegue", value: "GitHub Pages" },
          ].map((item) => (
            <div key={item.label} className="flex flex-col p-3 rounded-xl bg-moss-50">
              <span className="text-xs text-moss-500 font-medium">{item.label}</span>
              <span className="text-sm font-semibold text-moss-800 mt-0.5">{item.value}</span>
            </div>
          ))}
        </div>
      </div>

      <div className="card mb-8">
        <h2 className="text-xl font-bold text-moss-800 mb-4">Estructura de rutas</h2>
        <pre className="bg-moss-50 rounded-xl p-5 text-sm text-moss-700 overflow-x-auto font-mono leading-relaxed">
{`/
├── cursos
│   └── [course]                  (primer-curso, segundo-curso, tercer-curso)
│       └── [subject]             (asignatura)
│           └── [unit]            (unidad didáctica)
│               ├── leccion-01-fundamentos
│               └── leccion-02-aplicacion
├── mapa-web                      (mapa completo del sitio)
└── arquitectura                  (esta página)`}
        </pre>
      </div>

      <div className="card mb-8">
        <h2 className="text-xl font-bold text-moss-800 mb-4">Organización del contenido</h2>
        <pre className="bg-moss-50 rounded-xl p-5 text-sm text-moss-700 overflow-x-auto font-mono leading-relaxed">
{`content/
├── primer-curso/
│   ├── educacion-ambiental/
│   │   ├── index.md             (frontmatter: título, competencias, capacidades)
│   │   └── unidad-NN/
│   │       ├── leccion-01-fundamentos.md
│   │       └── leccion-02-aplicacion.md
│   ├── agroecologia/
│   ...`}
        </pre>
      </div>

      <div className="card">
        <h2 className="text-xl font-bold text-moss-800 mb-4">Despliegue</h2>
        <p className="text-moss-600 text-sm leading-relaxed">
          El portal se compila como sitio estático con <code className="text-lagoon-700 bg-moss-100 px-1.5 py-0.5 rounded">output: &apos;export&apos;</code> y se publica
          automáticamente en GitHub Pages mediante GitHub Actions. Cada push a la rama <code className="text-lagoon-700 bg-moss-100 px-1.5 py-0.5 rounded">main</code>
          dispara el build y el deploy a la rama <code className="text-lagoon-700 bg-moss-100 px-1.5 py-0.5 rounded">gh-pages</code>.
        </p>
      </div>
    </div>
  );
}
