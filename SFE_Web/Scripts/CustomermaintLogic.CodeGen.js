//****************************************************************************
// WARNING: This code was generated by CodeGen. Any changes that you
//  		make to this code will be overwritten if the code is regenerated!
//
// Template author: Richard C. Morris, Synergex Technology Evangelist
//
// Template Name:   Symphony Framework : SYMPHONY_SPA_MAINTLOGIC_V3_2.tpl
//
//***************************************************************************

//page wide types/variables

//field validation details
var mFieldDetails = Array();
var mDefaultBackground = null;

//Page on load event handler
function pageLoaded() {

	//get default settings
    mDefaultBackground = document.getElementById("txtCUST_CODE").style.backgroundColor;
	
    //show the list selection view
    ToListSelectionView();

	var keySpecification = "";
	var separator = "";
    keySpecification += separator + "Cust_code";
	separator = ",";
	
    LoadItemsFromServer("customers", keySpecification, "cust_code,name", null, null, 5);

	//sort out field level validation
	
    var control = null;
    control = new FieldControl('txtCUST_CODE', true, 0, 999999);
	mFieldDetails.push(control);
    control = new FieldControl('txtNAME', true, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtADDRESS1', true, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtADDRESS2', false, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtADDRESS3', false, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtPOSTCODE', true, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtPHONE', false, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtCONTACT', false, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtEMAIL', false, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtCREATE_DATE', false, 0, 99999999);
	mFieldDetails.push(control);
}

//handler to display data when reloaded from the server
function DisplayData(itemToEdit) {
	var result = null;
    //put data into the fields
    document.getElementById("txtCUST_CODE").value = itemToEdit.Cust_code;
	document.getElementById("txtCUST_CODE").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtNAME").value = itemToEdit.Name;
	document.getElementById("txtNAME").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtADDRESS1").value = itemToEdit.Address1;
	document.getElementById("txtADDRESS1").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtADDRESS2").value = itemToEdit.Address2;
	document.getElementById("txtADDRESS2").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtADDRESS3").value = itemToEdit.Address3;
	document.getElementById("txtADDRESS3").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtPOSTCODE").value = itemToEdit.Postcode;
	document.getElementById("txtPOSTCODE").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtPHONE").value = itemToEdit.Phone;
	document.getElementById("txtPHONE").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtCONTACT").value = itemToEdit.Contact;
	document.getElementById("txtCONTACT").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtEMAIL").value = itemToEdit.Email;
	document.getElementById("txtEMAIL").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtCREATE_DATE").value = itemToEdit.Create_date;
	document.getElementById("txtCREATE_DATE").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	

    //disable key fields
    document.getElementById("txtCUST_CODE").disabled = true;

    //focus the first page
    document.getElementById("txtNAME").focus(); 
    document.getElementById("txtNAME").select(); 
}

//handler to initialize the fields on the page
function InitializeData() {
    document.getElementById("txtCUST_CODE").value = "";
    document.getElementById("txtNAME").value = "";
    document.getElementById("txtADDRESS1").value = "";
    document.getElementById("txtADDRESS2").value = "";
    document.getElementById("txtADDRESS3").value = "";
    document.getElementById("txtPOSTCODE").value = "";
    document.getElementById("txtPHONE").value = "";
    document.getElementById("txtCONTACT").value = "";
    document.getElementById("txtEMAIL").value = "";
    document.getElementById("txtCREATE_DATE").value = "";

    ValidateResource(true);

    //disable key fields
    document.getElementById("txtCUST_CODE").disabled = false;

    //focus the first page
    document.getElementById("txtCUST_CODE").focus();
    document.getElementById("txtCUST_CODE").select();
}

function SetFieldFocus(fieldSpec) {

	var infoText = "";
	switch (fieldSpec) {
		case "txtCUST_CODE" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtNAME" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtADDRESS1" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtADDRESS2" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtADDRESS3" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtPOSTCODE" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtPHONE" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtCONTACT" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtEMAIL" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtCREATE_DATE" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
	}
}

//validate if field entry.
function ValidateResource(noChangeMethod) {

	validateCUST_CODE(noChangeMethod);
	validateNAME(noChangeMethod);
	validateADDRESS1(noChangeMethod);
	validateADDRESS2(noChangeMethod);
	validateADDRESS3(noChangeMethod);
	validatePOSTCODE(noChangeMethod);
	validatePHONE(noChangeMethod);
	validateCONTACT(noChangeMethod);
	validateEMAIL(noChangeMethod);
	validateCREATE_DATE(noChangeMethod);

}

