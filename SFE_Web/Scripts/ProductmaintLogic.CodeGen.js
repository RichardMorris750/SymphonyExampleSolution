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
    mDefaultBackground = document.getElementById("txtPROD_CODE").style.backgroundColor;
	
    //show the list selection view
    ToListSelectionView();

	var keySpecification = "";
	var separator = "";
    keySpecification += separator + "Prod_code";
	separator = ",";
	
    LoadItemsFromServer("products", keySpecification, "prod_code,prod_description", null, null, 5);

	//sort out field level validation
	
    var control = null;
    control = new FieldControl('txtPROD_CODE', false, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtPROD_DESCRIPTION', false, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtSUPP_CODE', false, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtCOST_PRICE', false, 0, 999999.99);
	mFieldDetails.push(control);
    control = new FieldControl('txtSELL_PRICE', false, 0, 999999.99);
	mFieldDetails.push(control);
    control = new FieldControl('txtPACK_SIZE', false, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtVAT_CODE', false, 0, 3);
	mFieldDetails.push(control);
    control = new FieldControl('txtPROD_GROUP', false, null, null);
	mFieldDetails.push(control);
    control = new FieldControl('txtPROMOTION', false, 0, 1);
	mFieldDetails.push(control);
}

//handler to display data when reloaded from the server
function DisplayData(itemToEdit) {
	var result = null;
    //put data into the fields
    document.getElementById("txtPROD_CODE").value = itemToEdit.Prod_code;
	document.getElementById("txtPROD_CODE").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtPROD_DESCRIPTION").value = itemToEdit.Prod_description;
	document.getElementById("txtPROD_DESCRIPTION").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtSUPP_CODE").value = itemToEdit.Supp_code;
	document.getElementById("txtSUPP_CODE").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtCOST_PRICE").value = itemToEdit.Cost_price;
	document.getElementById("txtCOST_PRICE").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtSELL_PRICE").value = itemToEdit.Sell_price;
	document.getElementById("txtSELL_PRICE").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtPACK_SIZE").value = itemToEdit.Pack_size;
	document.getElementById("txtPACK_SIZE").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtVAT_CODE").value = itemToEdit.Vat_code;
	document.getElementById("txtVAT_CODE").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtPROD_GROUP").value = itemToEdit.Prod_group;
	document.getElementById("txtPROD_GROUP").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	
    document.getElementById("txtPROMOTION").value = itemToEdit.Promotion;
	document.getElementById("txtPROMOTION").style.backgroundColor = mDefaultBackground;
	//if we have a change method, let's call it
	

    //disable key fields
    document.getElementById("txtPROD_CODE").disabled = true;

    //focus the first page
    document.getElementById("txtPROD_DESCRIPTION").focus(); 
    document.getElementById("txtPROD_DESCRIPTION").select(); 
}

//handler to initialize the fields on the page
function InitializeData() {
    document.getElementById("txtPROD_CODE").value = "";
    document.getElementById("txtPROD_DESCRIPTION").value = "";
    document.getElementById("txtSUPP_CODE").value = "";
    document.getElementById("txtCOST_PRICE").value = "";
    document.getElementById("txtSELL_PRICE").value = "";
    document.getElementById("txtPACK_SIZE").value = "";
    document.getElementById("txtVAT_CODE").value = "";
    document.getElementById("txtPROD_GROUP").value = "";
    document.getElementById("txtPROMOTION").value = "";

    ValidateResource(true);

    //disable key fields
    document.getElementById("txtPROD_CODE").disabled = false;

    //focus the first page
    document.getElementById("txtPROD_CODE").focus();
    document.getElementById("txtPROD_CODE").select();
}

function SetFieldFocus(fieldSpec) {

	var infoText = "";
	switch (fieldSpec) {
		case "txtPROD_CODE" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtPROD_DESCRIPTION" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtSUPP_CODE" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtCOST_PRICE" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtSELL_PRICE" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtPACK_SIZE" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtVAT_CODE" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtPROD_GROUP" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
		case "txtPROMOTION" :
			infoText = "";
            document.getElementById("lblInfoBar").innerText = infoText.trim();
			break;
	}
}

//validate if field entry.
function ValidateResource(noChangeMethod) {

	validatePROD_CODE(noChangeMethod);
	validatePROD_DESCRIPTION(noChangeMethod);
	validateSUPP_CODE(noChangeMethod);
	validateCOST_PRICE(noChangeMethod);
	validateSELL_PRICE(noChangeMethod);
	validatePACK_SIZE(noChangeMethod);
	validateVAT_CODE(noChangeMethod);
	validatePROD_GROUP(noChangeMethod);
	validatePROMOTION(noChangeMethod);

}

function validatePROD_CODE(noChangeMethod) {

	DataValueChangedValue("PROD_CODE", null);
	infoText = "";
	document.getElementById("txtPROD_CODE").title = infoText.trim();
	var fieldValue = document.getElementById("txtPROD_CODE").value.toUpperCase();

    var regexTest = /^.{0,6}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtPROD_CODE").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtPROD_CODE").style.backgroundColor = mErrorBackground;
		document.getElementById("txtPROD_CODE").title = "Invalid value.";
	}
}
function validatePROD_DESCRIPTION(noChangeMethod) {

	DataValueChangedValue("PROD_DESCRIPTION", null);
	infoText = "";
	document.getElementById("txtPROD_DESCRIPTION").title = infoText.trim();
	var fieldValue = document.getElementById("txtPROD_DESCRIPTION").value;

    var regexTest = /^.{0,40}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtPROD_DESCRIPTION").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtPROD_DESCRIPTION").style.backgroundColor = mErrorBackground;
		document.getElementById("txtPROD_DESCRIPTION").title = "Invalid value.";
	}
}
function validateSUPP_CODE(noChangeMethod) {

	DataValueChangedValue("SUPP_CODE", null);
	infoText = "";
	document.getElementById("txtSUPP_CODE").title = infoText.trim();
	var fieldValue = document.getElementById("txtSUPP_CODE").value.toUpperCase();

    var regexTest = /^.{0,6}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtSUPP_CODE").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtSUPP_CODE").style.backgroundColor = mErrorBackground;
		document.getElementById("txtSUPP_CODE").title = "Invalid value.";
	}
}
function validateCOST_PRICE(noChangeMethod) {

	DataValueChangedValue("COST_PRICE", null);
	infoText = "";
	document.getElementById("txtCOST_PRICE").title = infoText.trim();
	var fieldValue = document.getElementById("txtCOST_PRICE").value;

    var regexTest = /^[+]?[0]*[0-9]{0,6}(\.[0-9]{0,2}[0]*)?$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtCOST_PRICE").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtCOST_PRICE").style.backgroundColor = mErrorBackground;
		document.getElementById("txtCOST_PRICE").title = "Invalid value.";
	}
}
function validateSELL_PRICE(noChangeMethod) {

	DataValueChangedValue("SELL_PRICE", null);
	infoText = "";
	document.getElementById("txtSELL_PRICE").title = infoText.trim();
	var fieldValue = document.getElementById("txtSELL_PRICE").value;

    var regexTest = /^[+]?[0]*[0-9]{0,6}(\.[0-9]{0,2}[0]*)?$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtSELL_PRICE").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtSELL_PRICE").style.backgroundColor = mErrorBackground;
		document.getElementById("txtSELL_PRICE").title = "Invalid value.";
	}
}
function validatePACK_SIZE(noChangeMethod) {

	DataValueChangedValue("PACK_SIZE", null);
	infoText = "";
	document.getElementById("txtPACK_SIZE").title = infoText.trim();
	var fieldValue = document.getElementById("txtPACK_SIZE").value;

    var regexTest = /^.{0,10}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtPACK_SIZE").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtPACK_SIZE").style.backgroundColor = mErrorBackground;
		document.getElementById("txtPACK_SIZE").title = "Invalid value.";
	}
}
function validateVAT_CODE(noChangeMethod) {

	DataValueChangedValue("VAT_CODE", null);
	infoText = "";
	document.getElementById("txtVAT_CODE").title = infoText.trim();
	var fieldValue = document.getElementById("txtVAT_CODE").value;

    var regexTest = /^[+]?[0]*[0-9]{0,1}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtVAT_CODE").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtVAT_CODE").style.backgroundColor = mErrorBackground;
		document.getElementById("txtVAT_CODE").title = "Invalid value.";
	}
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
function validatePROMOTION(noChangeMethod) {

	DataValueChangedValue("PROMOTION", null);
	infoText = "";
	document.getElementById("txtPROMOTION").title = infoText.trim();
	var fieldValue = document.getElementById("txtPROMOTION").value;

    var regexTest = /^[+]?[0]*[0-9]{0,1}$/;
    var testResult = regexTest.test(fieldValue);
	if (testResult === true) {
		document.getElementById("txtPROMOTION").style.backgroundColor = mDefaultBackground;
	}
	else {
		document.getElementById("txtPROMOTION").style.backgroundColor = mErrorBackground;
		document.getElementById("txtPROMOTION").title = "Invalid value.";
	}
}

