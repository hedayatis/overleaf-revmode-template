# Contributing to RevMode

Thanks for helping make manuscript revision less fragile.

## Good contributions

- A minimal example that exposes a compatibility problem with a journal class.
- A failing regression case for a command or rendering mode.
- Clearer instructions for Overleaf or a local LaTeX editor.
- A backwards-compatible macro or package option that serves a common review
  workflow.

## Development workflow

1. Fork the repository and create a focused branch.
2. Keep `manuscript.tex` as the single body; do not add parallel final copies.
3. Run `make test`.
4. If packaging changed, run `make dispatch` and inspect both ZIP listings.
5. Explain user-visible behaviour and compatibility in the pull request.

Please do not commit generated PDFs, auxiliary LaTeX files or `dist/`. The CI
workflow publishes reproducible build artefacts.
