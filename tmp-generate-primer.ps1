$root = 'c:\Users\Administrator\Documents\MEC 2026\2025 BTCA 2do. Educ. Ambiental\content\primer-curso'
$subjects = @(
  @{
    Slug='biologia-general'; Order=5; Title='Biología General'; Description='Bases de ecología, diversidad de seres vivos y relaciones entre organismos y ambiente.';
    Competencies=@('Comprende nociones básicas de biología y ecología.','Relaciona seres vivos, ambiente y equilibrio ecológico.','Reconoce la biodiversidad como base de la conservación.');
    Capacities=@('Identificar niveles de organización biológica.','Distinguir relaciones entre organismos y ambiente.','Reconocer importancia de la biodiversidad.','Aplicar observación básica en contextos escolares.');
    Profile=@('Fortalece la comprensión científica del ambiente.','Apoya el análisis de ecosistemas y biodiversidad.','Aporta bases para la conservación y el estudio ambiental.');
    Units=@(
      @('Unidad 1 | Vida y organización biológica','célula, tejidos y niveles de organización','vida-organizacion-biologica','vida, organización biológica, célula'),
      @('Unidad 2 | Seres vivos y funciones vitales','nutrición, relación y reproducción','seres-vivos-funciones-vitales','seres vivos, funciones vitales, reproducción'),
      @('Unidad 3 | Ecología básica','ecosistema, población y comunidad','ecologia-basica','ecología, ecosistema, comunidad'),
      @('Unidad 4 | Biodiversidad del Paraguay','especies, hábitats y conservación','biodiversidad-del-paraguay','biodiversidad, Paraguay, conservación'),
      @('Unidad 5 | Adaptación y equilibrio natural','interacciones y equilibrio ecológico','adaptacion-equilibrio-natural','adaptación, equilibrio, ambiente')
    )
  },
  @{
    Slug='administracion-recursos-naturales'; Order=6; Title='Administración de los Recursos Naturales'; Description='Introducción al uso responsable, valoración y manejo inicial de los recursos naturales.';
    Competencies=@('Reconoce la importancia de los recursos naturales para la vida y el desarrollo.','Analiza formas básicas de uso y conservación.','Relaciona aprovechamiento y sostenibilidad.');
    Capacities=@('Identificar tipos de recursos naturales.','Distinguir usos responsables e irresponsables.','Relacionar manejo y conservación.','Valorar el cuidado del territorio.');
    Profile=@('Aporta bases para el manejo sostenible del ambiente.','Fortalece decisiones sobre uso responsable de recursos.','Vincula territorio, producción y conservación.');
    Units=@(
      @('Unidad 1 | Recursos naturales y ambiente','clasificación y valor de los recursos','recursos-naturales-ambiente','recursos naturales, ambiente, clasificación'),
      @('Unidad 2 | Agua, suelo y bosque','recursos esenciales para la vida','agua-suelo-bosque','agua, suelo, bosque'),
      @('Unidad 3 | Uso sostenible del territorio','aprovechamiento responsable y límites','uso-sostenible-territorio','territorio, sostenibilidad, uso'),
      @('Unidad 4 | Problemas de degradación','sobreexplotación, erosión y pérdida de cobertura','problemas-degradacion','degradación, erosión, sobreexplotación'),
      @('Unidad 5 | Conservación y manejo comunitario','acciones escolares y comunitarias de cuidado','conservacion-manejo-comunitario','conservación, manejo, comunidad')
    )
  },
  @{
    Slug='recursos-geologicos-edafologicos'; Order=7; Title='Recursos Geológicos y Edafológicos'; Description='Estudio inicial del suelo, las rocas y su relación con producción, agua y conservación.';
    Competencies=@('Reconoce componentes geológicos y edáficos del territorio.','Relaciona suelo, roca, relieve y uso productivo.','Valora el suelo como recurso estratégico.');
    Capacities=@('Identificar tipos básicos de suelo y roca.','Describir propiedades elementales del suelo.','Relacionar relieve y erosión.','Valorar prácticas de conservación edáfica.');
    Profile=@('Fortalece la lectura física del territorio.','Aporta bases para conservación de suelos.','Apoya decisiones sobre producción y ambiente.');
    Units=@(
      @('Unidad 1 | Rocas, minerales y relieve','componentes físicos del territorio','rocas-minerales-relieve','rocas, minerales, relieve'),
      @('Unidad 2 | El suelo como recurso','formación, horizontes y funciones','suelo-como-recurso','suelo, horizontes, recurso'),
      @('Unidad 3 | Propiedades del suelo','textura, color, humedad y fertilidad','propiedades-del-suelo','textura, fertilidad, humedad'),
      @('Unidad 4 | Erosión y degradación edáfica','causas, efectos y prevención','erosion-degradacion-edafica','erosión, degradación, prevención'),
      @('Unidad 5 | Conservación del suelo','cobertura, manejo y protección escolar','conservacion-del-suelo','conservación del suelo, cobertura, manejo')
    )
  },
  @{
    Slug='legislacion-ambiental'; Order=8; Title='Legislación Ambiental'; Description='Marco introductorio de normas, derechos y responsabilidades vinculadas con el ambiente.';
    Competencies=@('Reconoce el sentido de la legislación ambiental.','Relaciona normas con protección de recursos y calidad de vida.','Valora responsabilidades ciudadanas e institucionales.');
    Capacities=@('Identificar normas ambientales básicas.','Relacionar ley y protección del ambiente.','Distinguir responsabilidades individuales y colectivas.','Aplicar lectura básica de casos ambientales.');
    Profile=@('Aporta bases para ciudadanía ambiental.','Fortalece comprensión normativa del territorio.','Vincula cuidado ambiental y responsabilidad social.');
    Units=@(
      @('Unidad 1 | Ambiente, derechos y normas','sentido de la regulación ambiental','ambiente-derechos-normas','ambiente, derechos, normas'),
      @('Unidad 2 | Leyes ambientales del Paraguay','marco básico de protección','leyes-ambientales-paraguay','leyes ambientales, Paraguay, protección'),
      @('Unidad 3 | Instituciones y responsabilidades','actores públicos y sociales','instituciones-responsabilidades','instituciones, responsabilidades, ambiente'),
      @('Unidad 4 | Delitos y conflictos ambientales','incumplimientos y consecuencias','delitos-conflictos-ambientales','delitos ambientales, conflictos, consecuencias'),
      @('Unidad 5 | Participación y control ciudadano','acciones de seguimiento y denuncia','participacion-control-ciudadano','participación, control ciudadano, denuncia')
    )
  },
  @{
    Slug='evaluacion-impacto-ambiental'; Order=9; Title='Evaluación de Impacto Ambiental'; Description='Introducción a los impactos ambientales y a la lectura básica de efectos, riesgos y medidas.';
    Competencies=@('Comprende qué es un impacto ambiental.','Reconoce efectos de actividades humanas sobre el ambiente.','Relaciona prevención, mitigación y evaluación.');
    Capacities=@('Identificar acciones con posible impacto.','Distinguir impactos positivos y negativos.','Relacionar riesgo y prevención.','Proponer medidas sencillas de mitigación.');
    Profile=@('Aporta bases para análisis preventivo.','Fortalece lectura crítica de proyectos y actividades.','Vincula ambiente, decisiones y mitigación.');
    Units=@(
      @('Unidad 1 | Impacto ambiental y actividades humanas','acciones y efectos sobre el entorno','impacto-ambiental-actividades-humanas','impacto ambiental, actividades humanas, efectos'),
      @('Unidad 2 | Tipos de impacto','impactos directos, indirectos y acumulativos','tipos-de-impacto','tipos de impacto, directo, indirecto'),
      @('Unidad 3 | Riesgo y prevención','lectura básica de amenazas y cuidado','riesgo-prevencion','riesgo, prevención, amenazas'),
      @('Unidad 4 | Medidas de mitigación','respuestas para reducir efectos','medidas-de-mitigacion','mitigación, medidas, efectos'),
      @('Unidad 5 | Casos del entorno escolar y comunitario','análisis aplicado de situaciones cercanas','casos-entorno-escolar-comunitario','casos, comunidad, escuela')
    )
  },
  @{
    Slug='metodologia-investigacion'; Order=10; Title='Metodología de la Investigación'; Description='Herramientas iniciales para observar, registrar, preguntar y ordenar información ambiental.';
    Competencies=@('Comprende el valor de investigar problemas del entorno.','Organiza preguntas, observaciones y registros básicos.','Relaciona investigación y toma de decisiones.');
    Capacities=@('Formular preguntas sencillas de investigación.','Registrar datos básicos del entorno.','Ordenar información en cuadros y fichas.','Comunicar hallazgos iniciales.');
    Profile=@('Fortalece el pensamiento analítico.','Aporta herramientas para el diagnóstico ambiental.','Vincula observación, datos y proyecto.');
    Units=@(
      @('Unidad 1 | Problema y pregunta de investigación','cómo iniciar un estudio del entorno','problema-pregunta-investigacion','problema, pregunta, investigación'),
      @('Unidad 2 | Observación y registro','técnicas básicas de recolección de datos','observacion-registro','observación, registro, datos'),
      @('Unidad 3 | Fuentes e información','lectura, contraste y organización','fuentes-informacion','fuentes, información, organización'),
      @('Unidad 4 | Análisis simple de datos','cuadros, comparaciones y conclusiones iniciales','analisis-simple-datos','análisis, datos, conclusiones'),
      @('Unidad 5 | Informe y comunicación','presentación de resultados básicos','informe-comunicacion','informe, comunicación, resultados')
    )
  },
  @{
    Slug='sociologia-rural-urbana'; Order=11; Title='Sociología Rural y Urbana'; Description='Lectura social del territorio, las comunidades y sus relaciones con el ambiente.';
    Competencies=@('Reconoce diferencias y vínculos entre espacios rurales y urbanos.','Relaciona organización social y ambiente.','Analiza problemas comunitarios desde una mirada territorial.');
    Capacities=@('Describir características de comunidades rurales y urbanas.','Relacionar ambiente y calidad de vida.','Identificar actores sociales del territorio.','Valorar participación comunitaria.');
    Profile=@('Fortalece comprensión social del ambiente.','Aporta bases para el diagnóstico comunitario.','Vincula territorio, población y acción colectiva.');
    Units=@(
      @('Unidad 1 | Sociedad, territorio y ambiente','relaciones básicas entre comunidad y espacio','sociedad-territorio-ambiente','sociedad, territorio, ambiente'),
      @('Unidad 2 | Espacios rurales','producción, comunidad y recursos','espacios-rurales','rural, comunidad, recursos'),
      @('Unidad 3 | Espacios urbanos','servicios, residuos y dinámica social','espacios-urbanos','urbano, residuos, servicios'),
      @('Unidad 4 | Problemas socioambientales','conflictos y desigualdades territoriales','problemas-socioambientales','problemas socioambientales, conflictos, desigualdad'),
      @('Unidad 5 | Participación y organización comunitaria','acciones colectivas para mejorar el entorno','participacion-organizacion-comunitaria','participación, organización comunitaria, entorno')
    )
  },
  @{
    Slug='diseno-elaboracion-proyecto'; Order=12; Title='Diseño y elaboración de proyecto'; Description='Introducción al diseño de proyectos ambientales con objetivos, acciones y organización básica.';
    Competencies=@('Comprende la estructura básica de un proyecto.','Relaciona problema, objetivo y acción.','Organiza propuestas ambientales sencillas y viables.');
    Capacities=@('Definir un problema y un objetivo.','Ordenar acciones y responsables.','Relacionar recursos y tiempos.','Presentar una propuesta breve.');
    Profile=@('Fortalece planificación de acciones ambientales.','Aporta bases para proyectos escolares y comunitarios.','Vincula diagnóstico, objetivos y solución.');
    Units=@(
      @('Unidad 1 | Problema y objetivo','punto de partida de un proyecto','problema-objetivo','problema, objetivo, proyecto'),
      @('Unidad 2 | Acciones y responsables','organización básica de tareas','acciones-responsables','acciones, responsables, organización'),
      @('Unidad 3 | Recursos y cronograma','tiempos, materiales y viabilidad','recursos-cronograma','recursos, cronograma, viabilidad'),
      @('Unidad 4 | Indicadores y seguimiento','cómo revisar avances del proyecto','indicadores-seguimiento','indicadores, seguimiento, proyecto'),
      @('Unidad 5 | Presentación de la propuesta','comunicación clara de la idea','presentacion-propuesta','presentación, propuesta, comunicación')
    )
  },
  @{
    Slug='economia-ambiental'; Order=13; Title='Economía Ambiental'; Description='Nociones iniciales sobre recursos, costos, beneficios y decisiones vinculadas con el ambiente.';
    Competencies=@('Relaciona ambiente, recursos y decisiones económicas.','Comprende nociones básicas de costo, beneficio e impacto.','Valora la sostenibilidad en el uso de bienes comunes.');
    Capacities=@('Identificar recursos con valor económico y ambiental.','Distinguir costo y beneficio en ejemplos simples.','Relacionar consumo y sostenibilidad.','Valorar decisiones responsables.');
    Profile=@('Aporta mirada económica al cuidado ambiental.','Fortalece análisis de uso responsable de recursos.','Vincula sostenibilidad, producción y comunidad.');
    Units=@(
      @('Unidad 1 | Ambiente y economía','relación entre recursos y decisiones','ambiente-economia','ambiente, economía, recursos'),
      @('Unidad 2 | Bienes comunes y valor ambiental','uso, cuidado y aprovechamiento','bienes-comunes-valor-ambiental','bienes comunes, valor ambiental, cuidado'),
      @('Unidad 3 | Costos y beneficios','lectura simple de decisiones ambientales','costos-beneficios','costos, beneficios, decisiones'),
      @('Unidad 4 | Consumo responsable','hábitos, residuos y sostenibilidad','consumo-responsable','consumo, residuos, sostenibilidad'),
      @('Unidad 5 | Economía y proyecto escolar','viabilidad básica de propuestas ambientales','economia-proyecto-escolar','economía, proyecto escolar, viabilidad')
    )
  }
)
function New-LessonContent($subjectTitle, $unitTitle, $unitDesc, $unitOrder, $lessonOrder, $topics) {
  $lessonLabel = if ($lessonOrder -eq 1) { 'Lección 1 | Fundamentos' } else { 'Lección 2 | Aplicación y proyecto' }
  $lessonDesc = if ($lessonOrder -eq 1) { 'Microlección inicial centrada en conceptos base, objetivos y comprensión del tema.' } else { 'Microlección aplicada centrada en propuesta, organización de acciones y seguimiento.' }
  $topicBullets = ($topics -split ',\s*' | ForEach-Object { "  - $_" }) -join "`n"
  $activity = if ($lessonOrder -eq 1) { 'elabora un cuadro de conceptos, una observación breve del entorno o una comparación simple relacionada con esta unidad.' } else { 'organiza una propuesta breve para la escuela o la comunidad, con acciones, responsables y una forma simple de seguimiento.' }
  $expected = if ($lessonOrder -eq 1) { 'Reconocer conceptos clave, relaciones y criterios de análisis.' } else { 'Definir acciones, responsables y seguimiento.' }
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
foreach ($subject in $subjects) {
  $subjectDir = Join-Path $root $subject.Slug
  New-Item -ItemType Directory -Path $subjectDir -Force | Out-Null
  $competenciesYaml = ($subject.Competencies | ForEach-Object { "  - $_" }) -join "`n"
  $capacitiesYaml = ($subject.Capacities | ForEach-Object { "  - $_" }) -join "`n"
  $profileYaml = ($subject.Profile | ForEach-Object { "  - $_" }) -join "`n"
  $competencies = ($subject.Competencies | ForEach-Object { "- $_" }) -join "`n"
  $capacities = ($subject.Capacities | ForEach-Object { "- $_" }) -join "`n"
  $profile = ($subject.Profile | ForEach-Object { "- $_" }) -join "`n"
  $unitsList = ($subject.Units | ForEach-Object { "- **$($_[0])**" }) -join "`n"
  $index = @"
---
title: "$($subject.Title)"
description: "$($subject.Description)"
order: $($subject.Order)
competencies:
$competenciesYaml
capacities:
$capacitiesYaml
profileRelation:
$profileYaml
---

# $($subject.Title)

## Introducción de la asignatura

$($subject.Description)

## Competencias

$competencies

## Capacidades

$capacities

## Relación con el perfil de egreso

$profile

## Unidades didácticas

$unitsList
"@
  Set-Content -Path (Join-Path $subjectDir 'index.md') -Value $index -Encoding utf8
  $u = 1
  foreach ($unit in $subject.Units) {
    $unitDir = Join-Path $subjectDir $unit[2]
    New-Item -ItemType Directory -Path $unitDir -Force | Out-Null
    Set-Content -Path (Join-Path $unitDir 'leccion-01-fundamentos.md') -Value (New-LessonContent $subject.Title $unit[0] $unit[1] $u 1 $unit[3]) -Encoding utf8
    Set-Content -Path (Join-Path $unitDir 'leccion-02-aplicacion.md') -Value (New-LessonContent $subject.Title $unit[0] $unit[1] $u 2 $unit[3]) -Encoding utf8
    $u++
  }
}
Write-Output 'created'
