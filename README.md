# Portal BTCA | Contenido educativo estático

Este proyecto organiza contenidos del Bachillerato Técnico en Ciencias Ambientales del MEC de Paraguay para una plataforma educativa estática construida con Next.js y MDX.

## Estructura principal

```text
content/
  primer-curso/
    educacion-ambiental/
      index.mdx
      unidad-01/
        leccion-01-...
        leccion-02-...
    agroecologia/
    meteorologia/
    administracion-ambiental/
  segundo-curso/
    educacion-ambiental-ii/
    agroecologia-ii/
    meteorologia-aplicada/
    biologia-aplicada/
    administracion-ambiental/
  tercer-curso/
    gestion-ambiental/
    recursos-naturales/
    agroecologia-avanzada/
    evaluacion-impacto-ambiental/
    proyecto-ambiental/
```

## Criterio pedagógico

- aprendizaje visual
- aprendizaje activo
- proyectos ambientales
- relación con la comunidad
- ejemplos situados en Paraguay

## Uso en la app

- Cada asignatura tiene un `index.mdx` con introducción, competencias, capacidades y relación con el perfil de egreso.
- Cada unidad incluye dos microlecciones con objetivos, contenido, ejemplo aplicado, actividad, autoevaluación y resumen.
- Las rutas quedan organizadas como `curso -> asignatura -> unidad -> leccion`.

## Archivos de apoyo

- `documentacion/mapa-curricular-btca.md`
- `documentacion/tabla-asignaturas-competencias.md`
- `documentacion/perfil-salida-matriz-indicadores.md`
- `documentacion/recorrido-programa-general.md`
