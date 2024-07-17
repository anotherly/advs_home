<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script language="javascript">

	if('${result_insert}' == "1")
	{
		if('${auth_id}' != "101")
		{
			window.open('/supervise/Power_Rights_Popup.do', 'eval_inst','left=200, top=100, width=500, height=385');
		}
		location.href="/main/Main.do";
	}
	else
	{
		alert("처리 중 오류가 발생했습니다.");
		history.back();
	}

</script>
