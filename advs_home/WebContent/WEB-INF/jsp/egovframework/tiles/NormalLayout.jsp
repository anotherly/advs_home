<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles"				prefix="t" %>

<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	if (request.getProtocol().equals("HTTP/1.1")){
	        response.setHeader("Cache-Control", "no-cache");
	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자율주행 데이터 공유센터입니다.</title>

<!-- <script src="/js/common/commonFunction.js"></script>as-is 공통 script 함수를 정의 -->
<!--새로 정의 -->
<!-- <link rel="stylesheet" href="/css/lib/bootstrap.min.css" > -->
<link rel="stylesheet" href="/css/lib/bootstrap-datetimepicker.min.css" >
<link rel="stylesheet" href="/css/ux-common.css" >
<link rel="stylesheet" href="/css/lib/fullpage.css" >
<link rel="stylesheet" href="/css/sub.css" >
<link rel="stylesheet" href="/css/main.css" >
<link rel="stylesheet" href="/css/us_ag.css" >
<link rel="stylesheet" href="/css/us_da.css" >
<link rel="stylesheet" href="/css/us_du.css" >
<link rel="stylesheet" href="/css/us_od.css" >
<link rel="stylesheet" href="/css/us_fa.css">
<link rel="stylesheet" href="/css/us_ce.css">
<link rel="stylesheet" href="/css/fix.css">
<link rel="stylesheet" href="/css/avsc/layout.css" >



</head>
<body>
 	<t:insertAttribute name="header" ignore="true"></t:insertAttribute>
	<t:insertAttribute name="content" ignore="true"></t:insertAttribute>
 	<t:insertAttribute name="footer" ignore="true"></t:insertAttribute> 
	

<!-- //공통선언 -->
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="/js/lib/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/lib/tweenmax.min.js"></script>
<script type="text/javascript" src="/js/lib/moment.min.js"></script>
<script type="text/javascript" src="/js/lib/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="/js/lib/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/sub.js"></script>
<script type="text/javascript" src="/js/lib/fullpage.js"></script>
<script type="text/javascript" src="/js/main.js" defer></script>
<script type="text/javascript" src="/js/commonFunction.js"></script>
</body>
</html>
