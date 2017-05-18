setlocal

set ROOT=%~dp0
set CODEGEN_TPLDIR=%ROOT%Templates

rem set the required repository environment variables

set RPSMFIL=%ROOT%Rps\rpsmain.ism
set RPSTFIL=%ROOT%Rps\rpstext.ism

set OPTS=-e -r

rem Data library
codegen %OPTS% -s BUYER -t Symphony_Data_v3_2.tpl 	-o %ROOT%\AppData_Server -n AppData -ut ASSEMBLYNAME=AppData
codegen %OPTS% -s BUYER -t Symphony_DataFieldMapper.tpl -o %ROOT%\AppData_Server -n AppData -ut ASSEMBLYNAME=AppData
codegen %OPTS% -s BUYER -t Symphony_FileIO.tpl 		-o %ROOT%\AppData_Server -n AppData -ut ASSEMBLYNAME=AppData
codegen %OPTS% -s BUYER -t Symphony_DOCache_v3_3.tpl 	-o %ROOT%\AppData_Server -n AppData -ut MODELNAMESPACE=AppData -ut ASSEMBLYNAME=AppData

codegen %OPTS% -s BUYER -t Symphony_Collection_v3_2.tpl -o %ROOT%\SFE_UI\Content -n SFE_UI.Content

codegen %OPTS% -s BUYER -t Symphony_Content.tpl 	-o %ROOT%SFE_UI\Resources -n SFE_UI.Content -ut ASSEMBLYNAME=SFE_UI
codegen %OPTS% -s BUYER -t Symphony_Style_v3_2 		-o %ROOT%SFE_UI\Resources -n SFE_UI.Resources -ut ASSEMBLYNAME=SFE_UI









endlocal