function validateCUST_CODE(noChangeMethod) {

	DataValueChangedValue("CUST_CODE", null);
	infoText = "";
	document.getElementById("txtCUST_CODE").title = infoText.trim();
	var fieldValue = document.getElementById("txtCUST_CODE").value;

    if (fieldValue == null || fieldValue === "") {
		document.getElementById("txtCUST_CODE").style.backgroundColor = mErrorBackground;
		document.getElementById("txtCUST_CODE").title = "Non-blank/non-zero required.";
    }
    else {
        var regexTest = /^[+]?[0]*[0-9]{0,6}$/;
        var testResult = regexTest.test(fieldValue);
		if (testResult === true) {
			document.getElementById("txtCUST_CODE").style.backgroundColor = mDefaultBackground;
		}
		else {
			document.getElementById("txtCUST_CODE").style.backgroundColor = mErrorBackground;
			document.getElementById("txtCUST_CODE").title = "Invalid value.";
		}
    }
}
function validateNAME(noChangeMethod) {

	DataValueChangedValue("NAME", null);
	infoText = "";
	document.getElementById("txtNAME").title = infoText.trim();
	var fieldValue = document.getElementById("txtNAME").value;

    if (fieldValue == null || fieldValue === "") {
		document.getElementById("txtNAME").style.backgroundColor = mErrorBackground;
		document.getElementById("txtNAME").title = "Non-blank/non-zero required.";
    }
    else {
        var regexTest = /^.{1,30}$/;
        var testResult = regexTest.test(fieldValue);
		if (testResult === true) {
			document.getElementById("txtNAME").style.backgroundColor = mDefaultBackground;
		}
		else {
			document.getElementById("txtNAME").style.backgroundColor = mErrorBackground;
			document.getElementById("txtNAME").title = "Invalid value.";
		}
    }
}
function validateADDRESS1(noChangeMethod) {

	DataValueChangedValue("ADDRESS1", null);
	infoText = "";
	document.getElementById("txtADDRESS1").title = infoText.trim();
	var fieldValue = document.getElementById("txtADDRESS1").value;

    if (fieldValue == null || fieldValue === "") {
		document.getElementById("txtADDRESS1").style.backgroundColor = mErrorBackground;
		document.getElementById("txtADDRESS1").title = "Non-blank/non-zero required.";
    }
    else {
        var regexTest = /^.{1,30}$/;
        var testResult = regexTest.test(fieldValue);
		if (testResult === true) {
			document.getElementById("txtADDRESS1").style.backgroundColor = mDefaultBackground;
		}
		else {
			document.getElementById("txtADDRESS1").style.backgroundColor = mErrorBackground;
			document.getElementById("txtADDRESS1").title = "Invalid value.";
		}
    }
}
function validateADDRESS2(noChangeMethod) {

	DataValueChangedValue("ADDRESS2", null);
	infoText = "";
	document.getElementById("txtADDRESS2").title = infoText.trim();
	var fieldValue = document.getElementById("txtADDRESS2").value;

    var regexTest = /^.{0,30}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtADDRESS2").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtADDRESS2").style.backgroundColor = mErrorBackground;
		document.getElementById("txtADDRESS2").title = "Invalid value.";
	}
}
function validateADDRESS3(noChangeMethod) {

	DataValueChangedValue("ADDRESS3", null);
	infoText = "";
	document.getElementById("txtADDRESS3").title = infoText.trim();
	var fieldValue = document.getElementById("txtADDRESS3").value;

    var regexTest = /^.{0,30}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtADDRESS3").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtADDRESS3").style.backgroundColor = mErrorBackground;
		document.getElementById("txtADDRESS3").title = "Invalid value.";
	}
}
function validatePOSTCODE(noChangeMethod) {

	DataValueChangedValue("POSTCODE", null);
	infoText = "";
	document.getElementById("txtPOSTCODE").title = infoText.trim();
	var fieldValue = document.getElementById("txtPOSTCODE").value;

    if (fieldValue == null || fieldValue === "") {
		document.getElementById("txtPOSTCODE").style.backgroundColor = mErrorBackground;
		document.getElementById("txtPOSTCODE").title = "Non-blank/non-zero required.";
    }
    else {
        var regexTest = /^.{1,10}$/;
        var testResult = regexTest.test(fieldValue);
		if (testResult === true) {
			document.getElementById("txtPOSTCODE").style.backgroundColor = mDefaultBackground;
		}
		else {
			document.getElementById("txtPOSTCODE").style.backgroundColor = mErrorBackground;
			document.getElementById("txtPOSTCODE").title = "Invalid value.";
		}
    }
}
function validatePHONE(noChangeMethod) {

	DataValueChangedValue("PHONE", null);
	infoText = "";
	document.getElementById("txtPHONE").title = infoText.trim();
	var fieldValue = document.getElementById("txtPHONE").value;

    var regexTest = /^.{0,20}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtPHONE").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtPHONE").style.backgroundColor = mErrorBackground;
		document.getElementById("txtPHONE").title = "Invalid value.";
	}
}
function validateCONTACT(noChangeMethod) {

	DataValueChangedValue("CONTACT", null);
	infoText = "";
	document.getElementById("txtCONTACT").title = infoText.trim();
	var fieldValue = document.getElementById("txtCONTACT").value;

    var regexTest = /^.{0,30}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtCONTACT").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtCONTACT").style.backgroundColor = mErrorBackground;
		document.getElementById("txtCONTACT").title = "Invalid value.";
	}
}
function validateEMAIL(noChangeMethod) {

	DataValueChangedValue("EMAIL", null);
	infoText = "";
	document.getElementById("txtEMAIL").title = infoText.trim();
	var fieldValue = document.getElementById("txtEMAIL").value;

    var regexTest = /^.{0,50}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtEMAIL").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtEMAIL").style.backgroundColor = mErrorBackground;
		document.getElementById("txtEMAIL").title = "Invalid value.";
	}
}
function validateCREATE_DATE(noChangeMethod) {

	DataValueChangedValue("CREATE_DATE", null);
	infoText = "";
	document.getElementById("txtCREATE_DATE").title = infoText.trim();
	var fieldValue = document.getElementById("txtCREATE_DATE").value;

    var regexTest = /^[+]?[0]*[0-9]{0,8}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtCREATE_DATE").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtCREATE_DATE").style.backgroundColor = mErrorBackground;
		document.getElementById("txtCREATE_DATE").title = "Invalid value.";
	}
}

