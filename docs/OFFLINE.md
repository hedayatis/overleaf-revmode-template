# Offline and TeXstudio guide

RevMode is a normal LaTeX project. Internet access is not required after a TeX
distribution is installed.

## Requirements

- TeX Live 2021+, MacTeX or MiKTeX
- `latexmk` for one-command builds (recommended)
- `make` on macOS/Linux when using the Makefile

The required packages are `kvoptions`, `xcolor` and `lineno`. `ulem` is
optional: without it, RevMode uses visible `[+]`/`[-]` fallback marks.

## TeXstudio

1. Extract `revmode-offline-vX.Y.Z.zip`.
2. Open the desired `main-*.tex` file.
3. Choose **Options → Define Current Document as Master Document**.
4. In **Options → Configure TeXstudio → Build**, select `Latexmk` as the default
   compiler when available.
5. Build `main-original.tex` while writing, `main-comments.tex` when circulating
   a review, and `main-final.tex` before submission.

If the response ledger says this is the first compilation, build again.

## Command line

macOS/Linux:

```bash
make
make test
make dispatch
```

Windows PowerShell:

```powershell
./scripts/build-all.ps1
./scripts/build-all.ps1 -Dispatch
```

## Sharing choices

- Share the Overleaf ZIP when the recipient will upload a project.
- Share the offline ZIP when the recipient wants source, build helpers and PDFs.
- Share one PDF from `dist/dispatch/` when the recipient only needs to read a
  particular view.

Do not exchange manually renamed manuscript copies. Keep the shared source in
Git or Overleaf and regenerate the view that each recipient needs.
