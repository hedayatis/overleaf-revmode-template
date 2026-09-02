#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_dir"

if [[ "${1:-}" != "--no-build" ]]; then
  latexmk -pdf -interaction=nonstopmode -halt-on-error main-original.tex >/dev/null
  latexmk -pdf -interaction=nonstopmode -halt-on-error main-comments.tex >/dev/null
  latexmk -pdf -interaction=nonstopmode -halt-on-error main-final.tex >/dev/null
  latexmk -pdf -interaction=nonstopmode -halt-on-error main-response.tex >/dev/null
fi

for pdf in main-original.pdf main-comments.pdf main-final.pdf main-response.pdf; do
  [[ -s "$pdf" ]] || { echo "missing or empty: $pdf" >&2; exit 1; }
done

if ! command -v pdftotext >/dev/null 2>&1; then
  echo "pdftotext is required for validation" >&2
  exit 1
fi

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
pdftotext main-original.pdf "$tmp_dir/original.txt"
pdftotext main-comments.pdf "$tmp_dir/comments.txt"
pdftotext main-final.pdf "$tmp_dir/final.txt"
pdftotext main-response.pdf "$tmp_dir/response.txt"
for view in original comments final response; do
  tr '\n' ' ' < "$tmp_dir/$view.txt" | tr -s '[:space:]' ' ' > "$tmp_dir/$view.normalized.txt"
done

assert_has() {
  local file="$1" text="$2"
  grep -Fq "$text" "$file" || { echo "expected '$text' in $file" >&2; exit 1; }
}

assert_lacks() {
  local file="$1" text="$2"
  if grep -Fq "$text" "$file"; then
    echo "unexpected '$text' in $file" >&2
    exit 1
  fi
}

assert_has "$tmp_dir/original.normalized.txt" "Private reminder"
assert_has "$tmp_dir/original.normalized.txt" "Working scratch"
assert_has "$tmp_dir/comments.normalized.txt" "Point-by-point response"
assert_has "$tmp_dir/comments.normalized.txt" "[R1] Reviewer"
assert_has "$tmp_dir/comments.normalized.txt" "description of the estimator"
assert_has "$tmp_dir/comments.normalized.txt" "expanded the method"
assert_lacks "$tmp_dir/comments.normalized.txt" "Private reminder"
assert_lacks "$tmp_dir/comments.normalized.txt" "Working scratch"

assert_has "$tmp_dir/final.normalized.txt" "linear in the number of iterations"
assert_has "$tmp_dir/final.normalized.txt" "the residual"
assert_has "$tmp_dir/final.normalized.txt" "Funding"
assert_lacks "$tmp_dir/final.normalized.txt" "roughly linear"
assert_lacks "$tmp_dir/final.normalized.txt" "Co-author 1"
assert_lacks "$tmp_dir/final.normalized.txt" "Reviewer"
assert_lacks "$tmp_dir/final.normalized.txt" "Point-by-point response"
assert_lacks "$tmp_dir/final.normalized.txt" "Private reminder"

assert_has "$tmp_dir/response.normalized.txt" "Point-by-point response"
assert_has "$tmp_dir/response.normalized.txt" "[R1] Reviewer"
assert_has "$tmp_dir/response.normalized.txt" "Change in manuscript"
assert_lacks "$tmp_dir/response.normalized.txt" "Private reminder"

echo "RevMode validation passed: three manuscript modes and the standalone response are separated."
