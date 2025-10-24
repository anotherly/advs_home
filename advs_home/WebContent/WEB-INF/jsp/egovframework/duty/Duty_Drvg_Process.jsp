<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script language="javascript">
	if ('${result_insert}' == "1") {
		alert("제어권전환 상세 ${result_ctrchng} 건을 포함한 정보가 등록 되었습니다.");
		location.href = "/duty/driving/Duty_Drvg_List.do";
	} else if ('${result_insert}' == "2") {
		alert("입력한 월별 제어권 전환 횟수와 엑셀의 제어권전환 횟수가 일치하지 않습니다. \n엑셀을 확인 바랍니다.");
		location.href = "/duty/driving/Duty_Drvg_List.do";
	} else if ('${result_insert}' == "3") {
		alert("입력한 월별 제어권 전환 횟수와 엑셀의 제어권전환 횟수가 일치하지 않습니다. \n엑셀을 확인 바랍니다.");
		location.href = "/duty/driving/Duty_Drvg_List.do";
	} else if ('${result_insert}' == "DuplicateKeyException") {
		alert("기준일에 이미 등록된 보고서가 있습니다. \n기준일자를 확인 바랍니다.");
		location.href = "/duty/driving/Duty_Drvg_List.do";
	} else if ('${result_update}' == "1") {
		alert("제어권전환 상세 ${result_ctrchng} 건을 포함한 정보가 수정 되었습니다.");
		//alert("운행정보가 수정 되었습니다.");
		location.href = "/duty/driving/Duty_Drvg_Info.do?drv_no=" + encodeURI('${drv_no}') + "&std_dt=${std_dt}";
	} else if ('${result_delete}' == "1") {
		alert("삭제 되었습니다.");
		location.href = "/duty/driving/Duty_Drvg_List.do";
	} else if ('${result_update}' == "3") {
		alert("운행정보가 등록 되었습니다. \n 제어권 전환 정보 상세 ${result_ctrchng} 째 줄에서 에러가 발생했습니다. \n엑셀을 확인 바랍니다.");
		location.href = "/duty/driving/Duty_Drvg_List.do";
	} else {
		alert("제어권 전환 상세  ${result_ctrchng}건 입력 중 에러가 발생했습니다. \n엑셀을 확인해 주세요.");
		location.href = "/duty/driving/Duty_Drvg_List.do";
	}
</script>
