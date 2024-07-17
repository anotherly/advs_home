<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko" >
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>자율주행 데이터 공유센터입니다.</title>

<!-- <link rel="stylesheet" href="/css/avsc/style.css" type="text/css" /> -->
<link rel="stylesheet" href="/css/lib/bootstrap.min.css">
<link rel="stylesheet" href="/css/lib/bootstrap-datetimepicker.min.css">
<link rel="stylesheet" href="/css/ux-common.css">
<link rel="stylesheet" href="/css/lib/fullpage.css">
<link rel="stylesheet" href="/css/sub.css">
<link rel="stylesheet" href="/css/main.css">
<link rel="stylesheet" href="/css/us_ag.css">
<link rel="stylesheet" href="/css/us_da.css">
<link rel="stylesheet" href="/css/us_du.css">
<link rel="stylesheet" href="/css/us_od.css">
<link rel="stylesheet" href="/css/avsc/layout.css">

<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javascript" src="/js/lib/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/lib/tweenmax.min.js"></script>
<script type="text/javascript" src="/js/lib/moment.min.js"></script>
<script type="text/javascript" src="/js/lib/bootstrap.bundle.min.js"></script>
<script type="text/javascript" src="/js/lib/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/sub.js"></script>
<script type="text/javascript" src="/js/lib/fullpage.js"></script>
<!-- <script type="text/javascript" src="/js/main.js" defer=""></script> -->
<script type="text/javascript" src="/js/commonFunction.js"></script>

<script type="text/javaScript" language="javascript" defer="defer">
$(document).ready(function() {

});


</script>
</head>
<body id="pop_body">
<!-- 팝업 -->
<div class="modal-content2">
	<div class="modal-header">
		V2X 데이터셋
	    <a href="javascript:self.close();" class="pop_close"></a>
	</div>
	<div class="modal-body">
    	<div class="table-basic table-basic--row">
    		<div class="tab-cont__txt" style="padding-bottom:10px;"><p>노변 인프라 및 차대차간 통신으로부터 수집된 V2X 메시지를 포함한 데이터셋</p></div>
			<table summary="" class="table-basic table-basic--col">
				<colgroup>
					<col width="23%">
					<col width="13%">
					<col width="17%">
					<col width="17%">
					<col width="17%">
					<col width="13%">
				</colgroup>
				<thead>
					<tr>
						<th colspan="6" class="border_l_none" style="text-align:center;">시나리오 코드</th>
					</tr>
					<tr>
						<th class="border_l_none" style="text-align:center;">V2I</th>
						<th class="border_l_none" style="text-align:center;">I2V</th>
						<th class="border_l_none" style="text-align:center;">V2V</th>
						<th class="border_l_none" style="text-align:center;">V2N</th>
						<th class="border_l_none" style="text-align:center;">V2P</th>
						<th class="border_l_none" style="text-align:center;">IVN</th>
					</tr>
					<tr>
						<td class="border_l_none" style="text-align:center;">VI</td>
						<td class="border_l_none" style="text-align:center;">IV</td>
						<td class="border_l_none" style="text-align:center;">VV</td>
						<td class="border_l_none" style="text-align:center;">VN</td>
						<td class="border_l_none" style="text-align:center;">VP</td>
						<td class="border_l_none" style="text-align:center;">IVN</td>
					</tr>
					<tr>
						<th colspan="2" class="border_l_none" style="text-align:center;">장소</th>
						<th colspan="2" class="border_l_none" style="text-align:center;">세부상황</th>
						<th colspan="2" class="border_l_none" style="text-align:center;">수집데이터</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>시나리오</td>
						<td>코드</td>						
						<td>시나리오</td>						
						<td>코드</td>						
						<td>데이터</td>						
						<td>코드</td>						
					</tr>
					<tr>
						<td rowspan="4">일반도로</td>
						<td rowspan="4">NO</td>						
						<td>급커브</td>						
						<td>CRV</td>						
						<td>BSM_GPS</td>						
						<td>BSM</td>						
					</tr>
					<tr>
						<td>급정거</td>						
						<td>EST</td>						
						<td>BSM_NO_GPS</td>						
						<td>BSN</td>
												
					</tr>
					<tr>
						<td>차선변경</td>						
						<td>LNC</td>						
						<td>PVD</td>						
						<td>PVD</td>	
					</tr>
					<tr>
						<td>우합류</td>						
						<td>CFL</td>						
						<td>SPaT</td>						
						<td>SPT</td>	
					</tr>
					<tr>
						<td rowspan="4">고속도로</td>
						<td rowspan="4">HI</td>						
						<td>급커브</td>						
						<td>CRV</td>
						<td>GPS</td>						
						<td>GPS</td>
					</tr>
					<tr>
						<td>급정거</td>						
						<td>EST</td>
						<td>MAP</td>						
						<td>MAP</td>
					</tr>
					<tr>						
						<td>차선변경</td>						
						<td>LNC</td>
						<td colspan="2"></td>
					</tr>
					<tr>						
						<td>우합류</td>						
						<td>CFL</td>
						<td rowspan="13" colspan="2"></td>
					</tr>
					<tr>
						<td rowspan="7">일반교차로</td>
						<td rowspan="7">IN</td>						
						<td>교차로 진입</td>						
						<td>INI</td>
					</tr>
					<tr>
						<td>직진</td>						
						<td>GST</td>
					</tr>
					<tr>
						<td>우회전</td>						
						<td>TRR</td>
					</tr>
					<tr>
						<td>유턴</td>						
						<td>UTR</td>
					</tr>
					<tr>
						<td>좌회전</td>						
						<td>TRL</td>
					</tr>
					<tr>
						<td>급정거</td>						
						<td>EST</td>
					</tr>
					<tr>
						<td>비보호 좌회전</td>						
						<td>NTL</td>
					</tr>
					<tr>
						<td rowspan="2">회전교차로</td>						
						<td rowspan="2">RO</td>
						<td>교차로 진입</td>
						<td>INI</td>
					</tr>
					<tr>
						<td>급정거</td>						
						<td>EST</td>
					</tr>
					<tr>
						<td rowspan="2">터널</td>						
						<td rowspan="2">TA</td>
						<td>급정거</td>
						<td>LNC</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<!-- //팝업 -->
</body>
</html>
