<%@page import="com.clipsoft.clipreport.oof.OOFFile"%>
<%@page import="com.clipsoft.clipreport.oof.OOFDocument"%>
<%@page import="java.io.File"%>
<%@page import="com.clipsoft.clipreport.server.service.ReportUtil"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="Property.jsp"%>
<%
String rptname = request.getParameter("rptname");
System.out.println("sdafsdafsdaf");

OOFDocument oof = OOFDocument.newOOF();
OOFFile file = oof.addFile("crf", "/Share1/crf/"+rptname+".crfe");

if(rptname.equals("driveReport")){
	oof.addConnectionData("*", "MySQL");
}
String[] names = {"rptname"};
java.util.Enumeration e = request.getParameterNames();

while(e.hasMoreElements()){
	String name =  e.nextElement().toString();
	
	for(String n : names) {
		if(name.indexOf(n)>-1)
			continue; 
	}
	oof.addField(name, request.getParameter(name));  
}



%>
<%
//세션을 활용하여 리포트키들을 관리하지 않는 옵션
//request.getSession().setAttribute("ClipReport-SessionList-Allow", false);
/* String resultKey =  ReportUtil.createReport(request, oof, "false", "false", request.getRemoteAddr(), propertyPath); */
String resultKey =  ReportUtil.createEForm(request, oof, "false", "false", request.getRemoteAddr(), propertyPath);
//리포트의 특정 사용자 ID를 부여합니다.
//clipreport4.properties 의 useuserid 옵션이 true 일 때만 적용됩니다. 
//clipreport4.properties 의 useuserid 옵션이 true 이고 기본 예제[String resultKey =  ReportUtil.createReport(request, oof, "false", "false", request.getRemoteAddr(), propertyPath);] 사용 했을 때 세션ID가 userID로 사용 됩니다.
//String resultKey =  ReportUtil.createReport(request, oof, "false", "false", request.getRemoteAddr(), propertyPath, "userID");

//리포트key의 사용자문자열을 추가합니다.(문자숫자만 가능합니다.)
//String resultKey =  ReportUtil.createReport(request, oof, "false", "false", request.getRemoteAddr(), propertyPath, "", "usetKey");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>EForm</title>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
<!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
<!-- <link rel="stylesheet" type="text/css" href="./css/clipreport.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./css/UserConfig.css"> -->
<!-- <link rel="stylesheet" type="text/css" href="./css/font.css"> -->
<!-- <script type='text/javascript' src='./js/jquery-1.11.1.js'></script> -->
<!-- <script type='text/javascript' src='./js/clipreport.js'></script> -->
<!-- <script type='text/javascript' src='./js/UserConfig.js'></script> -->
<!-- <script type='text/javascript'> -->
<meta name="viewport" content="width=800, user-scalable=no">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" type="text/css" href="./css/clipreport.css">
<link rel="stylesheet" type="text/css" href="./css/eform.css">
<link rel="stylesheet" type="text/css" href="./css/UserConfig.css">
<link rel="stylesheet" type="text/css" href="./css/font.css">
<script type='text/javascript' src='./js/jquery-1.11.1.js'></script>
<script type='text/javascript' src='./js/clipreport.js?ver=1.0'></script>
<script type='text/javascript' src='./js/UserConfig.js'></script>
<script type='text/javascript' src='popup.js'></script>
<script type='text/javascript'>
alert("start");
var urlPath = document.location.protocol + "//" + document.location.host;
var eform = "";	

function html2xml(divPath){	
    var eformkey = "<%=resultKey%>";
	//var report = createImportJSPReport(urlPath + "/ClipReport4/Clip.jsp?a=1", reportkey, document.getElementById(divPath));
		//var report = createImportJSPEForm(urlPath + "/ClipReport4/Clip.jsp", eformkey, document.getElementById(divPath));
// 		var eform = createImportJSPEForm(urlPath + "/ClipReport4/Clip.jsp", eformkey, document.getElementById(divPath));
	eform = createImportJSPEForm("./Clip.jsp", eformkey, document.getElementById(divPath));
	
	eform.setEndSaveButtonEvent(function(){ 
		exportForPartPDF();
	    //alert("Save Button Click");
		//저장 로직이들어가는 부분

		//!중요: 선언한 함수안에 return 값이 true | false 따라 뷰어의 기본동작이 활성화 됩니다.
	    return true;
	 });
	//report.setClientPaintView(true);
   
	//popup.js에 있는 popupCall() 호출
	eform.setEndReportEvent(function(){ 
		popupCall();
	});
	
	//리포트 실행
    eform.view();
    //report.setSaveDirectExcelOption("report",2,true,false,true,false,100,100,10,1,100,false,false,false);
    
   
	
}

function exportForPartPDF() {
	var reportForm = document.createElement('form');
    reportForm.name = 'newForm';
    reportForm.method = 'post';
    reportForm.action = 'exportForPartPDF.jsp';
    reportForm.target = '_blank';
   
    var input1 = document.createElement('input');
    input1.setAttribute("type", "hidden");
    input1.setAttribute("name", "report_key");
    input1.setAttribute("value", eform.getReportKey());
   
    reportForm.appendChild(input1);
   
    document.body.appendChild(reportForm);
    reportForm.submit();
}
</script>
</head>
<body onload="html2xml('targetDiv1')">
<div id='targetDiv1' style='position:absolute;top:5px;left:5px;right:5px;bottom:5px;'></div>
</body>
</html>

