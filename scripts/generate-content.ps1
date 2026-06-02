$ErrorActionPreference = "Stop"
$root = Join-Path (Split-Path $PSScriptRoot -Parent) "content"

function New-LessonContent($subjectTitle, $unitTitle, $unitDesc, $unitOrder, $lessonOrder, $topics) {
  $lessonLabel = if ($lessonOrder -eq 1) { "Lección 1 | Fundamentos" } else { "Lección 2 | Aplicación y proyecto" }
  $lessonDesc = if ($lessonOrder -eq 1) { "Microlección inicial centrada en conceptos base, objetivos y comprensión del tema." } else { "Microlección aplicada centrada en propuesta, organización de acciones y seguimiento." }
  $topicBullets = ($topics -split ',\s*' | ForEach-Object { "  - $_" }) -join "`n"
  $activity = if ($lessonOrder -eq 1) { "elabora un cuadro de conceptos, una observación breve del entorno o una comparación simple relacionada con esta unidad." } else { "organiza una propuesta breve para la escuela o la comunidad, con acciones, responsables y una forma simple de seguimiento." }
  $expected = if ($lessonOrder -eq 1) { "Reconocer conceptos clave, relaciones y criterios de análisis." } else { "Definir acciones, responsables y seguimiento." }
@"
---
title: "$unitTitle | $lessonLabel"
description: "$lessonDesc"
unitTitle: "$unitTitle"
unitDescription: "$unitDesc"
unitOrder: $unitOrder
lessonOrder: $lessonOrder
topics:
$topicBullets
---

# $unitTitle | $lessonLabel

## Objetivos de aprendizaje

- Comprender las ideas centrales de $unitDesc.
- Relacionar el contenido con situaciones ambientales del Paraguay.
- Organizar observaciones, conceptos o acciones en un formato claro.
- Comunicar una interpretación con lenguaje técnico sencillo.
- Vincular la unidad con la vida escolar y comunitaria.

## Contenido

En $subjectTitle, esta microlección aborda $unitDesc como parte del recorrido formativo de la unidad. Se trabaja con ejemplos cercanos del Paraguay, situaciones escolares y problemas ambientales reales para que el contenido no quede solo en definiciones.

El desarrollo busca que el estudiante relacione conceptos, territorio y comunidad. Por eso, el tema se presenta con lenguaje claro, organización progresiva y referencias a prácticas, observaciones o decisiones que pueden discutirse dentro del aula.

También se promueve el uso de cuadros, listas de observación, registros y esquemas simples. Eso ayuda a transformar la lectura del tema en una base útil para el análisis o para una acción posterior.

[imagen: $unitDesc]
[diagrama: relaciones principales de $unitDesc]
[infografía: pasos clave para estudiar $unitDesc]

## Ejemplo aplicado

En Paraguay, este tema puede observarse en comunidades, escuelas, barrios, fincas familiares o espacios públicos donde el ambiente se relaciona con decisiones concretas. La unidad ayuda a leer mejor esas situaciones y a reconocer por qué es importante comprender el tema antes de intervenir.

## Actividad

Como trabajo de esta microlección, $activity

## Autoevaluación

- **Opción múltiple:** ¿Qué acción corresponde mejor al trabajo de esta microlección?
  - $expected
  - Actuar sin comprensión del tema.
  - Copiar información sin relación con el contexto.
  - Evitar toda revisión del contenido.
- **Respuesta esperada:** $expected

- **Verdadero o falso:** Este contenido puede relacionarse con situaciones reales de la escuela o de la comunidad.
- **Respuesta esperada:** Verdadero

- **Reflexión:** ¿Cómo se relaciona esta unidad con una situación ambiental cercana a tu curso?

## Resumen

- $unitDesc se estudia con relación al territorio y a la vida comunitaria.
- La unidad fortalece comprensión, organización y aplicación del contenido.
- El contexto paraguayo ofrece ejemplos cercanos para interpretar el tema.
- Esta microlección sirve como base para seguir profundizando la asignatura.
"@
}

