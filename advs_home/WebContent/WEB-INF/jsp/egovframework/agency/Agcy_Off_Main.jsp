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
								<h3 class="lnb__tit">협의체데이터</h3>
								<div class="lnb-list">
									<div class="lnb-item <c:if test="${bbs_seq eq '2080'}">is-active</c:if>"><a href="/open/normal/Open_Normal_List.do?bbs_seq=2080">일반시나리오 데이터셋</a></div>
									<div class="lnb-item <c:if test="${bbs_seq eq '2090'}">is-active</c:if>"><a href="/open/edge/Open_Edge_List.do?bbs_seq=2090">엣지케이스 시나리오<br/>데이터셋</a></div>
									<div class="lnb-item <c:if test="${bbs_seq eq '2100'}">is-active</c:if>"><a href="/open/v2x/Open_V2x_List.do?bbs_seq=2100">V2X 데이터셋</a></div>
									<div class="lnb-item is-active"><a href="/agency/off/Agcy_Off_Main.do">오프라인 공유 <br/>안내 및 신청</a></div>
						        	<div class="lnb-item">
							            <a href="/agency/consultative/Agcy_Dset_List.do">데이터셋(21년 이전)</a>
							            <ul class="lnb-depth--02 lists lists-cir--s">
				                            <li>
				                                <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2010">차량거동정보</a>
				                            </li>
				                            <li>
				                                <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2030">센서정보</a>
				                            </li>
				                            <li>
				                                <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2040">자율주행 학습정보</a>
				                            </li>
				                            <li>
				                                <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2050">융합정보</a>
				                            </li>
				                            <li>
				                                <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2060">V2X 정보</a>
				                            </li>
				                            <li>
				                                <a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2070">기타자율주행정보</a>
				                            </li>
				                            <li>
				                                <a href="/agency/consultative/Agcy_Dset_List.do">데이터셋</a>
				                            </li>
							            </ul>
							        </div>
							    </div>
							</div>
							<div class="layout-content">
								<div class="layout-content__inner">
									<div class="layout-content__top">
										<h4 class="layout-content__tit">오프라인 공유 안내 및 신청</h4>
										<ul class="location ml-auto">
											<li>
	                                           	<img src="/image/sub/icon/icon-home.png" alt="홈">
	                                           </li>
											<li>협의체데이터</li>
											<li>오프라인 공유 안내 및 신청</li>
										</ul>
									</div>
	
<!-- 									<h5 class="layout-content__subtit">안내</h5> -->
									<div class="layout-content__view">
                                        <div class="el-offline-wrap">
                                            <div class="el-offline__img">
                                                <img src="/image/sub/images/img-us_ag_04--img01.png" alt="">
                                            </div>
                                            <div class="el-offline__cont">
                                                <h3 class="el-offline__tit">오프라인 공유안내 및 신청</h3>
                                                <h4 class="el-offline__subtit">국내 자율주행 기술개발을 지원</h4>
                                                <p class="el-offline__txt">
                                                			  데이터공유센터에서 보유중인 자율주행 학습용 데이터를 <br/>
                                                			  위치정보가 포함된 데이터, 대용량 데이터를 필요로 하시는<br/>
                                                			  기관은 오프라인을 통한 공유를 신청할 수 있습니다.
                                                </p>
                                                <div class="btn-wrap btn-row">
                                                    <button type="button" id="goToList" class="btn btn-width--l btn-color--white" onclick="fn_goList();">신청내역</button>
                                                    <button type="button" id="goToList" class="btn btn-width--l btn-color--navy" onclick="fn_Add_View();">데이터 공유신청</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
<!-- 									<div class="layout-content__view pb80"> -->
<!--                                         <div class="el-platform"> -->
<!--                                             <h5 class="el-platform__tit">차량 플랫폼 공유</h5> -->
<!--                                             <div class="el-platform__txt"> -->
<!--                                                 <strong>차량 플랫폼 공유에 관한 설명이 노출됩니다. 차량 플랫폼 공유에 관한 설명이 노출됩니다</strong><br/> -->
<!--                                                 <strong>차량 플랫폼 공유에 관한 설명이 노출됩니다. 차량 플랫폼 공유에 관한 설명이 노출됩니다</strong> -->
<!--                                             </div> -->
<!--                                         </div> -->
<!--                                     </div> -->
	
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
