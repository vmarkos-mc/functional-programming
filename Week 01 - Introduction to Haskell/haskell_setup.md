# Haskell Installation Instructions for Windows

To install Haskell on Windows:

1. Visit this url: [https://www.haskell.org/ghcup/install/](https://www.haskell.org/ghcup/install/).
2. Follow the instructions there or, if it feels overwhelming, just copy-paste this to a powershell (not **cmd**) session: `Set-ExecutionPolicy Bypass -Scope Process -Force;[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; try { & ([ScriptBlock]::Create((Invoke-WebRequest https://www.haskell.org/ghcup/sh/bootstrap-haskell.ps1 -UseBasicParsing))) -Interactive -DisableCurl } catch { Write-Error $_ }
`.
3. Then hit enter and accept all defaults.
4. Wait a few minutes, until the installer finishes.
5. Run from a cmd (not powershell) sessions `ghci` to verify that things work as expected - you might need to exit and reopen cmd for that purpose.

In case of failure, repeat the above and resume installation - there is a common timeout error in some cases.