<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>操作完了画面</title>
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manage.css">
</head>
<body>

<jsp:include page="/header.jsp" />

<div class="content">
	<h1><span>■</span>操作完了画面</h1>
	<div class="content-top" style="margin-top: 30px; margin-bottom: 70px; text-align: center">
		<span>${msg}</span>
	</div>
	<div class="content-bottom" style="text-align: center">
		<input type="button" value="${userAccessLog.gamenOyaName}" onclick="location.assign('${pageContext.request.contextPath}${url}')"/>
	</div>
</div>

</body>
</html>