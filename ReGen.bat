setlocal

@echo off

set ROOT=%~dp0
set CODEGEN_TPLDIR=%ROOT%Templates

rem set the required repository environment variables

set RPSMFIL=%ROOT%SFE_Repository\bin\debug\rpsmain.ism
set RPSTFIL=%ROOT%SFE_Repository\bin\debug\rpstext.ism

set strList=BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE PARAMETER CUSTOMER SALES_ORDER_HEADER SALES_ORDER_LINE
set strListLessParameter=BUYER PRODUCT SUPPLIER PRODUCT_GROUP ORDER_HEADER ORDER_LINE CUSTOMER SALES_ORDER_HEADER SALES_ORDER_LINE

set storedProcedureName=StoredProcedures

set serverProjectNameSpace=AppData
set clientProjectNameSpace=SFE_UI

set OPTS=-e -r

rem Data library
codegen %OPTS% -s %strList% -t Symphony_Data_V3_2 -o %ROOT%\AppData_Server -n %serverProjectNameSpace%

rem Stadnard File IO classes
codegen %OPTS% -s %strListLessParameter% -t Symphony_FileIO_V3_2 -o %ROOT%\AppData_Server -n AppData -ut MODELNAMESPACE=%serverProjectNameSpace%

rem Data object cache classes
codegen %OPTS% -s BUYER SUPPLIER PRODUCT_GROUP -t Symphony_DOCache_v3_3.tpl 	-o %ROOT%%serverProjectNameSpace%_Server -n %serverProjectNameSpace% -ut MODELNAMESPACE=%serverProjectNameSpace% -ut ASSEMBLYNAME=%serverProjectNameSpace%_Server

rem Data mapping
codegen %OPTS% -s %strList% -t Symphony_DataFieldMapper -o %ROOT%\%serverProjectNameSpace%_Server -n %serverProjectNameSpace%

rem Table mapping routine
codegen %OPTS% -s * -ms -t Symphony_TableMapper_v3_2 -o %ROOT%\%serverProjectNameSpace%_Server -n %serverProjectNameSpace%

rem REST data objects
codegen e -r -s %strListLessParameter% -t Symphony_DataREST_v3_2 -o %ROOT%\%serverProjectNameSpace%_Server -n %serverProjectNameSpace%

rem REST Contollers
codegen e -r -s %strListLessParameter% -t Symphony_RESTController_v3_2 -o %ROOT%\%serverProjectNameSpace%_Server -n %serverProjectNameSpace% -ut MODELNAMESPACE=%serverProjectNameSpace% -ut ASSEMBLYNAME=%serverProjectNameSpace% -ut TABLEMAPPER=%serverProjectNameSpace%.TableMapper.MapTableToFile -ut PROCEDURENAMESPACE=%serverProjectNameSpace%.%storedProcedureName%

rem Content files contain repository selection field data
codegen %OPTS% -s %strList% -t Symphony_Content -o %ROOT%\%clientProjectNameSpace%\Resources -n %clientProjectNameSpace%.Content -ut ASSEMBLYNAME=%clientProjectNameSpace%

rem Styles define field input control styling
codegen %OPTS% -s %strList% -t Symphony_Style_V3_2 -o %ROOT%\%clientProjectNameSpace%\Resources -n %serverProjectNameSpace% -ut ASSEMBLYNAME=SFE_UI

rem Create the connection object between styled input controls and select data 
codegen %OPTS% -s %strList% -t Symphony_Collection_V3_2 -o %ROOT%\%clientProjectNameSpace%\Content -n %clientProjectNameSpace%.Content -ut ASSEMBLYNAME=%clientProjectNameSpace%









endlocal

