//Generic function to build the required URI

var mServerName = "http://localhost";  //insert the server address here
var mServerPort = "8083";               //server port number
var mRetrevalLimit = 5;                 //number of items to limit in the list
var mStoreResourceName = null;          //store the resource name
var mStoreKeyFieldName = null;          //store the key field name
var mStoreFieldsList = null;            //store the restricted field list
var mPageIndexValue = new Array();      //create an array of page key values
var mFirstItemKey = null;               //First key value on the page
var mPageTopItem = null;                //current page top item
var mCurrentKeyValue = null;            //current/selected resource key value
var mChangesMade = false;               //indicate of changes have been made
var mUpdateFieldList = new Array();     //array of changed fields
var mErrorBackground = "#FFAEAE";       //default error color for edit fields

//program modes
var mProgramMode = Object.freeze({ "INITIAL": 0, "CREATE": 1, "READ": 2, "UPDATE": 3, "DELETE": 4, "CANCEL": 5, "DRILL": 6 });
var mCurrentProgramMode = mProgramMode.READ;

//dialog options
var mDialogMode = Object.freeze({ "OK": 1, "QUESTION": 2 });

//function to load data from the server based on selection criteria
function LoadItemsFromServer(resourceName, keyFieldName, fieldsToLoad, startFrom, queryType, retrevalLimit) {

    mCurrentProgramMode = mProgramMode.INITIAL;

    mRetrevalLimit = retrevalLimit;

    var filterValue = null;
    var appendString = "";
    var separator = "?";

    if (resourceName !== null) {
        mStoreResourceName = resourceName;
    }

    if (keyFieldName !== null) {
        mStoreKeyFieldName = keyFieldName;
    }

    appendString += separator + "limit=" + mRetrevalLimit;
    separator = "&";

    //should we restrict the fields coming back?
    if (fieldsToLoad !== null && fieldsToLoad !== "") {
        mStoreFieldsList = fieldsToLoad;
        appendString += separator + "fields=" + fieldsToLoad;
        separator = "&";
    }

    if (startFrom !== null) {
        //we have a start from value
        switch (queryType) {
            case "EQ":
                filterValue = "filter=" + mStoreKeyFieldName + ">='" + startFrom + "'";
                mPageIndexValue.pop();
                mPageIndexValue.pop();
                break;
            case "GT":
                filterValue = "filter=" + mStoreKeyFieldName + ">'" + startFrom + "'";
                break;
            default:
        }
        appendString += separator + filterValue;
        separator = "&";
    }

    var messageLabel = document.getElementById("lblNoMoreRecords");
    if (messageLabel !== null) {
        messageLabel.innerText = "";
    }

    $.ajax({
        method: "GET",
        cache: false,
        url: buildURL(mStoreResourceName, appendString),
        crossDomain: true,
        xhrFields: { withCredentials: true },
        success: function (response) {
            buildHtmlTable(response);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            if (startFrom !== null && errorThrown === "Not Found") {
                var messageLabel = document.getElementById("lblNoMoreRecords");
                if (messageLabel !== null) {
                    messageLabel.innerText = "No more records returned from the server.";
                }
            }
            else {
                processError(jqXHR, textStatus, errorThrown);
            }
        }
    });

}

