<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/custom-functions.tld" prefix="cfn" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>社員${isAddNew?'登録':'更新'}</title>
    <meta name="viewport" content="width=device-width">
    <link href="https://cdn.bootcss.com/jqueryui/1.12.1/jquery-ui.min.css" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/jquery-ui.js"></script>
	<script src="${pageContext.request.contextPath}/js/dateFormat.js"></script>
	<script src="${pageContext.request.contextPath}/js/inputCheck.js"></script>
	<script src="${pageContext.request.contextPath}/js/syain_edit.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/manage.css">
</head>
<body>
<jsp:include page="/header.jsp"/>
<div id="edit_box" class="content">
    <h1><span>■</span>社員${isAddNew?'登録':'更新'}</h1>
    <div class="content-inner">
        <form class="edit-form" autocomplete="off" method="post">
            <h2>基本情報</h2>
            <div class="content-part">
                <div class="row">
                    <label>社員コード：</label>
                    <input type="text" id="employeeCode" name="employeeCode" value="${vo.employeeCode }">
                </div>
                <div class="row">
                    <label>社員名（漢字）</label>
                    <label for="kanji-sei" class="mr5">姓</label>
                    <input type="text" class="mr5 w100" id="kanji-sei" name="kanjiSei" value="${vo.kanjiSei }">
                    <label for="kanji-sei" class="mr5">名</label>
                    <input type="text" class="mr5 w100" id="kanji-mei" name="kanjiMei" value="${vo.kanjiMei }">
                    <span class="red">必須</span>
                </div>
                <div class="row">
                    <label>社員名（カタカナ）</label>
                    <label for="katakana-sei" class="mr5">ｾｲ</label>
                    <input type="text" class="mr5 w100" id="katakana-sei" name="katakanaSei" value="${vo.katakanaSei }">
                    <label for="katakana-mei" class="mr5">ﾒｲ</label>
                    <input type="text" class="mr5 w100" id="katakana-mei" name="katakanaMei" value="${vo.katakanaMei }">
                    <span class="red">必須</span>
                </div>
                <div class="row">
                    <label>社員名（英語）</label>
                    <label for="english-sei" class="mr5">first name</label>
                    <input type="text" class="mr5 w100" id="english-sei" name="englishSei" value="${vo.englishSei }">
                    <label for="english-mei" class="mr5">last name</label>
                    <input type="text" class="mr5 w100" id="english-mei" name="englishMei" value="${vo.englishMei }">
                    <span class="red">必須</span>
                </div>
                <div class="row">
                    <label>性別</label>
                    <label for="gender-man"><input style="margin: 0 8px 0 5px" type="radio" id="gender-man"
                                                   name="gender" value="1" ${ vo.gender == 1 ? "checked" : "" }>男</label>
                    <label for="gender-woman"><input style="margin: 0 8px 0 20px" type="radio" id="gender-woman"
                                                     name="gender" value="0" ${ vo.gender == 0 ? "checked" : "" }>女</label>
                </div>
                <div class="row">
                    <label for="birthday">誕生日</label>
                    <input type="text" value="${vo.birthday }" id="birthday" name="birthday">
                </div>
                <div class="row">
                    <label for="country">国籍</label>
                    <select name="country" id="country">
		               <c:forEach var="country" items="${so.countrys }">
		                    <option value="${country.key }" ${ vo.country == country.key ? "selected" : "" }>${country.value }</option>
		               </c:forEach>
                    </select>
                </div>
                <div class="row">
                    <label for="shusshin">出身地</label>
                    <input type="text" id="shusshin" name="shusshin" value="${vo.shusshin }">
                </div>
                <div class="row">
                    <label>配偶者有り無し</label>
                    <label for="haigusha-ari"><input style="margin: 0 8px 0 5px" type="radio" id="haigusha-ari"
                                                     name="haigusha" value="1" ${ vo.haigusha == 1 ? "checked" : "" }>有</label>
                    <label for="haigusha-nai"><input style="margin: 0 8px 0 20px" type="radio" id="haigusha-nai"
                                                     name="haigusha" value="0" ${ vo.haigusha == 0 ? "checked" : "" }>無</label>
                </div>
            </div>

            <h3>個人証明情報</h3>

            <div class="content-part">
                <div class="row">
                    <label for="passport-id">パスポート番号</label>
                    <input type="text" value="${vo.passportId }" id="passport-id" name="passportId" style="ime-mode: disabled;">
                </div>
                <div class="row">
                    <label for="passport-expire">パスポート有効日</label>
                    <input type="text" id="passport-expire" value="${vo.passportExpire }" name="passportExpire">
                </div>
                <div class="row">
                    <label for="visa-period">ビザ期間</label>
                    <select id="visa-period" style="min-width: 100px" name="visaPeriod">
                        <c:forEach var="visaPeriod" items="${so.visaPeriods }">
		                    <option value="${visaPeriod.key }" ${ vo.visaPeriod == visaPeriod.key ? 'selected' : '' }>${visaPeriod.value }</option>
		               </c:forEach>
                    </select>
                    <span>年</span>
                </div>
                <div class="row">
                    <label for="visa-expire">ビザ有効日</label>
                    <input type="text" id="visa-expire" name="visaExpire" value="${vo.visaExpire }">
                </div>
                <div class="row">
                    <label for="zairyuu-name">在留資格名称</label>
                    <select id="zairyuu-name" name="zairyuuName">
                    	<c:forEach var="zairyuuName" items="${so.zairyuuNames }">
		                    <option value="${zairyuuName.key }" ${ vo.zairyuuName == zairyuuName.key ? 'selected' : '' }>${zairyuuName.value }</option>
		               </c:forEach>
                    </select>
                </div>
                <div class="row">
                    <label for="my-number">マイナンバー</label>
                    <input type="text" id="my-number" name="myNumber" style="ime-mode: disabled;" value="${vo.myNumber }">
                </div>
                <div class="row">
                    <label for="zairyuu-number">在留番号</label>
                    <input type="text" id="zairyuu-number" name="zairyuuNumber" value="${vo.zairyuuNumber }">
                </div>
            </div>

            <h2>会社関連情報</h2>

            <div class="content-part">
                <div class="row">
                    <label for="company">所属会社</label>
                    <select id="company" name="company">
                        <c:forEach var="company" items="${so.companys }">
		                     <option value="${company.key }" ${vo.company == company.key ? 'selected' : '' }>${company.value }</option>
		                </c:forEach>
                    </select>
                </div>
                <div class="row">
                    <label for="nyuusha-date">入社日</label>
                    <input type="text" id="nyuusha-date" name="nyuushaDate" value= "${vo.nyuushaDate}">
                </div>
                <div class="row">
                    <label for="taisya-date">退社日</label>
                    <input type="text" id="taisya-date" name="taishaDate" value="${vo.taishaDate}">
                </div>
                <div class="row">
                    <label for="job">職業種類</label>
                    <select id="job" name="job">
                        <c:forEach var="job" items="${so.jobs }">
		                    <option value="${job.key }" ${vo.job == job.key? 'selected' : '' }>${job.value }</option>
		               </c:forEach>
                    </select>
                </div>
                <div class="row">
                    <label for="rainichi-date">来日時間</label>
                    <input type="text" id="rainichi-date" name="rainichiDate" value="${vo.rainichiDate }">
                </div>
                <div class="row textarea-row">
                    <label for="bikou">備考</label>
                    <textarea id="bikou" name="bikou">${vo.bikou }</textarea>
                </div>
            </div>

            <h2>連絡先</h2>

            <div class="content-part">
                <div class="row">
                    <label for="postcode">住所</label>
                    <span style="margin: 0 5px">〒</span><input type="text" id="postcode" name="postcode"
                                                               style="width: 130px" value="${vo.postcode }">
                </div>
                <div class="row">
                    <label for="address-1"></label>
                    <input type="text" id="address-1" name="address1" value="${vo.address1 }" style="width: 400px">
                    <span>番地まで</span>
                </div>
                <div class="row">
                    <label for="address-2"></label>
                    <input type="text" id="address-2" name="address2" value="${vo.address2 }" style="width: 400px;">
                    <span>マンション名・号室など</span>
                </div>
                <div class="row">
                    <label for="moyori-eki">最寄駅</label>
                    <input type="text" id="moyori-eki" name="moyoriEki" value="${vo.moyoriEki }">
                </div>
                <div class="row">
                    <label for="tel">携帯電話</label>
                    <input type="text" id="tel" name="tel" style="ime-mode: disabled;" value="${vo.tel }">
                </div>
                <div class="row">
                    <label for="mail-address">メールアドレス</label>
                    <input type="text" id="mail-address" name="mailAddress" style="ime-mode: disabled;" value="${vo.mailAddress }" style="width: 400px">
                </div>
                <div class="row">
                    <label for="wechat-id">WechatID</label>
                    <input type="text" id="wechat-id" name="wechatId" value="${vo.wechatId }">
                </div>
                <div class="row">
                    <label for="line-id">LineID</label>
                    <input type="text" id="line-id" name="lineId" value="${vo.lineId }">
                </div>
            </div>

            <h3>母国関連</h3>

            <div class="content-part">
                <div class="row textarea-row">
                    <label for="bokoku-address">住所</label>
                    <textarea name="bokokuAddress" id="bokoku-address">${vo.bokokuAddress }</textarea>
                </div>
                <div class="row textarea-row">
                    <label for="bokoku-rennraku">緊急連絡先</label>
                    <textarea name="bokokuRennraku" id="bokoku-rennraku">${vo.bokokuRennraku}</textarea>
                </div>
            </div>

            <h2>学歴情報</h2>

            <div class="content-part">
                <div class="row">
                    <label for="gakureki">最終学歴</label>
                    <select id="gakureki" name="gakureki">
                        <c:forEach var="gakureki" items="${so.gakurekis }">
		                    <option value="${gakureki.key }" ${vo.gakureki == gakureki.key? 'selected' : '' }>${gakureki.value }</option>
		                </c:forEach>
                    </select>
                </div>
                <div class="row">
                    <label for="school-name">学校名</label>
                    <input type="text" id="school-name" name="schoolName" value="${vo.schoolName }">
                </div>
                <div class="row">
                    <label for="sennmonn">専門</label>
                    <input type="text" id="sennmonn" name="sennmonn" value="${vo.sennmonn }">
                </div>
                <div class="row">
                    <label for="sotsugyou-date">卒業年月日</label>
                    <input type="text" id="sotsugyou-date" name="sotsugyouDate" value="${vo.sotsugyouDate }">
                </div>
            </div>

            <h2>職歴情報</h2>

            <div class="content-part">
                <!-- <div class="row">
                    <label for="work-years">IT関連実務年数</label>
                    <input type="text" id="work-years" class="w100" name="workYears" value="${vo.workYears }">
                    <span>年</span>
                </div> -->

                <div class="row" style="text-align: right">
                    <input type="button" value="新規行追加"
                           style="background-color: #a5a5a5; padding: 2px 20px; background-image: initial"
                           id="work-history-add" onclick="add_work_history()">
                    <input type="button" value="最後行削除"
                           style="background-color: #a5a5a5; padding: 2px 20px; background-image: initial"
                           id="work-history-remove" onclick="remove_work_history()">
                </div>

                <div class="row">
                    <table class="work-history-table text-center-table">
                        <tr>
                            <th style="width: 15%">入社年月日</th>
                            <th style="width: 15%">退社年月日</th>
                            <th style="width: 40%">会社名</th>
                            <th style="width: 30%">部署</th>
                        </tr>
                        <c:forEach var="i" begin="0" end="${ fn:length(vo.rirekiBuSho) - 1 }" step="1" >
	                        <tr>
	                            <td><input type="text" class="work-history-nyuusha-date" name="rirekiNyuushaDate" value="${vo.rirekiNyuushaDate[i] }"></td>
	                            <td><input type="text" class="work-history-taisha-date" name="rirekiTaishaDate" value="${vo.rirekiTaishaDate[i] }"></td>
	                            <td><input type="text" name="rirekiCompanyName" value="${vo.rirekiCompanyName[i] }"></td>
	                            <td><input type="text" name="rirekiBuSho" value="${vo.rirekiBuSho[i] }"></td>
	                        </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>

            <h2>技術経験<span>◎：実務経験１年以上 ／ ○：実務経験有り ／ △：知識有り</span></h2>

            <div class="skill-table">
                <div class="skill-row">
	                <div class="skill-name" >OS</div>
			        <div class="skill-meisai">
			            <div class="skill-table">
                       	<c:set var="size" value="${fn:length(so.skillOS)}"  />
                       	<c:set var="lineCnt" value="${((fn:length(so.skillOS)-1) / 5).intValue()}" />
                       	<c:forEach var="row" begin="0" end="${((fn:length(so.skillOS)-1) / 5).intValue()}" step="1">
			                <div class="skill-row">
                       			<c:forEach var="col" begin="1" end="5" step="1" >
                       				<c:set var="currentIndex" value="${(row * 5 + col).intValue()}"  />
                  					<c:if test="${currentIndex <= size }">
                       					<div class="skill-item-name" style="${(row == lineCnt)?'border-bottom: none':''}">${so.skillOS[currentIndex]}</div>
                               			<div class="skill-item-select"
                               				style="${(row == lineCnt)?'border-bottom: none;':'' } ${(col == 5)?'border-right: none':''}">
                              				<select name="skillOS">
                                       		<option value=""></option>
                                       		<option value="${currentIndex }-1" ${cfn:contains0(vo.skillOS, currentIndex,-1)?'selected':''}>◎</option>
                                       		<option value="${currentIndex }-2" ${cfn:contains0(vo.skillOS, currentIndex,-2)?'selected':''}>○</option>
                                       		<option value="${currentIndex }-3" ${cfn:contains0(vo.skillOS, currentIndex,-3)?'selected':''}>△</option>
                                   			</select>
										</div>
									</c:if>
                       			</c:forEach>
                       		</div>
                       	</c:forEach>
                    </div>
                    </div>
                </div>
            <div class="skill-row">
                <div class="skill-name">言語</div>
		        <div class="skill-meisai">
		            <div class="skill-table">
                      	<c:set var="size" value="${fn:length(so.skillLanguage)}"  />
                      	<c:set var="lineCnt" value="${((fn:length(so.skillLanguage)-1) / 5).intValue()}" />
                      	<c:forEach var="row" begin="0" end="${((fn:length(so.skillLanguage)-1) / 5).intValue()}" step="1">
		                <div class="skill-row">
                      			<c:forEach var="col" begin="1" end="5" step="1" >
                      				<c:set var="currentIndex" value="${(row * 5 + col).intValue()}"  />
                 					<c:if test="${currentIndex <= size }">
                      					<div class="skill-item-name" style="${(row == lineCnt)?'border-bottom: none;':''}">${so.skillLanguage[currentIndex]}</div>
                              			<div class="skill-item-select"
                              				style="${(row == lineCnt)?'border-bottom: none;':'' } ${(col == 5)?'border-right: none':''}">
                             				<select name="skillLanguage">
                                      		<option value=""></option>
                                      		<option value="${currentIndex }-1" ${cfn:contains0(vo.skillLanguage, currentIndex,-1)?'selected':''}>◎</option>
                                      		<option value="${currentIndex }-2" ${cfn:contains0(vo.skillLanguage, currentIndex,-2)?'selected':''}>○</option>
                                      		<option value="${currentIndex }-3" ${cfn:contains0(vo.skillLanguage, currentIndex,-3)?'selected':''}>△</option>
                                  			</select>
									</div>
								</c:if>
                      			</c:forEach>
                      		</div>
                      	</c:forEach>
                   </div>
                   </div>
               </div>
               <div class="skill-row">
                <div class="skill-name">DB</div>
		        <div class="skill-meisai">
		            <div class="skill-table">
                      	<c:set var="size" value="${fn:length(so.skillDB)}"  />
                      	<c:set var="lineCnt" value="${((fn:length(so.skillDB)-1) / 5).intValue()}" />
                      	<c:forEach var="row" begin="0" end="${((fn:length(so.skillDB)-1) / 5).intValue()}" step="1">
		                <div class="skill-row">
                      			<c:forEach var="col" begin="1" end="5" step="1" >
                      				<c:set var="currentIndex" value="${(row * 5 + col).intValue()}"  />
                 					<c:if test="${currentIndex <= size }">
                      					<div class="skill-item-name" style="${(row == lineCnt)?'border-bottom: none;':''}">${so.skillDB[currentIndex]}</div>
                              			<div class="skill-item-select"
                              				style="${(row == lineCnt)?'border-bottom: none;':'' } ${(col == 5)?'border-right: none':''}">
                             				<select name="skillDB">
                                      		<option value=""></option>
                                      		<option value="${currentIndex }-1" ${cfn:contains0(vo.skillDB, currentIndex,-1)?'selected':''}>◎</option>
                                      		<option value="${currentIndex }-2" ${cfn:contains0(vo.skillDB, currentIndex,-2)?'selected':''}>○</option>
                                      		<option value="${currentIndex }-3" ${cfn:contains0(vo.skillDB, currentIndex,-3)?'selected':''}>△</option>
                                  			</select>
									</div>
								</c:if>
                      			</c:forEach>
                      		</div>
                      	</c:forEach>
                   </div>
                   </div>
               </div>
               <div class="skill-row">
                <div class="skill-name">WEBサーバ</div>
		        <div class="skill-meisai">
		            <div class="skill-table">
                      	<c:set var="size" value="${fn:length(so.skillWebServer)}"  />
                      	<c:set var="lineCnt" value="${((fn:length(so.skillWebServer)-1) / 5).intValue()}" />
                      	<c:forEach var="row" begin="0" end="${((fn:length(so.skillWebServer)-1) / 5).intValue()}" step="1">
		                <div class="skill-row">
                      			<c:forEach var="col" begin="1" end="5" step="1" >
                      				<c:set var="currentIndex" value="${(row * 5 + col).intValue()}"  />
                 					<c:if test="${currentIndex <= size }">
                      					<div class="skill-item-name" style="${(row == lineCnt)?'border-bottom: none;':''}">${so.skillWebServer[currentIndex]}</div>
                              			<div class="skill-item-select"
                              				style="${(row == lineCnt)?'border-bottom: none;':'' } ${(col == 5)?'border-right: none':''}">
                             				<select name="skillWebServer">
                                      		<option value=""></option>
                                      		<option value="${currentIndex }-1" ${cfn:contains0(vo.skillWebServer, currentIndex,-1)?'selected':''}>◎</option>
                                      		<option value="${currentIndex }-2" ${cfn:contains0(vo.skillWebServer, currentIndex,-2)?'selected':''}>○</option>
                                      		<option value="${currentIndex }-3" ${cfn:contains0(vo.skillWebServer, currentIndex,-3)?'selected':''}>△</option>
                                  			</select>
									</div>
								</c:if>
                      			</c:forEach>
                      		</div>
                      	</c:forEach>
                   </div>
                   </div>
               </div>
                <div class="skill-row">
	                <div class="skill-name">FrameWork</div>
			        <div class="skill-meisai">
			            <div class="skill-table">
                       	<c:set var="size" value="${fn:length(so.skillFW)}"  />
                       	<c:set var="lineCnt" value="${((fn:length(so.skillFW)-1) / 5).intValue()}" />
                       	<c:forEach var="row" begin="0" end="${((fn:length(so.skillFW)-1) / 5).intValue()}" step="1">
			                <div class="skill-row">
                       			<c:forEach var="col" begin="1" end="5" step="1" >
                       				<c:set var="currentIndex" value="${(row * 5 + col).intValue()}"  />
                  					<c:if test="${currentIndex <= size }">
                       					<div class="skill-item-name" style="${(row == lineCnt)?'border-bottom: none;':''}">${so.skillFW[currentIndex]}</div>
                               			<div class="skill-item-select"
                               				style="${(row == lineCnt)?'border-bottom: none;':'' } ${(col == 5)?'border-right: none':''}">
                              				<select name="skillFW">
                                       		<option value=""></option>
                                       		<option value="${currentIndex }-1" ${cfn:contains0(vo.skillFW, currentIndex,-1)?'selected':''}>◎</option>
                                       		<option value="${currentIndex }-2" ${cfn:contains0(vo.skillFW, currentIndex,-2)?'selected':''}>○</option>
                                       		<option value="${currentIndex }-3" ${cfn:contains0(vo.skillFW, currentIndex,-3)?'selected':''}>△</option>
                                   			</select>
										</div>
									</c:if>
                       			</c:forEach>
                       		</div>
                       	</c:forEach>
                    </div>
                    </div>
                </div>
                <div class="skill-row">
	                <div class="skill-name" style="border-bottom: 1px solid">その他</div>
			        <div class="skill-meisai" style="border-bottom: 1px solid">
			            <div class="skill-table">
                       	<c:set var="size" value="${fn:length(so.skillOther)}"  />
                       	<c:set var="lineCnt" value="${((fn:length(so.skillOther)-1) / 5).intValue()}" />
                       	<c:forEach var="row" begin="0" end="${((fn:length(so.skillOther)-1) / 5).intValue()}" step="1">
			                <div class="skill-row">
                       			<c:forEach var="col" begin="1" end="5" step="1" >
                       				<c:set var="currentIndex" value="${(row * 5 + col).intValue()}"  />
                  					<c:if test="${currentIndex <= size }">
                       					<div class="skill-item-name" style="${(row == lineCnt)?'border-bottom: none;':''}">${so.skillOther[currentIndex]}</div>
                               			<div class="skill-item-select"
                               				style="${(row == lineCnt)?'border-bottom: none;':'' } ${(col == 5)?'border-right: none':''}">
                              				<select name="skillOther">
                                       		<option value=""></option>
                                       		<option value="${currentIndex }-1" ${cfn:contains0(vo.skillOther, currentIndex,-1)?'selected':''}>◎</option>
                                       		<option value="${currentIndex }-2" ${cfn:contains0(vo.skillOther, currentIndex,-2)?'selected':''}>○</option>
                                       		<option value="${currentIndex }-3" ${cfn:contains0(vo.skillOther, currentIndex,-3)?'selected':''}>△</option>
                                   			</select>
										</div>
									</c:if>
                       			</c:forEach>
                       		</div>
                       	</c:forEach>
                    </div>
                    </div>
                </div>
           </div>
            <div class="row textarea-row" style="margin-top: 20px">
               <label for="appeal"
                      style="width: 300px; background: #ccffff; display: block;border-top: 1px solid;
                      border-top: 1px solid; border-left: 1px solid; border-right: 1px solid; border-bottom: none;">
                      備考及び自己アピール
               </label>
               <textarea name="appeal" id="appeal" style="width: 1020px; min-height: 80px;" class="ime_active">${vo.appeal }</textarea>
           </div>
		   <div class="row textarea-row" style="margin-top: 20px">
               <label for="appeal"
                      style="width: 300px; background: #ccffff; display: block;border-top: 1px solid;
                      border-top: 1px solid; border-left: 1px solid; border-right: 1px solid; border-bottom: none;">
                     コメント
               </label>
               <textarea name="comment" id="comment" style="width: 1020px; min-height: 80px;" class="ime_active">${vo.comment }</textarea>
           </div>
            <h2>業務経歴</h2>

            <div class="content-part" id="projects">
            <c:forEach var="i" begin="0" end="${ fn:length(vo.projectName) - 1 }" step="1" >

                <div class="project">
                    <div class="row" style="text-align: right; width: 1020px">
                        <input type="button" value="新規情報追加"
                               style="background-color: #a5a5a5; padding: 2px 20px; background-image: initial"
                               onclick="add_project()">
                        <input type="button" value="該当情報削除"
                               style="background-color: #a5a5a5; padding: 2px 20px; background-image: initial"
                               onclick="remove_project(this)">
                    </div>
                    <div class="row">
                        <table class="project-table">
                            <tr>
                                <th>
                                    <div>開始年月</div>
                                </th>
                                <td><input type="text" class="project-start-date" name="projectStartDate" value="${vo.projectStartDate[i] }"></td>
                                <th>
                                    <div>終了年月</div>
                                </th>
                                <td><input type="text" class="project-end-date" name="projectEndDate" value="${vo.projectEndDate[i] }"></td>
                                <th>
                                    <div>PJ名</div>
                                </th>
                                <td colspan="3"><input type="text" style="width: 300px" name="projectName" value="${vo.projectName[i] }"></td>
                                <th>
                                    <div>対日</div>
                                </th>
                                <td>
                                    <select name="tainichi">
                                        <option value="0" ${vo.tainichi[i] == 0 ? 'selected' : '' }>　</option>
                                        <option value="1" ${vo.tainichi[i] == 1 ? 'selected' : '' }>〇</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <div>開発場所</div>
                                </th>
                                <td>
                                    <select name="kaihatsuBasho">
                                    	<c:forEach var="country" items="${so.countrys }">
					                    	<option value="${country.key }" ${vo.kaihatsuBasho[i] == country.key ? 'selected' : '' }>${country.value }</option>
					               		</c:forEach>
                                    </select>
                                </td>
                                <th>
                                    <div>規模人数</div>
                                </th>
                                <td><input type="text" name="kibo" style="ime-mode: disabled;" value="${vo.kibo[i] }"></td>
                                <th>
                                    <div>開発業種</div>
                                </th>
                                <td>
                                    <select name="kaihatsuGyoushu">
                                        <c:forEach var="kaihatsuGyoushu" items="${so.kaihatsuGyoushus }">
					                    	<option value="${kaihatsuGyoushu.key }" ${vo.kaihatsuGyoushu[i] == kaihatsuGyoushu.key ? 'selected' : '' }>${kaihatsuGyoushu.value }</option>
					               		</c:forEach>
                                    </select>
                                </td>
                                <th>
                                    <div>開発環境</div>
                                </th>
                                <td>
                                    <select name="kaihatsuKannkyou">
                                        <c:forEach var="os" items="${so.skillOS }">
					                    	<option value="${os.key }" ${vo.kaihatsuKannkyou[i] == os.key ? 'selected' : '' }>${os.value }</option>
					               		</c:forEach>
                                    </select>
                                </td>
                                <th>
                                    <div>運用環境</div>
                                </th>
                                <td>
                                    <select name="unnyouKannkyou">
                                        <c:forEach var="os" items="${so.skillOS }">
					                    	<option value="${os.key }" ${vo.unnyouKannkyou[i] == os.key ? 'selected' : '' }>${os.value }</option>
					               		</c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <div>言語</div>
                                </th>
                                <td colspan="2"><input type="text" style="width: 200px" name="language" value="${vo.language[i] }"></td>
                                <th>
                                    <div>DB</div>
                                </th>
                                <td colspan="2"><input type="text" style="width: 200px" name="db" value="${vo.db[i] }"></td>
                                <th>
                                    <div>FW IDE ﾂｰﾙ</div>
                                </th>
                                <td colspan="3"><input type="text" style="width: 300px" name="tool" value="${vo.tool[i] }"></td>
                            </tr>
                            <tr>
                                <th>
                                    <div>担当</div>
                                </th>
                                <td>
                                    <select name="tanntou">
                                        <c:forEach var="tanntou" items="${so.tanntous }">
					                    	<option value="${tanntou.key }" ${vo.tanntou[i] == tanntou.key ? 'selected' : '' }>${tanntou.value }</option>
					               		</c:forEach>
                                    </select>
                                </td>
                                <th>
                                    <div>作業範囲</div>
                                </th>
                                <td colspan="7">
                                    <table class="project-scope-table">
                                        <tr>
                                            <th>
                                                <div>要</div>
                                            </th>
                                            <td>
                                                <select name="projectScope">
                                                    <option value="0" ${vo.projectScope[i * 10] == 0 ? 'selected' : '' }>　</option>
                                                    <option value="1" ${vo.projectScope[i * 10] == 1 ? 'selected' : '' }>〇</option>
                                                </select>
                                            </td>
                                            <th>
                                                <div>調</div>
                                            </th>
                                            <td>
                                                <select name="projectScope">
                                                    <option value="0" ${vo.projectScope[i * 10 + 1] == 0 ? 'selected' : '' }>　</option>
                                                    <option value="1" ${vo.projectScope[i * 10 + 1] == 1 ? 'selected' : '' }>〇</option>
                                                </select>
                                            </td>
                                            <th>
                                                <div>基</div>
                                            </th>
                                            <td>
                                                <select name="projectScope">
                                                    <option value="0" ${vo.projectScope[i * 10 + 2] == 0 ? 'selected' : '' }>　</option>
                                                    <option value="1" ${vo.projectScope[i * 10 + 2] == 1 ? 'selected' : '' }>〇</option>
                                                </select>
                                            </td>
                                            <th>
                                                <div>詳</div>
                                            </th>
                                            <td>
                                                <select name="projectScope">
                                                    <option value="0" ${vo.projectScope[i * 10 + 3] == 0 ? 'selected' : '' }>　</option>
                                                    <option value="1" ${vo.projectScope[i * 10 + 3] == 1 ? 'selected' : '' }>〇</option>
                                                </select>
                                            </td>
                                            <th>
                                                <div>CD</div>
                                            </th>
                                            <td>
                                                <select name="projectScope">
                                                    <option value="0" ${vo.projectScope[i * 10 + 4] == 0 ? 'selected' : '' }>　</option>
                                                    <option value="1" ${vo.projectScope[i * 10 + 4] == 1 ? 'selected' : '' }>〇</option>
                                                </select>
                                            </td>
                                            <th>
                                                <div>単</div>
                                            </th>
                                            <td>
                                                <select name="projectScope">
                                                    <option value="0" ${vo.projectScope[i * 10 + 5] == 0 ? 'selected' : '' }>　</option>
                                                    <option value="1" ${vo.projectScope[i * 10 + 5] == 1 ? 'selected' : '' }>〇</option>
                                                </select>
                                            </td>
                                            <th>
                                                <div>結</div>
                                            </th>
                                            <td>
                                                <select name="projectScope">
                                                    <option value="0" ${vo.projectScope[i * 10 + 6] == 0 ? 'selected' : '' }>　</option>
                                                    <option value="1" ${vo.projectScope[i * 10 + 6] == 1 ? 'selected' : '' }>〇</option>
                                                </select>
                                            </td>
                                            <th>
                                                <div>総</div>
                                            </th>
                                            <td>
                                                <select name="projectScope">
                                                    <option value="0" ${vo.projectScope[i * 10 + 7] == 0 ? 'selected' : '' }>　</option>
                                                    <option value="1" ${vo.projectScope[i * 10 + 7] == 1 ? 'selected' : '' }>〇</option>
                                                </select>
                                            </td>
                                            <th>
                                                <div>構</div>
                                            </th>
                                            <td>
                                                <select name="projectScope">
                                                    <option value="0" ${vo.projectScope[i * 10 + 8] == 0 ? 'selected' : '' }>　</option>
                                                    <option value="1" ${vo.projectScope[i * 10 + 8] == 1 ? 'selected' : '' }>〇</option>
                                                </select>
                                            </td>
                                            <th>
                                                <div>保</div>
                                            </th>
                                            <td>
                                                <select name="projectScope">
                                                    <option value="0" ${vo.projectScope[i * 10 + 9] == 0 ? 'selected' : '' }>　</option>
                                                    <option value="1" ${vo.projectScope[i * 10 + 9] == 1 ? 'selected' : '' }>〇</option>
                                                </select>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <th>
                                    <div>開発概要</div>
                                </th>
                                <td colspan="9">
                                    <textarea name="projectGaiyou"
                                              style="border: none; width: 100%; min-height: 80px; line-height: 20px;">${vo.projectGaiyou[i] }</textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </c:forEach>
            </div>

            <h2></h2>
            <div style="text-align: center">
                <input type="submit" value="登  録" onclick="return submit_check();">
            </div>
        </form>
    </div>
                <br></br><br></br>
</div>

<script>
init_date();
add_list_date_formto_init('.work-history-nyuusha-date','.work-history-taisha-date','yy年mm月dd日');
add_project_date_edit_page_init();
</script>

</body>
</html>