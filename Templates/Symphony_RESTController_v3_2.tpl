
<CODEGEN_FILENAME><Structure_name>Controller.CodeGen.dbc</CODEGEN_FILENAME>
<REQUIRES_USERTOKEN>MODELNAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>PROCEDURENAMESPACE</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>ASSEMBLYNAME</REQUIRES_USERTOKEN>
<REQUIRES_USERTOKEN>TABLEMAPPER</REQUIRES_USERTOKEN>
;//****************************************************************************
;//
;// Title:       Symphony_RESTController.tpl
;//
;// Type:        CodeGen Template
;//
;// Description: Template to define structure based REST controller for use with Symphony Bridge
;//
;// Author:      Richard C. Morris, RCP Consultants
;//
;// Copyright (c) 2019, RCP Consultants, Inc. All rights reserved.
;//
;// Redistribution and use in source and binary forms, with or without
;// modification, are permitted provided that the following conditions are met:
;//
;// * Redistributions of source code must retain the above copyright notice,
;//   this list of conditions and the following disclaimer.
;//
;// * Redistributions in binary form must reproduce the above copyright notice,
;//   this list of conditions and the following disclaimer in the documentation
;//   and/or other materials provided with the distribution.
;//
;// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
;// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
;// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
;// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
;// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
;// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
;// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
;// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
;// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
;// POSSIBILITY OF SUCH DAMAGE.
;//
;//****************************************************************************
;;****************************************************************************
;; WARNING: This code was generated by CodeGen. Any changes that you
;;          make to this code will be overwritten if the code is regenerated!
;;
;; Template author: Richard C. Morris, RCP Consultants
;;
;; Template Name:   Symphony Framework : <TEMPLATE>.tpl
;;
;;***************************************************************************
import System
import System.Collections.Generic
import System.Text
import System.Web.Http
import System.Net.Http
import System.Net
import System.Net.Http.Formatting
import Newtonsoft.Json
import SymphonyBridgeServerCore
import SymphonyBridgeServerCore.Controller

import <MODELNAMESPACE>

namespace <NAMESPACE>

	public partial class <Structure_name>sController extends ApiController
	
		;;; <summary>
		;;; Returns the requested resource
		;;; </summary>
		;;; <param name="id"></param>
		;;; <param name="fields"></param>
		;;; <param name="filter"></param>
		;;; <param name="casing"></param>
		;;; <param name="sort"></param>
		;;; <param name="limit"></param>
		;;; <param name="procedure"></param>
		;;; <param name="param"></param>
		;;; <returns></returns>
		{HttpGet}
		public method Get		,@HttpResponseMessage
			in req id			,string
			in req fields		,string
			in req filter		,string
			in req casing		,boolean
			in req sort			,string
			in req limit		,int
			in req procedure	,string
			in req param		,string
			endparams

			record
				methodResponse			,@HttpResponseMessage
			endrecord
		proc

			if (!string.IsNullOrEmpty(procedure)) then
			begin
				data controller = new ExecuteController()

				data executeCommand = "exec @<PROCEDURENAMESPACE>." + procedure

				methodResponse  = controller.CustomGet(Request, executeCommand,
				&	'{"DataObjectItem":{"DataObjectClass":"<MODELNAMESPACE>.<Structure_name>_DataREST, <ASSEMBLYNAME>","DataObjectData":{}}}',
				&	param)
			end
			else
			begin

				data localOrderByValue		,string	,""
				data localOrderDirection	,string	,""

				data localFilter			,string	,""

				if (!string.IsNullOrEmpty(filter))
				begin
					if (string.IsNullOrEmpty(id)) then
						localFilter = "Where " + filter
					else
						localFilter = "and " + filter
				end

				data caseSetting = string.Format('{{"SetCaseSensitivity":"{0}"}}', casing.ToString())

				if (!string.IsNullOrEmpty(sort))
				begin
					if (sort(1:1) == "-") then
						localOrderDirection = " DESC"
					else
						localOrderDirection = " ASC"

					localOrderByValue = " Order By " + 	sort.Replace("-", "").Replace("+", "")
				end


				data controller = new SelectController()

				data selectCommand	,string

				selectCommand = "select "
				
				if (limit > 0 )
				begin
					selectCommand = selectCommand + "TOP " + %string(limit)
				end
				
				selectCommand = selectCommand + fields + " from <structure_name> " 

				data paramString	,string	,""
				if (!string.IsNullOrEmpty(id))
				begin
					data params = new Dictionary<string, Object>()
					
					;;split the key incase we have segments
					data idSplit = id.Split(",")
					try 
					begin
