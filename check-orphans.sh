#!/usr/bin/env bash
# Fail if any CV has >1 page AND its last page is under THRESHOLD_PT (an orphan).
# Measured: orphan pages 9-123pt; healthy full pages 575-785pt. No ghostscript needed.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"; BUILD="$ROOT/build"
IDS=(en-original en-human en-bot ptbr-original ptbr-human ptbr-bot)
THRESHOLD_PT=200
fail=0
printf '%-16s %-6s %-10s %s\n' CV pages last-pt verdict
for id in "${IDS[@]}"; do
  xdv="$BUILD/$id.xdv"
  [[ -f "$xdv" ]] || { printf '%-16s %-6s %-10s %s\n' "$id" - - "MISSING (make $id)"; fail=1; continue; }
  mapfile -t sizes < <(dvisvgm --page=1- --no-fonts --stdout "$xdv" 2>&1 >/dev/null | grep -i "graphic size")
  n=${#sizes[@]}; h=$(sed -E 's/.* x ([0-9.]+)pt .*/\1/' <<<"${sizes[$((n-1))]}")
  v=ok
  if (( n>1 )) && awk -v h="$h" -v t="$THRESHOLD_PT" 'BEGIN{exit !(h<t)}'; then v="ORPHAN (<${THRESHOLD_PT}pt)"; fail=1; fi
  printf '%-16s %-6s %-10s %s\n' "$id" "$n" "$h" "$v"
done
(( fail )) && echo "FAIL: orphan page(s). Fix per CLAUDE.md (layout/typography/expand - never cut content)." >&2
exit $fail
