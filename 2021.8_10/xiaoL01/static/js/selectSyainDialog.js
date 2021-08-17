/**
 * Created by okimai on 2017/10/22.
 */
// searchButton -> ajax -> refresh rows
// select -> dispose dialog
/**
 * @param button_element 社員選択ボタン
 */
function initSyainDialog() {

    var openFirst = true;

    $("#syainSelectButton").on("click", function () {
        openFirst = true;
        if(openFirst){
            //最初は全ての取引先情報を表示
            $("#selectSyainButtonInDialog").click();
            openFirst = false;
        }
        $("#syainDialog").dialog("open");
    });
    $("#selectSyainButtonInDialog").on("click", function () {
        $.ajax({
            url: "/togokanri/select",
            type: "POST",
            data: $.param({action: "searchSyain", company: $(".searchDialog #kaisya").val(), syainName: $(".searchDialog #syainName").val(), kind: 1}),
            timeout: 5000,
            success: function(result){
                $("#syain-table .table-row").remove();
                for(i in result){
                    $("#syain-table tr:last").after("<tr class='table-row'>" +
                        "<td>" + result[i].syozokuGaisya + "</td>" +
                        "<td>" + result[i].syainName +"</td>" +
                        "<td>" + result[i].seibetu +"</td>" +
                        "<td>" + result[i].syokugyouKind +"</td>" +
                        "<td><a href='javascript:void(0)' onclick='selectSyain(" + result[i].syainId + ",\"" + result[i].syainName + "\")'>選択</a></td>" +
                        "</tr>");
                }
                $("#syainNum").html(result.length);
            },
            complete: function(XMLHttpRequest, status){
                if(XMLHttpRequest.status == 404){
                    alert("ページが見つかりません");
                }
                if(status == "timeout"){
                    alert("request timeout");
                }
            },
            error: function(jqXHR, textStatus, message) {
                alert(jqXHR.responseText);
            }
        });
    });

    $("#syainDialog").dialog({
        //modal: true,
        //width: 200,
        draggable: true,
        height: 400,
        width: 800,
        resizable: false,
        title: "社員選択",
        autoOpen: true
    });
    $("#syainDialog").dialog("close");
    $("#syainDialog").css("display", "block");
}

var selectSyain = function(syainId, syainName) {
    var id_element =$("#jyutyuuSyainId");
    var name_element = $("#jyutyuuSyainName");
    id_element.val(syainId);
    name_element.val(syainName);
    id_element.change();
    name_element.change();
    $("#syainDialog").dialog("close");
}

initSyainDialog();