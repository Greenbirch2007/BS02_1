<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>受注画面</title>
<link rel="stylesheet" href="css/reset.css" type="text/css" />
<link rel="stylesheet" href="css/common.css" type="text/css" />
<link rel="stylesheet" href="css/manage.css" type="text/css" />
<link rel="stylesheet"
    href="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.min.css"
    type="text/css" />
<style>
input[type="button"] {
    padding: 0 20px;
}

.edit-form select {
    min-width: 100px;
}

#ui-datepicker-div {
    width: 160px;
    font-size: 62.5%;
}

.ui-datepicker select.ui-datepicker-month,.ui-datepicker select.ui-datepicker-year
    {
    width: 30%;
    min-width: 40px;
}

.ui-datepicker select.ui-datepicker-year {
    width: 45%;
    min-width: 55px;
}
#detailForPerson input {
    width: 100% !important;
    border: none
}
</style>
</head>
<body>
    <jsp:include page="header.jsp" flush="true" />
    <div class="content">
    	<h1>
            <span>■</span>請求データ確認
        </h1>
        <div class="content-inner">
            <form action="" method="post" class="edit-form">
                <br />
                <div class="content-part">
                    <div class="rowB">
                        <div class="col-xs-6 col-md-3">
                            <label>依頼先：</label>
                            <input type="text" name="jyutyuuIraisaki"
                                id="jyutyuuIraisaki"
                                disabled
                                value="${ vo.iraisakiName }">
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>契約会社：</label>
                            <input type="text" name="jyutyuuIraisaki"
                                id="keiyakukaisya" disabled
                                value="${ vo.keiyakuKaisya==1?'株式会社ブライトスター':'株式会社トップクラウド'  }">
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>発注月：</label>
                            <input type="text" name="jyutyuuIraisaki"
                                id="gatsu" disabled
                                value="${fn:substring(vo.month, 0,4) }年${fn:substring(vo.month, 4,6) }月">
                            <input type="hidden" 
                                id="billingMonth" disabled
                                value="${fn:substring(vo.month, 4,6)}">
                            <input type="hidden" 
                                id="years" disabled
                                value="${fn:substring(vo.month, 0,4)}">
                        </div>
                    </div>
                    <br />
                    <br />
                    <div class="rowB">
                        <div class="col-xs-6 col-md-3">
                            <label>小    計 ：</label>
                            ¥<input type="text"
                                id="totalBeforeTax" disabled value="">
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>消 費 税 <fmt:formatNumber type="number" value="${tax*100}" pattern="0" maxFractionDigits="0"/>%：</label>
                            ¥<input type="text" name="jyutyuuIraisaki"
                                id="taxShow" disabled 
                                value=""/>
                            <input type="hidden" name="jyutyuuIraisaki"
                                id="tax" disabled value="${ tax }"/>
                        </div>
                        <div class="col-xs-6 col-md-3">
                            <label>総    額 ：</label>
                            ¥<input type="text"
                                id="totalAfterTax" disabled value="">
                            <input type="hidden"
                                id="syuryoubi" disabled value="${vo.seityuBookDOList[0].syuryoubi }">
                            <input type="hidden"
                                id="jyutyuuNum" disabled value="${vo.jyutyuuNum }">
                            <input type="hidden"
                                id="saisyubi" disabled value="${vo.saisyubi }">
                            <input type="hidden"
                                id="yuubin" disabled value="${vo.yuubin }">
                            <input type="hidden"
                                id="value1" disabled value="${vo.seityuBookDOList[0].value1}">
                            <input type="hidden"
                                id="jyusyo" disabled value="${vo.jyusyo }">
                            <input type="hidden"
                                id="fileUrl" disabled value="${pageContext.request.contextPath}/xlsx/画面機能設計書.xlsx">
                        </div>
                    </div>
                </div>
                <br />
                <br />
                <div>
                    <label>備 　考：</label>
                    <textarea name="remarks" id="remarks" 
                       maxlength="255" style="width: 100%;height:80px">${empty tbvo ? null : tbvo[0].remarks}</textarea>
                </div>
                <h2 style="display: flex;justify-content: space-between ;">
                    ■請求一覧 
                    <div>
                        <label for="sagyoin" class="red" style="margin-left: 30px">
                          <input style="margin: 0 8px 0 5px" 
                            type="radio" id="sagyoin" name="tanni" value="sagyoin" checked>作業員単位
                        </label>
                        <label for="anken" class="red">
                            <input style="margin: 0 8px 0 20px" type="radio" id="anken" value="tanni" name="tanni">案件単位
                        </label>
                    </div>
                    <button class="ui-button" id="personKeiSan" type="button" onClick="acc()">精算</button>
                    <button class="ui-button" id="ankenKeiSan" type="button" onClick="ankenAcc()" style="display:none">精算</button>
                </h2>
                <%
                    int i = 0;
                %>
                <table border="1" class="manage-table" id="detailForPerson">
                    <tr>
                        <th style="width: 20%">No</th>
                        <th style="width: 34%">品 目</th>
                        <th style="width: 13%">数 量</th>
                        <th style="width: 13%">単 位</th>
                        <th style="width: 10%">単 価</th>
                        <th style="width: 10%">金 額</th>
                    </tr>
                    
                    <c:choose>
                      <c:when test="${jyutyuStep>=4&&tbvo[0].type=='person'}">
                        <c:forEach var="mrow" items="${tbvo}" varStatus="status">
                            <tr>
                                <td class="seikyu-value">
                                  ${mrow.renban+1}
                                </td>
                                <td class="seikyu-value productName">
                                  <input type="text" id="tb-productName"
                                      value="${mrow.hinmei}">
                                </td>
                                <td class="seikyu-value wari">
                                  <input type="text" id="tb-wari"
                                      value="${mrow.suuryou}">
                                </td>
                                <td class="seikyu-value tani">
                                   <input type="text" id="tb-tani"
                                      value="${mrow.tani}">
                                </td>
                                <td class="seikyu-value kingaku">
                                   <input type="text" id="tb-kingaku"
                                      value="${mrow.tanka}" style="width:80% !important">/H
                                </td>
                                <td class="seikyu-value detailForPerson-value " >
                                   ¥<input type="text" id="tb-detailForPerson-value"
                                      value="<fmt:formatNumber value="${mrow.count}" pattern="#,#00" /> "
                                      style="width:80% !important"
                                    >
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="mrow" items="${vo.seityuBookDOList }" varStatus="status">
                            <%
                                i ++;
                            %>
                            <tr>
                                <td class="seikyu-value">
                                  <%=i%>
                                </td>
                                <td class="seikyu-value productName">
                                  <input type="text" id="tb-productName"
                                      value="${fn:substring(vo.month, 0,4) }年${fn:substring(vo.month, 4,6) }月委託業務(${mrow.targetNM }　${mrow.sagyouJikan }H)">
                                </td>
                                <td class="seikyu-value wari">
                                  <input type="text" id="tb-wari"
                                      value="<fmt:formatNumber type="number" value="${mrow.wari }" pattern="0.00" maxFractionDigits="2"/>">
                                </td>
                                <td class="seikyu-value tani">
                                   <input type="text" id="tb-tani"
                                      value="月">
                                </td>
                                <td class="seikyu-value kingaku">
                                   <input type="text" id="tb-kingaku"
                                      value="${mrow.kingaku}">
                                </td>
                                <td class="seikyu-value detailForPerson-value " >
                                   ¥<input type="text" id="tb-detailForPerson-value"
                                      value="<fmt:formatNumber type="number" value="${mrow.kingaku*mrow.wari}" pattern="#,#00" maxFractionDigits="0"/>"
                                      style="width:80% !important"
                                    >
                                </td>
                            </tr>
                            <c:if test="${mrow.sagyouJikan - mrow.jyougenJikan>0}">
                                <tr>
                                    <td class="seikyu-value">
                                    <%
                                        i ++;
                                    %>
                                    <%=i%>
                                    </td>
                                    <td class="seikyu-value productName">
                                        <input type="text" id="tb-productName"
                                         value="${fn:substring(vo.month, 0,4) }年${fn:substring(vo.month, 4,6) }月超過金額(${mrow.targetNM }　${mrow.jyougenJikan }H)">
                                    </td>
                                    <td class="seikyu-value wari">
                                        <input type="text" id="tb-wari"
                                         value="<fmt:formatNumber type="number" value="${mrow.sagyouJikan - mrow.jyougenJikan}" pattern="0.00" maxFractionDigits="2"/>">
                                    </td>
                                    <td class="seikyu-value tani">
                                        <input type="text" id="tb-tani" value="時間">
                                    </td>
                                    <td class="seikyu-value kingaku">
                                        <input type="text" id="tb-kingaku" style="width:80% !important" value="${mrow.jyougenKingaku}">/H
                                    </td>
                                    <td class="seikyu-value detailForPerson-value ">
                                        ¥<input type="text" id="tb-detailForPerson-value"
                                         value="<fmt:formatNumber type="number" value="${(mrow.sagyouJikan - mrow.jyougenJikan)*mrow.jyougenKingaku}" 
                                         pattern="#,#00"  maxFractionDigits="0"/>"
                                         style="width:80% !important">
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${mrow.sagyouJikan - mrow.kagenJikan<0}">
                              <tr>
                                  <td class="seikyu-value">
                                  <%
                                      i ++;
                                  %>
                                  <%=i%>
                                  </td>
                                  <td class="seikyu-value productName">
                                     <input type="text" id="tb-productName"
                                       value="${fn:substring(vo.month, 0,4) }年${fn:substring(vo.month, 4,6) }月控除金額(${mrow.targetNM }　${mrow.kagenJikan }H)">
                                  </td>
                                  <td class="seikyu-value wari">
                                      <input type="text" id="tb-wari"
                                       value="<fmt:formatNumber type="number" value="${ mrow.kagenJikan - mrow.sagyouJikan }" pattern="0.00" maxFractionDigits="2"/>">
                                  </td>
                                  <td class="seikyu-value tani"><input type="text" id="tb-tani" value="時間"></td>
                                  <td class="seikyu-value kingaku">
                                      <input type="number" id="tb-kingaku" value="${-mrow.kagenKingaku}">/H
                                  </td>
                                  <td class="seikyu-value detailForPerson-value">
                                      ¥<input type="text" id="tb-detailForPerson-value" style="width:80% !important"
                                       value="<fmt:formatNumber type="number" value="${-(mrow.sagyouJikan - mrow.kagenJikan)*mrow.kagenKingaku}" pattern="#,#00"  maxFractionDigits="0"/> ">
                                  </td>
                              </tr>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                   </c:choose>
                </table>
                <%
                    int ank = 0;
                %>
                <table border="1" class="manage-table" id="manageTable" style="display:none">
                    <tr>
                        <th style="width: 22%">No</th>
                        <th style="width: 36%">品 目</th>
                        <th style="width: 15%">数 量</th>
                        <th style="width: 15%">単 位</th>
                        <th style="width: 12%">金 額</th>
                    </tr>
                    <c:choose>
                      <c:when test="${jyutyuStep>=4&&tbvo[0].type=='anken'}">
                       <c:forEach var="mrow" items="${tbvo }" varStatus="status">
                        <tr>
                            <td class="seikyu-value">
                              ${mrow.renban+1}
                            </td>
                            <td class="seikyu-value productName">
                              <input type="text" id="tb-productName"
                                  value="${mrow.hinmei}">
                            </td>
                            <td class="seikyu-value wari">
                              <input type="text" id="tb-wari" disabled
                                  value="${mrow.suuryou}">
                            </td>
                            <td class="seikyu-value tani">
                               <input type="text" id="tb-tani" disabled
                                  value="${mrow.tani}">
                            </td>
                            <td class="seikyu-value detailForPerson-value " >
                               ¥<input type="text" id="tb-manageTable-value" style="width:80% !important"
                                  value="<fmt:formatNumber type="number" 
                                         value="${mrow.count}" 
                                         pattern="#,#00" maxFractionDigits="0"/>">
                            </td>
                         </tr>
                       </c:forEach>
                    </c:when>
                    <c:otherwise>
                       <c:forEach var="mrow" items="${ankenvo.seityuBookDOList }" varStatus="status">
                            <%
                                ank ++;
                            %>
                            <tr>
                                <td class="seikyu-value">
                                <%=ank%>
                                </td>
                                <td class="seikyu-value" 
                                    style="text-align: left;padding-left: 5px;">
                                    <input type="text" id="tb-productName"
                                      value="${fn:substring(vo.month, 0,4) }年${fn:substring(vo.month, 4,6) }月${mrow.ankenmei }案件">
                                </td>
                                <td class="seikyu-value"  style="text-align: left;">
                                    <input type="text" id="tb-wari" disabled value="1">
                                </td>
                                <td class="seikyu-value" style="text-align: left;">
                                    <input type="text" id="tb-tani" disabled value="月">
                                </td>
                                <td class="seikyu-value" style="text-align: left;padding-left: 5px;">
                                   ¥<input type="text" id="tb-manageTable-value"  style="width:80% !important"
                                         value="<fmt:formatNumber type="number" 
                                         value="${mrow.kingakuKeiSan}" 
                                         pattern="#,#00" maxFractionDigits="0"/>">
                                </td>
                            </tr>
                            <c:if test="${mrow.sagyouJikan - mrow.jyougenJikan>0}">
                                <tr>
                                    <td class="seikyu-value">
                                    <%
                                        ank ++;
                                    %>
                                    <%=ank%>
                                    </td>
                                    <td class="seikyu-value"  style="text-align: left;padding-left: 5px;">
                                        <input type="text" id="tb-productName"
                                          value="${fn:substring(vo.month, 0,4) }年${fn:substring(vo.month, 4,6) }月${mrow.ankenmei }案件超過金額">
                                    </td>
                                    <td class="seikyu-value"  style="text-align: left;">
                                        <input type="text" id="tb-wari" disabled value="<fmt:formatNumber type="number" value="${mrow.tyoukaJikan}" pattern="0.00" maxFractionDigits="2"/>">
                                    </td>
                                    <td class="seikyu-value"  style="text-align: left;">
                                        <input type="text" id="tb-tani" disabled value="時間">
                                    </td>
                                    <td class="seikyu-value" style="text-align: left;padding-left: 5px;">
                                       ¥<input type="text" id="tb-manageTable-value" style="width:80% !important"
                                         value="<fmt:formatNumber type="number" 
                                         value="${mrow.tyoukaKeiSan}" 
                                         pattern="#,#00" maxFractionDigits="0"/>">
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${mrow.sagyouJikan - mrow.kagenJikan<0}">
                                <tr>
                                    <td class="seikyu-value">
                                    <%
                                      ank ++;
                                    %>
                                    <%=ank%>
                                    </td>
                                    <td class="seikyu-value"  style="text-align: left;padding-left: 5px;">
                                        <input type="text" id="tb-productName"
                                          value="${fn:substring(vo.month, 0,4) }年${fn:substring(vo.month, 4,6) }月${mrow.ankenmei }案件控除金額">
                                    </td>
                                    <td class="seikyu-value"  style="text-align: left;padding-left: 5px;">
                                        <input type="text" id="tb-wari" disabled value="<fmt:formatNumber type="number" value="${mrow.kouJyoJikan}" pattern="0" maxFractionDigits="2"/>">
                                    </td>
                                    <td class="seikyu-value" style="text-align: left;padding-left: 5px;">
                                        <input type="text" id="tb-tani" disabled value="時間"></td>
                                    <td class="seikyu-value" style="text-align: left;padding-left: 5px;">
                                        ¥<input type="text" id="tb-manageTable-value" style="width:80% !important"
                                         value="<fmt:formatNumber type="number" 
                                         value="${mrow.kouJyoKeiSan}" 
                                         pattern="#,#00" maxFractionDigits="0"/>">
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:otherwise>
                   </c:choose>
                </table>
                <h2>■請求書作成</h2>
                <button class="ui-button" id="sakuseiPerson" type="button"
                    onClick="make('${pageContext.request.contextPath}/fileExcel')">作成</button>
                <button class="ui-button" id="sakuseiAnken" type="button"
                    onClick="makeAnken('${pageContext.request.contextPath}/fileExcel')" style="display:none">作成</button>
            </form>
        </div>
    </div>
    <form action="#" id="fileForm" method="post" >
    </form>
    <div id="torihikisakiDialog" style="display: none">
        <jsp:include page="TG0205.jsp" flush="true" />
    </div>

    <div id="syainDialog" style="display: none">
        <jsp:include page="TG0206.jsp" flush="true" />
    </div>

    <div id="kojinjigyousyuDialog" style="display: none">
        <jsp:include page="TG0207.jsp" flush="true" />
    </div>

    <!-- [if lt IE 9] >
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<![endif]  -->
    <!-- [if gte IE 9] ><!-->
    <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
    <!-- <![endif]  -->
    <script src="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.js"></script>
    <script src="js/datePickerFormat.js" charset="utf-8"></script>
    <script src="js/inputCheck.js" charset='utf-8'></script>
    <script src="${pageContext.request.contextPath}/js/jquery.form.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/ajaxfileupload.js"></script>
    <script>
        document.write("<script type='text/javascript' charset='utf-8' src='${pageContext.request.contextPath}/js/TG0201.js?t="
                        + Date.now() + "'><\/script>");
    </script>
    <script type="text/javascript">
        $(function(){
          $(":radio").click(function(e){
            if($(this).val()=="tanni"){
                $("#manageTable").show();
                $("#detailForPerson").hide();
                $("#personKeiSan").hide();
                $("#ankenKeiSan").show();
                $("#sakuseiPerson").hide();
                $("#sakuseiAnken").show();
            }else {
               $("#detailForPerson").show();
               $("#manageTable").hide();
               $("#personKeiSan").show();
               $("#ankenKeiSan").hide();
               $("#sakuseiPerson").show();
               $("#sakuseiAnken").hide();
            }
          });
         });
        function ankenAcc(){
             var count = 0;
             $.each($("#manageTable #tb-manageTable-value"), function(i,val){ 
                  count+=parseFloat($(val).val().replace(/,/g, ""));
             });
             $("#totalBeforeTax").val(new Intl.NumberFormat().format(parseInt(count)));
             $("#taxShow").val(new Intl.NumberFormat().format(parseInt(count * parseFloat($("#tax").val()))));
             var totalAfterTax = (count * parseFloat($("#tax").val()))+count;
             $("#totalAfterTax").val(new Intl.NumberFormat().format(parseInt(totalAfterTax)));
        }
        function acc(){
            var table = $("#detailForPerson")[0].rows;
            for(var i = 1;i<table.length;i++){
                let productName = $($($("#detailForPerson")[0].rows[i])[0].cells[1])[0].children[0].value;
                let wari = $($($("#detailForPerson")[0].rows[i])[0].cells[2])[0].children[0].value;
                let tani = $($($("#detailForPerson")[0].rows[i])[0].cells[3])[0].children[0].value;
                let kingaku = $($($("#detailForPerson")[0].rows[i])[0].cells[4])[0].children[0].value.replace(/,/g, "");;
                $($($("#detailForPerson")[0].rows[i])[0].cells[5])[0].children[0].value = new Intl.NumberFormat().format(parseInt(kingaku*parseFloat(wari)));
            }
            var count = 0;
            $.each($("#detailForPerson .detailForPerson-value input"), function(i,val){ 
            	  console.log($(val).val());
          	  console.log($(val).val().replace(/,/g, ""));
                 count+=parseFloat($(val).val().replace(/,/g, ""));
            });
            $("#totalBeforeTax").val(new Intl.NumberFormat().format(count));
            var taxShow = count * parseFloat($("#tax").val());
            $("#taxShow").val(new Intl.NumberFormat().format(taxShow));
            var totalAfterTax = (count * parseFloat($("#tax").val()))+count;
            totalAfterTax = new Intl.NumberFormat().format(parseInt(totalAfterTax));
            $("#totalAfterTax").val(totalAfterTax);
        }
        //输出base64编码
        function base64 (s) { return window.btoa(unescape(encodeURIComponent(s))) }
        function getDate(value1,billingMonth){
            var lastDay = 1;
            if(value1==30){
                payMonth = billingMonth;
            }
            if(value1==35){
                payMonth = billingMonth + 1;
                lastDay = 5;
            }
            if(value1==40){
                payMonth = billingMonth + 1;
                lastDay = 10;
            }
            if(value1==45){
                payMonth = billingMonth + 1;
                lastDay = 15;
            }
            if(value1==50){
                payMonth = billingMonth + 1;
                lastDay = 20;
            }
            if(value1==55){
                payMonth = billingMonth + 1;
                lastDay = 25;
            }
            if(value1==60){
                payMonth = billingMonth + 1;
            }
            var year = parseInt($("#years").val());
            if(payMonth>12){
            	year+=1;
            	payMonth = payMonth-12;
            }
            var leapYear = false;
            if(year%4==0&&year%100!=0||year%400==0){
              leapYear = true;
            }else{
              leapYear = false;
            }
            var payDay = 30;
            if(payMonth==1||payMonth==5 ||payMonth==7||payMonth== 8 ||payMonth==10 ||payMonth==12){
                payDay = 31;
            }else if(payMonth==2){
                if(leapYear){
                    payDay = 29;
                }else{
                	payDay = 28;
                }
             }
             if(value1==60||value1==30){
                lastDay = payDay;
             }
             return year+"年"+payMonth+"月"+lastDay+"日";
        }
        function makeAnken(url){
            var table = $("#detailForPerson")[0].rows;
            var tableObjArray = [];
            
            for(var i = 1;i<table.length;i++){
              let productName = $($($("#manageTable")[0].rows[i])[0].cells[1])[0].children[0].value+"";
              let wari = $($($("#manageTable")[0].rows[i])[0].cells[2])[0].children[0].value+"";
              let tani = $($($("#manageTable")[0].rows[i])[0].cells[3])[0].children[0].value+"";
              let kingaku = $($($("#manageTable")[0].rows[i])[0].cells[4])[0].children[0].value+"";
              let detailForPersonValue = kingaku;
              let tableObj = {
                  productName: productName,
                  wari: wari,
                  tani: tani,
                  kingaku: kingaku.replace(/,/g, ""),
                  detailForPersonValue: detailForPersonValue.replace(/,/g, ""),
              }
              tableObjArray.push(tableObj);
            }
            var billingMonth = parseInt($("#billingMonth").val());

            var payMonth = parseInt($("#billingMonth").val());
            var myDate = new Date();
            var year = myDate.getFullYear();
            var leapYear = false;
            if(year%4==0&&year%100!=0||year%400==0){
                leapYear = true;
            }else{
                leapYear = false;
            }
            var value1 = parseInt($("#value1").val());
            var payDate = getDate(value1,payMonth);
            var billingDate = 30;
            if(billingMonth==1||billingMonth==5 ||billingMonth==7||billingMonth== 8 ||billingMonth==10 ||billingMonth==12){
               billingDate = 31;
            }else if(billingMonth==2){
                if(leapYear){
                    billingDate = 29;
                }else{
                    billingDate = 28;
                }
            }
            var formObj = {
               jyutyuuNum: $("#jyutyuuNum").val(),
               IraisakiName: $("#jyutyuuIraisaki").val(), 
               yuubin: $("#yuubin").val(), 
               gatsu: $("#gatsu").val(), 
               saisyubi: $("#saisyubi").val(),
               jyusyo: $("#jyusyo").val(),
               totalAfterTax: $("#totalAfterTax").val(),
               totalBeforeTax: $("#totalBeforeTax").val(),
               tax: $("#tax").val(), 
               tableList: tableObjArray,
               remarks: $("#remarks").val(),
               billingDate: billingDate,
               type: "anken",
               keiyakukaisya: $("#keiyakukaisya").val(),
               payDate : payDate
            };
            $.ajax({
                type: 'post',
                url: url,
                dataType:"json",
                data: JSON.stringify(formObj),
                cache: false,
                processData: false,
                contentType: false,
                success: function (data) { 
                    alert(data);
                },
                error: function (data) {
                    window.location.href = url + "?fname="+data.responseText;
                },
            })
          }
        function make(url){
          var table = $("#detailForPerson")[0].rows;
          var tableObjArray = [];

          var billingMonth = parseInt($("#billingMonth").val());
          var myDate = new Date();
          var year = myDate.getFullYear();
          var leapYear = false;
          if(year%4==0&&year%100!=0||year%400==0){
            leapYear = true;
          }else{
            leapYear = false;
          }
          var billingDate = 30;
          if(billingMonth==1||billingMonth==5 ||billingMonth==7||billingMonth== 8 ||billingMonth==10 ||billingMonth==12){
             billingDate = 31;
          }else if(billingMonth==2){
              if(leapYear){
                  billingDate = 29;
              }else{
                  billingDate = 28;
              }
          }
          for(var i = 1;i<table.length;i++){
            let productName = $($($("#detailForPerson")[0].rows[i])[0].cells[1])[0].children[0].value+"";
            let wari = $($($("#detailForPerson")[0].rows[i])[0].cells[2])[0].children[0].value+"";
            let tani = $($($("#detailForPerson")[0].rows[i])[0].cells[3])[0].children[0].value+"";
            let kingaku = $($($("#detailForPerson")[0].rows[i])[0].cells[4])[0].children[0].value+"";
            let detailForPersonValue = $($($("#detailForPerson")[0].rows[i])[0].cells[5])[0].children[0].value+"";
            let tableObj = {
                productName: productName,
                wari: wari,
                tani: tani,
                kingaku: kingaku,
                detailForPersonValue: parseInt(detailForPersonValue.replace(/,/g, "")),
            }
            tableObjArray.push(tableObj);
          }

          var payMonth = parseInt($("#billingMonth").val());
          var value1 = parseInt($("#value1").val());
          var payDate = getDate(value1,payMonth);
          var formObj = {
             jyutyuuNum: $("#jyutyuuNum").val(),
             IraisakiName: $("#jyutyuuIraisaki").val(), 
             yuubin: $("#yuubin").val(), 
             gatsu: $("#gatsu").val(), 
             saisyubi: $("#saisyubi").val(),
             jyusyo: $("#jyusyo").val(),
             totalAfterTax: $("#totalAfterTax").val(),
             totalBeforeTax: $("#totalBeforeTax").val(),
             tax: $("#tax").val(), 
             tableList: tableObjArray,
             remarks: $("#remarks").val(),
             type: "person",
             keiyakukaisya: $("#keiyakukaisya").val(),
             billingDate: billingDate,
             payDate : payDate
          };
          $.ajax({
              type: 'post',
              url: url,
              dataType:"json",
              data: JSON.stringify(formObj),
              cache: false,
              processData: false,
              contentType: false,
              success: function (data) {
                  alert(data);
              },
              error: function (data) { 
                  window.location.href = url + "?fname="+data.responseText;
              },
          })
        }
    </script>
    <script src="js/selectTorihikisakiDialog.js" charset='utf-8'></script>
    <script src="js/selectSyainDialog.js" charset='utf-8'></script>
    <script src="js/selectKojinjigyousyuDialog.js" charset='utf-8'></script>
</body>
</html>