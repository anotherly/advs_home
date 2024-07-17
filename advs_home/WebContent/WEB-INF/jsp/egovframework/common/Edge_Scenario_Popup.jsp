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
		엣지케이스 시나리오 데이터셋
	    <a href="javascript:self.close();" class="pop_close"></a>
	</div>
	<div class="modal-body">
    	<div class="table-basic table-basic--row">
    		<div class="tab-cont__txt" style="padding-bottom:10px;"><p>사고상황, 도로파손, 낙하물 등 일반적이지 않은 주행 환경의 데이터셋</p></div>
    		<video  width="100%" controls autoplay muted loop="10">
				<source src="/image/sub/media_01.mp4" type="video/mp4">
			</video>
			<table summary="" class="table-basic table-basic--col">
				<colgroup>
					<col width="25%">
					<col width="30%">
					<col width="45%">
				</colgroup>
				<thead>
					<tr>
						<th colspan="3" class="border_l_none" style="text-align:center;">엣지케이스 시나리오 코드</th>
					</tr>
					<tr>
						<th class="border_l_none" style="text-align:center;">종류</th>
						<th class="border_l_none" style="text-align:center;">상황</th>
						<th class="border_l_none" style="text-align:center;">세부상황</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td rowspan="8">차대차</td>
						<td rowspan="4">측면충돌</td>						
						<td>좌회전 시 유도선 침범</td>						
					</tr>
					<tr>
						<td>급차선 변경</td>						
					</tr>
					<tr>
						<td>고속도록 합류 사고</td>						
					</tr>
					<tr>
						<td>딜레마 존(우회전)</td>						
					</tr>
					<tr>
						<td rowspan="2">전방충돌</td>						
						<td>좌회전 대 직진 차량</td>
					</tr>
					<tr>				
						<td>유턴사고</td>						
					</tr>
					<tr>						
						<td rowspan="2">후방충돌</td>						
						<td>회피주행</td>						
					</tr>
					<tr>						
						<td>황색신호 급제동</td>						
					</tr>
					<!-- 2 -->
					<tr>
						<td rowspan="9">차대사람</td>
						<td rowspan="5">횡단중</td>						
						<td>우회전 (추월 상황)</td>						
					</tr>
					<tr>
						<td>우회전 (좌측 차량에 의한 사각)</td>						
					</tr>
					<tr>
						<td>우회전 (주정차 차량에 의한 사각)</td>						
					</tr>
					<tr>
						<td>정지선 침범 후 후진 상황</td>						
					</tr>
					<tr>				
						<td>직진 (주정차 차량에 의한 사각)</td>
					</tr>
					<tr>						
						<td rowspan="2">차도통행중</td>						
						<td>무단횡단 (우측 차량과 차량 사이)</td>						
					</tr>
					<tr>						
						<td>무단횡단 (좌측 차량에 의한 사각)</td>						
					</tr>
					<tr>						
						<td>보도통행중</td>						
						<td>보도 통행중인 사람과 충돌</td>						
					</tr>
					<tr>						
						<td>갓길통행중</td>						
						<td>갓길 통행중인 사람과 충돌</td>						
					</tr>
					<!-- 3 -->
					<tr>
						<td rowspan="8">차량단독</td>
						<td rowspan="6">공작물충돌</td>						
						<td>차선변경 중 가드레일 충돌</td>						
					</tr>
					<tr>
						<td>교차로 진입 중 가드레일 충돌</td>						
					</tr>
					<tr>
						<td>무단횡단 보행자 회피 후 충돌</td>						
					</tr>
					<tr>
						<td>우회전 중 신호등 충돌</td>						
					</tr>
					<tr>				
						<td>낙하물 회피 후 충돌</td>
					</tr>
					<tr>				
						<td>고속도로 요금소 충돌</td>
					</tr>
					<tr>						
						<td rowspan="2">주 /정차차량충돌</td>						
						<td>이면도로 주행 중 주차 차량 충돌</td>						
					</tr>
					<tr>						
						<td>이면도로 후진 중 주차 차량 충돌</td>						
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<!-- //팝업 -->
</body>
</html>
