#!/usr/bin/env python3
"""Utilidades para implementar una spec de Spec Kit historia por historia.

Lee el tasks.md de Spec Kit (fases "## Phase N: ...", tareas "- [ ] T001 ...").

Uso:
  stories.py next <tasks.md>            Imprime el siguiente lote a implementar:
                                        1a línea = id (US1, US2, polish...), luego un título de fase por línea.
                                        No imprime nada si no quedan tareas pendientes.
  stories.py check <tasks.md> <lote>    Falla si alguna fase del lote (archivo generado por `next`)
                                        tiene tareas sin marcar.
  stories.py remaining <tasks.md>       Imprime la cantidad de tareas pendientes.

Regla de lotes:
  - Setup y Foundational van en el mismo PR que la primera historia.
  - Cada historia de usuario siguiente es su propio PR.
  - Las fases finales (Polish) van en un PR aparte.
"""
import re
import sys

PHASE_RE = re.compile(r"^##\s+(.*\S)\s*$")
TASK_RE = re.compile(r"^\s*-\s*\[( |x|X)\]\s")
STORY_RE = re.compile(r"(user\s+story|historia(\s+de\s+usuario)?)\s*(\d+)", re.IGNORECASE)


def parse(path):
    """Devuelve una lista de fases: [{title, pending, total}] en orden."""
    phases = []
    current = None
    with open(path, encoding="utf-8") as f:
        for line in f:
            m = PHASE_RE.match(line)
            if m:
                current = {"title": m.group(1), "pending": 0, "total": 0}
                phases.append(current)
                continue
            t = TASK_RE.match(line)
            if t and current is not None:
                current["total"] += 1
                if t.group(1) == " ":
                    current["pending"] += 1
    return [p for p in phases if p["total"] > 0]


def story_number(title):
    m = STORY_RE.search(title)
    return int(m.group(3)) if m else None


def next_batch(phases):
    start = next((i for i, p in enumerate(phases) if p["pending"] > 0), None)
    if start is None:
        return None, []
    batch = []
    for p in phases[start:]:
        batch.append(p)
        n = story_number(p["title"])
        if n is not None:
            return f"US{n}", batch
    # No quedan historias pendientes: el resto (Polish, etc.) va en un solo PR.
    return "polish", batch


def main():
    if len(sys.argv) < 3:
        print(__doc__)
        sys.exit(2)
    cmd, path = sys.argv[1], sys.argv[2]
    phases = parse(path)

    if cmd == "next":
        sid, batch = next_batch(phases)
        if sid:
            print(sid)
            for p in batch:
                print(p["title"])
    elif cmd == "check":
        with open(sys.argv[3], encoding="utf-8") as f:
            titles = [l.strip() for l in f.readlines()[1:] if l.strip()]
        by_title = {p["title"]: p for p in phases}
        failed = False
        for t in titles:
            p = by_title.get(t)
            if p is None:
                print(f"No se encontró la fase: {t}")
                failed = True
            elif p["pending"] > 0:
                print(f"La fase '{t}' tiene {p['pending']} tarea(s) sin marcar")
                failed = True
        sys.exit(1 if failed else 0)
    elif cmd == "remaining":
        print(sum(p["pending"] for p in phases))
    else:
        print(__doc__)
        sys.exit(2)


if __name__ == "__main__":
    main()
