$ErrorActionPreference = "Stop"

$repo_root = Split-Path -Parent $PSScriptRoot
$dev_env = Join-Path $PSScriptRoot "dev-env.ps1"
$coverage_dir = "build-coverage"

Push-Location $repo_root
try {
    & $dev_env cmake -S . -B $coverage_dir -G Ninja -DENABLE_COVERAGE=ON
    & $dev_env cmake --build $coverage_dir --parallel
    & $dev_env ctest --test-dir $coverage_dir --output-on-failure
    & $dev_env lcov --capture --directory $coverage_dir --output-file "$coverage_dir/coverage.info"
    & $dev_env lcov --summary "$coverage_dir/coverage.info"
} finally {
    Pop-Location
}
