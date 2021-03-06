/**
 * Created by okimai on 2017/10/13.
 */
$(function () {

    function initForm(target) {

       // new Condition("input[name=jyutyuuIraisaki]", "依頼先", true, "string", 4, null),
        var conditions = [
            new Condition("input[name=jyutyuuIraisakiId]", "依頼先", true, "string",100, null),
            new Condition("input[name=jyutyuuSyainId]", "社員名", true, "string", 100, null),
            new Condition("input[name=date]", "受注月", true, "regExp", 8, /^20\d{2}年(0[1-9]|1[0-2])月$/),
            new Condition("input[name=jyutyuuSyainName]", "社員", true, "string", 4, null),
            new Condition("input[name=jyutyuuAnkeimei]", "案件名", true, "string", 100, null),
            new Condition("input[name=jyutyuuSagyouBasyo]", "作業場所", true, "string", 50, null),
            new Condition("input[name=jyutyuuWari]", "日割り率", true, "regExp", 4, /^0|1|(0\.\d{1,2})$/),
            new Condition("input[name=jyutyuuKaishibi]", "開始日", true, "regExp", 2, /^\d{1,2}$/),
            new Condition("input[name=jyutyuuSyuuryoubi]", "終了日", true, "regExp", 20, /^\d{1,2}$/),
            new Condition("input[name=jyutyuuKingaku]", "受注金額", true, "numeric", 10, null),
            new Condition("input[name=jyutyuuSeisan]", "在留番号", false, "regExp", 20, /^[A-Z0-9]+$/),
            new Condition("input[name=jyutyuuKagenJikan]", "下限時間", false, "regExp", 5, /^\d{1,3}(\.\d)?$/),
            new Condition("input[name=jyutyuuJyougenJikan]", "上限時間", false, "regExp", 5, /^\d{1,3}(\.\d)?$/),
            new Condition("input[name=jyutyuuKagenKingaku]", "控除金額", false, "numeric", 10, null),
            new Condition("input[name=jyutyuuJyougenKingaku]", "超過金額", false, "numeric", 10, null),
            new Condition("textarea[name=jyutyuuBikou]", "備考", false, "string", 255, null),

            new Condition("input[name=gaityuusaki]", "外注先", false, "string", 255, null),//特殊
            new Condition("input[name=gaityuuKaishibi]", "開始日", false, "regExp", 4, /^\d{1,2}$/),//特殊
            new Condition("input[name=gaityuuSyuuryoubi]", "終了日", false, "regExp", 4, /^\d{1,2}$/),//特殊
            new Condition("input[name=gaityuuKingaku]", "外注金額",  false, "numeric", 10, null),//特殊
            new Condition("input[name=gaityuuKagenJikan]", "下限時間", false,  "regExp", 5, /^\d{1,3}(\.\d)?$/),
            new Condition("input[name=gaityuuJyougenJikan]", "上限時間", false,  "regExp", 5, /^\d{1,3}(\.\d)?$/),
            new Condition("input[name=gaityuuKagenKingaku]", "控除金額", false, "numeric", 10, null),
            new Condition("input[name=gaityuuJyougenKingaku]", "超過金額", false, "numeric", 10, null),
            new Condition("input[name=gaityuuSagyouinName]", "作業員名", true, "string", 100, null), //特殊
            new Condition("textarea[name=gaityuuBikou]", "備考", false, "string", 255, null)
        ];

        /**
         * 精算ボタンや外注チェックボックスの数値の変化で、conditionsへの変化を初期設定
         */
        var initSeisan = function () {
            // 受注の精算ありになったら、下限時間、上限時間、下限金額、上限金額の入力チェックが必要になります。
            $("#jyutyuuSeisan").on("change", function () {
                var nn = this.value == 1;
                getCondition("input[name=jyutyuuKagenJikan]").nn = nn;
                getCondition("input[name=jyutyuuJyougenJikan]").nn = nn;
                getCondition("input[name=jyutyuuKagenKingaku]").nn = nn;
                getCondition("input[name=jyutyuuJyougenKingaku]").nn = nn;
                var inputFields = $("input[name=jyutyuuKagenJikan], \
                    input[name=jyutyuuJyougenJikan], \
                    input[name=jyutyuuKagenKingaku], \
                    input[name=jyutyuuJyougenKingaku]");
                inputFields.attr("disabled", !nn);
                if(!nn){
                    inputFields.val("");
                }

                if(isGaityuCheckBoxSelected()){
                    $("#gaityuuSeisan").val(this.value);
                    $("#gaityuuSeisan").change();
                }
            });

            // 外注の精算ありになったら、もし外注のチェックボックスをチェックしたら、
            // 下限時間、上限時間、下限金額、上限金額の入力チェックが必要になります。
            $("#gaityuuSeisan").on("change", function () {
                var nn = this.value == 1 && isGaityuCheckBoxSelected();
                    getCondition("input[name=gaityuuKagenJikan]").nn = nn;
                    getCondition("input[name=gaityuuJyougenJikan]").nn = nn;
                    getCondition("input[name=gaityuuKagenKingaku]").nn = nn;
                    getCondition("input[name=gaityuuJyougenKingaku]").nn = nn;

                    var inputFields = $("input[name=gaityuuKagenJikan], \
                    input[name=gaityuuJyougenJikan], \
                    input[name=gaityuuKagenKingaku], \
                    input[name=gaityuuJyougenKingaku]");
                    inputFields.attr("disabled", !nn);
                    if(!nn){
                        inputFields.val("");
                    }
            });


            $("#jyutyuuSeisan").change();
            $("#gaityuu").change();
            $("#gaityuuSeisan").change();

        };

        var isGaityuCheckBoxSelected = function () {
            return $("#gaityuu:checked").val() == 1;
        };

        var getCondition = function (selector) {
            for(i in conditions){
                var condition = conditions[i];
                if(condition.selector == selector){
                    return condition;
                }
            }
        };

        var checkAll = function () {
            var input_check = infput_check;
            return input_check(conditions);
        };

        var updateShuuRyoubi = function (date_elem) {
            //「日付」要素の今月の最後の日を取得
            var date = $(date_elem).datepicker("getDate");
            date.setMonth( date.getMonth() + 1 );
            date.setDate( 0 );
            var syuuryoubi = date.getDate();

            $("input[name=gaityuuSyuuryoubi], input[name=jyutyuuSyuuryoubi]").val(syuuryoubi);
        };

        var initGaityuCheckbox = function () {
            $("#gaityuu").on("change", function () {
                if(this.checked){
                    gaityuActive();
                } else {
                    gaityuInactive();
                }

                //外注関連
                var nn = this.checked ? true : false;
                getCondition("input[name=gaityuusaki]").nn = nn;
                getCondition("input[name=gaityuuKaishibi]").nn = nn;
                getCondition("input[name=gaityuuSyuuryoubi]").nn = nn;
                getCondition("input[name=gaityuuKingaku]").nn = nn;

                // 社員チェック無効、作業員チェック有効
                getCondition("input[name=jyutyuuSyainName]").nn = !nn;
                getCondition("input[name=jyutyuuSyainId]").nn = !nn;
                getCondition("input[name=gaityuuSagyouinName]").nn = nn;
                $("#gaityuuSeisan").change();
            });
        };

        var gaityuActive = function () {
            //外注関連ブロックを表示する
            $("#gaityuuBox").show();

            //受注からコピーする：開始日、終了日、精算、下限時間、上限時間、控除金額、超過金額
            $("#gaityuuKaishibi").val(document.getElementById("jyutyuuKaishibi").value);
            $("#gaityuuSyuuryoubi").val(document.getElementById("jyutyuuSyuuryoubi").value);
            $("#gaityuuSeisan").val(document.getElementById("jyutyuuSeisan").value);
            $("#gaityuuKagenJikan").val(document.getElementById("jyutyuuKagenJikan").value);
            $("#gaityuuJyougenJikan").val(document.getElementById("jyutyuuJyougenJikan").value);
            $("#gaityuuKagenKingaku").val(document.getElementById("jyutyuuKagenKingaku").value);
            $("#gaityuuJyougenKingaku").val(document.getElementById("jyutyuuJyougenKingaku").value);

            //社員名を空白し、社員検索を無効にする
            $("#jyutyuuSyainName").val("");
            $("#jyutyuuSyainId").val("");
            $("#syainSelectButton").hide();
        };

        var gaityuInactive = function () {
            //外注関連ブロックを表示する
            $("#gaityuuBox").hide();
            //社員検索を有効にする
            $("#syainSelectButton").show();
            //受注の場合、作業員チェック無効
            var nn = false;
            getCondition("input[name=gaityuuSagyouinName]").nn = nn;

            $("#bottom-line").hide();
        };

        var initCalculateKingaku = function(){
            $("#calculateKingaku").on("click", function () {
            	
                //控除金額、超過金額を計算、記入
                //控除金額＝外注金額/下限時間（※10円切り上げ）
                //超過金額＝外注金額/上限時間（※10円切り捨て）
                var kingaku = document.getElementById("gaityuuKingaku").value;
                var kagenJikan = document.getElementById("gaityuuKagenJikan").value;
                var jyougenJikan = document.getElementById("gaityuuJyougenJikan").value;

                if(!kingaku || !kagenJikan || !jyougenJikan){
                	alert("外注金額、上限時間と下限時間を入力してください!");               	
                } else if (kagenJikan <= 0 || jyougenJikan <= 0) {
                	alert("上限時間または下限時間0以上を入力してください!");
                } else {
                	var kagenKingaku = kingaku / kagenJikan;
                    kagenKingaku = Math.ceil( kagenKingaku / 10 ) * 10;
                    $("#gaityuuKagenKingaku").val(kagenKingaku);
                    var jyougenKingaku = kingaku / jyougenJikan;
                    jyougenKingaku = Math.floor( jyougenKingaku / 10 ) * 10;
                    $("#gaityuuJyougenKingaku").val(jyougenKingaku);
                }
          
            });
        };

        // 関連チェック
        $("#checkflag").on("click", function () {
        	// 受注開始日と終了日
        	var jyutyuKaishibi = document.getElementById("jyutyuuKaishibi").value;
        	var jyutyuSyuryoubi = document.getElementById("jyutyuuSyuuryoubi").value;
        	// 外注開始日と終了日
        	var gaityuKaishibi = document.getElementById("gaityuuKaishibi").value;
        	var gaityuSyuryoubi = document.getElementById("gaityuuSyuuryoubi").value;
        	// 受注上下限時間
        	var jyutyuJyougenJikan = document.getElementById("jyutyuuJyougenJikan").value;
        	var jyutyuKagenJikan = document.getElementById("jyutyuuKagenJikan").value;
        	// 外注上下限時間
        	var gaityuJyougenJikan = document.getElementById("gaityuuJyougenJikan").value;
        	var gaityuKagenJikan = document.getElementById("gaityuuKagenJikan").value;
        	// 受注控除金額と超過金額
        	var jyutyuKagenKingaku = document.getElementById("jyutyuuKagenKingaku").value;
        	var jyutyuJyougenKingaku = document.getElementById("jyutyuuJyougenKingaku").value;
        	// 外注控除金額と超過金額
        	var gaityuKagenKingaku = document.getElementById("gaityuuKagenKingaku").value;
        	var gaityuJyougenKingaku = document.getElementById("gaityuuJyougenKingaku").value;
	
        	var jyutyugetu = $("#date");
        	var date = $(jyutyugetu).datepicker("getDate");
            date.setMonth(date.getMonth() + 1);
            date.setDate(0);
            var syuuryoubi = date.getDate();

        	if(jyutyuSyuryoubi > syuuryoubi){			
        		alert("受注終了日は今月の最後の日を超えてはいけません。");						
        		return false;		
        	}		
        	if(gaityuSyuryoubi　> syuuryoubi){			
        		alert("外注終了日は今月の最後の日を超えてはいけません。");			
        		return false;		
        	}
        	if (jyutyuKagenJikan && jyutyuJyougenJikan) {
        		if(jyutyuKagenJikan > jyutyuJyougenJikan){			
            		alert("受注下限時間は上限時間を超えてはいけません。");						
            		return false;		
            	}
        	}
        	if(gaityuJyougenJikan && gaityuKagenJikan){
        		if (gaityuKagenJikan > gaityuJyougenJikan) {
        			alert("外注下限時間は上限時間を超えてはいけません。");						
            		return false;
        		}       				
        	}
        	if (jyutyuKaishibi && jyutyuSyuryoubi) {
        		if(jyutyuKaishibi > jyutyuSyuryoubi){			
            		alert("受注開始日は終了日を超えてはいけません。");						
            		return false;		
            	}
        	}  	
        	if(gaityuKaishibi && gaityuSyuryoubi){
        		if (gaityuKaishibi > gaityuSyuryoubi) {
        			alert("外注開始日は終了日を超えてはいけません。");						
            		return false;
        		}       				
        	}
        	if (jyutyuKagenKingaku && jyutyuJyougenKingaku) {
        		if(jyutyuJyougenKingaku > jyutyuKagenKingaku){			
            		alert("受注超過金額は控除金額を超えてはいけません。");						
            		return false;		
            	}
        	}
        	if(gaityuKagenKingaku && gaityuJyougenKingaku){
        		if (gaityuJyougenKingaku > gaityuKagenKingaku) {
        			alert("外注超過金額は控除金額を超えてはいけません。");						
            		return false;
        		}       				
        	}
        	return true;	
        });

        //初期設定
        var init = function () {
            target.on({
                'submit': function () {
                    return checkAll();
                }
            });
            var date_elem = $("#date");
            date_elem.on({
                'change': function () {
                    updateShuuRyoubi(this);
                }
            });
            var curDate = new Date();
            var curYear =curDate.getFullYear();
            var curMonth = curDate.getMonth()+1; 
            $("#niseDate").val(curYear+"年"+curMonth+"月")
//            var niseDate = 
            $("#gaityuusakiId").on("change", function () {
                $("#gaityuuSyainId").val("");
            });
            $("#gaityuuSyainId").on("change", function () {
                $("#gaityuusakiId").val("");
            });
            initDate(date_elem);
            initDateWithArrow(date_elem, $("#minusDateArrow"), $("#addDateArrow"));
            initGaityuCheckbox();
            initCalculateKingaku();
            initSeisan();
            updateShuuRyoubi(date_elem);
        }

        init();
    }

    initForm($(".edit-form"));
});