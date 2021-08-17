<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>取引先管理</title>
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manage.css">
    <script src="js/torihikisaki_manage.js"></script>

</head>
<body>
<jsp:include page="/header.jsp" />
<div id="edit_box" class="content">
    <h1><span>■</span>取引先管理</h1>
	<h2>■検索条件</h2>
	<div class="content-top">
        <form method="get" onsubmit="return queryConfirm();" class="manage-form">
            <label for="name">取引先名</label>
            <input type="text" name="name" id="name" value="${param.name }"/>
            <input type="submit" value="検索">
        </form>
	</div>
	<h2>■取引先一覧</h2>
	<form name="frmTorihikisaki" method="post">

	    <div class="content-bottom">
	        <div class="row" style="margin-bottom: 5px">
	            <div class="right">
	                <span style="margin-right: 50px">件数：　${fn:length(vo) }件</span>
		            <a href="javascript:void(0)" onclick="javascript:doSubmit(0,null,null); return false;" >新規登録</a>
	            </div>
	        </div>
	        <table border="1" class="manage-table">
	            <tr>
	                <th style="width: 30%">取引先名</th>
	                <th style="width: 15%">担当者名</th>
	                <th style="width: 25%">担当者Mail</th>
	                <th style="width: 20%">担当者Tel</th>
	                <th style="width: 10%">編集</th>
	            </tr>
	            <c:forEach var="torihikisaki" items="${vo }">
		            <tr>
		                <td>${torihikisaki.torihikiNameRyaku}</td>
		                <td>${torihikisaki.tantou_name}</td>
		                <td>${torihikisaki.tantou_mail}</td>
		                <td>${torihikisaki.tantou_tel}</td>
		                <td>
		                    <div>
		                       <a href="javascript:void(0)" onclick="javascript:doSubmit(1,${torihikisaki.torihikisakiId},null); return false;" >更新</a>
		                    </div>
							<c:if test="${userRole == 'S'}">
		                    <c:choose>
   					 <c:when test="${torihikisaki.delete_flag == '0'}">
                    	<div>
		                       <a href="javascript:void(0)" onclick="javascript:doSubmit(2,${torihikisaki.torihikisakiId},'${torihikisaki.tantou_name}');return false;" >削除</a>
		                    </div>
    				</c:when>
    				<c:otherwise>
 						<div> 削除</div>
    				</c:otherwise>
					</c:choose>
							</c:if>
		                </td>
		            </tr>

	            </c:forEach>
	        </table>
	    </div>
	    <input type="hidden" id="torihikisakiId" name="torihikisakiId" >
	    <input type="hidden" id="action" name="action">
	    <input type="hidden" id="deleteFlag" name="deleteFlag">
	</form>
</div>
<!--
${pageContext.request.contextPath}
${empty param.zaisyoku }
${empty param.hizaisyoku }
${empty param.hizaisyoku && empty param.zaisyoku }
 -->
<!-- [if lt IE 9] >
<script src="https://cdn.bootcss.com/jquery/1.12.4/jquery.min.js"></script>
<![endif]  -->
<!-- [if gte IE 9] ><!-->
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
<!-- <![endif]  -->
<script src="/js/manage.js"></script>
</body>
</html>