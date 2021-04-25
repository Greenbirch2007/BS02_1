<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>システムエラー</title>
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manage.css">
</head>
<body>

<jsp:include page="/header.jsp" />

<div class="content">
	<h1><span>■</span>システムエラー</h1>
	<div class="content-top" style="margin-top: 30px; margin-bottom: 20px">
		<span style="color: red">システムエラーが発生しました。</span>
	</div>
	<div class="content-middle" style="margin-bottom: 20px">
		<span>${msg }</span>
	</div>
	<div class="content-bottom" style="text-align: center">
		<input type="button" value="システム終了" onclick="window.close();">
	</div>
</div>

</body>
</html>