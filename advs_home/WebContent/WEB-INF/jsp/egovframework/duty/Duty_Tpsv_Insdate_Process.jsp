<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String insInitDate = (String) request.getAttribute("insInitDate");
	System.out.println("insInitDate : "+insInitDate);
%>
<script language="javascript">

	if('${result_insert}' == "1")
	{
		opener.fnSetInsInitDate("<%=insInitDate%>");
		alert("정상 수정 되었습니다.");
		self.close();
	}
	else
	{
		alert("처리 중 오류가 발생했습니다.");
		history.back();
	}

</script>