function New-Subject($courseSlug, $subjectData) {
  $subjectDir = Join-Path (Join-Path $root $courseSlug) $subjectData.Slug
  New-Item -ItemType Directory -Path $subjectDir -Force | Out-Null

  $competenciesYaml = ($subjectData.Competencies | ForEach-Object { "  - $_" }) -join "`n"
  $capacitiesYaml = ($subjectData.Capacities | ForEach-Object { "  - $_" }) -join "`n"
  $profileYaml = ($subjectData.Profile | ForEach-Object { "  - $_" }) -join "`n"
  $competencies = ($subjectData.Competencies | ForEach-Object { "- $_" }) -join "`n"
  $capacities = ($subjectData.Capacities | ForEach-Object { "- $_" }) -join "`n"
  $profile = ($subjectData.Profile | ForEach-Object { "- $_" }) -join "`n"
  $unitsList = ($subjectData.Units | ForEach-Object { "- **$($_[0])**" }) -join "`n"

  $index = @"
---
title: "$($subjectData.Title)"
description: "$($subjectData.Description)"
order: $($subjectData.Order)
competencies:
$competenciesYaml
capacities:
$capacitiesYaml
profileRelation:
$profileYaml
---

# $($subjectData.Title)

## Introducción de la asignatura

$($subjectData.Description)

## Competencias

$competencies

## Capacidades

$capacities

## Relación con el perfil de egreso

$profile

## Unidades didácticas

$unitsList
"@
  Set-Content -Path (Join-Path $subjectDir "index.md") -Value $index -Encoding utf8

  $u = 1
  foreach ($unit in $subjectData.Units) {
    $unitDir = Join-Path $subjectDir $unit[2]
    New-Item -ItemType Directory -Path $unitDir -Force | Out-Null
    Set-Content -Path (Join-Path $unitDir "leccion-01-fundamentos.md") -Value (New-LessonContent $subjectData.Title $unit[0] $unit[1] $u 1 $unit[3]) -Encoding utf8
    Set-Content -Path (Join-Path $unitDir "leccion-02-aplicacion.md") -Value (New-LessonContent $subjectData.Title $unit[0] $unit[1] $u 2 $unit[3]) -Encoding utf8
    $u++
  }
}

# ============================================================
# PRIMER CURSO
# ============================================================

