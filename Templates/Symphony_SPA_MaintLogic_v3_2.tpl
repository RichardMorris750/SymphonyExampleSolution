<CODEGEN_FILENAME><Structure_name>maintLogic.CodeGen.js</CODEGEN_FILENAME>
<OPTIONAL_USERTOKEN>RESTRICTEDFIELDLIST=</OPTIONAL_USERTOKEN>
<OPTIONAL_USERTOKEN>RESTRICTEDITEMCOUNT=5</OPTIONAL_USERTOKEN>
;//****************************************************************************
;//
;// Title:  	 Symphony_SPA_MaintLogic_v3.tpl
;//
;// Type:   	 CodeGen Template
;//
;// Description: Template to define page-behind java script logic for Single Page Applciaiton web site
;//
;// Author: 	 Richard C. Morris, RCP Consultants
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
//****************************************************************************
// WARNING: This code was generated by CodeGen. Any changes that you
//  		make to this code will be overwritten if the code is regenerated!
//
// Template author: Richard C. Morris, RCP Consultants
//
// Template Name:   Symphony Framework : <TEMPLATE>.tpl
//
//***************************************************************************

//page wide types/variables

//field validation details
var mFieldDetails = Array();
var mDefaultBackground = null;

//Page on load event handler
function pageLoaded() {

	//get default settings
    mDefaultBackground = document.getElementById("txt<PRIMARY_KEY_FIELD>").style.backgroundColor;
	
    //show the list selection view
    ToListSelectionView();

	var keySpecification = "";
	var separator = "";
<PRIMARY_KEY>
<SEGMENT_LOOP>
    keySpecification += separator + "<Segment_name>";
	separator = ",";
</SEGMENT_LOOP>
</PRIMARY_KEY>
	
    LoadItemsFromServer("<structure_name>s", keySpecification, "<RESTRICTEDFIELDLIST>", null, null, <RESTRICTEDITEMCOUNT>);

	//sort out field level validation
	
    var control = null;
<FIELD_LOOP>
<IF NUMERIC>
    control = new FieldControl('txt<FIELD_SQLNAME>', <IF REQUIRED>true</IF><IF OPTIONAL>false</IF>, <FIELD_MINVALUE>, <FIELD_MAXVALUE>);
<ELSE>
    control = new FieldControl('txt<FIELD_SQLNAME>', <IF REQUIRED>true</IF><IF OPTIONAL>false</IF>, null, null);
</IF NUMERIC>
	mFieldDetails.push(control);
</FIELD_LOOP>	
}

//handler to display data when reloaded from the server
function DisplayData(itemToEdit) {
	var result = null;
    //put data into the fields
<FIELD_LOOP>
    document.getElementById("txt<FIELD_SQLNAME>").value = itemToEdit.<Field_sqlname>;
	document.getElementById("txt<FIELD_SQLNAME>").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
<IF CHANGE>
	document.getElementById("lbl<FIELD_SQLNAME>").value = "";
	result = ExecuteChangeMethod("<FIELD_CHANGEM>", "<FIELD_SQLNAME>", itemToEdit.<Field_sqlname>);
	if (result === false) {
		document.getElementById("txt<FIELD_SQLNAME>").style.backgroundColor = mErrorBackground;
	}
</IF CHANGE>
	
</FIELD_LOOP>	

    //disable key fields
    document.getElementById("txt<PRIMARY_KEY_FIELD>").disabled = true;

    //focus the first page
    document.getElementById("txt<DISPLAY_FIELD>").focus(); 
    document.getElementById("txt<DISPLAY_FIELD>").select(); 
}

//handler to initialize the fields on the page
function InitializeData() {
<FIELD_LOOP>
<IF DEFAULT>
    document.getElementById("txt<FIELD_SQLNAME>").value = "<FIELD_DEFAULT>";
<ELSE>
    document.getElementById("txt<FIELD_SQLNAME>").value = "";
</IF DEFAULT>
<IF CHANGE>
	document.getElementById("lbl<FIELD_SQLNAME>").innerText = "";
</IF CHANGE>
</FIELD_LOOP>	

    ValidateResource(true);

    //disable key fields
    document.getElementById("txt<PRIMARY_KEY_FIELD>").disabled = false;

    //focus the first page
    document.getElementById("txt<PRIMARY_KEY_FIELD>").focus();
    document.getElementById("txt<PRIMARY_KEY_FIELD>").select();
}