//built the resulting HTML table with the retreived details
function buildHtmlTable(itemArray) {

    //create a table with the results in
    var tableDefinition = '<table><tr>';

    //first add the generic table/item options
    tableDefinition += addEditHeadings();

    //use the first row to define the table columns
    var cols = new Array();
    var topItem = itemArray[0];
    for (var columnKey in topItem) {
        tableDefinition += "<th>" + columnKey + "</th>";
        cols.push(columnKey);
    }

    tableDefinition += "</tr>";

    var firstItem = itemArray[0];
    mFirstItemKey = firstItem[cols[0]];
    mPageTopItem = mFirstItemKey;

    mPageIndexValue.push(mFirstItemKey);
    if (mPageIndexValue.length > 1) {
        mFirstItemKey = mPageIndexValue[mPageIndexValue.length - 2];
    }


    //now add each "row" of data.
    for (var i = 0; i < itemArray.length; i++) {
        var item = itemArray[i];
        tableDefinition += addEditOptions(item[cols[0]]);
        for (var j = 0; j < cols.length; j++) {
            tableDefinition += "<td>" + item[cols[j]] + "</td>";
        }
        //build the primary key
        mLastItemKey = item[cols[0]];

        tableDefinition += "</tr>";
    }

    //end the table of items
    tableDefinition += "</table>";

    //now add navigation to the page
    tableDefinition += addListNavigation(mFirstItemKey, mLastItemKey);

    document.getElementById("divSelectionList").innerHTML = tableDefinition;

}

//Build the URL to access the resource on the server.
function buildURL(whatToQuery, appendString) {

    return mServerName + ':' + mServerPort + '/api/v1/' + whatToQuery + appendString;

}

//add table headings.
function addEditHeadings() {

    return "<th></th><th></th>";
}

