<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
//String user_id = (String)session.getAttribute("user_id");
//String agcy_nm = (String)session.getAttribute("agcy_nm");
//boolean login = user_id == null ? false: true;
%>
<script type="text/javascript" src="/raonkupload/js/raonkupload.js"></script>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>

<script type="text/javascript">
	var G_UploadID;
	var G_vertical = '\u000B'; // 파일 구분자
	var G_formfeed = '\u000C'; // 각 파일당 속성 구분자
	
	function addAllFiles(uploadID) {
		<c:forEach var="list" items="${videoList}" varStatus="status">
			RAONKUPLOAD.AddUploadedFile('${list.seq}', '${list.drivingVideoFile}', '/incd/${list.drivingVideoFile}', '${list.fileSize}', 'Custom Value', uploadID);			
		</c:forEach>   
	}
	
	// 생성완료 이벤트
    function RAONKUPLOAD_CreationComplete(uploadID) {
		G_UploadID = uploadID;
		addAllFiles(G_UploadID);
	}
</script>
<script type="text/javaScript" defer>
	//폼 변수
	var c_form = "";

	$(document).ready(function() {
		c_form = document.listForm; //폼 셋팅
	});
	
	function fn_goList() {
		location.href = "<c:url value='/agency/off/Agcy_Off_List.do'/>";
	}
	
	 /* 등록 화면 function */
	function fn_Add_View() {
    c_form.action = "<c:url value='/agency/off/Agcy_Off_Inst.do'/>";
    c_form.submit();
	}
	
</script>

<form:form id="listForm" name="listForm" method="post">
	<input type="hidden" name="drv_no" id="drv_no" />
	<input type="hidden" name="acc_id" id="acc_id" />
	<input type="hidden" name="file_nm" id="file_nm" />
	<input type="hidden" name="dir_nm" id="dir_nm" />

	<div class="skip">
		<a href="#container">Go to Content</a>
	</div>

	<div class="container">
		<div class="container__inner">
			<div class="content">
				<div class="content__inner">
				
					<div class="layout-container layout-full">
						<div class="layout-container__inner layout-container--row">
							<div class="lnb">
                                <h3 class="lnb__tit">데이터공유센터<br/>시설이용</h3>
                                <div class="lnb-list">
                                    <div class="lnb-item">
                                        <a href="">차량 플랫폼 공유</a>
                                        <ul class="lnb-depth--02 lists lists-cir--s">
                                            <li>
                                                <a href="/sharing/car/Car_Reserve_Main.do">안내</a>
                                            </li>
                                            <li>
                                                <a href="/sharing/car/Car_Reserve_Inst.do">예약신청</a>
                                            </li>
                                            <li>
                                                <a href="/sharing/car/Car_Reserve_List.do">예약현황 및 취소</a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="lnb-item is-active is-open">
                                        <a href="">공유센터 이용안내</a>
                                        <ul class="lnb-depth--02 lists lists-cir--s">
                                            <li>
                                                <a href="/center/fact/Center_Fact_Main.do">회의실 안내</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
							<div class="layout-content">
								<div class="layout-content__inner">
									<div class="layout-content__top">
										<h4 class="layout-content__tit">데이터공유센터 시설이용</h4>
										<ul class="location ml-auto">
											<li>
	                                           	<img src="/image/sub/icon/icon-home.png" alt="홈">
	                                        </li>
											<li>데이터공유센터 시설이용</li>
                                            <li>공유센터 이용안내</li>
                                            <li>회의실 안내</li>
										</ul>
									</div>
	
									<h5 class="layout-content__subtit">회의실 안내</h5>
									<div class="d-flex mt-20">
                                        <span class="img-wrap">
                                            <img src="/image/sub/images/img-us_fa_04--01.jpg" alt="">
                                        </span>
                                        <span class="img-wrap ml-5">
                                            <img src="/image/sub/images/img-us_fa_04--02.jpg" alt="">
                                        </span>
                                    </div>
                                    <div class="table-wrap">
                                        <table class="table-basic table-basic--col table-us_fa_04_list">
                                            <caption>데이터공유센터 시설이용 시설이용 테이블</caption>
                                            <colgroup>
                                                <col style="width:20%">
                                                <col style="width:auto">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th scope="col" colspan="2">이용안내</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <th scope="row">수용인원</th>
                                                    <td>18명</td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">구비품목</th>
                                                    <td>빔 프로젝터, 스크린, 인터넷 사용 불가</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="d-flex mt-50">
                                        <span class="img-wrap">
                                            <img src="/image/sub/images/img-us_fa_04--03.jpg" alt="">
                                        </span>
                                        <span class="img-wrap ml-5">
                                            <img src="/image/sub/images/img-us_fa_04--04.jpg" alt="">
                                        </span>
                                    </div>
                                    <div class="table-wrap">
                                        <table class="table-basic table-basic--col table-us_fa_04_list">
                                            <caption>데이터공유센터 시설이용 시설이용 테이블</caption>
                                            <colgroup>
                                                <col style="width:20%">
                                                <col style="width:auto">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th scope="col" colspan="2">이용안내</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <th scope="row">수용인원</th>
                                                    <td>16명</td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">구비품목</th>
                                                    <td>빔 프로젝터, 스크린 사용 가능<br> 인터넷 사용 불가</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
<!--                                         <div class="layout-content__view"> -->
<!--                                             <div class="el-platform"> -->
<!--                                                 <h5 class="el-platform__tit">대회의실</h5> -->
<!--                                                 <div class="el-platform__txt"> -->
<!--                                                     <strong>데이터 공유센터 내부에 마련된 회의실입니다. </strong>이런식의 안내문구가 노출됩니다.<br/> -->
<!--                                                     <strong>데이터 공유센터 내부에 마련된 회의실입니다. </strong>이런식의 안내문구가 노출됩니다. -->
<!--                                                 </div> -->
<!--                                             </div> -->
<!--                                         </div> -->
	
<!-- 									<div class="btn-wrap btn-row justify-center mt-30 mb-80"> -->
<!-- 										<button type="button" id="goToList" class="btn btn-width--l btn-color--white" onclick="fn_goList();">신청내역</button> -->
<!-- 										<button type="button" id="goToList" class="btn btn-width--l btn-color--navy" onclick="fn_Add_View();">데이터 공유 신청</button> -->
<!-- 									</div> -->
								</div>
							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	<!--  contWrap -->
	</div>
<!-- //container -->
</form:form>

<form id="excelForm" name="excelForm" method="post">
	<input type="hidden" name="drv_no" id="drv_no" />
	<input type="hidden" name="acc_id" id="acc_id" />
</form>