<PRIMARY_KEY>
<SEGMENT_LOOP>
					selectCommand = selectCommand + " Where <SEGMENT_NAME> = :<SEGMENT_NUMBER>"
					params.Add('<segment_name>', idSplit[<SEGMENT_NUMBER>])
</SEGMENT_LOOP>
</PRIMARY_KEY>
					end
					catch (e, @Exception)
					begin
						throw new Exception("All required primary segment data not provided")
					end
					endtry
					data settings = new JsonSerializerSettings()
					settings.ContractResolver = new Symphony.Harmony.Core.ContractResolver()
					paramString = JsonConvert.SerializeObject(params, settings)
				end

				selectCommand = selectCommand + localFilter 

				if (!string.IsNullOrEmpty(localOrderByValue))
				begin
					selectCommand = selectCommand + " Order By " + localOrderByValue + localOrderDirection
				end
				
				methodResponse  = controller.CustomGet(Request, selectCommand,
				&	'{"DataObjectItem":{"DataObjectClass":"<MODELNAMESPACE>.<Structure_name>_DataREST, <ASSEMBLYNAME>","DataObjectData":{}}}',
				&	'<TABLEMAPPER>',
				&	paramString,
				&	caseSetting)
			end

			mreturn methodResponse

		endmethod

		;;; <summary>
		;;; Insert passed resource.
		;;; </summary>
		;;; <param name="postItem"></param>
		;;; <param name="procedure"></param>
		;;; <param name="param"></param>
		;;; <returns></returns>
		{HttpPost}
		public method Post		,@HttpResponseMessage
			postItem			,@<Structure_name>_DataREST
			in req procedure	,string
			in req param		,string
			endparams

			record
				methodResponse			,@HttpResponseMessage
			endrecord

		proc

			if (!string.IsNullOrEmpty(procedure)) then
			begin
				data controller = new ExecuteController()

				data executeCommand = "exec @<PROCEDURENAMESPACE>." + procedure

				methodResponse  = controller.CustomGet(Request, executeCommand,
				&	'{"DataObjectItem":{"DataObjectClass":"<MODELNAMESPACE>.<Structure_name>_DataREST, <ASSEMBLYNAME>","DataObjectData":{}}}',
				&	param)
			end
			else
			begin
				;;we must get at least the primary key segments
<PRIMARY_KEY>
<SEGMENT_LOOP>
<IF ALPHA>
				if (string.IsNullOrEmpty(postItem.<segment_name>))
					throw new Exception("<SEGMENT_NAME> is required.")
</IF ALPHA>
<IF NUMERIC>
				if (!postItem.<segment_name>)
					throw new Exception("<SEGMENT_NAME> is required")
</IF NUMERIC>
</SEGMENT_LOOP>
</PRIMARY_KEY>

				;;first construct the required "object"
				data restDataObject = new RESTObjectContainer()
				restDataObject.DataObjectItem = postItem

				data settings = new JsonSerializerSettings()
				settings.ContractResolver = new Symphony.Harmony.Core.ContractResolver()

				data restDataObjectJSON	,string ,JsonConvert.SerializeObject(restDataObject, settings)

				data command = "insert into <structure_name>"

				data controllerInsert = new InsertController()

				methodResponse = controllerInsert.CustomPost(Request, command,
				&	restDataObjectJSON,
				&	'<TABLEMAPPER>')

			end

			mreturn methodResponse

		endmethod

		;;; <summary>
		;;; Update (or insert) passed resource.
		;;; </summary>
		;;; <param name="postItem"></param>
		;;; <param name="procedure"></param>
		;;; <param name="param"></param>
		;;; <returns></returns>
		{HttpPut}
		public method Put		,@HttpResponseMessage
			in req postItem		,@<Structure_name>_DataREST
			in req procedure	,string
			in req param		,string
			endparams

			record
				methodResponse			,@HttpResponseMessage
			endrecord

		proc

			if (!string.IsNullOrEmpty(procedure)) then
			begin
				data controller = new ExecuteController()

				data executeCommand = "exec @<PROCEDURENAMESPACE>." + procedure

				methodResponse  = controller.CustomGet(Request, executeCommand,
				&	'{"DataObjectItem":{"DataObjectClass":"<MODELNAMESPACE>.<Structure_name>_DataREST, <ASSEMBLYNAME>","DataObjectData":{}}}',
				&	param)
			end
			else
			begin
				;;we must get at least the primary key segments
<PRIMARY_KEY>
<SEGMENT_LOOP>
<IF ALPHA>
				if (string.IsNullOrEmpty(postItem.<segment_name>))
					throw new Exception("<SEGMENT_NAME> is required.")
</IF ALPHA>
<IF NUMERIC>
				if (!postItem.<segment_name>)
					throw new Exception("<SEGMENT_NAME> is required")
