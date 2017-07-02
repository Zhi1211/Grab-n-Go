<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>購物車-Grab &amp; Go</title>
    <meta name="keywords" content="Grab &amp; Go, 訂餐, 帶著就走, 上班族" />
    <meta name="description" content="短短的午休時間您受夠了在水深火熱中跟人家相爭排隊買午餐嗎? Grab &amp; Go 預約訂餐系統讓您輕鬆帶著走。" />
    <meta name="author" content="Grab &amp; Go">
    <meta name="copyright" content="Grab &amp; Go">
    <meta name="robots" content="index, follow">
    <meta name="GOOGLEBOT" content="index, follow">
    <meta name="distribution" content="GLOBAL">
    <meta property="og:title" content="Grab &amp; Go " />
    <meta property="og:description" content="短短的午休時間您受夠了在水深火熱中跟人家相爭排隊買午餐嗎? Grab &amp; Go 預約訂餐系統讓您輕鬆帶著走。" />
    <meta property="og:site_name" content="Grab &amp; Go" />
    <meta property="og:type" content="website" />
    <meta property="og:url" content="http://www.chewchew.com.tw" />
    <meta property="og:image" content="http://lovegreenfood.com/gg/fb.jpg" />
    <link rel="image_src" href="http://lovegreenfood.com/gg/fb.jpg" />
    <link rel="SHORTCUT ICON" href="../images/favicon.ico" />
    <link rel="icon" href="../images/favicon.ico" type="image/ico" />
    <!--main css-->
    <link href="../css_web/default.css" rel="stylesheet" type="text/css" />
    <link href="https://file.myfontastic.com/JgbKu4HBhSiTuUxrtB7R5d/icons.css" rel="stylesheet">
    <link href="../css_web/component.css" rel="stylesheet" type="text/css" />
</head>

<body id="top" class="cbp-spmenu-push">
     <jsp:include page="../_IncludeJsp/User_mainNav.jsp" />
    <div class="insideTitle">
        <h2>購物車</h2>
    </div>
    <main>
        <div class="brcame"><a href="../index.jsp">首頁</a> / 購物車</div>
        <section class="content">
            <form action="cart_success.htm" method="post" class="formcontent">
                <div id="cartLeft" class="cartLeft">
                    <h3>${clickRest.rest_name}&nbsp;${clickRest.rest_branch}</h3>
                    <!--菜單列表-->
                    <c:set var="map" property="shoppingCart" value="${ShoppingCart}"/>
                    <c:forEach var="list" items="${map.listAllMap}">
                    	<div id="List${list.prod_id}"class="foodList">
<%--                     	${list.prod_id}<br> --%>
	                        <figure><img src="${pageContext.servletContext.contextPath}/_00_init/getImage?id=${list.prod_id}' alt="${list.item_name}" title="${list.item_name}">
	                        </figure>
	                        <div class="foodInfo" name="prod_${list.prod_id}${list.item_note}">
	                            <h4>${list.item_name}</h4>
	                            <input type="hidden" id="proId" value="${list.prod_id}">
	                            <p>數量 
	                            	<input type="number" name="" id="count${list.prod_id}${list.item_note}" value="${list.item_amount}" onchange="modifyAmount(${list.prod_id},'${list.item_note}')"  min="1"> 
	                            	<span class="price" >NT$${list.item_price}</span>
	                            </p>
	                            <textarea class="note" id="note${list.prod_id}${list.item_note}" placeholder="特殊需求" onchange="modifyNote(this,${list.prod_id},'${list.item_note}')">${list.item_note}</textarea>
	                        </div>
	                        <div class="closeBtn"><i  class="icon-close" title="刪除" onClick="deleteF(${list.prod_id},'${list.item_note}')"></i></div>
                	    </div>
                    </c:forEach>
                    
                    <!--菜單列表 end-->
                    <div class="total">總計：NT$${map.subtotal}元</div>
                </div>
                <div class="cartRight">
                    <h3>訂購人資訊</h3>
                    <!--訂購人資訊-->
                    <div class="formList">
                        <div class="formTitle"><i class="icon-user"></i>訂購人</div>
                        <div class="formInfo"><input type="text" name="name" id="name" value="${LoginOK.name}" class="validate[required] text-input"></div>
                    </div>
                    <div class="formList">
                        <div class="formTitle"><i class="icon-phone"></i>聯絡電話</div>
                        <div class="formInfo"><input type="text" name="tel" id="tel" value="${LoginOK.phone}" class="validate[required,custom[phone]] text-input"></div>
                    </div>
                    <div class="formList">
                        <div class="formTitle"><i class="icon-mail"></i>E-mail</div>
                        <div class="formInfo"><input type="text" name="eMail" id="eMail" value="${LoginOK.email}" class="validate[required,custom[email]] text-input"></div>
                    </div>
                    <div class="formList">
                        <div class="formTitle"><i class="icon-birth"></i>預計取餐時間</div>
                        <div class="formInfo"><input type="time" name="time" id="time" class="validate[required] text-input"></div>
                    </div>
                    <!--訂購人資訊 end-->
                    <div class="formBtn">
                        <p><a href="../indexA.jsp">繼續逛逛</a> <input name="submit" type="submit" id="submit" value="送出訂單"></p>
                    </div>
                </div>
            </form>
        </section>
    </main>
      <!--搜尋-->
   <jsp:include page="../_IncludeJsp/User_search.jsp" />  <!--搜尋 end-->
    <footer>
        <figure><img src="../images/share/logo.svg" alt="Grab &amp; Go" title="Grab &amp; Go"></figure>
        <p>Copyright © Garb and Go All rights reserved.</p><a href="#" class="backToTop">TOP</a></footer>
    <!--main js-->
    <!--[if lt IE 8]><script type="text/javascript" src="javascript/html5.js"></script><![endif]-->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
    <!--nav-->
    <script type="text/javascript" src="../javascript/classie.js"></script>
    <!-- form check-->
    <link rel="stylesheet" href="../javascript/validation/validationEngine.jquery.css">
    <script type="text/javascript" charset="utf-8" src="../javascript/validation/languages/jquery.validationEngine-zh_TW.js"></script>
    <script type="text/javascript" charset="utf-8" src="../javascript/validation/jquery.validationEngine.js"></script>
    <!-- form check end-->
    <!--share js-->
    <script src="../javascript/share.js"></script>
    <script src="../js/cartDAO.js"></script>
</body>

</html>