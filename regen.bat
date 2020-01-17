@echo off
setlocal

rem ---------------------------------------------------------------------------
rem set code generation options

set STRUCTURES=EMPLOYEE DEPARTMENT

set ENABLE_CLEAN_DATA=-define CLEAN_DATA
rem set USE_STRUCTURE_ALIASES=-a %STRUCTURES%
rem set USE_ALTERNATE_FIELD_NAMES=-af
rem set ENABLE_EXCLUDE_KEYS= -rpsoverride ExcludeKeyTest.json

rem ---------------------------------------------------------------------------
rem Configure the CodeGen environment

set ROOT=%~dp0
set STDOPTS=-i %ROOT%SRC\TEMPLATES -o %ROOT%SRC\LIBRARY -rps %RPSMFIL% %RPSTFIL% -e -r -lf %USE_STRUCTURE_ALIASES% %USE_ALTERNATE_FIELD_NAMES% %ENABLE_CLEAN_DATA% %ENABLE_EXCLUDE_KEYS%

rem ---------------------------------------------------------------------------
rem Generate code

rem Generate SQL I/O routines for the structures being replicated
codegen  -s %STRUCTURES% -t SqlIO %STDOPTS%

rem Templates requiring all structures to be processed at once
codegen -s %STRUCTURES% -ms -t GetReplicatedTables %STDOPTS%

endlocal
