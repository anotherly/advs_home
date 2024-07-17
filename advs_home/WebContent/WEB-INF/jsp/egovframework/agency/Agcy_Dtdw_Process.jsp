<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script language="javascript">

	if('${result_insert}' == "1")
	{
		alert("정상 요청 되었습니다.");
		//opener.location.href="/agency/consultative/Agcy_Cons_List.do";
		self.close();
	}
	else
	{
		alert("처리 중 오류가 발생했습니다.");
		history.back();
	}

</script>
