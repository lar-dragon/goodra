@echo off
set script=\%~dp0%\goodra.sh
set script=%script:\=/%
set script=%script::=%
"C:\Program Files\Git\bin\bash.exe" -c "%script% %*"