//add options to a resource item in the table
function addEditOptions(keyData) {

    var html = "<tr>";
    html += '<td class="simpletd"><img title="Amend: ' + keyData + '" class="selectListOption" onclick="RequestItemAmend(' + "'" + keyData + "'" + ');"'
        + 'src = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAbHSURBVGhD7VdrbJRlGu1u4pJ13eAaTfwjwYoVq0OBAgU60EJbOmVqL7TT0ina0tahEMrN5SJxmaS6O012XTCRLzZRk5qMBuqPooggWyUqdtklGwJRya4QavxhXPbiPQo5zz7n / d4pbeErbbOxYzInOXmf97m958B0oGkppJBCCikkFe5ah0B6K / 6SvhZfp68VmVhSA05MbUWxlTc6TItgdcYa4O4ILmRE0KVx54TS1dCvBLVZmSMjPSKTMx / GF8q + 7IjcaNMTjhmr8AtqymzB59Ro097wNaEgq1lkZrOEeJ / RhGhWM84qz00Qz85oxi5qyVqNGmqjRt5HxOwmBLNXiyj981pwJ + PZjTijPDpBPEMNWQ0ylZqMHtVo5XpjXgOCOY0iOTo0vxE + xnMbEbblHxx8mxqMFtXEmBpt2RuLtMn / kEjug + JfrMNuPHFG + DY1UAs1MaZGW / ZGfj2C + atE8mgkDB / jJeH / n5FoVH66uA53L2zCL21qRPBtaqAWamJMjbbsjYKVCBaFRQrrxF + gw4z1NEa2HEfBI8clQm55Fy2 / PiG3M7 + xD / cm8uTmd5DF / HAEqnFbYR1OcWdRGF8W1qPMljzBt60GHzWZWDXasjeKtalkpUhAh0p0mHFJLcLRk3Jj7BguxY6JJPi7t9DJGT1PDMkfw1mzbBgCKxFXXtY3HtOdHwZq8R + as + Vrgm8bDarFaNKYGm3ZG2XVCJbViJSGxF9eDR9jPcOdR2Xyc0dFhvANxDnz7Bs4PSzfb5YNQnktFpbVAEqH9wdqMN / ezR + GF / i21eCjJsbUaMveqNSmFdUiFdYI4xW67KgaefWQyFC6Rl45hNPD8kOM8OdC9 / 6Vuyqr8ERFFUqrqtCkcb / ycnlIZtrWq8C3OUct1GR2jMbIykoEa1eIhCrEX10OH + PaFQi / tw8 / 7zuA7 / 58QGSAPe6fbl8P3huc1773zTKLmkq02D1fu2eCuFRbie + 0 / nZamvzEtg8B32YvtVATY2q0ZW / Ua1N9hUidDoV1mLGe5of9o27MOd8tIfLcy6jqj8uvmD + 3X6Yk8uQ / 9mEa80RDudxcX47PdMeZQACTVlUiK1yBEu4PhWRyXTm2D35jOJi3dR9nGFOjLXujoQzBxjKR1aXib9RhxnqO++u34QE8yR0PlWGJTQ1Bm5rTN//eWIZP1oXkJpseAN+2GnxGk8bUaMveaFqOYEupSESHHi6Bj3Fz6fiMtJQgQ2e/1x37beqaSLzZUop2mxoA32aNWqiJMftt2Rtrtak1eMUI49aS8RlZsxztZj6I02uCWK87b7Ulg0i23KD55Vrfp0Tr8qu/7fg2dySMMKZGW/bG+mIE2wIiGwLi31AoU/SvHsrz6wNycrTU/oN2l8NdbcW4YE5DXFSeWh9Av+YvM6d93yj/qfF/3TlpHLTrvBJrl+EOarL91zeySZs2F4tsLEYd75uLsWHTMvRtKpaTo+XmZa4R3eVwF7+RdN8C3fM3zX1r9i3DBda2qOh1eXKT5uM6a4wwN7DP7W1jXveGOUONvI+IbQUIbisS2VqIUzuC7rfSeLG1CA532SvvcaX5+OgZY217oftLkltzjVwLauIWauIMNdq0N3Zq084CEcOl+EzvBx4tkP1joc6Zf194co9ZrNB7XGmM6BljLWHErblGHl0qFUP2qQatXxzQNRojv1mKougSkWg+/qh8JboEHyv/PUae5i6dd7jLLFbsykdcaYzoGWMtYYS1aL5rJLoUm4bt+5hatGc3Z6iRfSMiOh+3tC/GV+156I1mys9selzQPc7jeVeMPJ6HuNIY0VqMtQ5rhLX2xd4fLWrRmbeoLeYf5Uc+5kdbxyL9n6wfH8QW4SmNO8bIHWbPIjgaDxjRfXHNGSMax1hLGGGtw+8aieVK/qBdHdRALezX0/zgjxpP+iX0+1x8+IdckTFzoStW5x3ezUKF5uMDtYWIsdaR7RoxtVzXiJ47zJ5BpBZqYv0Hx54FcPYsuGJk9wLEd893jegZYy1hhDW9e360JhR758HZmyPi5EiEfHoeTij/xVhrr7O2NwcbB2o5SWrkmTlwOueKjIHJaeT52XCez9bfGOdI+vWovQe0NzmNdM2C88Jska6ZUnhdzkJv16wkNfJiFpyXZoqMli9mJamRbh+c7hkiL/uk8HrU3t5uX5Ia6bkfTs/9V75+R0LPfYj33JekRg5mYs/BTJFD0zDJpjxx8F50a/9Fe00uvJ6BmiPTRY5Mx5uH70GnF4/cg67D0/GNxq/Z0eSC6C9UvRn4rfLT3gwRL/4pA98qjxy+C3fY0RRSSCGFFH4MSEv7H3miq+ylMNWgAAAAAElFTkSuQmCC" >'
        + '</td > ';
    html += '<td class="simpletd"><img title="Delete: ' + keyData + '" class="selectListOption" onclick="RequestItemDelete(' + "'" + keyData + "'" + ');"'
        + 'src = "data:image/png;base64,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" >'
        + '</td > ';

    return html;
}