function SetFieldFocus(fieldSpec) {

	var infoText = "";
	switch (fieldSpec) {
<FIELD_LOOP>
		case "txt<FIELD_SQLNAME>" :
			infoText = "<FIELD_INFOLINE>";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
</FIELD_LOOP>
	}
}

//validate if field entry.
function ValidateResource(noChangeMethod) {

<FIELD_LOOP>
	validate<FIELD_SQLNAME>(noChangeMethod);
</FIELD_LOOP>

}

<FIELD_LOOP>
function validate<FIELD_SQLNAME>(noChangeMethod) {

	DataValueChangedValue("<FIELD_SQLNAME>", null);
	infoText = "<FIELD_INFOLINE>";
	document.getElementById("txt<FIELD_SQLNAME>").title = infoText.trim();
<IF UPPERCASE>
	var fieldValue = document.getElementById("txt<FIELD_SQLNAME>").value.toUpperCase();
<ELSE>
	var fieldValue = document.getElementById("txt<FIELD_SQLNAME>").value;
</IF UPPERCASE>

<IF REQUIRED>
    if (fieldValue == null || fieldValue === "") {
		document.getElementById("txt<FIELD_SQLNAME>").style.backgroundColor = mErrorBackground;
		document.getElementById("txt<FIELD_SQLNAME>").title = "Non-blank/non-zero required.";
    }
    else {
        var regexTest = /<FIELD_REGEX>/;
        var testResult = regexTest.test(fieldValue);
		if (testResult === true) {
			document.getElementById("txt<FIELD_SQLNAME>").style.backgroundColor = mDefaultBackground;
<IF NUMERIC>
<IF RANGE>
			//check entered value against a range
			if (fieldValue < <FIELD_RANGE_MIN> || fieldValue > <FIELD_RANGE_MAX>) {
				document.getElementById("txt<FIELD_SQLNAME>").style.backgroundColor = mErrorBackground;
				document.getElementById("txt<FIELD_SQLNAME>").title = "Out of range.";
			}
</IF RANGE>
</IF>
<IF CHANGE>
			document.getElementById("lbl<FIELD_SQLNAME>").value = "";
			if (noChangeMethod == null || (noChangeMethod !== null && noChangeMethod === false)) {
				ExecuteChangeMethod("<FIELD_CHANGEM>", "<FIELD_SQLNAME>", fieldValue);
			}
</IF CHANGE>
		}
		else {
			document.getElementById("txt<FIELD_SQLNAME>").style.backgroundColor = mErrorBackground;
			document.getElementById("txt<FIELD_SQLNAME>").title = "Invalid value.";
		}
    }
<ELSE>
    var regexTest = /<FIELD_REGEX>/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txt<FIELD_SQLNAME>").style.backgroundColor = mDefaultBackground;
<IF CHANGE>
		document.getElementById("lbl<FIELD_SQLNAME>").value = "";
		if (noChangeMethod == null || (noChangeMethod !== null && noChangeMethod === false)) {
			ExecuteChangeMethod("<FIELD_CHANGEM>", "<FIELD_SQLNAME>", fieldValue);
		}
</IF CHANGE>
	}
	else {
		document.getElementById("txt<FIELD_SQLNAME>").style.backgroundColor = mErrorBackground;
		document.getElementById("txt<FIELD_SQLNAME>").title = "Invalid value.";
	}
</IF REQUIRED>
}
</FIELD_LOOP>

function GetPageData(updateFieldList) {

    var pageDataObject = {};

	//first check we have a valid page
	var pageValid = true;
	var color = mDefaultBackground;
<FIELD_LOOP>
	color = document.getElementById("txt<FIELD_SQLNAME>").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
</FIELD_LOOP>	

	if (pageValid === false) {
		return null;
	}

	if (updateFieldList === null) {
<FIELD_LOOP>
		pageDataObject["<FIELD_SQLNAME>"] = document.getElementById("txt<FIELD_SQLNAME>").value;
</FIELD_LOOP>	
	}
	else
	{
		//always add the primary key
		pageDataObject["<PRIMARY_KEY_FIELD>"] = document.getElementById("txt<PRIMARY_KEY_FIELD>").value;

		//now add the requested fields
		for (var i = 0; i < updateFieldList.length; i++) {
			if (updateFieldList[i] !== "<PRIMARY_KEY_FIELD>") {
				pageDataObject[updateFieldList[i]] = document.getElementById("txt" + updateFieldList[i]).value;
			}
		}
	}
	return pageDataObject;	
}

