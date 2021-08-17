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
    	
    	if(!window.confirm(name+"該当取引先削除する、いいですか？" )){		
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


/**
 * Created by okimai on 2017/9/22.
 */

//$(function(){
//
//    function setAnswerForm(target) {
//        window.addData = function () {
////            $("#torihikisakiId").val("");
////            $("#actions").val("add");
//            target.submit();
//        };

//        window.updateData = function (hakkenMonth, renban, withJyutyuNum) {
//            $("#submitKind").val(SUBMIT_TYPE_EDIT);
//            $("#month").val(hakkenMonth);
//            $("#renban").val(renban);
//            $("#withJyutyuNum").val(withJyutyuNum);
//            target.submit();
//        };
//        function deleteData(type,id,name,deleteFlag) {
//            if(confirm(name+"該当取引先削除する、いいですか？" )){
//                $.ajax({
//                    url: "/togokanri/TorihikisakiManage",
//                    type: "POST",
//                    data: $.param({torihikisakiId: id, action: 'delete'}),
//                    timeout: 5000,
//                    success: function(result){
//                        switch (result.state){
//                            case 0:
//                                location.reload();
//                                break;
//                            case 1:
//                                alert("該当取引先すでに受注処理をしましたので、削除できません。");
//                                break;
//                        }
//                    },
//                    complete: function(XMLHttpRequest, status){
//                        if(XMLHttpRequest.status == 404){
//                            alert("ページが見つかりません");
//                        }
//                        if(status == "timeout"){
//                            alert("request timeout");
//                        }
//                    },
//                    error: function(jqXHR, textStatus, message) {
//                        alert("111");
//                    }
//                });
//            }
//        }
//    }

//    setAnswerForm($("#answerForm"));

//});
