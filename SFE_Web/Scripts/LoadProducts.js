$(document).ready(function () {
    $.ajax({
        type: "GET",
        url: "http://localhost:8083/api/v1/Products?fields=prod_code,prod_description",
        datatype: "jsonp",
        success: function (response) {
            $('body').append(arrayToTable(response));
        }
    });
})

function arrayToTable(tableData) {
    var table = $('<table border="1" width="70%"></table>');

    //add table headers
    table.append('<th>Code</th><th>Description</th><th width="100"></th>')

    $(tableData).each(function (i, rowData) {
        var row = $('<tr></tr>');
        $(rowData).each(function (j, cellData) {
            row.append($('<td>' + cellData.Prod_code + '</td>' + '<td>' + cellData.Prod_description + '</td><td><img height="100" width="100" src=http://symphonybridge.cloudapp.net/Images/' + cellData.Prod_code + '.jpg>' + '</td>'));
        });
        table.append(row);
    });
    return table;
}