function GetPageData(updateFieldList) {

    var pageDataObject = {};

	//first check we have a valid page
	var pageValid = true;
	var color = mDefaultBackground;
	color = document.getElementById("txtPROD_CODE").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtPROD_DESCRIPTION").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtSUPP_CODE").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtCOST_PRICE").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtSELL_PRICE").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtPACK_SIZE").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtVAT_CODE").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtPROD_GROUP").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}
	color = document.getElementById("txtPROMOTION").style.backgroundColor;
	if (color !== null && color !== mDefaultBackground) {
		pageValid = false;
	}

	if (pageValid === false) {
		return null;
	}

	if (updateFieldList === null) {
		pageDataObject["PROD_CODE"] = document.getElementById("txtPROD_CODE").value;
		pageDataObject["PROD_DESCRIPTION"] = document.getElementById("txtPROD_DESCRIPTION").value;
		pageDataObject["SUPP_CODE"] = document.getElementById("txtSUPP_CODE").value;
		pageDataObject["COST_PRICE"] = document.getElementById("txtCOST_PRICE").value;
		pageDataObject["SELL_PRICE"] = document.getElementById("txtSELL_PRICE").value;
		pageDataObject["PACK_SIZE"] = document.getElementById("txtPACK_SIZE").value;
		pageDataObject["VAT_CODE"] = document.getElementById("txtVAT_CODE").value;
		pageDataObject["PROD_GROUP"] = document.getElementById("txtPROD_GROUP").value;
		pageDataObject["PROMOTION"] = document.getElementById("txtPROMOTION").value;
	}
	else
	{
		//always add the primary key
		pageDataObject["PROD_CODE"] = document.getElementById("txtPROD_CODE").value;

		//now add the requested fields
		for (var i = 0; i < updateFieldList.length; i++) {
			if (updateFieldList[i] !== "PROD_CODE") {
				pageDataObject[updateFieldList[i]] = document.getElementById("txt" + updateFieldList[i]).value;
			}
		}
	}
	return pageDataObject;	
}


