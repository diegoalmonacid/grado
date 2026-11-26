# CLAUDE.md

Plataforma web con IA para preparar el examen de grado de Derecho en Chile.
La fuente de verdad de principios es `.specify/memory/constitution.md` — léela antes de cualquier tarea.

## Stack
- Next.js (App Router) + TypeScript (strict)
- Tailwind CSS + shadcn/ui (componentes en `src/components/ui`)
- Vercel AI SDK (`ai`) para LLM y embeddings — acceso solo vía `src/lib/ai`
- Tests: Vitest (+ Testing Library para componentes)

## Comandos
- `npm run dev` — servidor local
- `npm run lint` — ESLint
- `npm run typecheck` — `tsc --noEmit`
- `npm run test` — Vitest
- `npm run build` — build de producción
Antes de abrir un PR, corre lint, typecheck, test y build; todos deben pasar.

## Estructura
- `src/app/` — rutas (App Router) y route handlers (`app/api/...`)
- `src/components/` — componentes propios; `ui/` es shadcn (no editar a mano salvo necesidad)
- `src/lib/ai/` — cliente de modelos, prompts
- `src/lib/rag/` — chunking, embeddings, búsqueda
- `scripts/` — scripts de ingesta y utilidades (se corren localmente)
- `specs/` — specs de Spec Kit (una carpeta por feature)
- `evals/` — sets de evaluación del RAG

## Flujo de trabajo (obligatorio)
1. No implementes nada sin spec mergeada en `specs/<feature>/` (spec.md, plan.md, tasks.md).
2. Si te piden refinar una idea: usa `/speckit.specify`, luego `/speckit.clarify` y pregunta al usuario; no inventes requisitos. Después `/speckit.plan` y `/speckit.tasks`.
3. Para implementar: `/speckit.implement` sobre la spec aprobada, siguiendo `tasks.md` en orden.
4. Ramas: `APP-<n>-<descripcion-corta>`. Commits y título del PR empiezan con la key (`APP-12: ...`).
5. Nunca hagas push a `main`. Siempre abre un PR con: resumen, link a la spec, cómo probar.
6. Si algo de la spec es ambiguo durante la implementación, detente y pregunta en el PR; no improvises.

## Convenciones
- Server Components por defecto; `"use client"` solo cuando haga falta.
- Validación de entradas con Zod en route handlers.
- Textos de UI en español de Chile.
- Nombres de código en inglés; comentarios pueden ir en español.
- Respuestas de IA: siempre en streaming y siempre con citas a la fuente (ver constitución, principio I).

## Prohibido
- Commitear apuntes, preguntas de examen u otro material fuente (van en `data/`, que está en `.gitignore`).
- Commitear secretos; usa `.env.local` y documenta en `.env.example`.
- Agregar dependencias sin justificarlas en `plan.md`.
- Llamar a un proveedor de IA fuera de `src/lib/ai`.

## Definición de terminado
- Cumple los criterios de aceptación de la spec.
- Tests nuevos para la lógica agregada; evals del RAG pasan si aplica.
- CI en verde y PR con instrucciones para probar en el preview.