<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script language="javascript">

	if('${result_insert}' == "1")
	{
		alert("로그아웃 되었습니다.");	
		 location.href = "https://tsum.kotsa.or.kr/tsum/sso/SPLogout.jsp?logoutUrl=https://avds.kotsa.or.kr";
	}
	else
	{
		/* location.href="/main/Main.do"; */
		location.href="https://tsum.kotsa.or.kr/tsum/sso/SPLogout.jsp?logoutUrl=https://avds.kotsa.or.kr";
	}

</script>
