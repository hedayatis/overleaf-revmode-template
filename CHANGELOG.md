# Changelog

All notable changes to this template are recorded here. Versions follow
[semantic versioning](https://semver.org/).

## [1.0.0] — 2026-09-02

**Status:** release

Initial public release of a single-source, three-mode manuscript revision
workflow for Overleaf and offline LaTeX editors.

### Added
- `revmode.sty`: a standalone, class-agnostic package providing three
  rendering modes (`original`, `comments`, `final`) of a single source.
- Per-collaborator colours via `\definecollab{key}{name}{colour}`, with an
  eight-colour print-safe default palette.
- Markup: `\comment`, `\reply`, `\resolved`, `\changed`, `\suggest`,
  `\suggestadd`, `\suggestdel`, `\note`, `\revtodo`, and the block switches
  `\masteronly`, `\reviewonly`, `\finalonly`.
- Accept policy `accept=all` / `accept=none` for the submitted version, with
  per-suggestion `[accept]` / `[reject]` overrides.
- `\printrevisionlog`: an automatically assembled point-by-point response
  letter, built from the `.aux` file.
- `\revbanner`: a header identifying which version the reader is holding.
- Package options `mode`, `accept`, `log`, `lineno`, `marks`, `short`.
- Three main files, a shared preamble, a demo manuscript exercising every
  macro, a `Makefile`, and a GitHub Actions workflow building all three
  versions on every push.
- Cross-platform build helpers and a reproducible dispatch bundle for Overleaf
  and offline collaborators.
- Automated checks that enforce separation of private, review and clean
  submission content.
- An automatic dependency fallback when `ulem` is not installed.

### Validation

- `make test`: all three PDFs compiled and all mode-separation checks passed.
- Dispatch smoke test: both ZIP files were created and listed successfully.

### Compatibility and migration

- Works with Overleaf, TeXstudio, VS Code/LaTeX Workshop and command-line
  `latexmk`; no migration is required for this initial release.

### Known limitations

- The response ledger attaches replies to the most recent comment in source
  order; comments and their replies should remain adjacent.
- Complex tracked text in moving arguments may require journal-specific LaTeX
  protection.
