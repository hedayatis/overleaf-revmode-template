#!/usr/bin/env bash
set -euo pipefail
repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_dir"
latexmk -pdf -interaction=nonstopmode -halt-on-error main-original.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error main-comments.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error main-final.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error main-response.tex
