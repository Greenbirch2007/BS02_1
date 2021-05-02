<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:useBean id="loginModel" class="User.LoginModel" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
 "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-31j">
<title>ログイン画面</title>
<link rel="stylesheet" href="css/login.css" type="text/css" />
<link rel="stylesheet" href="css/common.css" type="text/css"/>
<script type="text/javascript" src="js/login.js"></script>
</head>
<body>
<jsp:include page="header.jsp"/>
<div  class="div">
<div class="boxContainer">
	<div class="box">
    <form  method="post" onSubmit="return checkInput()">
    <table class="login">
	    <tr><td class="title" colspan="2">利用者申請</td>
		<tr class="line" />
		<tr>
			<th >ログインID：</th>
			<td ><input type="text" id="userID" name="userID" value="<%= loginModel.getUserInfo().getUserID() %>"></td>
		</tr>
		<tr class="line" />
		<tr>
			<th >パスワード：</th>
			<td ><input type="password" id="password" name="password"></td>
		</tr>
		<tr class="line" />
		<tr class="line" />
		<tr>
			<td colspan="2"><input class="button" type="submit" value="ログイン" ></td>
		</tr>

	<%
		if(loginModel != null && loginModel.isValidUser() == false && loginModel.getMessage() != null) {
	%>
		<tr>
		<td class="error" colspan="2"><%=loginModel.getMessage() %></td></tr>
	<%
		}
	%>
	</table>
	</form>
	</div>
	<div class="box">
	    <table class="sysInfo">
	    	<tr><td class="title" colspan="3">応用機能</td></tr>
	    	<tr><td>●受注管理</td><td>●外注発行</td><td>●請求作成</td></tr>
	    	<tr><td>●見積作成</td><td>●作業催促</td><td>●各書類作成</td></tr>
	    	<tr><td class="title" colspan="3">マスタ管理機能</td></tr>
	    	<tr><td>●取引先情報管理</td><td></td><td></td></tr>
	    	<tr><td>●社員情報管理</td><td></td><td></td></tr>
	    	<tr><td colspan="3">&nbsp;&nbsp;&nbsp;・基本情報&nbsp;&nbsp;&nbsp;&nbsp;・履歴&nbsp;&nbsp;&nbsp;&nbsp;・経歴</td></tr>
	    	<tr><td class="title" colspan="3">開発関連</td></tr>
	    	<tr><td colspan="3">バージョンVer0.0.0.1</td></tr>
	    	<tr><td colspan="3">保留</td></tr>
	    </table>
	</div>
</div>
</div>

</body>
</html>