$primerCursoSubjects = @(
  @{
    Slug='educacion-ambiental'; Order=1; Title='Educación Ambiental'; Description='Introducción al ambiente, ecosistemas, problemas ambientales y conciencia ecológica.';
    Competencies=@('Comprende los fundamentos de la educación ambiental.','Reconoce los principales problemas ambientales globales y locales.','Relaciona educación y cuidado del ambiente.');
    Capacities=@('Identificar conceptos básicos de ambiente y ecología.','Describir problemas ambientales del Paraguay.','Proponer acciones de concienciación básicas.');
    Profile=@('Fortalece la conciencia ambiental del egresado.','Aporta bases para el análisis del entorno.');
    Units=@(
      @('Unidad 1 | Ambiente y ecosistemas','conceptos básicos de ambiente y ecología','ambiente-ecosistemas','ambiente, ecosistemas, ecología'),
      @('Unidad 2 | Problemas ambientales globales','cambio climático, contaminación y pérdida de biodiversidad','problemas-ambientales-globales','problemas ambientales, cambio climático, contaminación'),
      @('Unidad 3 | Problemas ambientales del Paraguay','deforestación, contaminación hídrica y residuos','problemas-ambientales-paraguay','Paraguay, deforestación, contaminación hídrica'),
      @('Unidad 4 | Conciencia y ética ambiental','valores, actitudes y responsabilidad ambiental','conciencia-etica-ambiental','conciencia ambiental, ética, valores'),
      @('Unidad 5 | Educación ambiental comunitaria','acciones escolares y comunitarias de educación','educacion-ambiental-comunitaria','educación, comunidad, acciones escolares')
    )
  },
  @{
    Slug='agroecologia'; Order=2; Title='Agroecología'; Description='Principios de agroecología, manejo sostenible de cultivos y sistemas agrícolas ecológicos.';
    Competencies=@('Comprende los principios de la agroecología.','Relaciona agricultura sostenible y cuidado ambiental.','Aplica nociones agroecológicas en contextos locales.');
    Capacities=@('Identificar principios agroecológicos básicos.','Distinguir agricultura convencional y agroecológica.','Reconocer prácticas amigables con el ambiente.');
    Profile=@('Aporta bases para la producción sostenible.','Vincula agricultura y conservación ambiental.');
    Units=@(
      @('Unidad 1 | Principios de la agroecología','fundamentos y enfoque sistémico','principios-agroecologia','agroecología, principios, enfoque sistémico'),
      @('Unidad 2 | Suelo vivo y fertilidad','materia orgánica, microorganismos y nutrientes','suelo-vivo-fertilidad','suelo, materia orgánica, fertilidad'),
      @('Unidad 3 | Manejo ecológico de plagas','control biológico, asociaciones y rotaciones','manejo-ecologico-plagas','plagas, control biológico, rotación'),
      @('Unidad 4 | Sistemas agroforestales','integración árbol-cultivo y beneficios ambientales','sistemas-agroforestales','agroforestería, árboles, cultivos'),
      @('Unidad 5 | Agroecología y seguridad alimentaria','producción local, huertas escolares y nutrición','agroecologia-seguridad-alimentaria','seguridad alimentaria, huertas, nutrición')
    )
  },
  @{
    Slug='meteorologia'; Order=3; Title='Meteorología'; Description='Fundamentos de meteorología, clima, tiempo atmosférico y su relación con el ambiente.';
    Competencies=@('Comprende los fundamentos de la meteorología.','Relaciona clima, ambiente y actividades humanas.','Interpreta información meteorológica básica.');
    Capacities=@('Identificar elementos del clima.','Describir fenómenos meteorológicos comunes.','Relacionar clima y agricultura.');
    Profile=@('Fortalece la comprensión del clima como factor ambiental.','Aporta herramientas para la lectura del territorio.');
    Units=@(
      @('Unidad 1 | Atmósfera y tiempo atmosférico','capas, composición y dinámica','atmosfera-tiempo-atmosferico','atmósfera, tiempo, dinámica'),
      @('Unidad 2 | Elementos del clima','temperatura, precipitación, viento y humedad','elementos-del-clima','temperatura, precipitación, viento'),
      @('Unidad 3 | Fenómenos meteorológicos','tormentas, sequías, heladas e inundaciones','fenomenos-meteorologicos','tormentas, sequías, inundaciones'),
      @('Unidad 4 | Clima del Paraguay','regiones, estaciones y variabilidad','clima-del-paraguay','clima, Paraguay, regiones'),
      @('Unidad 5 | Meteorología aplicada al agro','pronóstico, prevención y planificación','meteorologia-aplicada-agro','meteorología, agricultura, pronóstico')
    )
  },
  @{
    Slug='administracion-ambiental'; Order=4; Title='Administración Ambiental'; Description='Bases de administración aplicada a la gestión de recursos y proyectos ambientales.';
    Competencies=@('Comprende nociones básicas de administración ambiental.','Relaciona gestión, recursos y sostenibilidad.','Organiza información para la toma de decisiones.');
    Capacities=@('Identificar principios de administración.','Relacionar planificación y ambiente.','Organizar datos básicos de gestión.');
    Profile=@('Aporta herramientas de gestión ambiental.','Vincula administración y cuidado del territorio.');
    Units=@(
      @('Unidad 1 | Administración y ambiente','conceptos básicos de gestión ambiental','administracion-ambiente','administración, gestión, ambiente'),
      @('Unidad 2 | Planificación ambiental','diagnóstico, objetivos y metas','planificacion-ambiental','planificación, diagnóstico, objetivos'),
      @('Unidad 3 | Organización y recursos','estructura, actores y materiales','organizacion-recursos','organización, recursos, actores'),
      @('Unidad 4 | Ejecución y monitoreo','seguimiento de acciones ambientales','ejecucion-monitoreo','ejecución, monitoreo, seguimiento'),
      @('Unidad 5 | Evaluación y mejora continua','resultados, ajustes y lecciones aprendidas','evaluacion-mejora-continua','evaluación, mejora, resultados')
    )
  },
  @{
    Slug='biologia-general'; Order=5; Title='Biología General'; Description='Bases de ecología, diversidad de seres vivos y relaciones entre organismos y ambiente.';
    Competencies=@('Comprende nociones básicas de biología y ecología.','Relaciona seres vivos, ambiente y equilibrio ecológico.','Reconoce la biodiversidad como base de la conservación.');
    Capacities=@('Identificar niveles de organización biológica.','Distinguir relaciones entre organismos y ambiente.','Reconocer importancia de la biodiversidad.');
    Profile=@('Fortalece la comprensión científica del ambiente.','Aporta bases para la conservación y el estudio ambiental.');
    Units=@(
      @('Unidad 1 | Vida y organización biológica','célula, tejidos y niveles de organización','vida-organizacion-biologica','vida, organización biológica, célula'),
      @('Unidad 2 | Seres vivos y funciones vitales','nutrición, relación y reproducción','seres-vivos-funciones-vitales','seres vivos, funciones vitales, reproducción'),
      @('Unidad 3 | Ecología básica','ecosistema, población y comunidad','ecologia-basica','ecología, ecosistema, comunidad'),
      @('Unidad 4 | Biodiversidad del Paraguay','especies, hábitats y conservación','biodiversidad-del-paraguay','biodiversidad, Paraguay, conservación'),
      @('Unidad 5 | Adaptación y equilibrio natural','interacciones y equilibrio ecológico','adaptacion-equilibrio-natural','adaptación, equilibrio, ambiente')
    )
  }
)

# ============================================================
# SEGUNDO CURSO
# ============================================================

