$ErrorActionPreference = "Stop"

$repo_root = Split-Path -Parent $PSScriptRoot
$dev_env = Join-Path $PSScriptRoot "dev-env.ps1"

Push-Location $repo_root
try {
    $files = Get-ChildItem -Path . -Recurse -File -Include *.c, *.h |
        Where-Object { $_.FullName -notmatch "\\build\\" } |
        ForEach-Object { $_.FullName }

    if ($files.Count -eq 0) {
        exit 0
    }

    & $dev_env clang-format -i @files
    exit $LASTEXITCODE
} finally {
    Pop-Location
}
