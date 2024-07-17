<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script language="javascript">

	if('${result_delete}' == "1")
	{
		alert("삭제 되었습니다.");
		location.href="/data/control/Data_Dtmg_List.do";
	}
	else
	{
		alert("처리 중 오류가 발생했습니다.");
		history.back();
	}

</script>
