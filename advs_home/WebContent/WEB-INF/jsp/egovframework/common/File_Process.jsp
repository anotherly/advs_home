<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script language="javascript">

	if('${result}' == "1")
	{
		alert("등록 되었습니다.");
		history.back();
	}
	else if('${result}' == "2")
	{
		alert('파일이 존재하지 않습니다');
		history.back();
	}
	else if('${result}' == "3")
	{
		alert("다운로드 이력등록 처리중 오류가 발생했습니다.");
		history.back();
	}
	else
	{
		alert("처리 중 오류가 발생했습니다.");
		history.back();
	}

</script>