$segundoCursoSubjects = @(
  @{
    Slug='educacion-ambiental-ii'; Order=1; Title='Educación Ambiental II'; Description='Profundización en análisis de contaminantes, recursos hídricos, suelo y concienciación comunitaria.';
    Competencies=@('Analiza las influencias ambientales en la calidad de vida.','Investiga tipos de contaminantes y su dispersión.','Promueve campañas de concienciación comunitaria.');
    Capacities=@('Identificar contaminación por sustancias químicas.','Conocer enfermedades de transmisión hídrica.','Plantear alternativas educativas a la contaminación.');
    Profile=@('Fortalece la capacidad de análisis y prevención.','Vincula salud ambiental y responsabilidad social.');
    Units=@(
      @('Unidad 1 | Contaminación y calidad de vida','tipos, fuentes y efectos de contaminantes','contaminacion-calidad-vida','contaminación, calidad de vida, fuentes'),
      @('Unidad 2 | Contaminación de recursos hídricos','sustancias químicas, orgánicas e inorgánicas','contaminacion-recursos-hidricos','agua, contaminación hídrica, Paraguay'),
      @('Unidad 3 | Contaminación del suelo','origen doméstico e industrial','contaminacion-del-suelo','suelo, contaminación, urbano, industrial'),
      @('Unidad 4 | Enfermedades de origen ambiental','transmisión hídrica, aérea y por vectores','enfermedades-origen-ambiental','enfermedades, agua, vectores'),
      @('Unidad 5 | Concienciación y medios','campañas radiales y comunicación ambiental','concienciacion-medios','concienciación, radio, comunicación')
    )
  },
  @{
    Slug='agroecologia-ii'; Order=2; Title='Agroecología II'; Description='Aplicación de principios agroecológicos, manejo integrado y producción sostenible.';
    Competencies=@('Aplica principios agroecológicos en contextos productivos.','Diseña sistemas de producción ecológica.','Evalúa prácticas agroecológicas.');
    Capacities=@('Planificar rotaciones y asociaciones de cultivos.','Implementar técnicas de conservación de suelo.','Evaluar sostenibilidad de sistemas productivos.');
    Profile=@('Fortalece competencias para la producción sostenible.','Aporta herramientas para el desarrollo rural.');
    Units=@(
      @('Unidad 1 | Agroecología aplicada','del principio a la práctica productiva','agroecologia-aplicada','agroecología, práctica, producción'),
      @('Unidad 2 | Manejo integrado de cultivos','policultivos, rotaciones y coberturas','manejo-integrado-cultivos','policultivos, rotación, cobertura'),
      @('Unidad 3 | Ganadería ecológica','sistemas silvopastoriles y bienestar animal','ganaderia-ecologica','ganadería, silvopastoril, bienestar animal'),
      @('Unidad 4 | Comercialización y certificación','mercados justos, sellos y economía solidaria','comercializacion-certificacion','comercialización, certificación, mercados'),
      @('Unidad 5 | Proyecto agroecológico escolar','diseño, ejecución y evaluación de una huerta','proyecto-agroecologico-escolar','proyecto, huerta escolar, ejecución')
    )
  },
  @{
    Slug='meteorologia-aplicada'; Order=3; Title='Meteorología Aplicada'; Description='Instrumentos, pronóstico, fenómenos extremos y aplicación de la meteorología al agro.';
    Competencies=@('Maneja instrumentos meteorológicos básicos.','Interpreta pronósticos y alertas climáticas.','Aplica información meteorológica al agro y al ambiente.');
    Capacities=@('Utilizar instrumentos de medición climática.','Leer e interpretar mapas meteorológicos.','Relacionar pronóstico y planificación agropecuaria.');
    Profile=@('Aporta herramientas técnicas para la lectura del clima.','Fortalece la prevención de riesgos climáticos.');
    Units=@(
      @('Unidad 1 | Instrumentos meteorológicos','medición de temperatura, presión, humedad, viento y lluvia','instrumentos-meteorologicos','instrumentos, medición, clima'),
      @('Unidad 2 | Pronóstico del tiempo','modelos, mapas sinópticos e interpretación','pronostico-del-tiempo','pronóstico, modelos, mapas'),
      @('Unidad 3 | Fenómenos extremos','sequías, inundaciones, heladas y olas de calor','fenomenos-extremos','fenómenos extremos, riesgo, prevención'),
      @('Unidad 4 | Cambio climático y variabilidad','tendencias, impactos y adaptación en Paraguay','cambio-climatico-variabilidad','cambio climático, adaptación, Paraguay'),
      @('Unidad 5 | Meteorología para la producción','calendario climático y toma de decisiones','meteorologia-produccion','meteorología, producción, planificación')
    )
  },
  @{
    Slug='biologia-aplicada'; Order=4; Title='Biología Aplicada'; Description='Biología de la conservación, genética básica, biotecnología y su relación ambiental.';
    Competencies=@('Comprende principios de conservación biológica.','Relaciona genética, ambiente y biodiversidad.','Analiza aplicaciones biotecnológicas básicas.');
    Capacities=@('Identificar estrategias de conservación.','Describir principios genéticos elementales.','Relacionar biotecnología y ambiente.');
    Profile=@('Fortalece la comprensión biológica del territorio.','Aporta bases para la gestión de la biodiversidad.');
    Units=@(
      @('Unidad 1 | Biología de la conservación','especies amenazadas, áreas protegidas y corredores','biologia-conservacion','conservación, especies, áreas protegidas'),
      @('Unidad 2 | Genética y ambiente','herencia, variabilidad y adaptación','genetica-ambiente','genética, herencia, adaptación'),
      @('Unidad 3 | Biotecnología básica','aplicaciones ambientales y productivas','biotecnologia-basica','biotecnología, aplicaciones, ambiente'),
      @('Unidad 4 | Microbiología ambiental','microorganismos, suelo, agua y descomposición','microbiologia-ambiental','microbiología, suelo, agua, descomposición'),
      @('Unidad 5 | Monitoreo biológico','bioindicadores, muestreo y registro de datos','monitoreo-biologico','monitoreo, bioindicadores, muestreo')
    )
  },
  @{
    Slug='administracion-recursos-naturales'; Order=5; Title='Administración de los Recursos Naturales'; Description='Introducción al uso responsable, valoración y manejo inicial de los recursos naturales.';
    Competencies=@('Reconoce la importancia de los recursos naturales para la vida y el desarrollo.','Analiza formas básicas de uso y conservación.','Relaciona aprovechamiento y sostenibilidad.');
    Capacities=@('Identificar tipos de recursos naturales.','Distinguir usos responsables e irresponsables.','Relacionar manejo y conservación.');
    Profile=@('Aporta bases para el manejo sostenible del ambiente.','Fortalece decisiones sobre uso responsable de recursos.');
    Units=@(
      @('Unidad 1 | Recursos naturales y ambiente','clasificación y valor de los recursos','recursos-naturales-ambiente','recursos naturales, ambiente, clasificación'),
      @('Unidad 2 | Agua, suelo y bosque','recursos esenciales para la vida','agua-suelo-bosque','agua, suelo, bosque'),
      @('Unidad 3 | Uso sostenible del territorio','aprovechamiento responsable y límites','uso-sostenible-territorio','territorio, sostenibilidad, uso'),
      @('Unidad 4 | Problemas de degradación','sobreexplotación, erosión y pérdida de cobertura','problemas-degradacion','degradación, erosión, sobreexplotación'),
      @('Unidad 5 | Conservación y manejo comunitario','acciones escolares y comunitarias de cuidado','conservacion-manejo-comunitario','conservación, manejo, comunidad')
    )
  },
  @{
    Slug='legislacion-ambiental'; Order=6; Title='Legislación Ambiental'; Description='Marco introductorio de normas, derechos y responsabilidades vinculadas con el ambiente.';
    Competencies=@('Reconoce el sentido de la legislación ambiental.','Relaciona normas con protección de recursos y calidad de vida.','Valora responsabilidades ciudadanas e institucionales.');
    Capacities=@('Identificar normas ambientales básicas.','Relacionar ley y protección del ambiente.','Distinguir responsabilidades individuales y colectivas.');
    Profile=@('Aporta bases para ciudadanía ambiental.','Fortalece comprensión normativa del territorio.');
    Units=@(
      @('Unidad 1 | Ambiente, derechos y normas','sentido de la regulación ambiental','ambiente-derechos-normas','ambiente, derechos, normas'),
      @('Unidad 2 | Leyes ambientales del Paraguay','marco básico de protección','leyes-ambientales-paraguay','leyes ambientales, Paraguay, protección'),
      @('Unidad 3 | Instituciones y responsabilidades','actores públicos y sociales','instituciones-responsabilidades','instituciones, responsabilidades, ambiente'),
      @('Unidad 4 | Delitos y conflictos ambientales','incumplimientos y consecuencias','delitos-conflictos-ambientales','delitos ambientales, conflictos, consecuencias'),
      @('Unidad 5 | Participación y control ciudadano','acciones de seguimiento y denuncia','participacion-control-ciudadano','participación, control ciudadano, denuncia')
    )
  },
  @{
    Slug='sociologia-rural-urbana'; Order=7; Title='Sociología Rural y Urbana'; Description='Lectura social del territorio, las comunidades y sus relaciones con el ambiente.';
    Competencies=@('Reconoce diferencias entre espacios rurales y urbanos.','Relaciona organización social y ambiente.','Analiza problemas comunitarios desde una mirada territorial.');
    Capacities=@('Describir características de comunidades rurales y urbanas.','Relacionar ambiente y calidad de vida.','Identificar actores sociales del territorio.');
    Profile=@('Fortalece comprensión social del ambiente.','Aporta bases para el diagnóstico comunitario.');
    Units=@(
      @('Unidad 1 | Sociedad, territorio y ambiente','relaciones básicas entre comunidad y espacio','sociedad-territorio-ambiente','sociedad, territorio, ambiente'),
      @('Unidad 2 | Espacios rurales','producción, comunidad y recursos','espacios-rurales','rural, comunidad, recursos'),
      @('Unidad 3 | Espacios urbanos','servicios, residuos y dinámica social','espacios-urbanos','urbano, residuos, servicios'),
      @('Unidad 4 | Problemas socioambientales','conflictos y desigualdades territoriales','problemas-socioambientales','problemas socioambientales, conflictos, desigualdad'),
      @('Unidad 5 | Participación y organización comunitaria','acciones colectivas para mejorar el entorno','participacion-organizacion-comunitaria','participación, organización comunitaria, entorno')
    )
  }
)