//add the selection list navigation buttons to the page
function addListNavigation(firstItem, lastItem) {
    var html = '<div class="centeredDiv">';

    html += '<img title="Return to the menu" class="navigationOption" onclick="backToMenu();"'
        + ' src = "data:image/png;base64,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" >';

    html += '<img title="Add a new item to the database" class="navigationOption" onclick="RequestItemCreate();"'
        + ' src = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAADIAAAAyCAYAAAAeP4ixAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAATvSURBVGhD7VnvT9ZVHPVFvvMv0DemMpDIIBOnmKBmkECGJJlozFBExY1euFVukj8WvNCyLb6bOXXD7mwCieKjBSXKta2cYnte1Mv6C5S/4Nw+53Pvq4jte2n7urnnbGf3cM/z3HPOCzY25hVQQAEFPF9Y1OW2L+zC0KJDGH8WXHgIg3I2hzpzw+KDuLj4oHOLD+Cp8JHoh5mSmcxmB+kSasVh2QG3fVmnc8v24+vqHvdCuM4cKzvc/KWd6A9d3g3X6VGyD4PFHXjKh0oPugXy88nifTiXKTtwnNnsUNLhpoVXQ730KGuHFeapX96LE0LIz0+yJDOZHfrkhZY6ChUfwgp1SMUemIo9blqNDMFMZquWLuykRgxWtcEKdUhlG0xlW/ZDmMlsanZhJzVisPYD2KrdfohoU7U7+yHMZLbXyLOTGjGoaYWt2eWHVO+Cqd6V/RBmMpuaXdhJjRhs2gm76X0/RE7zxs7shzCT2dTswk5qxKD2PVihDqnbAVO3I/shzGQ2NbuwkxoxaGyBbWjxQ0Sbhpb4Id2/oP6j+3hAUofr1GAms71Gnp3UiMG2ZlihDmlqhmlqjh/ysUXyyX3nSOpwnRrMZDY1u7CTGjFo2QYr1CEtTTAtTfFDeu4h+WzSOZI6XKcGM5mtWrqwkxoxaN0K2/qOHyKnad0aP+Tzu0h67zpHUofr1GAms1VLF3ZSIwZtb8O2Nfohcpq2xvghX9xB8uWEcyR1uE4NZjLba+TZSY0YtDfCtjf4IXvlsfaG+CH9PyFJfnaOpA7XqcFMZnuNPDupEYPOLbCd9X7I/nqYzvrZh1wcw5YL465vBscwJadTej3jM/xueGYGmMlsr5FnJzVi0FULe7jWDzlcB3O4bvYhl8fw+Nsx5+ZCfjc8MwPMZLZq6cJOasSg+01YoQ7proXprp19yNBtPB76wbm5EVPhmRlgJrNVSxd2UiMGRzbDCnWInObI5tmHjN7Clhs51/dvjuYwNXrLOaXo//rMjRzeCs/MADOZ7TXy7KRGDD7dCCvUIUc3whzdGP/L/uNNJGM3nSOpw3VqMJPZ1OzCTmrE4NgG2J4NfsixGpiemvgh924gmRx1jqQO16nBTGarli7spEYMTq2HPVXth5yshjm5Pn7IryNIfrvuHEkdrlODmcymZhd2UiMGva/D9q7zQ+Q0fevihzy+huT3a86R1OE6NZjJbGp2YSc1YnBmLezpKj/k9FqYM1XxQ/4YRvLn986R1OE6NZjJbGp2YSc1YvDVGtiza/wQ0ebsmvghfw+j/q9BPCCpw3VqMJPZXiPPTmrEIKmEFeqQ/tUw/avjh/xfMJPZ1OzCTmrE4PwqWKEO+eY1mPOrsh/CTGZ7jTw7qRGDS6/CCnWInObSyuyHMJPZqqULO6kRg8vlsAPlfshABcxAefZDmMlsr5FnJzVicOUVWKEO+W4FzJUV2Q9hJrNVSxd2UiMGQ2WwQh0yXAYzXJb9EGYym5pd2EmNGIy8BHu91A8RfUKIkVI8yZTMlGx2YBd2oo5CrgSDt0rw9OFKN3+i1C3ILcdx4bmMeZzZ7JBb7qZzJXP4t8J4MZrHi+Uv12L086FwnTmYLR0SdmGncB2HO0W4OFHknHB6ogiP5HyYLTVTstkBF0KtueHei2i2SzA4uRTjz4J2ibsq+dtCnQIKKKCA5wLz5v0DdbdxRCTsVpQAAAAASUVORK5CYII=" >';

    html += '<img title="Previous page of items from the database" class="navigationOption" onclick="DoLoadFrom(' + "'" + firstItem + "'" + ', ' + "'EQ'" + ');"'
        + ' src = "data:image/png;base64,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" >';

    html += '<img title="Next page of items from the database" class="navigationOption" onclick="DoLoadFrom(' + "'" + lastItem + "'" + ', ' + "'GT'" + ');"'
        + ' src = "data:image/png;base64,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" >';

    html += '<p><label id="lblNoMoreRecords"></label></p>';

    html += "</div>";

    return html;
}

