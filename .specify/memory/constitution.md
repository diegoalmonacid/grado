<!--
Sync Impact Report
- Version change: (plantilla sin completar) → 1.0.0
- Principios agregados: I. Fidelidad a la fuente; II. Desarrollo guiado por specs; III. Simplicidad;
  IV. Costo cero; V. Datos privados fuera del repo; VI. Calidad verificable;
  VII. Experiencia del estudiante
- Secciones agregadas: Restricciones Adicionales; Flujo de Desarrollo; Governance (completa)
- Secciones eliminadas: ninguna
- TODOs diferidos: ninguno
-->
# Examen de Grado IA Constitution

## Core Principles

### I. Fidelidad a la fuente (NO NEGOCIABLE)
Toda respuesta jurídica MUST basarse únicamente en el material recuperado (apuntes y preguntas de
exámenes anteriores) y MUST citar la sección de origen. Si el material recuperado es insuficiente,
el sistema MUST decirlo explícitamente en vez de inventar o completar con conocimiento del modelo.
Una respuesta sin cita o sin respaldo en el material recuperado es un defecto bloqueante.

Razón: un estudiante que memoriza una respuesta jurídica inventada puede reprobar el examen.

### II. Desarrollo guiado por specs
Nada se implementa sin `spec.md`, `plan.md` y `tasks.md` mergeados en `specs/<feature>/`. Una spec
MUST NOT aprobarse con marcadores `[NEEDS CLARIFICATION]` pendientes. Las historias de usuario
MUST salir del refinamiento (`/speckit.specify` y `/speckit.clarify`), no definirse antes de él.
Si la spec es ambigua durante la implementación, se detiene el trabajo y se pregunta en el PR.

### III. Simplicidad
Se MUST elegir la solución más simple que cumpla la spec. Toda dependencia nueva MUST justificarse
en `plan.md`; sin justificación, no se agrega.

### IV. Costo cero
Todo el sistema MUST caber en planes gratuitos (hosting, base de datos, modelos, CI). El acceso a
modelos MUST pasar por una única capa, `src/lib/ai`, usando Vercel AI SDK; ningún otro módulo llama
directamente a un proveedor de IA.

### V. Datos privados fuera del repo
El repositorio es público. Los apuntes, preguntas de examen y cualquier material fuente MUST NOT
commitearse (viven en `data/`, ignorado por git). Los secretos MUST vivir solo en variables de
entorno (`.env.local`), documentadas sin valores en `.env.example`.

### VI. Calidad verificable
El código MUST usar TypeScript estricto. La lógica nueva MUST tener tests con Vitest. El RAG MUST
tener evals mínimos en `evals/`. Un PR solo se mergea con CI en verde (lint, typecheck, test y
build).

### VII. Experiencia del estudiante
Los textos de UI MUST estar en español de Chile. El diseño MUST ser mobile-first. Las respuestas de
IA MUST entregarse en streaming. La UI MUST construirse solo con Tailwind CSS y shadcn/ui.

## Restricciones Adicionales

- Stack: Next.js (App Router), TypeScript estricto, Tailwind CSS, shadcn/ui, Vercel AI SDK, Vitest.
- Validación de entradas en route handlers con Zod.
- Server Components por defecto; `"use client"` solo cuando sea necesario.
- Nombres de código en inglés; los comentarios pueden estar en español.

## Flujo de Desarrollo

- Una rama por ticket, nombrada `APP-<n>-<descripcion-corta>`; commits y título de PR comienzan con
  la key (`APP-12: ...`).
- Nunca se hace push a `main`; todo cambio entra por PR.
- Cada feature tiene dos PRs: uno de spec (`spec.md`, `plan.md`, `tasks.md`) y uno de
  implementación, que referencia la spec e incluye resumen y cómo probar.
- Cada `plan.md` MUST incluir un Constitution Check que verifique los principios I–VII.

## Governance

Esta constitución prevalece sobre cualquier otra práctica del proyecto.

- Enmiendas: solo vía PR que modifique este archivo, con justificación y revisión previa al merge.
  Si la enmienda afecta specs o planes existentes, el PR MUST indicar cómo migrarlos.
- Versionado semántico: MAJOR por eliminar o redefinir principios de forma incompatible; MINOR por
  agregar un principio o sección, o ampliar materialmente la guía; PATCH por aclaraciones y
  correcciones de redacción.
- Cumplimiento: todo PR MUST verificar el cumplimiento de esta constitución; las desviaciones MUST
  justificarse en `plan.md`. `CLAUDE.md` es la guía operativa y MUST mantenerse coherente con este
  documento.

**Version**: 1.0.0 | **Ratified**: 2026-11-24 | **Last Amended**: 2026-11-24
