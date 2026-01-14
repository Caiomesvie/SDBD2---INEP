@echo off
echo Juntando Microdados partes no MICRODADOS_ENEM_2021.csv...
echo.

copy /b "MicrodadosEnem-split-*" "MICRODADOS_ENEM_2021.csv"

echo.
echo concluido!
pause