//reload the selection list based on the from value
function DoLoadFrom(keyData, queryType) {

    var messageLabel = document.getElementById("lblNoMoreRecords");
    if (messageLabel !== null) {
        if (queryType === "GT" && messageLabel.innerText === "No more records returned from the server.") {
            return; //can't next page when we are at the end
        }
    }
    LoadItemsFromServer(null, null, mStoreFieldsList, keyData, queryType, mRetrevalLimit);
}

function RequestItemCreate() {

    mUpdateFieldList = new Array();

    //display the right view
    ToItemEntry();

    mCurrentProgramMode = mProgramMode.CREATE;
    InitializeData();
    mCurrentKeyValue = "";

}

//request to edit the current item
function RequestItemAmend(keyValue) {

    mUpdateFieldList = new Array();

    //display the right view
    ToItemEntry();

    //load the item from the server - we may have restricted field list in the selection view
    ReloadResource(keyValue);

}

//Reload the selected resource based on the key value
function ReloadResource(keyValue) {

    mCurrentProgramMode = mProgramMode.UPDATE;
    mChangesMade = false;

    $.ajax({
        method: "GET",
        cache: false,
        url: buildURL(mStoreResourceName, "/" + keyValue),
        crossDomain: true,
        xhrFields: { withCredentials: true },
        success: function (response) {
            DisplayData(response[0]);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            processError(jqXHR, textStatus, errorThrown);
        }
    });

    mCurrentKeyValue = keyValue;

}

//this function records when fields changed when amending a resource
function DataValueChangedValue(fieldName, changeMethod) {

    var fieldData = document.getElementById("txt" + fieldName).value;

    var found = false;
    for (var i = 0; i < mUpdateFieldList.length; i++) {
        if (mUpdateFieldList[i] === fieldName) {
            found = true;
        }
    }

    if (found === false) {
        mUpdateFieldList.push(fieldName);
    }

    mChangesMade = true;

    if (changeMethod !== null && changeMethod !== "") {
        //we have a change methods - let's execute it on the remote server
        ExecuteChangeMethod(changeMethod, fieldName, fieldData);
    }
}

function ExecuteChangeMethod(changeMethod, fieldName, fieldData) {

    var appendString = "?procedure=ExecuteChangeMethod&param=";

    //build up the "parameters"
    var parameterData = {};
    parameterData["methodName"] = changeMethod;
    parameterData["fieldName"] = fieldName;
    parameterData["fieldData"] = fieldData;

    appendString += JSON.stringify(parameterData);

    $.ajax({
        method: "GET",
        cache: false,
        url: buildURL("change_method_responses", appendString),
        crossDomain: true,
        xhrFields: { withCredentials: true },
        success: function (response) {
            processChangeMethodResponse(response);
        },
        error: function (jqXHR, textStatus, errorThrown) {
            processError(jqXHR, textStatus, errorThrown);
        }
    });
}

function processChangeMethodResponse(response) {
    var responseItem = response[0];

    //we have data back from the remote server from the change method call
    if (responseItem.Call_status === 0) {
        document.getElementById(responseItem.Display_field_name).innerText = responseItem.Display_field_data;
    }
    else {
        //it's an error, display the error response
        document.getElementById(responseItem.Display_field_name).innerText = responseItem.Message;
        document.getElementById("txt" + responseItem.Field_name).style.backgroundColor = mErrorBackground;
    }
}

