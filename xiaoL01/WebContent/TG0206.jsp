<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
    .searchButton {
        letter-spacing: 10px;
        margin-left: 30px;
    }

    .ui-widget-content a {
        color: blue;
    }
</style>
</head>
<body>
<div class="content searchDialog">
    <h1><span>■</span>社員選択</h1>
    <h2>■検索条件</h2>
    <div class="content-top" style="text-align: center">
        <div class="row">
            <div class="row-left">
                <label for="kaisya" style="margin-right: 30px">所属会社</label>
                <select name="kaisya" id="kaisya">
                    <option value="0">全て</option>
                    <c:forEach var="company" items="${so.companys }">
                        <option value="${company.key }">${company.value }</option>
                    </c:forEach>
                </select>
            </div>
            <div class="row-right">
                <label for="syainName" style="margin-right: 30px">社員名</label>
                <input type="text" name="syainName" id="syainName">
            </div>
        </div>
        <div class="row" style="text-align: left;margin-left: 40px;">
            <input type="button" value="検索" id="selectSyainButtonInDialog" class="searchButton" style="padding: 2px 20px 2px 30px;">
        </div>

    </div>
    <h2>■社員一覧</h2>
    <div class="content-bottom">
            <div class="row" style="margin-bottom: 5px">
                <div class="right">
                    <span style="margin-right: 50px">件数： <span style="color: #0066cc"><span id="syainNum">0</span> 件</span></span>
                </div>
            </div>
            <table border="1" class="manage-table" id="syain-table">
                <tr>
                    <th style="width: 15%">所属会社</th>
                    <th style="width: 10%">社員名</th>
                    <th style="width: 10%">性別</th>
                    <th style="width: 10%">職業種類</th>
                    <th style="width: 10%">編集</th>
                </tr>
            </table>
        </form>
    </div>
</div>