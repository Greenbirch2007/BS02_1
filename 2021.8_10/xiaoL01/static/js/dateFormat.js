$.datepicker.regional['jp'] = {
    changeMonth: true, //年份变下拉框
    changeYear: true,	//月份变下拉框
    showMonthAfterYear: true,
    yearRange: "-80:+80",  //前後80年
    monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月', '八月', '九月', '十月', '十一月', '十二月'],
    monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
    dayNames: ['日曜日', '月曜日', '火曜日', '水曜日', '木曜日', '金曜日', '土曜日'],  //鼠标在星期几上面显示
    dayNamesMin: ['日', '月', '火', '水', '木', '金', '土'],
    dateFormat: "yy年mm月dd日",
    maxDate: "+1y",  //1年後
    // gotoCurrent: true,
    closeText: "確認",
    currentText: "今日",
    beforeShow: showDates //展示日期
};

$.datepicker.setDefaults($.datepicker.regional['jp']);


function _time_period_select_init(date_start_elem, date_end_elem) {
    date_start_elem.datepicker({
        onClose: function (selectedDate) {
            date_end_elem.datepicker("option", "minDate", selectedDate);
        }
    });

    date_end_elem.datepicker({
        onClose: function (selectedDate) {
            date_start_elem.datepicker("option", "maxDate", selectedDate);
        }
    });
}

function showDates(input, inst) {
    var newclass = 'calendar-base showDates';
    var p = inst.dpDiv.parent();
    if (!p.hasClass('calendar-base'))
        inst.dpDiv.wrap('<div class="' + newclass + '"></div>');
    else
        p.removeClass('hideDates').addClass('showDates');
}

function hideDates(input, inst) {
    var newclass = 'calendar-base hideDates';
    var p = inst.dpDiv.parent();
    if (!p.hasClass('calendar-base'))
        inst.dpDiv.wrap('<div class="'+newclass+'"></div>');
    else
        p.removeClass('showDates').addClass('hideDates');
}