//allow deletion of the selected item
function RequestItemDelete(item) {

    mCurrentProgramMode = mProgramMode.DELETE;
    mCurrentKeyValue = item;
    ShowDialog("Delete the selected item: " + item + " ?", mDialogMode.QUESTION);
}


function RequestCancelChanges() {

    if (mChangesMade === true) {
        mCurrentProgramMode = mProgramMode.CANCEL;
        ShowDialog("Cancel and lose changes for item: " + mCurrentKeyValue + " ?", mDialogMode.QUESTION);
    }
    else {
        ToListSelectionView();
    }

}

function RequestCreateUpdateItem() {

    //go and ask/confirm they want to create/update the data on the server/
    DialogCommit();
}

function ShowDialog(message, dialogOption) {

    //first hide the selection list
    document.getElementById("divSelectionList").style.display = "none";

    //hide the item entry
    document.getElementById("divItemView").style.display = "none";

    document.getElementById("divDialogBox").style.display = "block";
    document.getElementById("lblMessage").innerText = message;

    switch (dialogOption) {
        case mDialogMode.OK:
            document.getElementById("divQuestionButtons").style.display = "none";
            document.getElementById("divOKButtons").style.display = "block";
            break;
        case mDialogMode.QUESTION:
            document.getElementById("divQuestionButtons").style.display = "block";
            document.getElementById("divOKButtons").style.display = "none";
            break;
        default:
    }

}

//function  to handle dialog commit command
function DialogCommit() {
    switch (mCurrentProgramMode) {
        case mProgramMode.CANCEL:
            ToListSelectionView();
            break;
        case mProgramMode.CREATE:
            doCreateItem();
            break;
        case mProgramMode.READ:
            break;
        case mProgramMode.UPDATE:
            doUpdateItem();
            break;
        case mProgramMode.DELETE:
            doDeleteItem();
            break;
        default:
    }
}

//function to handle dilaog cancle command
function DialogCancel() {
    switch (mCurrentProgramMode) {
        case mProgramMode.CANCEL:
        case mProgramMode.CREATE:
            ToItemEntry();
            break;
        case mProgramMode.READ:
            break;
        case mProgramMode.UPDATE:
            ToItemEntry();
            break;
        case mProgramMode.DELETE:
            ToListSelectionView();
            break;
        default:
    }
}

//function to handle dialog OK command
function DialogOK() {
    switch (mCurrentProgramMode) {
        case mProgramMode.INITIAL:
            window.history.back();
            break;
        case mProgramMode.CREATE:
        case mProgramMode.UPDATE:
        case mProgramMode.DELETE:
            LoadItemsFromServer(null, null, mStoreFieldsList, null, null, mRetrevalLimit);
            ToListSelectionView();
            break;
        case mProgramMode.READ:
            break;
        default:
    }
}
function doDeleteItem() {

    $.ajax({
        method: "DELETE",
        cache: false,
        url: buildURL(mStoreResourceName, "/" + mCurrentKeyValue),
        crossDomain: true,
        xhrFields: { withCredentials: true },
        success: function (response) {
            LoadItemsFromServer(null, null, mStoreFieldsList, null, null, mRetrevalLimit);
            ToListSelectionView();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            processError(jqXHR, textStatus, errorThrown);
        }
    });

}

function doCreateItem() {

    mCurrentProgramMode = mProgramMode.CREATE;

    //get the modified data fom the page
    var pageData = GetPageData();

    if (pageData === null) {
        document.getElementById("lblSaveMessage").innerText = "Invalid/incomplete data prevents saving.";
        setTimeout(clearNotification, 3000);
        return;
    }

    //put the modified data to the server
    $.ajax({
        method: "POST",
        data: pageData,
        cache: false,
        url: buildURL(mStoreResourceName, ""),
        crossDomain: true,
        xhrFields: { withCredentials: true },
        success: function (response) {
            LoadItemsFromServer(null, null, mStoreFieldsList, null, null, mRetrevalLimit);
            ToListSelectionView();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            processError(jqXHR, textStatus, errorThrown);
        }
    });
}

