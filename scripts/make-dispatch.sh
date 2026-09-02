#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_dir"

if [[ "${1:-}" != "--no-build" ]]; then
  bash tests/validate.sh
fi

version="$(tr -d '\r\n' < VERSION)"
dist_dir="$repo_dir/dist"
stage_dir="$(mktemp -d)"
trap 'rm -rf "$stage_dir"' EXIT

rm -rf "$dist_dir"
mkdir -p \
  "$dist_dir/dispatch/01-original" \
  "$dist_dir/dispatch/02-comment-driven" \
  "$dist_dir/dispatch/03-ready-to-submit" \
  "$dist_dir/dispatch/04-response-letter" \
  "$stage_dir/revmode-overleaf" \
  "$stage_dir/revmode-offline"

cp main-original.pdf "$dist_dir/dispatch/01-original/manuscript-original.pdf"
cp main-comments.pdf "$dist_dir/dispatch/02-comment-driven/manuscript-comment-driven.pdf"
cp main-final.pdf "$dist_dir/dispatch/03-ready-to-submit/manuscript-ready-to-submit.pdf"
cp main-response.pdf "$dist_dir/dispatch/04-response-letter/point-by-point-response.pdf"

source_files=(
  main-original.tex main-comments.tex main-final.tex main-response.tex
  manuscript.tex point-by-point.tex preamble.tex revmode.sty revmode-config.tex
  README.md START-HERE.md CHEATSHEET.md LICENSE VERSION
  docs/COLLABORATORS.md
)
for file in "${source_files[@]}"; do
  mkdir -p "$stage_dir/revmode-overleaf/$(dirname "$file")"
  cp "$file" "$stage_dir/revmode-overleaf/$file"
done

cp -R "$stage_dir/revmode-overleaf/." "$stage_dir/revmode-offline/"
cp Makefile CHANGELOG.md CONTRIBUTING.md CITATION.cff "$stage_dir/revmode-offline/"
cp -R docs scripts tests .github "$stage_dir/revmode-offline/"
cp -R "$dist_dir/dispatch" "$stage_dir/revmode-offline/"

(cd "$stage_dir" && zip -qr "$dist_dir/revmode-overleaf-v${version}.zip" revmode-overleaf)
(cd "$stage_dir" && zip -qr "$dist_dir/revmode-offline-v${version}.zip" revmode-offline)

unzip -tq "$dist_dir/revmode-overleaf-v${version}.zip"
unzip -tq "$dist_dir/revmode-offline-v${version}.zip"
echo "Dispatch bundle created in dist/."
