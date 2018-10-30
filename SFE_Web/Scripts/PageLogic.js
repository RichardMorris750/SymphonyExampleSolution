//script wide data
var txtRowCountBackground;

//Function executed when the page is loaded
function pageLoaded() {

    //let's setup the default page layout

    //local testing
    document.getElementById("txtServerURL").value = "http://localhost";
    document.getElementById("txtServerPort").value = "8083";

    //hide the elements we don't want just yet.
    document.getElementById("divSelection").style.display = "none";
    document.getElementById("divResults").style.display = "none";

    //get default settings
    txtRowCountBackground = document.getElementById("txtRowCount").style.backgroundColor;

    //disable the "get data" button
    document.getElementById("btnLoadTableData").style.display = "block";
}

function findServerTables() {

    document.getElementById("lblQueryString").innerHTML = '';

    $.ajax({
        url: buildURL("systables", ""),
        method: "GET",
        cache: false,
        crossDomain: true,
        xhrFields: { withCredentials: true },
        success: function (response) {
            addTables(response);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            document.getElementById("lblResultCount").innerText = "";
            if (jqXHR.status !== null && jqXHR.status !== 0) {
                document.getElementById("lblQueryString").innerHTML = '<p>Status code: ' + jqXHR.status
                    + '</p><p>Error: ' + errorThrown
                    + '</p><p>Response:</p><div>' + jqXHR.responseText + '</div>';
            }
            else {
                document.getElementById("lblQueryString").innerHTML = '<p>Status code: 0'
                    + '</p><p>Error: Remote server error.'
                    + '</p><p>Response:</p><div>Either the remote server is not running or CORS has not been correctly configured.</div>';
            }
            document.getElementById("divResults").style.display = "block";
            document.getElementById("divResultsTable").style.display = "none";
        }
    });

}

//add the avaialbe tables to the list of tables
function addTables(tableList) {

    var selectionHTML = '<select id = "cmboTables" onchange = "tableChanged();" > ';
    var firstOne = true;

    $(tableList).each(function (i, rowData) {
        $(rowData).each(function (j, cellData) {
            selectionHTML += '<option value="' + cellData.Name.replace("_Data", "s")
                + "!" + cellData.Tablespec + '">' + cellData.Name.replace("_Data", "s") + '</option>';
            if (firstOne === true) {
                firstOne = false;
                loadTableDetails(cellData.Name.replace("_Data", "s") + "!" + cellData.Tablespec);
            }
        });
    });
    selectionHTML += '</select>';

    document.getElementById("divTableList").innerHTML = selectionHTML;
    document.getElementById("divSelection").style.display = "block";
}

//function to handle table selection changes
function tableChanged() {
    loadTableDetails(document.getElementById("cmboTables").value);
}
function loadTableDetails(tableSpec) {

    document.getElementById("txtFieldList").value = "";
    document.getElementById("lblQueryString").value = "";
    document.getElementById("lblResultCount").value = "";
    document.getElementById("divResults").style.display = "none";

    //load the available columns from the server.

    var tableName = "/" + tableSpec.substring(tableSpec.indexOf("!") + 1,tableSpec.length);

//    datatype: "jsonp",
    $.ajax({
        type: "GET",
        cache: false,
        crossDomain: true,
        xhrFields: { withCredentials: true },
        url: buildURL("syscolumns", tableName),
        success: function (response) {
            addAvailableFields(response);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            document.getElementById("lblResultCount").innerText = "";
            if (jqXHR.status !== null && jqXHR.status !== 0) {
                document.getElementById("lblQueryString").innerHTML = '<p>Status code: ' + jqXHR.status
                    + '</p><p>Error: ' + errorThrown
                    + '</p><p>Response:</p><div>' + jqXHR.responseText + '</div>';
            }
            else {
                document.getElementById("lblQueryString").innerHTML = '<p>Status code: 0'
                    + '</p><p>Error: Remote server error.'
                    + '</p><p>Response:</p><div>Either the remote server is not running or CORS has not been correctly configured.</div>';
            }
            document.getElementById("divResults").style.display = "block";
            document.getElementById("divResultsTable").style.display = "none";
        }
    });
}

function addAvailableFields(fieldList) {

    //we shall add a checkbox to allow them to specify if they want to sort
    var selectionHTML = '<select id="cmboFields" >';

    //now add a list of avaialbe fields

    $(fieldList).each(function (i, rowData) {
        $(rowData).each(function (j, cellData) {
            selectionHTML += '<option value="' + cellData.Name + '">' + cellData.Name + '</option>';
        });
    });

    //now add the ascending or decending options
    selectionHTML += '</select>&nbsp'
        + '<select id="comboOrderByMode">'
        + '<option value="ASC">Ascending</option>'
        + '<option value="DESC">Decending</option></select> ';

    //push the html to the browser
    document.getElementById("tdOrderByField").innerHTML = selectionHTML;
    sortingOptions();
}

//event handler to toggle sorting options
function sortingOptions() {
    var doOrderBy = document.getElementById("chkOrderBy").checked;
    if (doOrderBy !== null && doOrderBy === true) {
        document.getElementById("cmboFields").disabled = false;
        document.getElementById("comboOrderByMode").disabled = false;
    }
    else {
        document.getElementById("cmboFields").disabled = true;
        document.getElementById("comboOrderByMode").disabled = true;
    }
}