function GetPageData(updateFieldList) {

    var pageDataObject = {};

	//first check we have a valid page
	var pageValid = true;
	var color = mDefaultBackground;
	color = document.getElementById("txtCUST_CODE").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtNAME").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtADDRESS1").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtADDRESS2").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtADDRESS3").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtPOSTCODE").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtPHONE").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtCONTACT").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtEMAIL").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtCREATE_DATE").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}

	if (pageValid === false) {
		return null;
	}

	if (updateFieldList === null) {
		pageDataObject["CUST_CODE"] = document.getElementById("txtCUST_CODE").value;
		pageDataObject["NAME"] = document.getElementById("txtNAME").value;
		pageDataObject["ADDRESS1"] = document.getElementById("txtADDRESS1").value;
		pageDataObject["ADDRESS2"] = document.getElementById("txtADDRESS2").value;
		pageDataObject["ADDRESS3"] = document.getElementById("txtADDRESS3").value;
		pageDataObject["POSTCODE"] = document.getElementById("txtPOSTCODE").value;
		pageDataObject["PHONE"] = document.getElementById("txtPHONE").value;
		pageDataObject["CONTACT"] = document.getElementById("txtCONTACT").value;
		pageDataObject["EMAIL"] = document.getElementById("txtEMAIL").value;
		pageDataObject["CREATE_DATE"] = document.getElementById("txtCREATE_DATE").value;
	}
	else
	{
		//always add the primary key
		pageDataObject["CUST_CODE"] = document.getElementById("txtCUST_CODE").value;

		//now add the requested fields
		for (var i = 0; i < updateFieldList.length; i++) {
			if (updateFieldList[i] !== "CUST_CODE") {
				pageDataObject[updateFieldList[i]] = document.getElementById("txt" + updateFieldList[i]).value;
			}
		}
	}
	return pageDataObject;	
}


