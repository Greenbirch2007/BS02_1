/**
 * Created by okimai on 2017/10/22.
 */
/*******************************************************
 *************      受注先選択   ************************
 ******************************************************/
// searchButton -> ajax -> refresh rows
// select -> dispose dialog
function initTorihikisakiDialog(button_element) {

    var openFirst = true;
    var isIraisaki;

    button_element.on("click", function () {
        openFirst = true;
        if(openFirst){
            //最初は全ての取引先情報を表示
            $("#selectTorihikisakiButtonInDialog").click();
            openFirst = false;
        }
        $("#torihikisakiDialog").dialog("open");
    });

    $("#iraisakiSelectButton").on("click", function () {
        isIraisaki = true;
    });

    $("#gaityusakiSelectButton").on("click", function () {
        isIraisaki = false;
    });

    $("#selectTorihikisakiButtonInDialog").on("click", function () {
        $.ajax({
            url: "/togokanri/select",
            type: "POST",
            data: $.param({action: "searchTorihikisaki", torihikisakiName: $(".searchDialog #torihikisakiName").val()}),
            timeout: 5000,
            success: function(result){
                $("#torihikisaki-table .table-row").remove();
                for(i in result){
                    $("#torihikisaki-table tr:last").after("<tr class='table-row'>" +
                        "<td>" + result[i].torihikisakiName + "</td>" +
                        "<td>" + result[i].tantouName +"</td>" +
                        "<td><a href='javascript:void(0)' onclick='selectTorihikisaki(" + result[i].torihikisakiId + ",\"" + result[i].torihikisakiName + "\"," + isIraisaki + ")'>選択</a></td>" +
                        "</tr>");
                }
                $("#torihikisakiNum").html(result.length);
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

    $("#torihikisakiDialog").dialog({
        //modal: true,
        //width: 200,
        draggable: true,
        height: 400,
        width: 800,
        resizable: false,
        title: "取引先選択",
        autoOpen: true
    });
    $("#torihikisakiDialog").dialog("close");
    $("#torihikisakiDialog").css("display", "block");
}

var selectTorihikisaki = function(torihikisakiId, torihikisakiName, isIraisaki) {
    var id_element = isIraisaki ? $("#jyutyuuIraisakiId") : $("#gaityuusakiId");
    var name_element = isIraisaki ? $("#jyutyuuIraisaki") : $("#gaityuusaki");
    id_element.val(torihikisakiId);
    name_element.val(torihikisakiName);
    id_element.change();
    name_element.change();
    $("#torihikisakiDialog").dialog("close");
}

initTorihikisakiDialog($("#iraisakiSelectButton"));
initTorihikisakiDialog($("#gaityusakiSelectButton"));
