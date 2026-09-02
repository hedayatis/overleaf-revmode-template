# Changelog

All notable changes to this template are recorded here. Versions follow
[semantic versioning](https://semver.org/).

## [1.0.1] — 2026-09-02

**Status:** release

### Added

- Dedicated collaborator guide with copy-and-paste examples for names, keys,
  custom colours, comments, replies, resolved points and suggestions.
- Regression assertions requiring real comment and response entries in the
  generated point-by-point section.

### Fixed

- Populate the point-by-point response ledger during the current compilation.
  Version 1.0.0 could produce only the heading until an additional undocumented
  compilation was forced.

### Validation

- Clean single-pass pdfLaTeX smoke test: response ledger contains C1–C5 and the
  associated replies.
- `make test`: all three modes and response-ledger content checks passed.
- `make dispatch`: both distribution ZIP integrity checks passed.

### Compatibility and migration

- Backward compatible. Existing markup requires no changes; stale 1.0.0 aux
  records are ignored safely.

### Known limitations

- Page numbers are captured when each inline comment is processed; unusually
  complex float-driven layouts should be visually checked.

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
