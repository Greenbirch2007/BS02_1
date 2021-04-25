<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>社員管理</title>
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manage.css">
    <script src="js/manage.js"></script>
<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>

<script src="${pageContext.request.contextPath}/js/syain_manage.js"></script>
</head>
<body >
<jsp:include page="/header.jsp" />
<div id="edit_box" class="content">
    <h1><span>■</span>社員管理</h1>
	<h2>■検索条件</h2>
	<div class="content-top">
        <form method="get" onsubmit="return queryConfirm();" class="manage-form" name="manageForm">
            <div class="row">
                <div class="row-left">
                    <label for="companyId">所属会社</label>
                    <select name="companyId" id="companyId">
                    	<c:choose>
                    		<c:when test="${empty param.companyId || param.companyId == '0' }">
		                        <option value="0" selected>全て</option>
		                        <c:forEach var="company" items="${so.companys }">
		                        	<option value="${company.key }">${company.value }</option>
		                        </c:forEach>
                    		</c:when>
                    		<c:otherwise>
                    			<!-- 根据搜索参数初始化所属公司下拉框 -->
                    			<option value="0">全て</option>
		                        <c:forEach var="company" items="${so.companys }">
		                        	<option value="${company.key }" ${company.key == param.companyId?'selected':''}>${company.value }</option>
		                        </c:forEach>
                    		</c:otherwise>
                    	</c:choose>

                    </select>
                </div>
                <div class="row-right">
                    <label for="name">社員名</label>
                    <input type="text" name="name" id="name" value="${param.name }"/>
                </div>
            </div>
            <div class="row">
                <div class="row-left">
                    <label for="jobId">職業種類</label>
                    <select name="jobId" id="jobId">
                		<c:choose>
                			<c:when test="${not empty param.jobId }">
	                			<!-- 根据搜索参数初始化职业种类下拉框 -->
                				<c:forEach var="pair" items="${so.jobs}">
		                    		<option value="${pair.key }" ${pair.key == param.jobId?'selected':''}>${pair.value }</option>
		                    	</c:forEach>
                			</c:when>
                			<c:otherwise>
                				<!-- 第一次初始化 -->
		                    	<c:forEach var="pair" items="${so.jobs}">
		                    		<option value="${pair.key }" ${pair.value == 'ITエンジニア'?'selected':''}>${pair.value }</option>
		                    	</c:forEach>
                			</c:otherwise>
                		</c:choose>
                    </select>
                </div>
                <div class="row-right" style="line-height: 25px">
                	
                    	    <c:choose>
                    	<c:when test="${empty param.zaisyoku && empty param.hizaisyoku }">
                    		<!--  -->
		                    <span style="margin-right: 20px">在職</span>
		                    <input value="○" name="zaisyoku" type="checkbox" checked>
		                    <span style="margin-left: 40px; margin-right: 20px">非在職</span>
		                    <input value="○" name="hizaisyoku" type="checkbox">
                    	</c:when>
                    	<c:otherwise>
                    		<!-- 根据搜索参数初始化职业种类下拉框 -->
                    		<label>
                  	  			在職
		                    	<input style="margin-left: 20px; margin-right: 40px"  value="○" name="zaisyoku" type="checkbox" ${ not empty param.zaisyoku ? "checked" : "" } >
                    		</label>
                    		<label>
			                    	非在職
			                    <input style="margin-left: 20px" value="○" name="hizaisyoku" type="checkbox" ${not empty param.hizaisyoku ? "checked" : "" }>
                    		</label>
                    	</c:otherwise>
                    </c:choose>
                    		
                   
                	
                  		<!--在職と非在職のcheckboxの表示 
                  		<span style="margin-right: 20px">在職</span>
                  		
                    	<input style="margin-left: 20px; margin-right: 40px"  name="zaisyoku" type="checkbox" ${not empty param.zaisyoku ? "checked" : "" }>
                  		
                  		<span style="margin-left: 40px; margin-right: 20px" >非在職</span>
	                    <input style="margin-left: 20px"  name="hizaisyoku" type="checkbox" ${not empty param.hizaisyoku ? "checked" : "" }>
                  		-->
                 
                </div>
            </div>
            <input type="submit" value="検索">
        </form>
	</div>
	<h2>■社員一覧</h2>
	<form name="frmSyain" method="post" >

	    <div class="content-bottom">
	        <div class="row" style="margin-bottom: 5px">
	            <div class="right">
	                <span style="margin-right: 50px">件数：　${fn:length(vo) }件</span>
		            <a href="javascript:void(0)" onclick="javascript:doSubmit(0,null,null); return false;" >新規登録</a>
	            </div>
	        </div>
	        <table border="1" class="manage-table">
	            <tr>
	                <th style="width: 21%">所属会社</th>
	                <th style="width: 14%">社員名</th>
	                <th style="width: 8%">性別</th>
	                <th style="width: 14%">職業種類</th>
	                <th style="width: 14%">入社日</th>
	                <th style="width: 14%">退社日</th>
	                <th style="width: 8%">編集</th>
	            </tr>
	            <c:forEach var="syain" items="${vo }">
		            <tr>
		                <td>${syain.company}</td>
		                <td>${syain.name }</td>
		                <td>${syain.sex }</td>
		                <td style="text-align: left">${syain.job }</td>
		                <td>${syain.nyuushaDate }</td>
		                <td>${syain.taishaDate }</td>
		                <td>
		                    <div>
		                       <a href="javascript:void(0)" onclick="javascript:doSubmit(1,${syain.syainId},null); return false;" >更新</a>
		                    </div>
							<c:if test="${userRole == 'S'}">
							<c:choose>
   					 <c:when test="${syain.delete_flag == '0'}">
                    	<div>
		                       <a href="javascript:void(0)" onclick="javascript:doSubmit(2,${syain.syainId},'${syain.name}'); return false;" >削除</a>
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
	    <input type="hidden" id="syainId" name="syainId" >
	    <input type="hidden" id="action" name="action">
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


</body>

</html>




