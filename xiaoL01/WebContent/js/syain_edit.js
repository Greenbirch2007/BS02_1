/**
 * Created by bin79 on 2017/6/11.
 */

//在datepicker初始化之前就要赋值，以免之后生成的日期框元素的id冲突
//projectHTML = $("#project-table-hidden").html();

function init_date(){
    $("#birthday, #rainichi-date, #sotsugyou-date").datepicker();
    _time_period_select_init($("#nyuusha-date"), $("#taisya-date"));
    $("#passport-expire, #visa-expire").datepicker({
        maxDate: "+30y",
        yearRange: "-30:+30"
    });
}

function add_list_date_formto_init(start_elem, end_elem) {
    $(start_elem).each(function (index, date_start_elem) {
    	$(this).attr("id", ++$.datepicker.uuid).removeClass("hasDatepicker").datepicker({
            onClose: function (selectedDate) {
                $(date_start_elem).datepicker("option", "minDate", selectedDate);
            }
        });
    })
    $(end_elem).each(function (index, date_end_elem) {
    	$(this).attr("id", ++$.datepicker.uuid).removeClass("hasDatepicker").datepicker({
            onClose: function (selectedDate) {
                $(date_end_elem).datepicker("option", "minDate", selectedDate);
            }
        });
    })
}

function add_project_date_edit_page_init() {
    function _project_date_start_init(start_elem, end_elem) {
        start_elem.attr("id", ++$.datepicker.uuid).removeClass("hasDatepicker").datepicker({
            dateFormat: "yy年mm月",
            showButtonPanel: true,
            beforeShow: hideDates,
            onClose: function (dateText, inst) {
                var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                $(this).datepicker("option", "defaultDate", new Date(year, month, 1));//
                $(this).datepicker('setDate', new Date(year, month, 1));
                var date = end_elem.datepicker("getDate");//
                end_elem.datepicker("option", "minDate", start_elem.datepicker("getDate"));
                end_elem.datepicker("option", "defaultDate", date);//
            }
        });
        set_value(start_elem);
    }

    function _project_date_end_init(start_elem, end_elem) {
        end_elem.attr("id", ++$.datepicker.uuid).removeClass("hasDatepicker").datepicker({
            dateFormat: "yy年mm月",
            showButtonPanel: true,
            beforeShow: hideDates,
            onClose: function (dateText, inst) {
                var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                $(this).datepicker("option", "defaultDate", new Date(year, month, 1));//
                $(this).datepicker('setDate', new Date(year, month, 1));
                var date = start_elem.datepicker("getDate");//
                start_elem.datepicker("option", "maxDate", end_elem.datepicker("getDate"));
                start_elem.datepicker("option", "defaultDate", date);//
            }
        });
        set_value(end_elem);
    }

    function set_value(elem) {
        var queryDate = elem.val(),
            dateParts = queryDate.match(/(\d+)/g),
            date = new Date(dateParts[0], dateParts[1] - 1, 1);
        elem.datepicker("option", "defaultDate", date);//
        elem.datepicker("setDate", date);
    }

    $("#projects .project").each(function (index, project_elem) {
        var start_elem = $(project_elem).find(".project-start-date");
        var end_elem = $(project_elem).find(".project-end-date");
        _project_date_start_init($(start_elem), $(end_elem));
        _project_date_end_init($(start_elem), $(end_elem));
    });
}
function set_value(elem) {
    var queryDate = elem.val(),
        dateParts = queryDate.match(/(\d+)/g),
        date = new Date(dateParts[0], dateParts[1] - 1, 1);
    elem.datepicker("option", "defaultDate", date);//
    elem.datepicker("setDate", date);
}

function add_work_history() {
    $(".work-history-table").append('<tr>' +
        '<td><input type="text" class="work-history-nyuusha-date" name="rirekiNyuushaDate"></td>' +
        '<td><input type="text" class="work-history-taisha-date" name="rirekiTaishaDate"></td>' +
        '<td><input type="text" name="rirekiCompanyName"></td>' +
        '<td><input type="text" name="rirekiBuSho"></td>' +
        '</tr>');
    add_list_date_formto_init('.work-history-nyuusha-date','.work-history-taisha-date','yy年mm月dd日');
}

function remove_work_history() {
    var length = $(".work-history-table tr").length;
    if(length > 2){
        _remove_last_work_history();
    } else if(length = 2) {
        _remove_last_work_history();
        add_work_history(true);
    }

    function _remove_last_work_history() {
        $(".work-history-table tr").last().remove();
    }
}

function add_project() {
	var node=$('.project')[0].cloneNode(true);
	$('.project')[0].parentNode.appendChild(node);

	add_project_date_edit_page_init();
}

function remove_project(button){
	   var length = $(".project").length;
	    if(length > 1){
	    	 $(button).parent().parent().remove();
	    }

}

var projectHTML;

/**
 * 業務経歴をもう一つ作る。五つが限界です。
 * @param index 1 - based
 */
/*
function add_project(button){

    if(button == null){ //when remove 一つ目の業務経歴
        $("#projects").html(projectHTML);
        var project = $("#projects").find(".project");
        add_project_date_init(project);
    } else if($("#projects .project").length >= 5) {
        return;
    } else {
        var addedHTML = projectHTML;
        var project = $(button).parent().parent();
        project.after(addedHTML);
        var next_project = project.next();
        add_project_date_init(next_project, true);
    }
}



*/
/**********************************************************************************************
 * ****************************************************************************************** *
 ******************         登録ボタンをクリックしてからのチェック         ***********************
 * ****************************************************************************************** *
 *********************************************************************************************/

