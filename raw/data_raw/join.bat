@echo off
setlocal

echo Juntando Microdados partes no MICRODADOS_ENEM_2021.csv...
echo.

copy /b "MicrodadosEnem-split-*" "MICRODADOS_ENEM_2021.csv"

echo.
echo Verificando a integridade do arquivo...
echo.

set "EXPECTED_SHA=31a9db83b9faab2aebce34c454196c72e108ad68321bb78cfc5dc0fb84289911"
set "FILE_TO_CHECK=MICRODADOS_ENEM_2021.csv"
set "ACTUAL_SHA="

for /f "skip=1 tokens=1" %%a in ('certutil -hashfile "%FILE_TO_CHECK%" SHA256') do (
    if not defined ACTUAL_SHA (
        set "ACTUAL_SHA=%%a"
    )
)

echo SHA esperado: %EXPECTED_SHA%
echo SHA calculado: %ACTUAL_SHA%
echo.

if /I "%ACTUAL_SHA%"=="%EXPECTED_SHA%" (
    echo A verificacao do SHA corresponde. O arquivo e integro.
) else (
    echo A verificacao do SHA falhou. O arquivo pode estar corrompido.
)

echo.
echo concluido!
pause
endlocal
