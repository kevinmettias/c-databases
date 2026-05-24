# Local Development

Use MSYS2 UCRT64 on Windows.

```powershell
C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File scripts\dev-env.ps1
C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File scripts\local-ci.ps1
```

Useful CMake presets:

```powershell
C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File scripts\dev-env.ps1 cmake --preset debug
C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File scripts\dev-env.ps1 cmake --build --preset debug
C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy Bypass -File scripts\dev-env.ps1 ctest --preset debug
```

The `sanitize-linux` preset is intended for Linux, WSL, and CI. Native Windows/MSYS2 GCC builds may not provide ASan/UBSan runtime libraries.
