<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<style>
        .searchButton {
            letter-spacing: 10px;
            margin-left: 30px;
        }

        .ui-widget-content a {
            color: blue;
        }
 </style>
<div class="content searchDialog">
    <h1><span>■</span>取引先選択</h1>
    <h2>■検索条件</h2>
    <div class="content-top" style="text-align: center">
        <label for="torihikisakiName" style="margin-right: 30px">取引先名</label>
        <input type="text" name="torihikisakiName" id="torihikisakiName" style="width: 150px" >
        <input type="button" value="検索" id="selectTorihikisakiButtonInDialog" class="searchButton" style="padding: 2px 20px 2px 30px;">
    </div>
    <h2>■取引先一覧</h2>
    <div class="content-bottom">
            <div class="row" style="margin-bottom: 5px">
                <div class="right">
                    <span style="margin-right: 50px">件数： <span style="color: #0066cc"><span id="torihikisakiNum">0</span> 件</span></span>
                </div>
            </div>
            <table border="1" class="manage-table" id="torihikisaki-table">
                <tr>
                    <th style="width: 10%">取引先名</th>
                    <th style="width: 10%">担当者名</th>
                    <th style="width: 10%">操作</th>
                </tr>
            </table>
    </div>
</div>