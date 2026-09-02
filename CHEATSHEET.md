# One-page cheatsheet

Keys come from `revmode-config.tex`. Colour follows the key automatically.

```latex
\comment{co1}{This paragraph needs a citation.}
\reply{sam}{Deliberate -- it is our own result, stated in Section 4.}
\resolved{sam}{Citation added.}

\changed{sam}{Text I have already written to address a comment.}

\suggest{co2}{old wording}{new wording}
\suggestadd{co2}{A sentence somebody proposes to insert.}
\suggestdel{co1}{A sentence somebody proposes to remove.}

\suggest[reject]{co1}{keep this}{not this}   % override accept=all
\suggest[accept]{co1}{drop this}{use this}   % override accept=none

\note{sam}{Private -- master version only.}
\revtodo{sam}{Private TODO -- master version only.}

\masteronly{Whole blocks that only the master version shows.}
\reviewonly{Blocks for the master and circulated versions, not the journal.}
\finalonly{Funding statements, acknowledgements, journal-only material.}

\revbanner              % header saying which version this is
```

In the separate `point-by-point.tex` file:

```latex
\responseheading
\responsepoint{R1}{rev}
  {Reviewer comment copied here.}
  {sam}
  {Formal author response written here.}
\responsechange{sam}{Exact revised manuscript text, when useful.}
```

## Switching version

Overleaf: **Menu → Main document →** `main-original.tex` /
`main-comments.tex` / `main-final.tex` / `main-response.tex`.

Locally: `make original`, `make comments`, `make final`, `make response`, or
`make` for every PDF.

## Accept policy (submitted version only)

| In `main-final.tex` | Effect |
|---|---|
| `\usepackage[mode=final,accept=all]{revmode}` | every pending suggestion applied |
| `\usepackage[mode=final,accept=none]{revmode}` | every pending suggestion discarded |

Per-suggestion `[accept]` / `[reject]` always wins over the global setting.

## Name clashes

If your journal class already defines `\comment`, `\note` or another short name,
load the package with `short=false` and use the long forms: `\revcomment`,
`\revreply`, `\revresolved`, `\revchanged`, `\revsuggest`, `\revadd`,
`\revdel`, `\revnote`.
