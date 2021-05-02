<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/custom-functions.tld" prefix="cfn" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>取引先${isAddNew?'登録':'更新'}</title>
    <meta name="viewport" content="width=device-width">
    <link href="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.min.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath}/js/inputCheck.js"></script>
	<script src="${pageContext.request.contextPath}/js/torihikisaki_edit.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manage.css">
</head>
<body>
<jsp:include page="/header.jsp"/>
<div id="edit_box" class="content">
    <h1><span>■</span>取引先${isAddNew?'登録':'更新'}</h1>
    <div class="content-inner">
        <form class="edit-form" autocomplete="off" method="post">
            <h2>基本情報</h2>
            <div class="content-part">
                <div class="row">
                    <label for="torihikiNameAll">取引先名（全名）</label>
                    <input type="text" value="${vo.torihikiNameAll }" id="torihikiNameAll" name="torihikiNameAll" >
                </div>
                <div class="row">
                    <label for="torihikiNameRyaku">会社名（略名））</label>
                    <input type="text" value="${vo.torihikiNameRyaku }" id="torihikiNameRyaku" name="torihikiNameRyaku" >
                </div>
                <div class="row">
                    <label for="yuubin">住所</label>
                    <span style="margin: 0 5px">〒</span><input type="text" id="yuubin" name="yuubin"
                                                               style="width: 130px" value="${vo.yuubin }">
                </div>
                <div class="row">
                    <label for="jyusyo1"></label>
                    <input type="text" id="jyusyo1" name="jyusyo1" value="${vo.jyusyo1 }" style="width: 400px">
                    <span>番地まで</span>
                </div>
                <div class="row">
                    <label for="jyusyo2"></label>
                    <input type="text" id="jyusyo2" name="jyusyo2" value="${vo.jyusyo2 }" style="width: 400px;">
                    <span>マンション名・号室など</span>
                </div>
                <div class="row">
                    <label for="tel">電話</label>
                    <input type="text" id="tel" name="tel" style="ime-mode: disabled;" value="${vo.tel }">
                </div>
                <div class="row">
                    <label for="fax">FAX</label>
                    <input type="text" id="tel" name="fax" style="ime-mode: disabled;" value="${vo.fax }">
                </div>

                <div class="row">
                    <label for="url">ホームページ</label>
                    <input type="text" id="url" name="url" style="ime-mode: disabled;" value="${vo.url }" style="width: 400px">
                </div>
                <div class="row textarea-row">
                    <label for="bikou">備考</label>
                    <textarea name="bikou" id="bikou">${vo.bikou }</textarea>
                </div>
            </div>

            <h2>担当者情報</h2>

            <div class="content-part">

                <div class="row" style="text-align: right">
                    <input type="button" value="新規行追加"
                           style="background-color: #a5a5a5; padding: 2px 20px; background-image: initial"
                           id="work-history-add" onclick="add_tantou()">
                    <input type="button" value="最後行削除"
                           style="background-color: #a5a5a5; padding: 2px 20px; background-image: initial"
                           id="work-history-remove" onclick="remove_tantou()">
                </div>

                <div class="row">
                    <table class="tantou-table text-center-table">
                        <tr>
                            <th style="width: 5%">To</th>
                            <th style="width: 5%">CC</th>
                            <th style="width: 10%">姓</th>
                            <th style="width: 10%">名</th>
                            <th style="width: 20%">メールアドレス</th>
                            <th style="width: 10%">所属</th>
                            <th style="width: 10%">役職</th>
                            <th style="width: 20%">個人電話番号</th>
                            <th style="width: 10%">備考</th>
                        </tr>
                        <c:forEach var="i" begin="0" end="${ fn:length(vo.tantou_firstName) - 1 }" step="1" >
	                        <tr>
	                            <td style="text-align:center;"><input type="checkbox"  name="tantou_jimuMail" value="1" ${(vo.tantou_jimuMail[i]==1) ? "checked" : "" }></td>
	                            <td style="text-align:center;"><input type="checkbox"  name="tantou_jimuMail" value="2" ${(vo.tantou_jimuMail[i]==2) ? "checked" : "" }></td>
	                            <td><input type="text" name="tantou_firstName" value="${vo.tantou_firstName[i] }"></td>
	                            <td><input type="text" name="tantou_lastName" value="${vo.tantou_lastName[i] }"></td>
	                            <td><input type="text" name="tantou_mail" value="${vo.tantou_mail[i] }"></td>
	                            <td><input type="text" name="tantou_syozoku" value="${vo.tantou_syozoku[i] }"></td>
	                            <td><input type="text" name="tantou_yakusyoku" value="${vo.tantou_yakusyoku[i] }"></td>
	                            <td><input type="text" name="tantou_tel" value="${vo.tantou_tel[i] }"></td>
	                            <td><input type="text" name="tantou_bikou" value="${vo.tantou_bikou[i] }"></td>
	                        </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>


            <h2></h2>
            <div style="text-align: center">
                <input type="submit" value="登  録" onclick="return submit_check();">
            </div>
        </form>
    </div>
                <br></br><br></br>
</div>

</body>
</html>