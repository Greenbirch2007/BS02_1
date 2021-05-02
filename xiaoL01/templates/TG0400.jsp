<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>請求作成画面</title>
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/reset.css" type="text/css" />
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/common.css"
    type="text/css" />
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/manage.css"
    type="text/css" />
<link href="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.min.css"
    rel="stylesheet">
</head>
<body>
    <jsp:include page="header.jsp" flush="true" />
    <div class="content">
        <h1>
            <span>■</span>請求管理
        </h1>
        <h2>■検索条件</h2>
        <div class="content-top">
            <form method="get" action="${pageContext.request.contextPath}/TG0400"
                accept-charset="UTF-8" class="manage-form" id="queryForm">
                <label for="date" style="margin-right: 50px; margin-left: 100px">受注月</label>
                <a href="javascript:void(0)"
                    style="margin-right: 30px; color: #0066cc" id="minusDateArrow">&lt;&lt;</a>
                <input type="text" name="date" id="date" style="width: 90px"
                    value="${not empty voDate ? voDate : ''}"> <a
                    href="javascript:void(0)" style="margin-left: 30px; color: #0066cc"
                    id="addDateArrow">&gt;&gt;</a>
            </form>
        </div>
        <h2>■受注一覧</h2>
        <div class="content-bottom">
            <form method="post"
                action="${pageContext.request.contextPath}/TG0400" id="answerForm">
                <div class="row" style="margin-bottom: 5px">
                    <div class="right">
                        <span style="margin-right: 50px">件数： <span
                            style="color: #0066cc">${ voSize } 件</span></span>
                    </div>
                </div>
            </form>
                <c:forEach var="row" items="${vo}">
                    <table border="1" class="manage-table" id="manageTable">
                        <tr>
                            <th style="width: 20%">依頼先名</th>
                            <th class="seikyu-value" style="width: 14%">${row.iraisakiName}</th>
                            <th style="width: 13%">請求進捗</th>
                            <th class="seikyu-value" style="width: 13%">
                                ${row.jyutyuStep == 0? '仮受注':''}
                                ${row.jyutyuStep == 1? '見積済（メール済み）' :''}
                                ${row.jyutyuStep == 2? '受注済み':''}
                                ${row.jyutyuStep == 3? '請求書作成可':''}
                                ${row.jyutyuStep == 4? '請求書作成済み':''} 
                                ${row.jyutyuStep == 5? 'メール送信済み':''}
                                ${row.jyutyuStep == 6? '入金済み':''}
                            </th>
                            <th style="width: 40%">
                                <button
                                    class="ui-button" type="button" 
                                    style="display:${row.jyutyuStep >= 3?'block':'none' }"
                                    onClick="goto401('${pageContext.request.contextPath}/TG0401','${row.iraisakiName}',
                                    '${voDate}','${row.keiyakuKaisya}','${row.jyutyuStep}','${row.sagyoinnList[0].jyutyuuNum}')"
                                >請求書作成</button>
                            </th>
                        </tr>
                    </table>
                    <table border="1" class="manage-table" id="manageTable">
                        <tr>
                            <th style="width: 20%">自社社名</th>
                            <th style="width: 14%">外注先名</th>
                            <th style="width: 13%">作業員名</th>
                            <th style="width: 13%">作業登録状態</th>
                            <th style="width: 20%">作業時間</th>
                            <th style="width: 40%">操作</th>
                        </tr>
                        <c:forEach var="mrow" items="${row.sagyoinnList }">
                            <tr>
                                <td class="seikyu-value">${row.keiyakuKaisya==1?'株式会社ブライトスター':'株式会社トップクラウド' }</td>
                                <td class="seikyu-value">${mrow.gaityusakiName }</td>
                                <td class="seikyu-value">${mrow.sagyoinName }</td>
                                <td class="seikyu-value">
                                    ${mrow.syozokuTouroku==1? '未登録':'' }
                                    ${mrow.syozokuTouroku==0? '登録済':'' }
                                </td>
                                <td class="seikyu-value">
                                    <form action="#" id="fileForm${mrow.renban}" autocomplete="off"  enctype="multipart/form-data" method="post" >
                                        <input type="text"
                                            name="sagyouJikan"
                                            id="${mrow.renban}${row.jyutyuStep}${mrow.hakenngetsu}"
                                            value="${mrow.sagyouJikan}" />
                                        <input type="hidden"
                                            name="renban"
                                            value="${mrow.renban}" />
                                        <input type="hidden"
                                            name="jyutyuStep"
                                            value="${row.jyutyuStep}" />
                                        <input type="hidden"
                                            name="hakenngetsu"
                                            value="${mrow.hakenngetsu}" />
                                        <input type="hidden"
                                            name="iraisakiName"
                                            value="${row.iraisakiName}" />
                                        <input type="hidden"
                                            name="jyutyuuNum"
                                            value="${mrow.jyutyuuNum}" />
                                        <input type="hidden"
                                            name="sagyoinName"
                                            value="${mrow.sagyoinName}" /> 
                                        <input
                                            type="file"
                                            name="file"
                                            id="${mrow.renban}${row.jyutyuStep}${mrow.hakenngetsu}-file"
                                            multiple
                                            style="display: none"
                                            onChange="selected(${mrow.renban},${row.jyutyuStep},${mrow.hakenngetsu},'${pageContext.request.contextPath}/TG0400','fileForm${mrow.renban}')"/>
                                    </form>
                                </td>
                                <td class="seikyu-value">
                                    <button class="ui-button" type="button"
                                        onClick="upload('${mrow.renban}${row.jyutyuStep}${mrow.hakenngetsu}',${mrow.renban},${row.jyutyuStep},${mrow.hakenngetsu})">作業登録</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <br />
                </c:forEach>

                <input type="hidden" id="submitKind" name="submitKind"> <input
                    type="hidden" id="month" name="month"> <input type="hidden"
                    id="renban" name="renban"> <input type="hidden"
                    id="withJyutyuNum" name="withJyutyuNum">
        </div>
    </div>

    <!-- [if lt IE 9] >
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<![endif]  -->
    <!-- [if gte IE 9] ><!-->
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <!-- <![endif]  -->
    <script src="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.js"></script>
    <script src="${pageContext.request.contextPath}/js/datePickerFormat.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.form.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>
    <script>document.write("<script type='text/javascript' src='${pageContext.request.contextPath}/js/TG0200.js?t=" + Date.now() + "'><\/script>");</script>
    <script type="text/javascript">
    function upload(id,renban,jyutyuStep,hakenngetsu){
    	
        if($("#"+renban+jyutyuStep+hakenngetsu).val()<=0){
        	alert("作業時間を入力してください");
        }else{
        	$("#"+id+"-file").click();
        }
    }
    function goto401(url,iraisakiName,voDate,keiyakuKaisya,jyutyuStep,jyutyuuNum){
        var year=$(date).val().substring(0,4);
        var month=$(date).val().substring(5,7);
        window.location.href=url+"?iraisakiName="+iraisakiName+"&keiyakuKaisya="+keiyakuKaisya+"&month="+year+month+"&jyutyuStep="+jyutyuStep+"&jyutyuuNum="+jyutyuuNum;
    }
    function selected(renban,jyutyuStep,hakenngetsu,url,fileForm){
    	
        var formData = new FormData();
        var fid = renban+""+jyutyuStep+""+hakenngetsu+"-file";
         formData.append("file", document.getElementById(fid));
         formData.append("renban", renban);
         formData.append("jyutyuStep", jyutyuStep);
         formData.append("hakenngetsu", hakenngetsu);
         formData.append("sagyouJikan", $("#"+renban+jyutyuStep+hakenngetsu).val());
         var option = {
                  type:"post",
                  url: url,
                  async: true,
                  enctype:"multipart/form-data",
                  dataType:"json",
                  error:function(data){
                    window.location.reload();
                  },
                  success:function(msg){
                    window.location.reload();
                  }
              };
         //alert(fileForm);
         $("#"+fileForm).ajaxSubmit(option);
    }
</script>
</body>
</html>