function submit_check() {
    return base_check() && work_history_check() && project_check() ;
}

//javascript不支持\A, \z.
function base_check() {

    var conditions = [
        new Condition("input[name=employeeCode]", "社員コード", true, "alphanumeric", 10, null),
        new Condition("input[name=kanjiSei]", "社員名（漢字）", true, "zenkaku", 15, null),
        new Condition("input[name=kanjiMei]", "社員名（漢字）", true, "zenkaku", 15, null),
        new Condition("input[name=katakanaSei]", "社員名（カタカナ）", true, "katakana", 15, null),
        new Condition("input[name=katakanaMei]", "社員名（カタカナ）", true, "katakana", 15, null),
        new Condition("input[name=englishSei]", "社員名（英語）", true, "alphabetic", 30, null),
        new Condition("input[name=englishMei]", "社員名（英語）", true, "alphabetic", 30, null),
        new Condition("input[name=shusshin]", "出身地", false, "zenkaku", 30, null),
        new Condition("input[name=passportId]", "パスポート番号", false, "regExp", 20, /^[A-Z0-9]+$/),
        new Condition("input[name=myNumber]", "マイナンバー", false, "regExp", 20, /^[A-Z0-9]+$/),
        new Condition("input[name=zairyuuNumber]", "在留番号", false, "regExp", 20, /^[A-Z0-9]+$/),
        new Condition("textarea[name=bikou]", "備考", false, "string", 255, null),
        new Condition("input[name=postcode]", "住所", false, "regExp", 8, /^\d{3}-\d{4}$/),
        new Condition("input[name=address1]", "住所", false, "zenkaku", 100, null),
        new Condition("input[name=address2]", "住所", false, "zenkaku", 100, null),
        new Condition("input[name=moyoriEki]", "最寄駅", false, "zenkaku", 30, null),
        new Condition("input[name=tel]", "携帯電話", false, "regExp", 15, /^0\d{1,4}-\d{1,4}-\d{4}$/),
        new Condition("input[name=mailAddress]", "メールアドレス", true, "regExp", 50, /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/),
        new Condition("input[name=wechatId]", "WechatID", false, "alphanumeric", 50, null),
        new Condition("input[name=lineId]", "LineID", false, "alphanumeric", 50, null),
        new Condition("textarea[name=bokokuAddress]", "母国の住所", false, "string", 255, null),
        new Condition("textarea[name=bokokuRennraku]", "母国の緊急連絡先", false, "string", 255, null),
        new Condition("input[name=schoolName]", "学校名", false, "zenkaku", 100, null),
        new Condition("input[name=sennmonn]", "専門", false, "zenkaku", 100, null),
        new Condition("input[name=rirekiCompanyName]", "会社名", false, "zenkaku", 100, null),
        new Condition("input[name=rirekiBuSho]", "部署", false, "zenkaku", 100, null),
        new Condition("textarea[name=appeal]", "備考及び自己アピール", false, "string", 1024, null),
        new Condition("#projects input[name=projectName]", "PJ名", false, "string", 100, null),
        new Condition("#projects input[name=kibo]", "規模人数", false, "numeric", 6, null),
        new Condition("#projects input[name=language]", "言語", false, "string", 100, null),
        new Condition("#projects input[name=db]", "DB", false, "string", 100, null),
        new Condition("#projects input[name=tool]", "FW・IDE・ツール", false, "string", 100, null),
        new Condition("#projects textarea[name=projectGaiyou]", "開発概要", false, "string", 1024, null)
    ];

   return infput_check(conditions);

}

function work_history_check() {
    var _result = true;
    $("input[name='rirekiNyuushaDate'], \
        input[name='rirekiTaishaDate'], \
        input[name='rirekiCompanyName'], \
        input[name='rirekiBuSho']").each(function (index, current_elem) {
        if(_result && is_Empty(current_elem)){
            current_elem.focus();
            alert("職歴を入力してください。");
            _result = false;
            return ;
        }
    });

    var nyuushaDates = [];
    $("input[name='rirekiNyuushaDate']").each(function (index, current_elem){
    	nyuushaDates.push($(current_elem).val());
    });
    if(is_repeat(nyuushaDates)){
    	alert("職歴の入社時間が重複しています。");
    	_result = false;
    }

    return _result;
}

function project_check() {
    var _result = true;
    $("#projects input[name='projectStartDate'], \
        #projects input[name='projectEndDate'], \
        #projects input[name='projectName'], \
        #projects input[name='kibo'], \
        #projects input[name='language'], \
        #projects input[name='db'], \
        #projects input[name='tool'], \
        #projects textarea[name='projectGaiyou']").each(function (index, current_elem) {
        if(_result && is_Empty(current_elem)){
            current_elem.focus();
            alert("業務経歴を入力してください。");
            _result = false;
            return;
        }
    });

    var startDates = [];
    $("#projects input[name='projectStartDate']").each(function (index, current_elem){
    	startDates.push($(current_elem).val());
    });
    if(is_repeat(startDates)){
    	alert("業務経歴の開始時間が重複しています。");
    	_result = false;
    }

    return _result;
}



