/**
 * Created by bin79 on 2017/6/11.
 */


function add_tantou() {
    $(".tantou-table").append('<tr>' +
    		 '<td style="text-align:center;"><input type="checkbox" name="tantou_jimuMail" value="1"></td> ' +
    		 '<td style="text-align:center;"><input type="checkbox" name="tantou_jimuMail" value="2" ></td> ' +
    		 '<td><input type="text" name="tantou_firstName" }"></td> ' +
    		 '<td><input type="text" name="tantou_lastName" "></td> ' +
    		 '<td><input type="text" name="tantou_mail" "></td> ' +
    		 '<td><input type="text" name="tantou_syozoku" "></td> ' +
    		 '<td><input type="text" name="tantou_yakusyoku" "></td> ' +
    		 '<td><input type="text" name="tantou_tel" "></td> ' +
    		 '<td><input type="text" name="tantou_bikou" }"></td> '	 +
        '</tr>');
}

function remove_tantou() {
    var length = $(".tantou-table tr").length;
    if(length > 2){
    	_remove_last_tantou();
    } else if(length = 2) {
        _remove_last_work_history();
        add_work_history(true);
    }

    function _remove_last_tantou() {
        $(".tantou-table tr").last().remove();
    }
}


/**********************************************************************************************
 * ****************************************************************************************** *
 ******************         登録ボタンをクリックしてからのチェック         ***********************
 * ****************************************************************************************** *
 *********************************************************************************************/

function submit_check() {
    return base_check() && tantou_check() ;
}

//javascript不支持\A, \z.
function base_check() {

    var conditions = [
        new Condition("input[name=torihikiNameAll]", "取引先名（全名）", true, "zenkaku", 49, null),
        new Condition("input[name=torihikiNameRyaku]", "会社名（略名）", true, "zenkaku", 29, null),
        new Condition("input[name=yuubin]", "郵便", true, "regExp", 8, /^\d{3}-\d{4}$/),
        new Condition("input[name=jyusyo1]", "住所１", true, "zenkaku", 100, null),
        new Condition("input[name=jyusyo2]", "住所２", false, "zenkaku", 100, null),
        new Condition("input[name=tel]", "電話", false, "regExp", 15, /^0\d{1,4}-\d{1,4}-\d{4}$/),
        new Condition("input[name=fax]", "FAX", false, "regExp", 15, /^0\d{1,4}-\d{1,4}-\d{4}$/),
        new Condition("input[name=url]", "ホームページ", false, "regExp", 100, /^(https?|ftp)(:\/\/[-_.!~*\'()a-zA-Z0-9;\/?:\@&=+\$,%#]+)$/),
        new Condition("textarea[name=bikou]", "備考", false, "string", 255, null),
        new Condition("#tantous input[name=tantou_firstName]", "姓", true, "string", 20, null),
        new Condition("#tantous input[name=tantou_lastName]", "名", true, "string", 20, null),
        new Condition("#tantous input[name=tantou_mail]", "メールアドレス", true, "regExp", 50, /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/),
        new Condition("#tantous input[name=tantou_syozoku]", "所属", false, "string", 50, null),
        new Condition("#tantous input[name=tantou_yakusyoku]", "役職", false, "string", 50, null),
        new Condition("#tantous input[name=tantou_tel]", "携帯電話", false, "regExp", 15, /^0\d{1,4}-\d{1,4}-\d{4}$/),
        new Condition("#tantous input[name=tantou_bikou]","備考", false, "string", 255, null),
    ];

   return infput_check(conditions);

}


function tantou_check() {
    var _result_1 = true;
    var _result_2 = true;
    var _result_3 = true;

   
  
    
   	var check=0;
    var ToCheck=0;
    $("input[name='tantou_jimuMail']").each(function (index, current_elem) {
    	if($(current_elem).is(':checked')){
    		check+=1;
    		if((index % 2)==0){
    			ToCheck+=1;
    		}
    	}//_result_1==true&&
    	if((index % 2)==1){
    		if(check!=1){
                current_elem.focus();
                alert("同一行のToとCCはいずれ一つのみチェックしてください。");
                _result_2 = false;
                return false;
    		}else{
    			check=0;
    		}
    	}
    });
    
    

    if(_result_1 && _result_2&&ToCheck==0){
    	alert("Toは少なくても一つチェックしてください。");
    	_result_3=false;
    }
    
    $("input[name='tantou_firstName'], \
    	       input[name='tantou_lastName'], \
    	       input[name='tantou_mail']").each(function (index, current_elem) {
    	        if(_result_2==true && _result_3==true&&is_Empty(current_elem)){
    	            current_elem.focus();
    	            alert("担当者姓名とメールアドレスの入力は必須です。");
    	            _result_1 = false;
    	            return false;
    	        }
    	        
    	    });
    return _result_1 && _result_2 && _result_3;
}



