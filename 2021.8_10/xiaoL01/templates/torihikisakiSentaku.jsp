<html>
<head>
    <title>個人事業主選択</title>

</head>
<body>
<div class="content">
    <h1><span>■</span>個人事業主選択</h1>
    <h2>■検索条件</h2>
    <div class="content-top">
        <form method="get" action="${pageContext.request.contextPath}/TG0200" class="manage-form" id="queryForm">
            <label for="date" style="margin-right: 50px; margin-left: 100px">受注月</label>
            <a href="javascript:void(0)" style="margin-right: 30px; color: #0066cc" id="minusDateArrow">&lt;&lt;</a>
            <input type="text" name="date" id="date" style="width: 90px" value="${not empty param.date ? param.date : ''}">
            <a href="javascript:void(0)" style="margin-left: 30px; color: #0066cc" id="addDateArrow">&gt;&gt;</a>
        </form>
    </div>
    <h2>■受注一覧</h2>
    <div class="content-bottom">
        <form method="post" action="${pageContext.request.contextPath}/TG0200" id="answerForm">
            <div class="row" style="margin-bottom: 5px">
                <div class="right">
                    <span style="margin-right: 50px">件数：　<span style="color: #0066cc">${fn:length(vo) }件</span></span>
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
                        <td>${ row.jyutyuuStep }</td>
                        <td>
                            <div>
                                <a href="javascript:void(0)" onclick="updateData('${ row.jyutyuuNum }');" >更新</a>
                            </div>
                            <div>
                                <a href="javascript:void(0)" onclick="deleteData('${ row.iraisakiNameRyaku}', '${ row.targetName }', '${ row.hakkenMonth }', '${ row.renban }');" >削除</a>
                            </div>
                            <c:if test="${row.isEntyou == 1}">
                                <div>
                                    <a href="javascript:void(0)" onclick="extendData('${ row.jyutyuuNum }');" >延長</a>
                                </div>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <input type="hidden" id="submitKind" name="submitKind">
            <input type="hidden" id="edit_id" name="edit_id">
            <input type="hidden" id="edit_jyutyuuStep" name="edit_jyutyuuStep">
            <input type="hidden" id="extend_flag" name="extend_flag">
            <input type="hidden" id="extend_jyutyuuNum" name="extend_jyutyuuNum">
        </form>
    </div>
</div>
</body>
</html>
