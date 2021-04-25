<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>受注${vo.actionStr}画面</title>
    <link rel="stylesheet" href="css/reset.css" type="text/css"/>
    <link rel="stylesheet" href="css/common.css" type="text/css"/>
    <link rel="stylesheet" href="css/manage.css" type="text/css"/>
    <link rel="stylesheet" href="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.min.css" type="text/css"/>
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
        .ui-datepicker select.ui-datepicker-month, .ui-datepicker select.ui-datepicker-year {
            width: 30%;
            min-width: 40px;
        }
        .ui-datepicker select.ui-datepicker-year {
            width: 45%;
            min-width: 55px;
        }


    </style>
</head>
<body>
<jsp:include page="header.jsp" flush="true"/>
<div class="content">
    <h1><span>■</span>受注${vo.actionStr}</h1>
    <div class="content-inner">
        <form action="${pageContext.request.contextPath}/TG0201?action=${vo.action}" autocomplete="off" method="post" class="edit-form">
            <h2>
                <div class="row">
                    <label for="date" class="red">受注月</label>
                    <c:if test="${not empty vo.jyutyuuNum}">
                    <input type="text" name="date" id="date" style="width: 90px" value="${vo.date}" disabled="true">
                    </c:if>
                    <c:if test="${empty vo.jyutyuuNum}">
                    <a href="javascript:void(0)" style="margin-right: 30px; color: #0066cc" id="minusDateArrow">&lt;&lt;</a>
            		<input type="text" name="date" id="date" style="width: 90px" value="${not empty voDate ? voDate : ''}">
            		<a href="javascript:void(0)" style="margin-left: 30px; color: #0066cc" id="addDateArrow">&gt;&gt;</a>
            		</c:if>
                    <label for="kariJyutyuu" class="red" style="margin-left: 30px">
                        <input style="margin: 0 8px 0 5px" type="radio" id="kariJyutyuu" value="0" name="jyutyuuStep" ${vo.jyutyuuStep < 2 || empty vo.jyutyuuStep ? 'checked' : ''} ${vo.jyutyuuStep > 2 ? 'disabled' : ''}>
                        仮受注
                    </label>
                    <label for="honJyutyuu" class="red">
                        <input style="margin: 0 8px 0 20px" type="radio" id="honJyutyuu" value="2" name="jyutyuuStep" ${vo.jyutyuuStep >= 2 ? 'checked' : ''}>
                        本受注
                    </label>
                    <c:if test="${not empty vo.jyutyuuNum}">
                    <label style="margin-left: 30px;font-size: 85%;">受注番号：${vo.jyutyuuNum}</label>
                    </c:if>
                </div>
            </h2>
            <div class="content-part">
                <div class="row">
                    <label>依頼先</label>
                    <input type="text" name="jyutyuuIraisaki" id="jyutyuuIraisaki" disabled value="${ not empty vo.jyutyuuIraisaki ? vo.jyutyuuIraisaki : '' }">
                    <input type="hidden" name="jyutyuuIraisakiId" id="jyutyuuIraisakiId" value="${vo.jyutyuuIraisakiId}">
                    <c:if test="${empty vo.jyutyuuIraisaki}">
                        <input type="button" value="依頼先検索" id="iraisakiSelectButton">
                    </c:if>
                </div>
                <div class="row">
                    <label>社員名</label>
                    <input type="text" name="jyutyuuSyainName" disabled id="jyutyuuSyainName" value="${ not empty vo.jyutyuuSyainName ? vo.jyutyuuSyainName : '' }">
                    <input type="hidden" name="jyutyuuSyainId" id="jyutyuuSyainId" value="${vo.jyutyuuSyainId}">
                    <c:if test="${empty vo.jyutyuuSyainName}">
                        <input type="button" value="社員検索" id="syainSelectButton">
                    </c:if>
                </div>
                <div class="row">
                    <label>契約種類</label>
                    <select name="jyutyuuHakkenSyurui">
                        <c:forEach var="syurui" items="${so.hakenSyuRuis }">
                            <option value="${syurui.key }" ${vo.jyutyuuHakkenSyurui == syurui.key? 'selected' : '' }>${syurui.value }</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="row">
                    <label>案件名</label>
                    <input type="text" style="width: 500px" name="jyutyuuAnkeimei" required maxlength="100"  value="${ not empty vo.jyutyuuAnkeimei ? vo.jyutyuuAnkeimei : '' }">
                </div>
                <div class="row">
                    <div class="row-left">
                        <label>作業場所</label>
                        <input type="text" name="jyutyuuSagyouBasyo" required maxlength="50" value="${ not empty vo.jyutyuuSagyouBasyo ? vo.jyutyuuSagyouBasyo : '' }">
                    </div>
                    <div class="row-right">
                        <label>日割り率</label>
                        <input type="number" name="jyutyuuWari" style="width: 100px" min="0" max="1" step="0.01" required value="${ not empty vo.jyutyuuWari ? vo.jyutyuuWari : '1' }">
                        <span>（0～１の小数点以下2桁まで記入）</span>
                    </div>
                </div>
                <div class="row">
                    <div class="row-left">
                        <label>開始日</label>
                        <input type="number" style="width: 100px" name="jyutyuuKaishibi"　min="1" max="31"  value="1" id="jyutyuuKaishibi" value="${ not empty vo.jyutyuuKaishibi ? vo.jyutyuuKaishibi : '' }">
                        <span>日</span>
                    </div>
                    <div class="row-right">
                        <label>終了日</label>
                        <input type="number" style="width: 100px" name="jyutyuuSyuuryoubi"　min="1" max="31" id="jyutyuuSyuuryoubi" value="${ not empty vo.jyutyuuSyuuryoubi ? vo.jyutyuuSyuuryoubi : '' }">
                        <span>日</span>
                    </div>
                </div>
                <div class="row">
                    <div class="row-left">
                        <label>受注金額</label>
                        <input type="number" style="width: 100px" name="jyutyuuKingaku" min="0" required step="1" value="${ not empty vo.jyutyuuKingaku ? vo.jyutyuuKingaku : '' }">
                        <span>円</span>
                    </div>
                    <div class="row-right">
                        <label>精算</label>
                        <select name="jyutyuuSeisan" id="jyutyuuSeisan">
                            <option value="1" ${vo.jyutyuuSeisan == 1? 'selected' : '' }>精算有</option>
                            <option value="0" ${vo.jyutyuuSeisan == 0? 'selected' : '' }>精算無</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="row-left">
                        <label>下限時間</label>
                        <input type="number" style="width: 100px" name="jyutyuuKagenJikan" min="0" max="999.9" step="0.1" id="jyutyuuKagenJikan" value="${ not empty vo.jyutyuuKagenJikan ? vo.jyutyuuKagenJikan : '' }">
                        <span>H</span>
                    </div>
                    <div class="row-right">
                        <label>上限時間</label>
                        <input type="number" style="width: 100px" name="jyutyuuJyougenJikan" min="0" max="999.9" step="0.1" id="jyutyuuJyougenJikan" value="${ not empty vo.jyutyuuJyougenJikan ? vo.jyutyuuJyougenJikan : '' }">
                        <span>H</span>
                    </div>
                </div>
                <div class="row">
                    <div class="row-left">
                        <label>控除金額</label>
                        <input type="number" style="width: 100px" name="jyutyuuKagenKingaku" min="0" id="jyutyuuKagenKingaku" value="${ not empty vo.jyutyuuKagenKingaku ? vo.jyutyuuKagenKingaku : '' }">
                        <span>円</span>
                    </div>
                    <div class="row-right">
                        <label>超過金額</label>
                        <input type="number" style="width: 100px" name="jyutyuuJyougenKingaku" min="0" id="jyutyuuJyougenKingaku" value="${ not empty vo.jyutyuuJyougenKingaku ? vo.jyutyuuJyougenKingaku : '' }">
                        <span>円</span>
                    </div>
                </div>
                <div class="row">
                    <label>支払いサイト</label>
                    <select name="jyutyuuShiharaiSite" style="width: 100px">
                        <%--<option value="1">30</option>--%>
                        <c:forEach var="site" items="${so.jyutyuShiharaiSites }">
                            <option value="${site.key }" ${vo.jyutyuuShiharaiSite == site.key? 'selected' : '' }>${site.value }</option>
                        </c:forEach>
                    </select>
                    <span>日</span>
                </div>
                <div class="row textarea-row">
                    <label>備考</label>
                    <textarea name="jyutyuuBikou" maxlength="255">${not empty vo.jyutyuuBikou ? vo.jyutyuuBikou : ''}</textarea>
                </div>
            </div>

            <h2>
                <div class="row">
                    <input value="1" name="gaityuu" id="gaityuu" type="checkbox" ${vo.gaityuu == 1 ? 'checked' : ''} style="display: ${vo.action eq "edit1" || vo.action eq "edit2" || vo.action eq "extend" ? 'none' : 'inline-block' }">
                    外注
                </div>
            </h2>

            <div class="content-part" id="gaityuuBox" style="display: ${vo.gaityuu == 0 || vo.action eq "edit1" || vo.action eq "add" ? 'none' : 'block'}">
                <div class="row">
                    <label>外注先</label>
                    <input type="text" name="gaityuusaki" id="gaityuusaki" disabled value="${not empty vo.gaityuusaki ? vo.gaityuusaki : ''}">
                    <input type="hidden" name="gaityuusakiId" id="gaityuusakiId" value="${vo.gaityuusakiId}">
                    <input type="hidden" name="gaityuuSyainId" id="gaityuuSyainId" value="${vo.gaityuuSyainId}">
                    <c:if test="${empty vo.gaityuusaki}">
                        <input type="button" value="外注会社検索" id="gaityusakiSelectButton">
                        <input type="button" value="個人事業主検索" id="kojinjigyousyuSelectButton">
                    </c:if>

                </div>
                <div class="row">
                    <div class="row-left">
                        <label>契約種類</label>
                        <select name="gaityuuSyurui" >
                            <%--<option value="1">労働者請負</option>--%>
                            <c:forEach var="syurui" items="${so.hakenSyuRuis }">
                                <option value="${syurui.key }" ${vo.jyutyuuHakkenSyurui == syurui.key? 'selected' : '' }>${syurui.value }</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="row-right">
                        <label>契約会社</label>
                        <select name="keiyakuGaisha">
                            <%--<option value="1">（株）ブライトスター</option>--%>
                            <c:forEach var="company" items="${so.companys }">
                                <option value="${company.key }" ${vo.keiyakuGaisha == company.key ? 'selected' : '' }>${company.value }</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="row-left">
                        <label>開始日</label>
                        <input type="number" style="width: 100px" name="gaityuuKaishibi"　min="1" max="31"  value="1" id="gaityuuKaishibi" value="${ not empty vo.gaityuuKaishibi ? vo.gaityuuKaishibi : '' }">
                        <span>日</span>
                    </div>
                    <div class="row-right">
                        <label>終了日</label>
                        <input type="number" style="width: 100px" name="gaityuuSyuuryoubi"　min="1" max="31" value="31" id="gaityuuSyuuryoubi" value="${ not empty vo.gaityuuSyuuryoubi ? vo.gaityuuSyuuryoubi : '' }">
                        <span>日</span>
                    </div>
                </div>
                <div class="row">
                    <div class="row-left">
                        <label>外注金額</label>
                        <input type="number" style="width: 100px" name="gaityuuKingaku" min="0" id="gaityuuKingaku" value="${ not empty vo.gaityuuKingaku ? vo.gaityuuKingaku : '' }">
                        <span>円</span>
                    </div>
                    <div class="row-right">
                        <label>精算</label>
                        <select name="gaityuuSeisan" id="gaityuuSeisan" disabled>
                            <option value="1" ${vo.gaityuuSeisan == 1? 'selected' : '' }>精算有</option>
                            <option value="0" ${vo.gaityuuSeisan == 0? 'selected' : '' }>精算無</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="row-left">
                        <label>下限時間</label>
                        <input type="number" style="width: 100px" name="gaityuuKagenJikan" min="0" max="999.9"　step="0.1" id="gaityuuKagenJikan"  value="${ not empty vo.gaityuuKagenJikan ? vo.gaityuuKagenJikan : '' }">
                        <span>H</span>
                    </div>
                    <div class="row-right">
                        <label>上限時間</label>
                        <input type="number" style="width: 100px" name="gaityuuJyougenJikan" min="0" max="999.9"　step="0.1" id="gaityuuJyougenJikan" value="${ not empty vo.gaityuuJyougenJikan ? vo.gaityuuJyougenJikan : '' }">
                        <span>H</span>
                    </div>
                </div>
                <div class="row">
                    <div class="row-left" style="width: 50%">
                        <label>控除金額</label>
                        <input type="number" style="width: 100px" name="gaityuuKagenKingaku" min="0" id="gaityuuKagenKingaku" value="${ not empty vo.gaityuuKagenKingaku ? vo.gaityuuKagenKingaku : '' }">
                        <span>円</span>
                    </div>
                    <div class="row-right" style="width: 50%">
                        <label>超過金額</label>
                        <input type="number" style="width: 100px" name="gaityuuJyougenKingaku" min="0" id="gaityuuJyougenKingaku" value="${ not empty vo.gaityuuJyougenKingaku ? vo.gaityuuJyougenKingaku : '' }">
                        <span>円</span>
                        <c:if test="${vo.gaityuuSeisan == 1}">
                        <input type="button" value="精算金額自動計算" id="calculateKingaku">
                        </c:if>
                        <c:if test="${vo.gaityuuSeisan == 0}">
                        <input type="button" value="精算金額自動計算" id="calculateKingaku" disabled>
                        </c:if>
                    </div>
                </div>
                <div class="row">
                    <label>支払いサイト</label>
                    <select name="gaityuuShiharaiSite" style="width: 100px">
                        <%--<option value="1">30</option>--%>
                        <c:forEach var="site" items="${so.gaityuShiharaiSites }">
                            <option value="${site.key }" ${vo.gaityuuShiharaiSite == site.key? 'selected' : '' }>${site.value }</option>
                        </c:forEach>
                    </select>
                    <span>日</span>
                </div>
                <div class="row">
                    <label>作業員名</label>
                    <input type="text" name="gaityuuSagyouinName" id="gaityuuSagyouinName" value="${ not empty vo.gaityuuSagyouinName ? vo.gaityuuSagyouinName : '' }">
                </div>
                <div class="row textarea-row">
                    <label for="gaityuuBikou">備考</label>
                    <textarea id="gaityuuBikou" name="gaityuuBikou" maxlength="255">${ not empty vo.gaityuuBikou ? vo.gaityuuBikou : '' }</textarea>
                </div>
            </div>

            <input type="hidden" name="renban" value="${vo.renban}">
			<input type="hidden" name="date" value="${vo.date}">
            <h2 id="bottom-line" style="display: none">
                <!-- 虚线 -->
            </h2>

            <div style="text-align: center">
                <input type="submit" value="登  録" id="checkflag">
            </div>

        </form>

    </div>
</div>

<div id="torihikisakiDialog" style="display: none">
    <jsp:include page="TG0205.jsp" flush="true"/>
</div>

<div id="syainDialog" style="display: none">
    <jsp:include page="TG0206.jsp" flush="true"/>
</div>

<div id="kojinjigyousyuDialog" style="display: none">
    <jsp:include page="TG0207.jsp" flush="true"/>
</div>

<!-- [if lt IE 9] >
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<![endif]  -->
<!-- [if gte IE 9] ><!-->
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<!-- <![endif]  -->
<script src="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.js"></script>
<script src="js/datePickerFormat.js" charset="utf-8"></script>
<script src="js/inputCheck.js" charset='utf-8' ></script>
<script>document.write("<script type='text/javascript' charset='utf-8' src='${pageContext.request.contextPath}/js/TG0201.js?t=" + Date.now() + "'><\/script>");</script>
<script src="js/selectTorihikisakiDialog.js" charset='utf-8' ></script>
<script src="js/selectSyainDialog.js" charset='utf-8' ></script>
<script src="js/selectKojinjigyousyuDialog.js" charset='utf-8' ></script>
</body>
</html>