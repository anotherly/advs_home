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

	/* 수정 function */
	function fn_Update(no, id) {
		if (confirm("등록된 정보를 수정 하시겠습니까?")) {
			c_form.drv_no.value = no;
			c_form.acc_id.value = id;
			c_form.action = "<c:url value='/duty/incident/Duty_Incd_Updt.do'/>";
			c_form.submit();
		}
	}

	/* 삭제 function */
	function fn_Delete(no, id) {
		if (confirm("정말 삭제 하시겠습니까?")) {
			c_form.drv_no.value = no;
			c_form.acc_id.value = id;
			if (confirm("등록된 사고 상세정보가 모두 삭제 됩니다")) {
				c_form.action = "<c:url value='/duty/incident/Duty_Incd_Delt_Process.do'/>";
				c_form.submit();
			}
		}
	}

	function fn_goList() {
		location.href = "<c:url value='/center/share/Center_Share_List.do'/>";
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
                                    <div class="lnb-item is-active is-open">
                                        <a href="">차량 플랫폼 공유</a>
                                        <ul class="lnb-depth--02 lists lists-cir--s">
                                            <li>
                                                <a href="/center/share/Center_Share_Main.do">안내</a>
                                            </li>
                                            <li>
                                                <a href="/center/share/Center_Share_Inst.do">예약신청</a>
                                            </li>
                                            <li>
                                                <a href="/center/share/Center_Share_List.do">예약현황 및 취소</a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="lnb-item">
                                        <a href="">공유센터 이용안내</a>
                                        <ul class="lnb-depth--02 lists lists-cir--s">
                                            <li>
                                                <a href="">회의실 안내</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
							<div class="layout-content">
								<div class="layout-content__inner">
									<div class="layout-content__top">
										<h4 class="layout-content__tit">차량 플랫폼 공유</h4>
										<ul class="location ml-auto">
											<li>
	                                           	<img src="/image/sub/icon/icon-home.png" alt="홈">
	                                           </li>
											<li>데이터공유센터 시설이용</li>
                                            <li>차량 플랫폼 공유</li>
                                            <li>예약신청</li>
										</ul>
									</div>
									<h5 class="layout-content__subtit">예약신청</h5>
									<div class="table-wrap">
	                                    <table class="table-basic table-basic--row">
	                                        <caption>데이터공유센터 시설이용 &gt; 차량 플랫폼 공유 &gt; 예약신청 테이블</caption>
	                                        <colgroup>
                                                <col style="width:18%">
                                                <col style="width:auto">
                                            </colgroup>
	                                        <tbody>
	                                        	<tr>
	                                                <th scope="row">
	                                                   	 기업체
	                                                </th>
	                                                <td>
	                                                	자동차안전연구원
	                                                </td>
	                                            </tr>
                                                <tr>
	                                                <th scope="row">
	                                                	날짜 선택
	                                                </th>
	                                                <td>
	                                                	2022-01-10
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <th scope="row">
	                                                	시간 선택
	                                                </th>
	                                                <td colspan="3">
	                                                	종일
	                                                </td>
	                                            </tr>
	                                            <tr>
	                                                <th scope="row">
	                                                    차량 정보
	                                                </th>
	                                                <td>
	                                                    ADVS-001
	
	                                                </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">
                                                        비고
                                                    </th>
                                                    <td>
                                                        예약날짜 변경될 수 있으니 참고부탁드립니다.<br/>
                                                        변경 시 취소 후 다시 예약하도록 하겠습니다
                                                    </td>
                                                </tr>
	                                        </tbody>
	                                    </table>
	                                </div>
	                                
									<div class="btn-wrap btn-row justify-center mt-30 mb-80">
										<button type="button" onclick="fn_goList();" class="btn btn-width--l btn-color--white">취소</button> 
										<button type="button" onclick="javascript:fn_Delete('${drv_no}','${acc_id}');" id="goToList" class="btn btn-width--l btn-color--navy">예약신청</button>
									</div>
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
