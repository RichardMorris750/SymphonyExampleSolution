setlocal

set ROOT=%~dp0
set CODEGEN_TPLDIR=%ROOT%Templates

rem set the required repository environment variables

set RPSMFIL=%ROOT%Rps\rpsmain.ism
set RPSTFIL=%ROOT%Rps\rpstext.ism

REM set OPTS=-e -r

rem Data library
REM codegen %OPTS% -s BUYER -t Symphony_Data_v3_2.tpl 	-o %ROOT%\AppData_Server -n AppData -ut ASSEMBLYNAME=AppData
REM codegen %OPTS% -s BUYER -t Symphony_DataFieldMapper.tpl -o %ROOT%\AppData_Server -n AppData -ut ASSEMBLYNAME=AppData
REM codegen %OPTS% -s BUYER -t Symphony_FileIO.tpl 		-o %ROOT%\AppData_Server -n AppData -ut ASSEMBLYNAME=AppData
REM codegen %OPTS% -s BUYER -t Symphony_DOCache_v3_3.tpl 	-o %ROOT%\AppData_Server -n AppData -ut MODELNAMESPACE=AppData -ut ASSEMBLYNAME=AppData
REM codegen %OPTS% -s BUYER -t Symphony_Collection_v3_2.tpl -o %ROOT%\SFE_UI\Content -n SFE_UI.Content
REM codegen %OPTS% -s BUYER -t Symphony_Content.tpl 	-o %ROOT%SFE_UI\Resources -n SFE_UI.Resources -ut ASSEMBLYNAME=SFE_UI
REM codegen %OPTS% -s BUYER -t Symphony_Style_v3_2 		-o %ROOT%SFE_UI\Resources -n SFE_UI.Resources -ut ASSEMBLYNAME=SFE_UI


set OPTS=-e -r -s
codegen %OPTS% PRODUCT_GROUP SUPPLIER -t Symphony_DOCache_v3_3.tpl 	-o %ROOT%\AppData_Server -n AppData -ut MODELNAMESPACE=AppData -ut ASSEMBLYNAME=AppData


codegen %OPTS% BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE PARAMETER -t Symphony_Data_V3_2 -o %ROOT%\AppData_Server -n AppData

codegen %OPTS% BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE PARAMETER -t Symphony_DataFieldMapper -o %ROOT%\AppData_Server -n AppData


codegen %OPTS% BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE PARAMETER -t Symphony_Content -o %ROOT%\SFE_UI\Resources -n SFE_UI.Content -ut ASSEMBLYNAME=SFE_UI

codegen %OPTS%  BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE PARAMETER -t Symphony_Style_V3_2 -o %ROOT%\SFE_UI\Resources -n AppData -ut ASSEMBLYNAME=SFE_UI

codegen %OPTS% BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE PARAMETER -t Symphony_Collection_V3_2 -o %ROOT%\SFE_UI\Content -n SFE_UI.Content -ut ASSEMBLYNAME=SFE_UI

codegen %OPTS% BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE  -t Symphony_FileIO_V3_2 -o %ROOT%\AppData_Server -n AppData -ut MODELNAMESPACE=AppData
REM parameter removed as codegen template does not allow for relative file

codegen %OPTS% * -ms -t Symphony_TableMapper_v3_2 -o %ROOT%\AppData_Server -n AppData








endlocal

