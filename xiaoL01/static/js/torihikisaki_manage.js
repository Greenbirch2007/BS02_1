/**
 * Created by okimai on 2017/6/8.
 */
(function () {

    // if(sessionStorage.companyId) {
    //     document.getElementById("companyId")[sessionStorage.companyId].selected = true;
    //     var company = companys[company.selectedIndex];
    // } else if(sessionStorage.name) {
    //     document.getElementById("name").value = sessionStorage.name;
    // } else if(sessionStorage.jobId) {
    //     document.getElementById("jobId")[sessionStorage.companyId].selected = true;
    // }

})();


function doSubmit(type,id,name){
    var hd1  = document.getElementById("torihikisakiId");
    var hd2  = document.getElementById("action");
    hd1.value=id

    if(type==1){
    	hd2.value="edit";
        document.frmTorihikisaki.submit();
    }else if(type==2){
    	if(!window.confirm( name+"を削除してもよろしいですか？" )){
  	      return;
 	    }else{
 	    	hd2.value="delete";
 	        document.frmTorihikisaki.submit();
 	    }
    }else{
    	hd2.value="addnew";
        document.frmTorihikisaki.submit();
    }
 }








