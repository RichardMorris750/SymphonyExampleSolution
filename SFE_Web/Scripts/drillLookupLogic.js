function LoadDrillLookupItemsFromServer(serverName, serverPort, resourceName, fieldName, fieldsToLoad, displayTagName, changeMethod) {

    var appendString = "";
    var separator = "?";

    //Only bring back selected fields
    if (fieldsToLoad != null && fieldsToLoad != "") {
        appendString += separator + "fields=" + fieldsToLoad;
        separator = "&";
    }

    $.ajax({
        type: "GET",
        cache: false,
        url: serverName + ':' + serverPort + '/api/v1/' + resourceName + appendString,
        crossDomain: true,
        xhrFields: { withCredentials: true },
        success: function (response) {
            buildDrillLookupTableTable(response, fieldName, displayTagName, changeMethod);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            processError(jqXHR, textStatus, errorThrown);
        }
    });
}

//built the resultsing HTML table with the retreived details
function buildDrillLookupTableTable(itemArray, fieldName, displayTagName, changeMethod) {

    //creat a table with the results in
    var tableDefinition = '<img title="Back" class="selectListOption" onclick="BackToView();"'
        + 'src="data:image/png;base64,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" >';

    tableDefinition += '<table><tr>';

    //first add the generic table/item options
    tableDefinition += addDrillLookupHeadings();

    //use the first row to define the table columns
    var cols = new Array();
    var topItem = itemArray[0];
    for (var columnKey in topItem) {
        tableDefinition += "<th>" + columnKey + "</th>";
        cols.push(columnKey);
    }

    tableDefinition += "</tr>";

    //now add each "row" of data.
    for (var i = 0; i < itemArray.length; i++) {
        var item = itemArray[i];
        tableDefinition += addDrillLookupOptions(item[cols[0]], fieldName, changeMethod);
        for (var j = 0; j < cols.length; j++) {
            tableDefinition += "<td>" + item[cols[j]] + "</td>";
        }
        tableDefinition += "</tr>";
    }

    //end the table of items
    tableDefinition += "</table>";

    document.getElementById(displayTagName).innerHTML = tableDefinition;
}

//add table headings.
function addDrillLookupHeadings() {

    return "<th></th>";
}

//add a resource item tothe selection list table
function addDrillLookupOptions(keyData, fieldName, changeMethod) {

    var html = "<tr>";
    html += '<td class="simpletd"><img title="Select: ' + keyData + '" class="selectListOption" onclick="DrillSelectItem(' + "'" + keyData + "'" + ", '" + fieldName + "'" + ", '" + changeMethod + "'" + ');"'
        + 'src="data:image/png;base64,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" >'
        + '</td > ';

    return html;
}
