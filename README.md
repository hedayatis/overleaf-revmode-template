# RevMode — one LaTeX source, three manuscripts

[![Build, validate and package](https://github.com/hedayatis/overleaf-revmode-template/actions/workflows/build.yml/badge.svg)](https://github.com/hedayatis/overleaf-revmode-template/actions/workflows/build.yml)
[![MIT License](https://img.shields.io/badge/license-MIT-0B4F6C.svg)](LICENSE)

**RevMode is a free, editor-agnostic revision workflow for research teams.**
Keep the manuscript, reviewer discussion, author replies and accepted changes
in one auditable LaTeX source, then render exactly the view each reader needs.

A free Overleaf-compatible template for collaborative revision. You keep **one**
`.tex` body. From it, three documents are produced by changing nothing but the
main file:

| Version | Main file | What it shows |
|---|---|---|
| **Original** — the working master | `main-original.tex` | Everything: comments, replies, suggestions, private notes, TODOs, master-only sections. Nothing applied. |
| **Comment-driven** — what you circulate | `main-comments.tex` | Comments, replies, suggestions and the changes written to address them, each in its author's colour. Line numbers on. Private notes stripped. A point-by-point response letter generated automatically. |
| **Ready to submit** | `main-final.tex` | Clean text. No colours, no comments, no line numbers. Pending suggestions resolved by the accept policy. |

No `latexdiff` runs, no duplicated files, no
`v3_final_JD_comments_REALfinal.tex`.

Every GitHub Actions run provides a downloadable dispatch bundle containing the
three demo PDFs, an Overleaf-ready ZIP and a complete offline ZIP. Generated
PDFs are not committed, so the repository never drifts away from its source.

## Quick start on Overleaf

1. Download this repository as a ZIP (green **Code** button → *Download ZIP*).
2. In Overleaf: **New Project → Upload Project** and drop the ZIP in.
3. **Menu → Main document** → pick `main-comments.tex` (or whichever version you
   want to see) and recompile.

Switching that one setting is how you switch versions. Everything else stays
put. Overleaf's free tier is enough. RevMode uses standard LaTeX packages. If
the optional `ulem` package is absent on a minimal offline installation, it
falls back automatically to clear `[+]` and `[-]` change marks.

Working locally instead? `make` builds all three PDFs. `make dispatch` also
creates a clean `dist/` folder that can be shared with collaborators.

## Setting up your collaborators

Open `revmode-config.tex`. It is the only file you need to touch:

```latex
\definecollab{sam}{S. Hedayati}{revBlue}
\definecollab{co1}{Co-author 1}{revRed}
\definecollab{co2}{Co-author 2}{revGreen}
\definecollab{rev}{Reviewer}{revPurple}
```

The first argument is the key you type in the markup, the second is the name
shown in the PDF, the third is any `xcolor` colour (`revBlue`, `revRed`,
`revGreen`, `revPurple`, `revOrange`, `revTeal`, `revBrown`, `revPink` are
predefined, print-safe, and reasonably distinguishable; `blue!60!black` works
just as well). Add as many collaborators as you like.

For a complete copy-and-paste setup with custom colours and an annotated
review example, see [Defining collaborators, colours and comments](docs/COLLABORATORS.md).

## The markup

Everything takes the collaborator key as its first argument, so the colour
follows automatically.

| Command | In the master | In the circulated version | In the submitted version |
|---|---|---|---|
| `\comment{who}{text}` | shown | shown | gone |
| `\reply{who}{text}` | shown | shown | gone |
| `\resolved{who}{text}` | shown with ✓ | shown with ✓ | gone |
| `\changed{who}{text}` | underlined in colour | underlined in colour | **kept as normal text** |
| `\suggest{who}{old}{new}` | ~~old~~ <ins>new</ins> | ~~old~~ <ins>new</ins> | `new` or `old`, per policy |
| `\suggestadd{who}{text}` | <ins>text</ins> | <ins>text</ins> | `text` or nothing |
| `\suggestdel{who}{text}` | ~~text~~ | ~~text~~ | nothing or `text` |
| `\note{who}{text}` | shown | **hidden** | gone |
| `\revtodo{who}{text}` | shown | **hidden** | gone |
| `\masteronly{...}` | shown | hidden | hidden |
| `\reviewonly{...}` | shown | shown | hidden |
| `\finalonly{...}` | hidden | hidden | shown |

The distinction that matters: **`\changed` is text you have already written**
and it survives into the journal version; **`\suggest` is a proposal** that has
not been acted on, and the accept policy decides its fate.

### Accepting all suggestions

`main-final.tex` loads the package as

```latex
\usepackage[mode=final,accept=all]{revmode}
```

`accept=all` applies every pending suggestion — that is the one-switch "accept
all" you want at submission time. `accept=none` produces the pre-suggestion
wording instead, which is useful for checking what actually changed.

Individual suggestions override the global policy:

```latex
\suggest[reject]{co1}{the residual}{the error}   % stays "the residual"
\suggest[accept]{co1}{roughly}{approximately}    % always applied
```

A rejected suggestion still shows in the circulated version, so the record of
the discussion survives even after the decision is made.

### The response letter writes itself

`\printrevisionlog` (already at the end of `main-original.tex` and
`main-comments.tex`) prints every comment in document order with its page
number and the replies attached to it. That is your point-by-point response to
reviewers, assembled from the same text you were commenting on. RevMode 1.0.1
records these entries during the current compilation, so the section no longer
depends on an extra hidden build pass.

## Package options

```latex
\usepackage[mode=comments, accept=all, log=true, lineno=true,
            marks=true, short=true]{revmode}
```

- `mode` — `original`, `comments` or `final`.
- `accept` — `all` or `none`. Only affects `mode=final`.
- `log` — record comments for `\printrevisionlog`. Default `true`.
- `lineno` — line numbers. Forced on in `mode=comments`.
- `marks` — superscript `[C1]` anchors next to each comment. Default `true`.
- `short` — also provide `\comment`, `\reply`, `\note`, … as aliases for
  `\revcomment`, `\revreply`, `\revnote`, …. Set `short=false` if another
  package in your journal's class already defines one of those names; the
  `\rev…` forms are always available.

## Using it with a journal template

`revmode.sty` is standalone and class-agnostic. Drop it next to your journal's
`.cls`, add the `\usepackage` line and `\input{revmode-config}`, and it works —
`elsarticle`, `IEEEtran`, `svjour3`, `achemso`, `article`. Nothing in it assumes
anything about the document class.

To keep the three-version structure in an existing project, split it the way
this repo is split: one `manuscript.tex` with the text, one `preamble.tex` with
the packages, and three thin main files that differ only in the `\usepackage`
line.

## Offline use: TeXstudio, VS Code or the command line

You do not have to choose. This is plain LaTeX, so it compiles identically in
Overleaf, TeXstudio, VS Code or `latexmk` on a laptop.
The reason to keep it on Overleaf is that comments only work when everyone
writes into the same file at the same time — which is exactly what a local
editor cannot give you without Git discipline your co-authors will not have.
TeXstudio's own commenting is `%` comments, which vanish from the PDF; your
reviewers never see them. RevMode comments are LaTeX commands and therefore
travel with the paper.

For TeXstudio:

1. Install TeX Live, MacTeX or MiKTeX, then open the project folder.
2. Open the main file you want (`main-original.tex`, `main-comments.tex` or
   `main-final.tex`) and choose **Options → Define Current Document as Master
   Document**.
3. Build twice, or configure `latexmk` as the default compiler.

For a terminal:

```bash
make             # build all three PDFs
make test        # build and verify that content is separated correctly
make dispatch    # create shareable Overleaf and offline bundles in dist/
```

On Windows PowerShell, run `scripts/build-all.ps1`; add `-Dispatch` to create
the same shareable folder.

## What the dispatch folder contains

`make dispatch` creates:

```text
dist/
├── dispatch/
│   ├── 01-original/manuscript-original.pdf
│   ├── 02-comment-driven/manuscript-comment-driven.pdf
│   └── 03-ready-to-submit/manuscript-ready-to-submit.pdf
├── revmode-overleaf-vX.Y.Z.zip
└── revmode-offline-vX.Y.Z.zip
```

The Overleaf ZIP contains only the source required for an upload. The offline
ZIP additionally includes the build helpers, tests, documentation and the three
compiled PDFs.

## Continuous integration and validation

`.github/workflows/build.yml` compiles all three versions on every push, checks
that private notes never enter the circulated or final view, checks that the
final view accepts suggestions and contains no revision markup, and attaches a
complete dispatch bundle in the **Actions** tab.

## Design boundaries

- RevMode controls what LaTeX renders; it does not replace Git merge history or
  Overleaf's real-time editing interface.
- The response ledger follows source order and links replies to the most recent
  comment. Keep a comment and its replies together in the source.
- Use the long `\rev...` commands with `short=false` if a journal class or
  another package already owns a short command such as `\comment`.
- Very complex tracked text inside section titles, captions or PDF bookmarks
  may need the journal class's usual protection rules.

## Repository structure

| Path | Purpose |
|---|---|
| `revmode.sty` | Standalone package and rendering logic |
| `revmode-config.tex` | Collaborator names and colours |
| `manuscript.tex` | One shared manuscript body |
| `main-*.tex` | Three thin rendering entry points |
| `scripts/` | Cross-platform build and dispatch helpers |
| `tests/validate.sh` | Compile-output regression checks |
| `docs/` | Collaborator setup, offline guide and revision records |

## Contributing

Issues and pull requests are welcome. Please see [CONTRIBUTING.md](CONTRIBUTING.md).

## Licence

MIT. Use it, fork it, strip the demo text out and put your own paper in.