# ============================================================
# TERCER CURSO
# ============================================================

$tercerCursoSubjects = @(
  @{
    Slug='gestion-ambiental'; Order=1; Title='Gestión Ambiental'; Description='Herramientas integradas de gestión, sistemas de información y gobernanza ambiental.';
    Competencies=@('Comprende los fundamentos de la gestión ambiental integrada.','Aplica herramientas de diagnóstico y planificación.','Evalúa políticas y programas ambientales.');
    Capacities=@('Diseñar diagnósticos ambientales participativos.','Planificar sistemas de gestión básicos.','Evaluar cumplimiento de normas y metas.');
    Profile=@('Fortalece la capacidad de gestión territorial.','Aporta herramientas para la toma de decisiones.');
    Units=@(
      @('Unidad 1 | Gestión ambiental integrada','enfoque sistémico, actores y escalas','gestion-ambiental-integrada','gestión, sistema, actores'),
      @('Unidad 2 | Diagnóstico ambiental participativo','herramientas, indicadores y cartografía social','diagnostico-ambiental-participativo','diagnóstico, participación, cartografía'),
      @('Unidad 3 | Planificación y ordenamiento','planes ambientales y uso del territorio','planificacion-ordenamiento','planificación, ordenamiento, territorio'),
      @('Unidad 4 | Sistemas de gestión ambiental','normas ISO 14001, auditorías y mejora continua','sistemas-gestion-ambiental','ISO 14001, auditoría, mejora continua'),
      @('Unidad 5 | Gobernanza y política ambiental','instituciones, acuerdos y participación ciudadana','gobernanza-politica-ambiental','gobernanza, política, participación')
    )
  },
  @{
    Slug='recursos-naturales'; Order=2; Title='Recursos Naturales'; Description='Valoración, uso sostenible y gestión integrada de los recursos naturales del Paraguay.';
    Competencies=@('Analiza el estado de los recursos naturales del país.','Propone estrategias de uso sostenible.','Evalúa impactos del aprovechamiento de recursos.');
    Capacities=@('Identificar recursos estratégicos del Paraguay.','Valorar servicios ecosistémicos.','Diseñar propuestas de manejo responsable.');
    Profile=@('Fortalece la gestión estratégica del patrimonio natural.','Aporta criterios para el desarrollo sostenible.');
    Units=@(
      @('Unidad 1 | Recursos naturales estratégicos','agua, bosques, suelo y biodiversidad','recursos-naturales-estrategicos','recursos, agua, bosques, biodiversidad'),
      @('Unidad 2 | Servicios ecosistémicos','regulación, provisión, soporte y cultura','servicios-ecosistemicos','servicios ecosistémicos, valoración'),
      @('Unidad 3 | Manejo forestal sostenible','planes de manejo, reforestación y control','manejo-forestal-sostenible','bosques, manejo, reforestación'),
      @('Unidad 4 | Gestión de cuencas hídricas','calidad, cantidad y actores del agua','gestion-cuencas-hidricas','cuencas, agua, gestión'),
      @('Unidad 5 | Áreas protegidas y corredores','conservación in situ y conectividad ecológica','areas-protegidas-corredores','áreas protegidas, corredores, conservación')
    )
  },
  @{
    Slug='agroecologia-avanzada'; Order=3; Title='Agroecología Avanzada'; Description='Diseño de sistemas agroecológicos, transición productiva y extensión rural.';
    Competencies=@('Diseña sistemas agroecológicos completos.','Planifica procesos de transición productiva.','Implementa estrategias de extensión rural.');
    Capacities=@('Diseñar fincas agroecológicas integradas.','Evaluar la transición de sistemas convencionales.','Comunicar principios agroecológicos a productores.');
    Profile=@('Aporta liderazgo en producción sostenible.','Fortalece la vinculación entre escuela y finca.');
    Units=@(
      @('Unidad 1 | Diseño de fincas agroecológicas','zonificación, integración y flujos','diseno-fincas-agroecologicas','diseño, finca, integración'),
      @('Unidad 2 | Transición agroecológica','de la agricultura convencional a la ecológica','transicion-agroecologica','transición, convencional, ecológica'),
      @('Unidad 3 | Extensión y comunicación rural','metodologías, actores y herramientas','extension-comunicacion-rural','extensión, comunicación, rural'),
      @('Unidad 4 | Agroecología y cambio climático','adaptación y mitigación desde la finca','agroecologia-cambio-climatico','agroecología, cambio climático, adaptación'),
      @('Unidad 5 | Proyecto integrador agroecológico','diseño, implementación y evaluación','proyecto-integrador-agroecologico','proyecto, integrador, evaluación')
    )
  },
  @{
    Slug='evaluacion-impacto-ambiental'; Order=4; Title='Evaluación de Impacto Ambiental'; Description='Metodologías de EIA, estudios de caso y aplicación al contexto paraguayo.';
    Competencies=@('Comprende los fundamentos de la evaluación de impacto.','Aplica metodologías básicas de EIA.','Analiza estudios de caso del Paraguay.');
    Capacities=@('Identificar impactos de proyectos.','Aplicar matrices y listas de chequeo.','Proponer medidas de mitigación y compensación.');
    Profile=@('Fortalece la capacidad preventiva y de análisis.','Aporta herramientas para la gestión de proyectos.');
    Units=@(
      @('Unidad 1 | Fundamentos de la EIA','conceptos, etapas y marco legal','fundamentos-eia','EIA, fundamentos, marco legal'),
      @('Unidad 2 | Identificación y valoración de impactos','matrices, listas y métodos cualitativos','identificacion-valoracion-impactos','impactos, matrices, valoración'),
      @('Unidad 3 | Medidas de mitigación y compensación','jerarquía de mitigación y planes de manejo','medidas-mitigacion-compensacion','mitigación, compensación, planes'),
      @('Unidad 4 | Participación pública en la EIA','consulta, audiencias y comunicación','participacion-publica-eia','participación, consulta, audiencias'),
      @('Unidad 5 | Estudios de caso en Paraguay','análisis de EIA reales del país','estudios-caso-paraguay','Paraguay, casos, EIA reales')
    )
  },
  @{
    Slug='proyecto-ambiental'; Order=5; Title='Proyecto Ambiental Integrador'; Description='Diseño, ejecución y evaluación del proyecto final de la especialidad.';
    Competencies=@('Diseña un proyecto ambiental completo.','Ejecuta acciones planificadas con seguimiento.','Evalúa resultados y comunica hallazgos.');
    Capacities=@('Formular problemas y objetivos ambientales.','Planificar acciones, recursos y cronograma.','Evaluar resultados con indicadores.');
    Profile=@('Demuestra integración de competencias de la especialidad.','Aporta experiencia de proyecto para la inserción laboral.');
    Units=@(
      @('Unidad 1 | Formulación del proyecto','problema, objetivos y marco lógico','formulacion-proyecto','formulación, proyecto, marco lógico'),
      @('Unidad 2 | Planificación de recursos','presupuesto, cronograma y equipo','planificacion-recursos-proyecto','recursos, presupuesto, cronograma'),
      @('Unidad 3 | Ejecución y monitoreo','implementación, registro de avances y ajustes','ejecucion-monitoreo-proyecto','ejecución, monitoreo, ajustes'),
      @('Unidad 4 | Evaluación de resultados','indicadores, impactos y lecciones aprendidas','evaluacion-resultados','evaluación, indicadores, impactos'),
      @('Unidad 5 | Comunicación del proyecto','informe final, presentación y difusión','comunicacion-proyecto','comunicación, informe, presentación')
    )
  },
  @{
    Slug='economia-ambiental'; Order=6; Title='Economía Ambiental'; Description='Nociones de economía aplicada a la valoración de recursos naturales y desarrollo sostenible.';
    Competencies=@('Relaciona ambiente, recursos y decisiones económicas.','Comprende nociones de costo, beneficio e impacto.','Valora la sostenibilidad en el uso de bienes comunes.');
    Capacities=@('Identificar recursos con valor económico y ambiental.','Distinguir costo y beneficio en ejemplos.','Relacionar consumo y sostenibilidad.');
    Profile=@('Aporta mirada económica al cuidado ambiental.','Fortalece análisis de uso responsable de recursos.');
    Units=@(
      @('Unidad 1 | Ambiente y economía','relación entre recursos y decisiones','ambiente-economia','ambiente, economía, recursos'),
      @('Unidad 2 | Bienes comunes y valor ambiental','uso, cuidado y aprovechamiento','bienes-comunes-valor','bienes comunes, valor, cuidado'),
      @('Unidad 3 | Costos y beneficios ambientales','lectura de decisiones ambientales','costos-beneficios-ambientales','costos, beneficios, decisiones'),
      @('Unidad 4 | Consumo responsable y sostenibilidad','hábitos, residuos y economía circular','consumo-responsable-sostenibilidad','consumo, residuos, economía circular'),
      @('Unidad 5 | Economía y proyecto ambiental','viabilidad económica de propuestas','economia-proyecto-ambiental','economía, proyecto, viabilidad')
    )
  },
  @{
    Slug='metodologia-investigacion'; Order=7; Title='Metodología de la Investigación'; Description='Herramientas para observar, registrar, preguntar y ordenar información ambiental.';
    Competencies=@('Comprende el valor de investigar problemas del entorno.','Organiza preguntas, observaciones y registros.','Relaciona investigación y toma de decisiones.');
    Capacities=@('Formular preguntas de investigación.','Registrar datos del entorno.','Ordenar información en cuadros y fichas.');
    Profile=@('Fortalece el pensamiento analítico.','Aporta herramientas para el diagnóstico ambiental.');
    Units=@(
      @('Unidad 1 | Problema y pregunta de investigación','cómo iniciar un estudio del entorno','problema-pregunta-investigacion','problema, pregunta, investigación'),
      @('Unidad 2 | Observación y registro','técnicas de recolección de datos','observacion-registro-investigacion','observación, registro, datos'),
      @('Unidad 3 | Fuentes e información','lectura, contraste y organización','fuentes-informacion-investigacion','fuentes, información, organización'),
      @('Unidad 4 | Análisis de datos','cuadros, comparaciones y conclusiones','analisis-datos-investigacion','análisis, datos, conclusiones'),
      @('Unidad 5 | Informe y comunicación de resultados','presentación de hallazgos','informe-comunicacion-investigacion','informe, comunicación, resultados')
    )
  },
  @{
    Slug='etica-desarrollo'; Order=8; Title='Ética y Desarrollo Sostenible'; Description='Reflexión sobre valores, equidad, justicia ambiental y los ODS en el contexto paraguayo.';
    Competencies=@('Reflexiona sobre valores y justicia ambiental.','Relaciona desarrollo sostenible y equidad.','Analiza los ODS en el contexto local.');
    Capacities=@('Identificar principios de ética ambiental.','Relacionar ODS y realidad paraguaya.','Proponer acciones de desarrollo sostenible.');
    Profile=@('Fortalece la formación integral del egresado.','Aporta valores para la ciudadanía ambiental.');
    Units=@(
      @('Unidad 1 | Ética y ambiente','valores, responsabilidad y justicia','etica-ambiente','ética, valores, justicia'),
      @('Unidad 2 | Desarrollo sostenible','origen, dimensiones y principios','desarrollo-sostenible','desarrollo sostenible, dimensiones'),
      @('Unidad 3 | Objetivos de Desarrollo Sostenible','Agenda 2030 y metas ambientales','ods-agenda-2030','ODS, Agenda 2030, metas'),
      @('Unidad 4 | Equidad y justicia ambiental','acceso, distribución y participación','equidad-justicia-ambiental','equidad, justicia, acceso'),
      @('Unidad 5 | Proyecto de desarrollo comunitario','propuesta de acción sostenible local','proyecto-desarrollo-comunitario','desarrollo, comunidad, acción local')
    )
  }
)

# ============================================================
# GENERAR TODO
# ============================================================

Remove-Item -Path $root -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path $root -Force | Out-Null

foreach ($subject in $primerCursoSubjects) {
  New-Subject "primer-curso" $subject
}
Write-Output "primer-curso: $($primerCursoSubjects.Count) asignaturas creadas"

foreach ($subject in $segundoCursoSubjects) {
  New-Subject "segundo-curso" $subject
}
Write-Output "segundo-curso: $($segundoCursoSubjects.Count) asignaturas creadas"

foreach ($subject in $tercerCursoSubjects) {
  New-Subject "tercer-curso" $subject
}
Write-Output "tercer-curso: $($tercerCursoSubjects.Count) asignaturas creadas"

Write-Output "===== CONTENIDO GENERADO ====="
