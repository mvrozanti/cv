#!/usr/bin/env bash
# README image = ALL pages of ptbr/original (the primary CV), stacked and
# flattened onto white so the dark CV text stays visible on GitHub's dark
# theme (a transparent background made it invisible there).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"; BUILD="$ROOT/build"; ID=ptbr-original

npages=$(dvisvgm --page=1- --no-fonts --stdout "$BUILD/$ID.xdv" 2>&1 >/dev/null | grep -c "graphic size")
pages=()
for p in $(seq 1 "$npages"); do
  dvisvgm --page="$p" --no-fonts --stdout "$BUILD/$ID.xdv" > "$BUILD/$ID-p$p.svg" 2>/dev/null
  inkscape "$BUILD/$ID-p$p.svg" -w 720 -b '#ffffff' -y 1.0 -o "$BUILD/$ID-p$p.png" 2>/dev/null
  pages+=("$BUILD/$ID-p$p.png")
done

magick montage "${pages[@]}" -tile 1x -geometry +0+12 -background white "$ROOT/preview.png"
ls -la "$ROOT/preview.png"