//function to load data from the server based on selection criteria
function loadItemsFromServer() {

    document.getElementById("lblQueryString").value = "";
    document.getElementById("lblResultCount").value = "";
    document.getElementById("divResults").style.display = "none";

    var tableSpec = document.getElementById("cmboTables").value;
    var tableName = tableSpec.substring(0, tableSpec.indexOf("!"));
    var appendString = "";
    var separator = "?";

    var findOnKey = document.getElementById("txtKeyValue").value;

    if (findOnKey !== null && findOnKey !== '') {
        appendString += "/" + findOnKey;
    }

    var limitResults = document.getElementById("txtRowCount").value;

    if (limitResults !== null && limitResults !== '') {
        appendString += separator + "limit=" + limitResults;
        separator = "&";
    }

    var fieldList = document.getElementById("txtFieldList").value;

    if (fieldList !== null && fieldList !== '') {
        appendString += separator + "fields=" + fieldList;
        separator = "&";
    }

    var filteredBy = document.getElementById("txtFilteredBy").value;

    if (filteredBy !== null && filteredBy !== '') {
        appendString += separator + "filter=" + filteredBy;
        separator = "&";
    }

    var casing = document.getElementById("comboFilterBy").value;

    if (casing !== null && casing !== '') {
        if (casing === 'YES') {
            appendString += separator + "casing=true";
        }
        else {
            appendString += separator + "casing=false";
        }
        separator = "&";
    }

    var doOrderBy = document.getElementById("chkOrderBy").checked;

    if (doOrderBy !== null && doOrderBy === true) {
        var direction = document.getElementById("comboOrderByMode").value;
        if (direction === 'ASC') {
            appendString += separator + "sort=+" + document.getElementById("cmboFields").value;
        }
        else {
            appendString += separator + "sort=-" + document.getElementById("cmboFields").value;
        }
        separator = "&";
    }

    queryString = buildURL(tableName, appendString);

    $.ajax({
        type: "GET",
        cache: false,
        url: queryString,
        crossDomain: true,
        xhrFields: { withCredentials: true },
        success: function (response) {
            buildHtmlTable(response);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            loadItemsFailed(jqXHR, textStatus, errorThrown);
        }
    });

}

function loadItemsFailed(jqXHR, textStatus, errorThrown) {
    document.getElementById("divResults").style.display = "block";
    document.getElementById("lblQueryString").innerText = errorThrown;
    document.getElementById("divResultsTable").style.display = "none";
}

function buildURL(whatToQuery, appendString) {

    var serverName = document.getElementById("txtServerURL").value;
    var serverPort = document.getElementById("txtServerPort").value;
    return serverName + ':' + serverPort + '/api/v1/' + whatToQuery + appendString;

}

var tableDefinition = "";
var queryString = "";
var token;

// Builds the HTML Table from the response JSON data.
function buildHtmlTable(arr) {

    document.getElementById("lblQueryString").innerText = queryString;
    var resultCount = arr.length;
    document.getElementById("lblResultCount").innerText = resultCount;

    document.getElementById("divResults").style.display = "block";
    document.getElementById("divResultsTable").style.display = "block";

    tableDefinition = "<table><tr>";
    var cols = new Array();

    var p = arr[0];
    for (var key in p) {
        tableDefinition += "<th>" + key + "</th>";
        cols.push(key);
    }

    tableDefinition += "</tr>";

    //now add each "row" of data.

    for (var i = 0; i < arr.length; i++) {
        var item = arr[i];
        tableDefinition += "<tr>";
        for (var j = 0; j < cols.length; j++) {
            tableDefinition += "<td>" + item[cols[j]] + "</td>";
        }
        tableDefinition += "</tr>";
    }

    tableDefinition += "</table>";

    document.getElementById("divResultsTable").innerHTML = tableDefinition;

}

// Adds a header row to the table and returns the set of columns.
function addAllColumnHeaders(arr, table) {
    var columnSet = [],
        tr = _tr_.cloneNode(false);
    for (var i = 0, l = arr.length; i < l; i++) {
        for (var key in arr[i]) {
            if (arr[i].hasOwnProperty(key) && columnSet.indexOf(key) === -1) {
                columnSet.push(key);
                var th = _th_.cloneNode(false);
                th.appendChild(document.createTextNode(key));
                tr.appendChild(th);
            }
        }
    }
    table.appendChild(tr);
    return columnSet;
}

//validation fields
var txtRowCountValid = true;
var txtKeyValueEntered = false;

//************************
//validate field functions
//************************

//function to validate row count value entered
function validateRowCount() {
    document.getElementById("txtRowCount").style.backgroundColor = txtRowCountBackground;
    txtRowCountValid = true;

    var limitResults = document.getElementById("txtRowCount").value;

    if (limitResults !== null && limitResults !== '') {
        //must be a number
        if (!limitResults.match(/^[0-9]+$/)) {
            document.getElementById("txtRowCount").style.backgroundColor = "red";
            txtRowCountValid = false;
        }
    }
    validateFormFields();
}

//function to validate entry of the key field values
function validateKeyValue() {
    var keyValueData = document.getElementById("txtKeyValue").value;
    if (keyValueData !== null && keyValueData !== '') {
        txtKeyValueEntered = true;
    }
    else {
        txtKeyValueEntered = false;
    }
    validateFormFields();
}

//function to validate the form
function validateFormFields() {

    if (txtRowCountValid === false) {
        document.getElementById("btnLoadTableData").style.display = "none";
    }
    else {
        document.getElementById("btnLoadTableData").style.display = "block";
    }

    if (txtKeyValueEntered === true) {
        document.getElementById("txtRowCount").disabled = true;
        document.getElementById("txtRowCount").value = "";
    }
    else {
        document.getElementById("txtRowCount").disabled = false;
    }

}