function doUpdateItem() {

    mCurrentProgramMode = mProgramMode.UPDATE;

    //get the modified data fom the page
    var pageData = GetPageData(mUpdateFieldList);

    if (pageData === null) {
        document.getElementById("lblSaveMessage").innerText = "Invalid/incomplete data prevents saving.";
        setTimeout(clearNotification, 3000);
        return;
    }

    if (mUpdateFieldList.length === 0) {
        document.getElementById("lblSaveMessage").innerText = "No changes to save.";
        setTimeout(clearNotification, 3000);
        return;     //nothing changed.
    }

    //put the modified data to the server
    $.ajax({
        method: "PUT",
        data: pageData,
        cache: false,
        url: buildURL(mStoreResourceName, ""),
        crossDomain: true,
        xhrFields: { withCredentials: true },
        success: function (response) {
            LoadItemsFromServer(null, null, mStoreFieldsList, mPageTopItem, "EQ", mRetrevalLimit);
            ToListSelectionView();
        },
        error: function (jqXHR, textStatus, errorThrown) {
            processError(jqXHR, textStatus, errorThrown);
        }
    });
}

function clearNotification() {
    document.getElementById("lblSaveMessage").innerText = "";
}

//take the user back to the selection list
function ToListSelectionView() {

    document.getElementById("divDialogBox").style.display = "none";
    document.getElementById("divItemView").style.display = "none";
    document.getElementById("divSelectionList").style.display = "block";
}

//take the user back to the item entry
function ToItemEntry() {

    document.getElementById("divDialogBox").style.display = "none";
    document.getElementById("divItemView").style.display = "block   ";
    document.getElementById("divSelectionList").style.display = "none";
}

//process network/connection/server errors
function processError(jqXHR, textStatus, errorThrown) {
    var errorMessage = "";
    if (jqXHR.status !== null && jqXHR.status !== 0) {
        errorMessage = 'Status code: ' + jqXHR.status
            + ', Error: ' + errorThrown
            + ', Response: ' + jqXHR.responseText;
    }
    else {
        errorMessage = 'Status code: 0'
            + ', Error: Remote server error.'
            + ' Response: Either the remote server is not running or CORS has not been correctly configured.';
    }
    ShowDialog(errorMessage, mDialogMode.OK);
}

var mpreviousView = null;
var mCurrentView = null;
var mSaveProgramMode = null;
var mSaveDrillDataItem = null;

//allow a page to "move" to a new view state
//currentView : tells us where to go back to when this view ends
//fieldName : is the name of the field in the master resource
//dataItem : is the name of the data entry element on the HTML page
//newView : is the name of the new view/div area to show
//resourceName : is the name of the resource on the server
//resourceFields : is the list of fields to display 
//changeMethod : any change method to execute
function MoveToView(currentView, fieldName, dataItem, newView, resourceName, resourceFields, changeMethod) {

    mSaveDrillDataItem = dataItem;

    mSaveProgramMode = mCurrentProgramMode;
    mCurrentProgramMode = mProgramMode.DRILL;

    document.getElementById(currentView).style.display = "none";
    mpreviousView = currentView;

    document.getElementById(newView).style.display = "block";
    mCurrentView = newView;

    //load tthe drill details
    LoadDrillLookupItemsFromServer(mServerName, mServerPort, resourceName, fieldName, resourceFields, newView, changeMethod);
}

//move to the previous view state
function BackToView() {

    mCurrentProgramMode = mSaveProgramMode;

    document.getElementById(mCurrentView).style.display = "none";
    document.getElementById(mpreviousView).style.display = "block";
}

function DrillSelectItem(dataItem, fieldName, changeMethod) {

    //populate the data we have been given
    document.getElementById(mSaveDrillDataItem).value = dataItem;

    ValidateResource(true);

    //add tell the page the data has changed
    DataValueChangedValue(fieldName, changeMethod);

    //go back to where we came from
    BackToView();
}

function backToMenu() {
    window.location.replace("/default.html");
}