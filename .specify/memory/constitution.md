<!--
Sync Impact Report
- Version change: (template, unversioned) → 1.0.0
- Modified principles: none (all principles newly defined)
- Added sections: Core Principles I–V, Restricciones Técnicas, Flujo de Desarrollo, Governance
- Removed sections: none
- Follow-up TODOs: none. Ratification date set to the date of adoption (2026-11-17).
-->
# Examen de Grado IA Constitution

## Core Principles

### I. Respuestas de IA con Fuente Citada (NON-NEGOTIABLE)
Toda respuesta generada por IA MUST citar su fuente (artículo o apunte) de forma explícita y
verificable. Si no existe una fuente que respalde la respuesta, la IA MUST decirlo de forma
explícita y MUST NOT presentar la respuesta como fundada. Una respuesta sin fuente ni aviso de
ausencia de fuente se considera un defecto.

Razón: es una herramienta de estudio para un examen de grado; una respuesta sin respaldo puede
enseñar contenido erróneo.

### II. TypeScript Estricto
Todo el código MUST escribirse en TypeScript con `strict: true`. El uso de `any` o de supresiones
(`@ts-ignore`, `@ts-expect-error`) MUST justificarse por escrito en el código. El código MUST
compilar sin errores de tipos.

### III. Tests para la Lógica de Evaluación
Toda lógica de evaluación (corrección de respuestas, puntajes, cálculo de resultados, validación
de citas/fuentes) MUST tener tests automatizados que pasen antes de integrar el cambio. Los tests
MUST escribirse junto con la lógica; un cambio en la lógica de evaluación sin tests se rechaza.

### IV. Mobile-First y Accesible
Las interfaces MUST diseñarse primero para pantallas móviles y escalar a pantallas mayores. MUST
cumplir WCAG 2.1 nivel AA: navegación por teclado, contraste suficiente, etiquetas para lectores
de pantalla y objetivos táctiles utilizables.

### V. Interfaz en Español de Chile
Todo texto visible al usuario (interfaz, mensajes de error, respuestas de la IA) MUST estar en
español de Chile. Los términos y el registro MUST ser coherentes en toda la aplicación.

## Restricciones Técnicas

- Lenguaje: TypeScript en modo estricto (Principio II).
- Idioma de la interfaz: es-CL (Principio V).
- Toda funcionalidad que use IA MUST pasar por el mecanismo de citación de fuentes (Principio I).

## Flujo de Desarrollo

- Cada feature MUST rastrearse en Jira, proyecto **EXG**, mediante su issue correspondiente.
- El flujo sigue Spec Kit: especificación, plan, tareas e implementación.
- Todo PR MUST verificar el cumplimiento de esta constitución: tipos estrictos, tests de lógica de
  evaluación, citación de fuentes, accesibilidad e idioma.

## Governance

Esta constitución prevalece sobre otras prácticas del proyecto. Las enmiendas MUST documentarse en
este archivo, con actualización de versión y fecha, y ser aprobadas por el responsable del
proyecto. El versionado es semántico: MAJOR para eliminación o redefinición incompatible de
principios, MINOR para nuevos principios o ampliación material, PATCH para aclaraciones. El
cumplimiento se revisa en cada PR y en cada plan de feature (Constitution Check).

**Version**: 1.0.0 | **Ratified**: 2026-11-17 | **Last Amended**: 2026-11-17
