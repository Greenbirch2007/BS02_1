/**
 * Created by okimai on 2017/6/8.
 */


function doSubmit(type,id,name){
    var hd1  = document.getElementById("syainId");
    var hd2  = document.getElementById("action");
    hd1.value=id

    if(type==1){
    	hd2.value="edit";
        document.frmSyain.submit();
    }else if(type==2){
    	if(!window.confirm( name+"を削除してもよろしいですか？" )){
  	      return;
 	    }else{
 	    	hd2.value="delete";
 	        document.frmSyain.submit();
 	    }
    }else{
    	hd2.value="addnew";
        document.frmSyain.submit();
    }
 }


function queryConfirm() {
    console.log(document.getElementsByName("zaisyoku")[0].checked);
    console.log(document.getElementsByName("hizaisyoku")[0].checked);
    
    if(!document.getElementsByName("zaisyoku")[0].checked &&
        !document.getElementsByName("hizaisyoku")[0].checked) {
        alert("在籍と非在籍がいずれにしても、\n１つのチェックが必須です。");
        return false;
    }
    return true;
}