</IF NUMERIC>
</SEGMENT_LOOP>
</PRIMARY_KEY>

				;;first construct the required REST "object"
				data restDataObject = new RESTObjectContainer()
				restDataObject.DataObjectItem = postItem
				data settings = new JsonSerializerSettings()
				settings.ContractResolver = new Symphony.Harmony.Core.ContractResolver()

				data restDataObjectJSON	,string ,JsonConvert.SerializeObject(restDataObject, settings)

				;;define parameters
				data params = new Dictionary<string, Object>()

				;;define the update command
				data command = "update <structure_name> set" 

				data fieldsToUpdate	,[#]string	,postItem.FieldList.Split(",")

				data fieldPos	,int	,0
				data fieldItem	,string
				foreach fieldItem in fieldsToUpdate
				begin
<FIELD_LOOP>
<IF LANGUAGE>
<IF PKSEGMENT>
<ELSE>
					if (fieldItem == "<Field_sqlname>")
					begin
						incr fieldPos
						command = command + " <Field_sqlname> = :" + %string(fieldPos)
						params.Add('<Field_sqlname>', postItem.<Field_sqlname>)
					end
</IF PKSEGMENT>
</IF LANGUAGE>
</FIELD_LOOP>
				end

				command  = command  + " where "
<PRIMARY_KEY>
<SEGMENT_LOOP>
				incr fieldPos
				command  = command  + "<segment_name> = :" + %string(fieldPos)
				params.Add('key_<segment_name>', postItem.<segment_name>)
</SEGMENT_LOOP>
</PRIMARY_KEY>

				data controllerUpdate = new UpdateController()

				methodResponse = controllerUpdate.CustomPut(Request, command,
				&	restDataObjectJSON,
				&	'<TABLEMAPPER>',
				&	JsonConvert.SerializeObject(params, settings),
				&	'{"SetCaseSensitivity":"true"}')

				;;if we get back a "not found" response we need to try to "insert" the data.
				if (methodResponse.StatusCode == HttpStatusCode.NotFound)
				begin
					data controllerInsert = new InsertController()

					command = "insert into <structure_name>"

					methodResponse = controllerInsert.CustomPost(Request, command,
					&	restDataObjectJSON,
					&	'<TABLEMAPPER>')

				end
			end
			mreturn methodResponse

		endmethod

		;;; <summary>
		;;; Delete the identified resource.
		;;; </summary>
		;;; <param name="id"></param>
		;;; <param name="procedure"></param>
		;;; <param name="param"></param>
		;;; <returns></returns>
		{HttpDelete}
		public method Delete	,@HttpResponseMessage
			in req id			,string
			in req procedure	,string
			in req param		,string
			endparams

			record
				methodResponse			,@HttpResponseMessage
			endrecord

		proc

			if (!string.IsNullOrEmpty(procedure)) then
			begin
				data controller = new ExecuteController()

				data executeCommand = "exec @<PROCEDURENAMESPACE>." + procedure

				methodResponse  = controller.CustomGet(Request, executeCommand,
				&	'{"DataObjectItem":{"DataObjectClass":"<MODELNAMESPACE>.<Structure_name>_DataREST, <ASSEMBLYNAME>","DataObjectData":{}}}',
				&	param)
			end
			else
			begin
				;;we must get at least the primary key segments
				if (string.IsNullOrEmpty(id))
					throw new Exception("Id is required.")

				data command = "delete from <structure_name> where " 
<PRIMARY_KEY>
<SEGMENT_LOOP>
<IF FIRST>
				&	+ "<segment_name> = :1"
</IF FIRST>
</SEGMENT_LOOP>
</PRIMARY_KEY>

				data controller = new DeleteController()

				;;define parameters
				data params = new Dictionary<string, Object>()
<PRIMARY_KEY>
<SEGMENT_LOOP>
<IF FIRST>
				params.Add('<segment_name>', id)
</IF FIRST>
</SEGMENT_LOOP>
</PRIMARY_KEY>

				data settings = new JsonSerializerSettings()
				settings.ContractResolver = new Symphony.Harmony.Core.ContractResolver()

				methodResponse = controller.CustomDelete(Request, command,
				&	'{"DataObjectItem":{"DataObjectClass":"<MODELNAMESPACE>.<Structure_name>_DataREST, <ASSEMBLYNAME>","DataObjectData":{}}}',
				&	'<TABLEMAPPER>',
				&	JsonConvert.SerializeObject(params, settings),
				&	'{"SetCaseSensitivity":"True"}')
			end
			
			mreturn methodResponse
			
		endmethod
	endclass

endnamespace
