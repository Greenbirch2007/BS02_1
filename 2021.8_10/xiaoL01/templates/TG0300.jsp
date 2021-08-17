<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>外注発行画面</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manage.css" type="text/css"/>
    <link href="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.min.css" rel="stylesheet">
    <style>
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
    <h1><span>■</span>受注画面</h1>
    <h2>■検索条件</h2>
    <div class="content-top">
        <form method="get" action="${pageContext.request.contextPath}/TG0200" accept-charset="UTF-8" class="manage-form" id="queryForm">
            <label for="date" style="margin-right: 50px; margin-left: 100px">受注月</label>
            <a href="javascript:void(0)" style="margin-right: 30px; color: #0066cc" id="minusDateArrow">&lt;&lt;</a>
            <input type="text" name="date" id="date" style="width: 90px" value="${not empty voDate ? voDate : ''}">
            <a href="javascript:void(0)" style="margin-left: 30px; color: #0066cc" id="addDateArrow">&gt;&gt;</a>
        </form>
    </div>
    <h2>■受注一覧</h2>
    <div class="content-bottom">
        <form method="post" action="${pageContext.request.contextPath}/TG0200" id="answerForm">
            <div class="row" style="margin-bottom: 5px">
                <div class="right">
                    <span style="margin-right: 50px">件数：　<span style="color: #0066cc">${ fn:length(vo) }件</span></span>
                    <a href="javascript:void(0)" style="margin-right: 50px" onclick="kariAddData()">未受注社員新規登録</a>
                    <a href="javascript:void(0)" style="margin-right: 20px" onclick="addData()">新規登録</a>
                </div>
            </div>
            <table border="1" class="manage-table" id="manageTable">
                <tr>
                    <th style="width: 10%">依頼先</th>
                    <th style="width: 10%">受注番号</th>
                    <th style="width: 10%">作業員名</th>
                    <th style="width: 9%">受注金額</th>
                    <th style="width: 15%">受注精算情報</th>
                    <th style="width: 10%">外注番号</th>
                    <th style="width: 9%">外注金額</th>
                    <th style="width: 15%">外注精算情報</th>
                    <th style="width: 7%">受注状態</th>
                    <th style="width: 4%">編集</th>
                </tr>
                <c:forEach var="row" items="${vo }">
                    <tr>
                        <td>${ row.iraisakiNameRyaku}</td>
                        <td>${ row.jyutyuuNum }</td>
                        <td>${ row.targetName }</td>
                        <td>${ row.jyutyuuMoney }</td>
                        <td>${ row.jyutyuuSeisanMoney }</td>
                        <td>${ row.gaityuNum }</td>
                        <td>${ row.gaityuMoney }</td>
                        <td>${ row.gaityuSeisanMoney }</td>
                        <td>${ row.jyutyuuStepStr }</td>
                        <td>
                            <div>
                                <a href="javascript:void(0)" onclick="updateData('${ row.hakkenMonth }', '${ row.renban }', ${ not empty row.jyutyuuNum });" >更新</a>
                            </div>
                            <div>
                                <a href="javascript:void(0)" onclick="deleteData('${ row.iraisakiNameRyaku}', '${ row.targetName }', '${ row.hakkenMonth }', '${ row.renban }');" >削除</a>
                            </div>
                            <c:if test="${row.isEntyou == 1}">
                                <div>
                                    <a href="javascript:void(0)" onclick="extendData('${ row.hakkenMonth }', '${ row.renban }');" >延長</a>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <input type="hidden" id="submitKind" name="submitKind">
            <input type="hidden" id="month" name="month">
            <input type="hidden" id="renban" name="renban">
            <input type="hidden" id="withJyutyuNum" name="withJyutyuNum">
        </form>
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
<script>document.write("<script type='text/javascript' src='${pageContext.request.contextPath}/js/TG0200.js?t=" + Date.now() + "'><\/script>");</script>
</body>
</html>