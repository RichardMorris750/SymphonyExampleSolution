//****************************************************************************
// WARNING: This code was generated by CodeGen. Any changes that you
//  		make to this code will be overwritten if the code is regenerated!
//
// Template author: Richard C. Morris, RCP Consultants
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
    mDefaultBackground = document.getElementById("txtPROD_GROUP").style.backgroundColor;
	
    //show the list selection view
    ToListSelectionView();

	var keySpecification = "";
	var separator = "";
    keySpecification += separator + "Prod_group";
	separator = ",";
	
    LoadItemsFromServer("product_groups", keySpecification, "prod_group,group_desc", null, null, 5);

	//sort out field level validation
	
    var control = null;
    control = new FieldControl('txtPROD_GROUP', false, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtGROUP_DESC', false, null, null);
	mFieldDetails.push(control);
}

//handler to display data when reloaded from the server
function DisplayData(itemToEdit) {
	var result = null;
    //put data into the fields
    document.getElementById("txtPROD_GROUP").value = itemToEdit.Prod_group;
	document.getElementById("txtPROD_GROUP").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtGROUP_DESC").value = itemToEdit.Group_desc;
	document.getElementById("txtGROUP_DESC").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	

    //disable key fields
    document.getElementById("txtPROD_GROUP").disabled = true;

    //focus the first page
    document.getElementById("txtGROUP_DESC").focus(); 
    document.getElementById("txtGROUP_DESC").select(); 
}

//handler to initialize the fields on the page
function InitializeData() {
    document.getElementById("txtPROD_GROUP").value = "";
    document.getElementById("txtGROUP_DESC").value = "";

    ValidateResource(true);

    //disable key fields
    document.getElementById("txtPROD_GROUP").disabled = false;

    //focus the first page
    document.getElementById("txtPROD_GROUP").focus();
    document.getElementById("txtPROD_GROUP").select();
}

function SetFieldFocus(fieldSpec) {

	var infoText = "";
	switch (fieldSpec) {
		case "txtPROD_GROUP" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtGROUP_DESC" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
	}
}

//validate if field entry.
function ValidateResource(noChangeMethod) {

	validatePROD_GROUP(noChangeMethod);
	validateGROUP_DESC(noChangeMethod);

}

function validatePROD_GROUP(noChangeMethod) {

	DataValueChangedValue("PROD_GROUP", null);
	infoText = "";
	document.getElementById("txtPROD_GROUP").title = infoText.trim();
	var fieldValue = document.getElementById("txtPROD_GROUP").value.toUpperCase();

    var regexTest = /^.{0,3}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtPROD_GROUP").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtPROD_GROUP").style.backgroundColor = mErrorBackground;
		document.getElementById("txtPROD_GROUP").title = "Invalid value.";
	}
}
function validateGROUP_DESC(noChangeMethod) {

	DataValueChangedValue("GROUP_DESC", null);
	infoText = "";
	document.getElementById("txtGROUP_DESC").title = infoText.trim();
	var fieldValue = document.getElementById("txtGROUP_DESC").value;

    var regexTest = /^.{0,20}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtGROUP_DESC").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtGROUP_DESC").style.backgroundColor = mErrorBackground;
		document.getElementById("txtGROUP_DESC").title = "Invalid value.";
	}
}

function GetPageData(updateFieldList) {

    var pageDataObject = {};

	//first check we have a valid page
	var pageValid = true;
	var color = mDefaultBackground;
	color = document.getElementById("txtPROD_GROUP").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtGROUP_DESC").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}

	if (pageValid === false) {
		return null;
	}

	if (updateFieldList === null) {
		pageDataObject["PROD_GROUP"] = document.getElementById("txtPROD_GROUP").value;
		pageDataObject["GROUP_DESC"] = document.getElementById("txtGROUP_DESC").value;
	}
	else
	{
		//always add the primary key
		pageDataObject["PROD_GROUP"] = document.getElementById("txtPROD_GROUP").value;

		//now add the requested fields
		for (var i = 0; i < updateFieldList.length; i++) {
			if (updateFieldList[i] !== "PROD_GROUP") {
				pageDataObject[updateFieldList[i]] = document.getElementById("txt" + updateFieldList[i]).value;
			}
		}
	}
	return pageDataObject;	
}

