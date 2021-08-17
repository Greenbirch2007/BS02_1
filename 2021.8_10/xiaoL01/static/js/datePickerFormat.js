/**
 * Created by okimai on 2017/10/1.
 */

/**
 * 「日付」を初期化
 * @param date_elem 「日付」要素
 */
function initDate(date_elem) {

    var hideDates = function (input, inst) {
        var newclass = 'calendar-base hideDates';
        var p = inst.dpDiv.parent();
        if (!p.hasClass('calendar-base'))
            inst.dpDiv.wrap('<div class="' + newclass + '"></div>');
        else
            p.removeClass('showDates').addClass('hideDates');
    }

    var showDates = function (input, inst) {
        var newclass = 'calendar-base showDates';
        var p = inst.dpDiv.parent();
        if (!p.hasClass('calendar-base'))
            inst.dpDiv.wrap('<div class="' + newclass + '"></div>');
        else
            p.removeClass('hideDates').addClass('showDates');
    }

    $.datepicker.regional['jp'] = {
        changeMonth: true, //年份变下拉框
        changeYear: true,	//月份变下拉框
        showMonthAfterYear: true,
        yearRange: "-10:+10",  //可选年份跨度(默认只能选前10年)
        monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
        monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
        dateFormat: "yy年mm月",
        //maxDate: 0,  //限制不能超过今天
        // gotoCurrent: true,
        closeText: "確認",
        currentText: "今日",
        beforeShow: showDates //展示日期
    };

    $.datepicker.setDefaults($.datepicker.regional['jp']);

    date_elem.datepicker({
        dateFormat: "yy年mm月",
        showButtonPanel: true,
        beforeShow: hideDates,
        onClose: function (dateText, inst) {
            var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
            var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
            $(this).datepicker("option", "defaultDate", new Date(year, month, 1));//
            $(this).datepicker('setDate', new Date(year, month, 1));
            $(this).change();
        }
    });

    //派遣月が初期化されていない場合は、システムの月にします
    if(!date_elem.val()){
        var firstDayOfThisMonth = new Date();
        firstDayOfThisMonth.setDate(1);
        date_elem.datepicker("option", "defaultDate", firstDayOfThisMonth);
        date_elem.datepicker("setDate", firstDayOfThisMonth);
    } else {
        var str = $("#date").val();
        var date = new Date(str.substring(0,4), Number(str.substring(5, 7)) - 1, 1);
        date_elem.datepicker("option", "defaultDate", date);
        date_elem.datepicker("setDate", date);
    }

}

/**
 * 「<< 日付 >>」 を初期化
 * @param date_elem 「日付」要素
 * @param minusArrow 「<<」要素
 * @param addArrow 「>>」要素
 */
function initDateWithArrow(date_elem, minusArrow, addArrow) {

    var addOneMonth = function () {
        var date = date_elem.datepicker("getDate");
        date.setMonth(date.getMonth() + 1);
        date_elem.datepicker("option", "defaultDate", date);
        date_elem.datepicker('setDate', date);
        date_elem.change();
    };

    var minusOneMonth = function () {
        var date = date_elem.datepicker("getDate");
        date.setMonth(date.getMonth() - 1);
        date_elem.datepicker("option", "defaultDate", date);
        date_elem.datepicker('setDate', date);
        date_elem.change();
    };

    minusArrow.on("click", function () {
        minusOneMonth();
    });

    addArrow.on("click", function () {
        addOneMonth();
    });

}

