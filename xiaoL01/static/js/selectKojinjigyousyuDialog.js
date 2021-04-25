/**
 * Created by okimai on 2017/10/22.
 */
// searchButton -> ajax -> refresh rows
// select -> dispose dialog
/**
 * @param button_element 社員選択ボタン
 */
function initKojinjigyousyuDialog() {

    var openFirst = true;

    $("#kojinjigyousyuSelectButton").on("click", function () {
        openFirst = true;
        if(openFirst){
            //最初は全ての取引先情報を表示
            $("#selectKojinjigyousyuButtonInDialog").click();
            openFirst = false;
        }
        $("#kojinjigyousyuDialog").dialog("open");
    });
    $("#selectKojinjigyousyuButtonInDialog").on("click", function () {
        $.ajax({
            url: "/togokanri/select",
            type: "POST",
            data: $.param({action: "searchSyain", company: $(".searchDialog #kaisya2").val(), syainName: $(".searchDialog #syainName2").val(), kind: 2}),
            timeout: 5000,
            success: function(result){
                $("#kojinjigyousyu-table .table-row").remove();
                for(i in result){
                    $("#kojinjigyousyu-table tr:last").after("<tr class='table-row'>" +
                        "<td>" + result[i].syozokuGaisya + "</td>" +
                        "<td>" + result[i].syainName +"</td>" +
                        "<td>" + result[i].seibetu +"</td>" +
                        "<td>" + result[i].syokugyouKind +"</td>" +
                        "<td><a href='javascript:void(0)' onclick='selectKojinjigyousyu(" + result[i].syainId + ",\"" + result[i].syainName + "\")'>選択</a></td>" +
                        "</tr>");
                }
                $("#kojinjigyousyuNum").html(result.length);
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

    $("#kojinjigyousyuDialog").dialog({
        //modal: true,
        //width: 200,
        draggable: true,
        height: 400,
        width: 800,
        resizable: false,
        title: "個人事業主選択",
        autoOpen: true
    });
    $("#kojinjigyousyuDialog").dialog("close");
    $("#kojinjigyousyuDialog").css("display", "block");
}

var selectKojinjigyousyu = function(syainId, syainName) {
    var id_element =$("#gaityuuSyainId");
    var name_element = $("#gaityuusaki");
    id_element.val(syainId);
    name_element.val(syainName);
    id_element.change();
    name_element.change();
    $("#kojinjigyousyuDialog").dialog("close");
}

initKojinjigyousyuDialog();