setlocal

set ROOT=%~dp0
set CODEGEN_TPLDIR=%ROOT%Templates

rem set the required repository environment variables

set RPSMFIL=%ROOT%SFE_Repository\bin\debug\rpsmain.ism
set RPSTFIL=%ROOT%SFE_Repository\bin\debug\rpstext.ism

set OPTS=-e -r

codegen %OPTS% -s BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE PARAMETER -t Symphony_Data_V3_2 -o %ROOT%\AppData_Server -n AppData

codegen %OPTS% -s BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE PARAMETER -t Symphony_DataFieldMapper -o %ROOT%\AppData_Server -n AppData

codegen %OPTS% -s BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE PARAMETER -t Symphony_Content -o %ROOT%\SFE_UI\Resources -n SFE_UI.Content -ut ASSEMBLYNAME=SFE_UI

codegen %OPTS% -s  BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE PARAMETER -t Symphony_Style_V3_2 -o %ROOT%\SFE_UI\Resources -n AppData -ut ASSEMBLYNAME=SFE_UI

codegen %OPTS% -s BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE PARAMETER -t Symphony_Collection_V3_2 -o %ROOT%\SFE_UI\Content -n SFE_UI.Content -ut ASSEMBLYNAME=SFE_UI

codegen %OPTS% -s BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE  -t Symphony_FileIO_V3_2 -o %ROOT%\AppData_Server -n AppData -ut MODELNAMESPACE=AppData
REM parameter removed as codegen template does not allow for relative file

codegen %OPTS% -s BUYER SUPPLIER PRODUCT_GROUP -t Symphony_DOCache_v3_3.tpl 	-o %ROOT%\AppData_Server -n AppData -ut MODELNAMESPACE=AppData -ut ASSEMBLYNAME=AppData_Server

codegen %OPTS% -s * -ms -t Symphony_TableMapper_v3_2 -o %ROOT%\AppData_Server -n AppData








endlocal

