<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles"				prefix="t" %>
<%--@ taglib uri="/WEB-INF/tld/c.tld"		prefix="c"	--%>
<%--@ taglib uri="/WEB-INF/tld/fn.tld"		prefix="fn"	--%>

<%
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setDateHeader("Expires",0);
	if (request.getProtocol().equals("HTTP/1.1"))
		response.setHeader("Cache-Control", "no-cache");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자율주행 데이터 공유센터입니다.</title>
<link rel="stylesheet" href="/css/avsc/style.css" type="text/css" />
<link rel="stylesheet" href="/css/avsc/main.css" type="text/css" />

<script src="/js/jquery-1.12.4.min.js"></script>
<script src="/js/common.js" type="text/javascript"></script>
<!-- ie9이하 html5 -->
<!--[if lt IE 9]>
<script src="/js/respond.min.js"></script>
<script src="/js/html5shiv.min.js"></script>
<![endif]-->
<!-- ie9이하 input text placeholder -->
<script src="/js/placeholders.min.js"></script>

<!-- 공통선언 -->
<link rel="shotcut icon" href="/favicon.ico" />
<link rel="stylesheet" href="/css/avsc/jquery-ui.css" /> <!-- jQuery 달력 CSS -->
<link rel="stylesheet" href="/css/avsc/jquery-ui.theme.css" /> <!-- jQuery 달력 CSS -->
<script src="/js/common/jquery-ui.js"></script> <!-- jQuery 달력 -->
<script src="/js/common/commonFunction.js"></script> <!-- 공통 script 함수를 정의 -->
<!-- //공통선언 -->

<script language="JavaScript" type="text/JavaScript">
<!--

//-->
</script>

</head>
<body>
	<t:insertAttribute name="header" ignore="true"></t:insertAttribute>
	<t:insertAttribute name="content" ignore="true"></t:insertAttribute>
	<t:insertAttribute name="footer" ignore="true"></t:insertAttribute>
</body>
</html>
