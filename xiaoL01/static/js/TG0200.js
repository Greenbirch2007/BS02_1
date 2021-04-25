/**
 * Created by okimai on 2017/9/22.
 */

$(function(){

    function setQueryForm(target){

        var date_elem = target.find("input[name=date]");

        //受注月の未入力チェック
        //後でinputCheck.jsでのis_Empty(elem)と統一する
        var checkAll = function () {
            if(!date_elem.val()){
                alert("受注月を入力してください");
                date_elem.focus();
                return false;
            } else {
                return true;
            }
        };

        //初期設定
        var init = function () {
            target.on({
               'submit': function () {
                   return checkAll();
               }
            });

            date_elem.on({
                'change': function () {
                    target.submit();
                }
            })

            initDate(date_elem);
            initDateWithArrow(date_elem, $("#minusDateArrow"), $("#addDateArrow"));
        }

        init();
    }

    function setAnswerForm(target) {

        var SUBMIT_TYPE_KARI_ADD = "kariAdd";
        var SUBMIT_TYPE_ADD = "add";
        var SUBMIT_TYPE_EDIT = "edit";
        var SUBMIT_TYPE_DELETE = "delete";
        var SUBMIT_TYPE_EXTEND = "extend";

        window.kariAddData = function () {
            $.ajax({
                url: "/togokanri/TG0200",
                type: "POST",
                data: $.param({submitKind: SUBMIT_TYPE_KARI_ADD, month: $("#date").val()}),
                timeout: 5000,
                success: function(result){
                    if(result.state == 0){
                        location.reload();
                    }
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
        };

        window.addData = function () {
            $("#submitKind").val(SUBMIT_TYPE_ADD);
            $("#month").val($("#date").val());
            target.submit();
        };

        window.updateData = function (hakkenMonth, renban, withJyutyuNum) {
            $("#submitKind").val(SUBMIT_TYPE_EDIT);
            $("#month").val(hakkenMonth);
            $("#renban").val(renban);
            $("#withJyutyuNum").val(withJyutyuNum);
            target.submit();
        };

        window.deleteData = function (iraisakiNameRyaku, targetName, hakkenMonth, renban) {
            if(confirm("以下の受注情報を削除しますか？\n依頼先：" + iraisakiNameRyaku + "\n作業員："
                    + targetName + "\n受注月：" + $("#date").val())){
                $.ajax({
                    url: "/togokanri/TG0200",
                    type: "POST",
                    data: $.param({hakkenMonth: hakkenMonth, renban: renban, submitKind: SUBMIT_TYPE_DELETE}),
                    timeout: 5000,
                    success: function(result){
                        switch (result.state){
                            case 0:
                                location.reload();
                                break;
                            case 1:
                                alert("以下の受注情報すでに外注済み\nまたは請求済みしましたので、削除できません。");
                                break;
                        }
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
            }
        };

        window.extendData = function (hakkenMonth, renban) {
            $("#submitKind").val(SUBMIT_TYPE_EXTEND);
            $("#month").val(hakkenMonth);
            $("#renban").val(renban);
            target.submit();
        };

        //コラムの隣接するセルの値が一緒だったら、セルを合併する
        //改修あり
        var setRowspan = function(table, colIdx) {
            var that;
            table.find("tr>td:nth-child(" + colIdx + "):visible").each(function () {
                if (that　!=null && $(this).html() == $(that).html() && $(this).html()) {
                    var rowspan = $(that).attr("rowSpan");
                    if (!rowspan) {
                        $(that).attr("rowSpan",1);
                        rowspan = $(that).attr("rowSpan");
                    }
                    rowspan = Number(rowspan)+1;
                    $(that).attr("rowSpan",rowspan);
                    $(this).hide();
                } else {
                    that = this;
                }
            });
        };

        var addBrTag = function () {
            target.find("tr>td:nth-child(3)").each(function () {
                var txt = $(this).html();
                $(this).html($(this).html().replace(/@@/, "<br>"));
            });
            target.find("tr>td:nth-child(5)").each(function () {
                $(this).html($(this).html().replace(/@@/, "<br>"));
            });
        }

        //初期設定
        var init = function () {
            setRowspan($("#manageTable"), 1);
            setRowspan($("#manageTable"), 2);
            addBrTag();
        };

        init();

    }

    setQueryForm($("#queryForm"));
    setAnswerForm($("#answerForm"));

});