import Link from "next/link";
import { basePath } from "@/lib/paths";

export default function NotFound() {
  return (
    <div className="max-w-2xl mx-auto px-4 py-24 text-center">
      <h1 className="text-4xl font-bold text-moss-800 mb-4">Página no encontrada</h1>
      <p className="text-moss-600 mb-8">
        La ruta solicitada no existe en el portal BTCA. Revisá el mapa del sitio o volvé al inicio.
      </p>
      <div className="flex flex-wrap gap-3 justify-center">
        <Link href={`${basePath}/`} className="btn-primary">Volver al inicio</Link>
        <Link href={`${basePath}/mapa-web`} className="btn-ghost">Mapa del sitio</Link>
      </div>
    </div>
  );
}
