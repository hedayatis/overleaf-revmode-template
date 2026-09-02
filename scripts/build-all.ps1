param([switch]$Dispatch)

$ErrorActionPreference = "Stop"
$RepoDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Push-Location $RepoDir
try {
    foreach ($Main in @("main-original.tex", "main-comments.tex", "main-final.tex")) {
        & latexmk -pdf -interaction=nonstopmode -halt-on-error $Main
        if ($LASTEXITCODE -ne 0) { throw "LaTeX build failed for $Main" }
    }
    if ($Dispatch) {
        & bash scripts/make-dispatch.sh --no-build
        if ($LASTEXITCODE -ne 0) { throw "Dispatch packaging failed" }
    }
}
finally {
    Pop-Location
}
