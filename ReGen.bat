setlocal

set ROOT=%~dp0
set CODEGEN_TPLDIR=%ROOT%Templates

rem set the required repository environment variables

set RPSMFIL=%ROOT%Rps\rpsmain.ism
set RPSTFIL=%ROOT%Rps\rpstext.ism

set OPTS=-e -r

rem Data library
codegen %OPTS% -s SUPPLIER PRODUCT_GROUP -t Symphony_DOCache_v3_3.tpl -o %ROOT%\AppData_Server -n AppData -ut MODELNAMESPACE=AppData -ut ASSEMBLYNAME=AppData

codegen %OPTS% -s PRODUCT -t Symphony_Style_v3_2 -o %ROOT%SFE_UI\Resources -n SFE_UI.Resources -ut ASSEMBLYNAME=SFE_UI


endlocal

