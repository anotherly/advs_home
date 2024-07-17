<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script language="javascript">

	if('${result_insert}' == "1")
	{
		alert("OpenAPI 신청 되었습니다.");
		location.href="/openapi/OpenAPI_Apply.do";
	}
	else if('${result_insert}' == "dupp")
	{
		alert("이미 신청한 내역이 있습니다.");
		location.href="/openapi/OpenAPI_Apply.do";
	}	
	else if('${result_update}' == "1")
	{
		alert("OpenAPI 수정 되었습니다.");
		location.href="/openapi/OpenAPI_Apply.do";
	}
	else if('${result_delete}' == "1")
	{
		alert("OpenAPI 신청 취소 되었습니다.");
		location.href="/openapi/OpenAPI_Apply.do";
	}
	else
	{
		alert("처리 중 오류가 발생했습니다.");
		history.back();
	}

</script>
