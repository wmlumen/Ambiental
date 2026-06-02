import type { Metadata } from "next";
import Link from "next/link";
import "./globals.css";

export const metadata: Metadata = {
  title: {
    default: "Portal BTCA | Ciencias Ambientales",
    template: "%s | Portal BTCA"
  },
  description:
    "Contenido educativo del Bachillerato Técnico en Ciencias Ambientales del MEC de Paraguay. Material organizado por cursos, asignaturas, unidades y lecciones."
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="es">
      <body className="min-h-screen flex flex-col">
        <header className="sticky top-0 z-50 bg-white/80 backdrop-blur-md border-b border-moss-100">
          <div className="max-w-6xl mx-auto px-4 md:px-6 h-16 flex items-center justify-between">
            <Link href="/" className="flex items-center gap-3">
              <span className="w-8 h-8 rounded-lg bg-moss-600 flex items-center justify-center text-white text-sm font-bold">
                BT
              </span>
              <div className="hidden sm:block">
                <p className="text-sm font-semibold text-moss-800 leading-tight">Portal BTCA</p>
                <p className="text-xs text-moss-500 leading-tight">Ciencias Ambientales</p>
              </div>
            </Link>
            <nav className="flex items-center gap-1 md:gap-2">
              <Link href="/" className="btn-ghost text-sm">Inicio</Link>
              <Link href="/cursos" className="btn-ghost text-sm">Cursos</Link>
              <Link href="/mapa-web" className="btn-ghost text-sm">Mapa</Link>
              <Link href="/arquitectura" className="btn-ghost text-sm">Arquitectura</Link>
            </nav>
          </div>
        </header>
        <main className="flex-1">{children}</main>
        <footer className="bg-moss-900 text-moss-300 text-sm py-8 px-4">
          <div className="max-w-6xl mx-auto text-center">
            <p>Portal BTCA | Bachillerato Técnico en Ciencias Ambientales</p>
            <p className="text-moss-500 mt-1">MEC Paraguay &middot; Contenido educativo estático</p>
          </div>
        </footer>
      </body>
    </html>
  );
}
