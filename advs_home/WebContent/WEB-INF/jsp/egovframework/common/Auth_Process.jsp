<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="/js/common/commonFunction.js"></script> <!-- 공통 script 함수를 정의 -->

<script language="javascript">

	if('${rst_scrn}' == "cits")
	{
		fn_OpenView('/main/Main.do','${rst_auth}','${rst_user}');
	}
	else if('${rst_scrn}' == "agcy")
	{
		fn_AgcyView('/main/Main.do','${rst_auth}','${rst_user}');
	}
	else if('${rst_scrn}' == "duty")
	{
		fn_DutyView('/main/Main.do','${rst_auth}','${rst_user}');
	}
	else if('${rst_scrn}' == "dtup")
	{
		fn_DtupView('/main/Main.do','${rst_auth}','${rst_user}');
	}
	else if('${rst_scrn}' == "drvg")
	{
		alert("운행정보 등록 기간이 아닙니다.");
		location.href="/main/Main.do";
	}
	else if('${rst_scrn}' == "openapi")
	{
		alert("로그인 후 이용하세요.");
		location.href="/main/Main.do";
	}

</script>
