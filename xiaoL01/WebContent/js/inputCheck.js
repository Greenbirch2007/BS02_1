function infput_check(conditions){

    for(i in conditions){
        var condition = conditions[i];
        var elems = $(condition.selector);
        //console.log(condition.selector + ": " + elems.length);
        if(elems.length == 1){
            if(!condition_check(elems, condition)){
                return false;
            }
        } else if(elems.length > 1) {
            elems.each(function (index, current_elem) {
                if (!condition_check($(current_elem), condition)) {
                    return false;
                }
            });
        }

    }
    return true;
}



function condition_check(elem, condition) {
    var empty = is_Empty(elem);

    if(condition.nn == true){
        if(empty){
            condition_check_fail(condition, condition.item_name + "を入力してください。");
            return false;
        }
    }

    if(empty) return true;

    if(condition.kind == "string"){

    } else if(condition.kind == "regExp"){
        if(condition.regExp.test(elem.val()) == false){ 			
            condition_check_fail(condition, condition.item_name + "の格式は正確に入力してください。");
            return false;
        }
    } else {
        if(checkCharType(elem.val(), condition.kind) == false){
            var kind;
            switch (condition.kind){
                case "zenkaku": kind = "全角"; break;
                case "katakana": kind = "全角のカタカナ"; break;
                case "zenkaku_alphabetic": kind = "全角の英字"; break;
                case "alphanumeric": kind = "半角英数字"; break;
                case "numeric": kind = "半角数字"; break;
                case "alphabetic": kind = "半角英文"; break;
            }
            condition_check_fail(condition, condition.item_name + "は" + kind +"で入力してください。");
            return false;
        }
    }

    if(elem.val().length > condition.maxLength){
        condition_check_fail(condition, condition.item_name + "は" + condition.maxLength + "文字数以下で入力してください。");
        return false;
    }

    return true;
}

/**
 * http://tokyo-wabisabi-boys.net/blog/javascriptjquery/js-string-regex-check
 文字列チェック
 @param  input    String  チェック対象文字列
 @param  charType String  チェック種別
 　・"zenkaku"               : 全角文字（ひらがな・カタカナ・漢字 etc.）
 　・"hiragana"              : 全角ひらがな
 　・"katakana"              : 全角カタカナ
 　・"alphanumeric"          : 半角英数字（大文字・小文字）
 　・"numeric"               : 半角数字
 　・"alphabetic"            : 半角英字（大文字・小文字）
 　・"upper-alphabetic"      : 半角英字（大文字のみ）
 　・"lower-alphabetic"      : 半角英字（小文字のみ）
 @return Boolean チェック結果OKかどうか
 true  : チェックOK（引数に指定した種別の文字列のみで構成されている)
 false : チェックNG（引数に指定した種別以外の文字列が含まれている）
 */
function checkCharType(input, charType) {
    switch (charType) {
        // 全角文字（ひらがな・カタカナ・漢字 etc.）
        case "zenkaku":
            return (input.match(/^[^\x01-\x7E\xA1-\xDF]+$/)) ? true : false;
        // 全角ひらがな
        case "hiragana":
            return (input.match(/^[\u3041-\u3096]+$/)) ? true : false;
        // 全角カタカナ
        case "katakana":
            return (input.match(/^[\u30a1-\u30f6]+$/)) ? true : false;
        // 半角英数字（大文字・小文字）
        case "alphanumeric":
            return (input.match(/^[0-9a-zA-Z]+$/)) ? true : false;
        // 半角数字
        case "numeric":
            return (input.match(/^[0-9]+$/)) ? true : false;
        // 半角英字（大文字・小文字）
        case "alphabetic":
            return (input.match(/^[a-zA-Z]+$/)) ? true : false;
        // 半角英字（大文字のみ）
        case "upper-alphabetic":
            return (input.match(/^[A-Z]+$/)) ? true : false;
        // 半角英字（小文字のみ）
        case "lower-alphabetic":
            return (input.match(/^[a-z]+$/)) ? true : false;
        // 全角英字
        case "zenkaku_alphabetic":
            return (input.match(/^[Ａ-Ｚａ-ｚ]+$/)) ? true : false;
    }
    return false;
}


function Condition(selector, item_name, nn, kind, maxLength, regExp) {
    this.selector = selector;
    this.item_name = item_name;
    this.nn = nn;
    this.kind = kind;
    this.maxLength = maxLength;
    this.regExp = regExp;
}

function condition_check_fail(condition, msg) {
    $(condition.selector).focus();
    alert(msg);
}

function is_Empty(elem) {
    var _result = false;
    if(!$(elem).val()){
        _result = true;
    }
    if(!$(elem).val().replace(/[ 　]/g, "")){
        _result = true;
    }
    return _result;
}

function is_repeat(arr){
	var hash = {};
	for(var i in arr) {
	   if(hash[arr[i]]){
	       return true;
	   }
	   hash[arr[i]] = true;
	}
	return false;
}