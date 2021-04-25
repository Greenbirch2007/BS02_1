<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" import="header.UserAccessLogModel" %>
<jsp:useBean id="userAccessLog" class="header.UserAccessLogModel" scope="session" />

<!DOCTYPE html PUBLIC "-//W3C//Ddiv HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="css/common.css" type="text/css"/>
<link rel="stylesheet" href="css/header.css" type="text/css"/>
<script src="js/header.js"></script>
</head>
<body>
<div class="div">
<form  action="header" name="headerFrom" method="post" >
<div class="headerBoxContainer">
	<div class ="headerBox1">
		<div style="world-break:break-all;font-size:20px;font-weight:bold;" >株式会社ブライトスター</div>
		<div style="font-size:10px;">BRIGHT STAR CO.LTD.</div>
	</div>
	<div class ="headerBox2">社内統合管理システム</div>
	<div class ="headerBox3"><img src="images/tu.png"/></div>
</div>

<%
userAccessLog=(UserAccessLogModel)session.getAttribute("userAccessLog");
String userRole=userAccessLog.getLogModel().getUserInfo().getUserRole();
int gamenType=userAccessLog.getGamenType();
int divCnt=2;

DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy年"+"MM月"+"dd日"+" "+"HH時"+"mm分"+"ss秒");


// ログイン画面以外の場合、ログイン情報バーを表示する。
if(gamenType != 0) {
%>
	<div class="headerBoxContainer">
	<div class ="headerBox4">登録日時:<%=dtf.format(userAccessLog.getLogModel().getLoginTime()) %></div>
	<div class ="headerBox5">ユーザ名:<%=userAccessLog.getLogModel().getUserInfo().getUserName()%></div>
	<div class ="headerBox6">権限:<%= userAccessLog.getLogModel().getUserInfo().getUserRoleName() %></div>
	<div class ="headerBox7" ><input class=square_btn id="back" name="back" type="submit"
									value="<%= userAccessLog.getGamenOyaName() %>" onclick="setGamenId(this)" /></div>
	</div>
<%	if (gamenType == 1) {
%>
	<div class="headerBoxContainer">
		<div class="meun_1"><input id="TG0100" type="submit" value="作業催促" onclick="setGamenId(this)"/></div>
<%
		// 経理・人事担当以外の場合、受注と外注ができます。
		if  (!(userRole.equals("C") || userRole.equals("D"))) {
			divCnt+=2;
%>
		<div class="meun_1"><input  class="meun_1" id="TG0200" type="submit" value="受注管理" onclick="setGamenId(this)"/></div>
		<div class="meun_1"><input id="TG0300" type="submit" value="外注管理" onclick="setGamenId(this)"/></div>
<%
		}
		// 営業・人事担当以外の場合、請求と見積ができます。
		if (!(userRole.equals("B") || userRole.equals("D"))) {
			divCnt+=2;
%>
		<div class="meun_1"><input id="TG0400" type="submit" value="請求管理" onclick="setGamenId(this)"/></div>
		<div class="meun_1"><input id="TG0500" type="submit" value="見積作成" onclick="setGamenId(this)"/></div>
<%
		}
%>
		<div class="meun_1"><input id="TG0600" type="submit" value="各種類作成" onclick="setGamenId(this)"/></div>
<%
		// 営業・経理担当以外の場合、取引先・社員管理ができます。
		if (!(userRole.equals("B") || userRole.equals("C"))) {
			divCnt+=2;
%>
		<div class="meun_2"><input id="TorihikisakiManage" type="submit" value="取引先管理" onclick="setGamenId(this)"/></div>
		<div class="meun_2"><input id="SyainManage" type="submit" value="社員管理" onclick="setGamenId(this)"/></div>
<%
		}
		// システム管理者のみ、管理ができます。
		if (userRole.equals("S") ) {
			divCnt+=2;
%>
		<div class="meun_3"><input id="TG0900" type="submit" value="システム設定" onclick="setGamenId(this)"/></div>
		<div class="meun_3"><input id="TG1000" type="submit" value="ユーザ管理" onclick="setGamenId(this)"/></div>
<%
		}
%>
	</div>
<%	}
}
%>


<input type="hidden" id="gamenId" name="gamenId" value="">
</form>
</div>
</body>

</html>
