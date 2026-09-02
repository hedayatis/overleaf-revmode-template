# Start here: complete RevMode procedure

This is the shortest safe path from opening the folder to submitting a clean
manuscript. Keep all source files together; do not create parallel manuscript
copies.

## 1. Open the project

### Overleaf

1. In Overleaf choose **New Project -> Upload Project**.
2. Upload the RevMode ZIP.
3. Open `START-HERE.md` and keep it beside the editor as your checklist.
4. Choose **Menu -> Main document -> `main-original.tex`**.
5. Click **Recompile**.

### Local or TeXstudio

1. Extract the offline ZIP into one folder.
2. Open `main-original.tex` in TeXstudio.
3. Choose **Options -> Define Current Document as Master Document**.
4. Select `latexmk` as the default compiler when available, then build.

## 2. Define the team and colours

Open `revmode-config.tex`. Replace the demo people with your team:

```latex
\definecollab{sam}{Sam Hedayati}{revBlue}
\definecollab{anna}{Anna Smith}{revRed}
\definecollab{reviewer1}{Reviewer 1}{revPurple}
```

Use the short key (`sam`, `anna`, `reviewer1`) in every markup command. See
`docs/COLLABORATORS.md` for the full palette and custom-colour examples.

## 3. Insert your manuscript

1. Put shared packages and bibliography settings in `preamble.tex`.
2. Replace the demo content in `manuscript.tex` with your paper.
3. Keep the three `main-*.tex` files thin; do not duplicate the manuscript.
4. Compile `main-original.tex` and fix ordinary LaTeX errors before reviewing.

## 4. Review in the original version

Use collaborator keys consistently:

```latex
\comment{anna}{Please add a source for this claim.}
\reply{sam}{Agreed; I will add the recent review.}
\resolved{sam}{Citation and explanation added.}
\changed{sam}{This sentence is the revised manuscript text.}
\suggest{anna}{old wording}{proposed wording}
```

Compile `main-original.tex` while the team is actively working. It shows
everything, including private notes and TODOs.

## 5. Fill the separate response letter

Open `point-by-point.tex`. Copy each reviewer/editor comment and write the
formal response beneath it:

```latex
\responsepoint{R1}{reviewer1}
  {Please explain the sampling procedure.}
  {sam}
  {Thank you. We added a numbered description in Section 3.}
\responsechange{sam}
  {We draw 1,000 independent scenarios using the fixed seed reported below.}
```

The file is intentionally manual: the author controls the final wording sent
to the editor. Compile `main-response.tex` for a separate response-letter PDF.
It is also appended automatically to `main-original.tex` and
`main-comments.tex`.

## 6. Circulate the comment-driven version

1. Select `main-comments.tex` as the main document.
2. Compile and check every comment, response, suggestion and coloured change.
3. Check that private `\note` and `\revtodo` text is absent.
4. Share `main-comments.pdf`, or the corresponding dispatch folder.
5. Update `point-by-point.tex` after every review decision.

## 7. Accept or reject suggestions

The ready-to-submit main file contains:

```latex
\usepackage[mode=final,accept=all]{revmode}
```

`accept=all` accepts all pending suggestions. Use `accept=none` to keep all old
wording. Override individual decisions in the manuscript with `[accept]` or
`[reject]`:

```latex
\suggest[reject]{anna}{preferred wording}{rejected wording}
```

## 8. Produce and inspect the final files

1. Select and compile `main-final.tex`.
2. Search the PDF for collaborator names, `Point-by-point`, TODOs and comments;
   none should remain.
3. Check equations, references, citations, tables and figures visually.
4. Compile `main-response.tex` and check that every reviewer point has a reply.
5. Run `make test` locally when available.

## 9. Package and share

Run `make dispatch`, or use the GitHub Actions artifact. The output contains:

- the original working PDF;
- the comment-driven PDF with the response letter;
- the clean ready-to-submit PDF;
- the standalone point-by-point response PDF;
- an Overleaf source ZIP; and
- a complete offline ZIP.

Submit only the files required by the journal. Keep `manuscript.tex`,
`point-by-point.tex` and `revmode-config.tex` under Git or in the same Overleaf
project so the review history remains understandable.
