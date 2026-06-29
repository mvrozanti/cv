#!/usr/bin/env bash
# README hero = first page of ptbr/human (the PT-BR impact CV).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"; BUILD="$ROOT/build"; ID=ptbr-human
dvisvgm --page=1 --no-fonts --stdout "$BUILD/$ID.xdv" > "$BUILD/$ID-p1.svg" 2>/dev/null
inkscape "$BUILD/$ID-p1.svg" -w 900 -o "$ROOT/preview.png" 2>/dev/null
ls -la "$ROOT/preview.png"
