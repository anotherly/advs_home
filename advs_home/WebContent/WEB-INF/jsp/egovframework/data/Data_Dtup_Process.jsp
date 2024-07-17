<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javaScript" defer >
	if('${result_insert}' == "1")
	{
		alert("등록 되었습니다.");
		location.href="/data/record/Data_Car_Inst.do";
	}
	else if('${result_update}' == "1")
	{
		alert("수정 되었습니다.");
// 		location.href="/data/upload/Data_Dtup_Info.do?b_seq=${b_seq}&bbs_seq=${bbs_seq}";
		location.href="/data/record/Data_Car_Updt.do";
	}
	else if('${result_delete}' == "1")
	{
		alert("삭제 되었습니다.");
		location.href="/data/record/Data_Uphs_List.do";
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
