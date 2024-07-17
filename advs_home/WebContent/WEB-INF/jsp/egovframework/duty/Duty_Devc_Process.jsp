<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script language="javascript">

	if('${result_insert}' == "1")
	{
		alert("등록 되었습니다.");
		location.href="/duty/device/Duty_Devc_List.do";
	}
	else if('${result_update}' == "1")
	{
		alert("수정 되었습니다.");
		location.href="/duty/device/Duty_Devc_Info.do?drv_no="+encodeURI('${drv_no}')+"&chg_id=${chg_id}";
	}
	else if('${result_delete}' == "1")
	{
		alert("삭제 되었습니다.");
		location.href="/duty/device/Duty_Devc_List.do";
	}
	else if('${result_insert}' == "ext")
	{
		alert("jsp,asp,php,html 파일은 업로드 할 수 없습니다");
		history.back();
	}
	else if('${result_update}' == "ext")
	{
		alert("jsp,asp,php,html 파일은 업로드 할 수 없습니다");
		history.back();
	}
	else
	{
		alert("처리 중 오류가 발생했습니다.");
		history.back();
	}

</script>
