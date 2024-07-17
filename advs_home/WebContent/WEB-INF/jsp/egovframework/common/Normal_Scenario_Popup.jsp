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
		일반시나리오 데이터셋
	    <a href="javascript:self.close();" class="pop_close"></a>
	</div>
	<div class="modal-body">
    	<div class="table-basic table-basic--row">
    		<div class="tab-cont__txt" style="padding-bottom:10px;"><p>일반적인 주행 환경에서 취득한 데이터를 시간, 도로상황, 날씨에 따라 분류한</p> <br><p>자율주행 학습용 데이터셋</p></div>
			<table summary="" class="table-basic table-basic--col">
				<colgroup>
					<col width="33%">
					<col width="33%">
					<col width="33%">
				</colgroup>
				<thead>
					<th class="border_l_none" style="text-align:center;">시간</th>
					<th class="border_l_none" style="text-align:center;">도로/상황</th>
					<th class="border_l_none" style="text-align:center;">날씨</th>
				</thead>
				<tbody>
					<tr>
						<td style="text-align:center;">주간</td>						
						<td style="text-align:center;">고속도로</td>						
						<td style="text-align:center;">맑음</td>						
					</tr>
					<tr>
						<td style="text-align:center;">일출일몰</td>						
						<td style="text-align:center;">일반도로</td>						
						<td style="text-align:center;">흐림</td>						
					</tr>
					<tr>
						<td style="text-align:center;">야간</td>						
						<td style="text-align:center;">지방도로</td>						
						<td style="text-align:center;">비</td>						
					</tr>
					<tr>
						<td rowspan="4"></td>						
						<td style="text-align:center;">이면도로</td>						
						<td style="text-align:center;">안개</td>						
					</tr>
					<tr>						
						<td style="text-align:center;">터널</td>						
						<td style="text-align:center;">눈</td>						
					</tr>
					<tr>						
						<td style="text-align:center;">낙하물</td>						
						<td style="text-align:center;">맑음흐림</td>						
					</tr>
					<tr>						
						<td></td>						
						<td style="text-align:center;">비안개눈</td>						
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<!-- //팝업 -->
</body>
</html>
