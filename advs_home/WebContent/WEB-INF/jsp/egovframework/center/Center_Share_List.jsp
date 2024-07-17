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
		RAONKUPLOAD.AddUploadedFile('${list.seq}', '${list.drivingVideoFile}',
				'/incd/${list.drivingVideoFile}', '${list.fileSize}',
				'Custom Value', uploadID);
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
	
	/* 상세 화면 function */
	function detail_View() {
		c_form.action = "<c:url value='/center/share/Center_Share_Info.do'/>";
		c_form.submit();
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
                                                <a href="/center/fact/Center_Fact_Main.do">회의실 안내</a>
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
											<li><img src="/image/sub/icon/icon-home.png" alt="홈"></li>
											<li>데이터공유센터 시설이용</li>
                                            <li>차량 플랫폼 공유</li>
                                            <li>예약현황 및 취소</li>
										</ul>
									</div>
									<h5 class="layout-content__subtit">예약현황 및 취소</h5>
									<div class="sch-area sch-area--box sch-area--gray">
										<div class="sch-form sch-form--row">
											<form action="">
												<label for=""> 
													<select name="searchType"
														id="searchType" title="차량 플랫폼 공유 예약현황 및 취소 구분항목 선택">
<!-- 															<option value="0" -->
<%-- 																<c:if test="${searchType eq '0' }">selected</c:if>>전체</option> --%>
<!-- 															<option value="1" -->
<%-- 																<c:if test="${searchType eq '1' }">selected</c:if>>제목</option> --%>
<!-- 															<option value="2" -->
<%-- 																<c:if test="${searchType eq '2' }">selected</c:if>>내용</option> --%>
														<option>전체</option>
													</select>
												</label> 
												<label for=""> 
													<input type="text"
													placeholder="검색어를 입력해 주세요." class="w250px" id="searchWord"
													name="searchWord" value="${searchWord }"
													onkeyup="injectionCheck(this)" />
												</label>
												<button type="button" class="btn btn--sch"
													onclick="javascript:form_Submit()" title="검색"></button>
											</form>
										</div>
									</div>
									<div class="table-wrap">
										<div class="table-cap">
											<p class="table-cap__count">
												총 <span>${pageSetting.totalRecordCount}</span> 건
											</p>
											<p class="table-cap__page">
												페이지 <span>${pageSetting.currentPageNo}</span>/${pageSetting.totalPageCount}
											</p>
										</div>
										<table class="table-basic table-basic--col table-us_fa_03_list">
											<caption>자율주행최신동향 &gt; 공지사항 테이블</caption>
                                            <colgroup>
                                                <col style="width:7%">
                                                <col style="width:auto">
                                                <col style="width:17%">
                                                <col style="width:17%">
                                                <col style="width:17%">
                                                <col style="width:7%">
                                                <col style="width:15%">
                                            </colgroup>
											<thead>
                                                <tr>
                                                    <th scope="col">번호</th>
                                                    <th scope="col">대여차량</th>
                                                    <th scope="col">신청기관</th>
                                                    <th scope="col">신청일자</th>
                                                    <th scope="col">예약일자</th>
                                                    <th scope="col">첨부파일</th>
                                                    <th scope="col">상태</th>
                                                </tr>
                                            </thead>
											<tbody>
												<c:choose>
													<c:when test="${resultList eq null || empty resultList}">
														<tr>
															<td colspan="5">등록된 정보가 없습니다</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach var="list" items="${resultList}" varStatus="status">
															<tr onClick="javascript:detail_View();"
																style="cursor: pointer;">
																<td>${list.listcnt}</td>
																<td>ADVS-001</td>
																<td>자율주행차</td>
																<td>${list.regDateView}</td>
																<td>${list.regDateView}</td>
																<td>
		                                                            <button type="button" title="첨부파일 다운로드">
		                                                                <img src="/image/common/icon/icon-download.png" alt="">
		                                                            </button>
		                                                        </td>
																<td>
																	<button type="button" class="btn btn-height--s btn-color--caution">예약취소</button>
		                                                      	</td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
									</div>
									<div class="paging">
										<a href="javascript:go_Page('1');"
											class="page-link page-link--first"> <img
											src="/image/common/icon/icon-page-link--first.png" alt="">
										</a> <a
											href="javascript:go_Page('${pageSetting.prvePageNoOnPageList }');"
											class="page-link page-link--prev"> <img
											src="/image/common/icon/icon-page-link--prev.png" alt="">
										</a>
										<c:forEach var="i"
											begin="${pageSetting.firstPageNoOnPageList }"
											end="${pageSetting.lastPageNoOnPageList }">
											<c:choose>
												<c:when test="${pageSetting.currentPageNo eq i }">
													<a href="javascript:void(0);" class="active">${i }</a>
												</c:when>
												<c:otherwise>
													<a href="javascript:void(0);" onclick="go_Page('${i }')">${i }</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<%--                                             <a class="active" href="javascript:go_Page('${pageSetting.nextPageNoOnPageList }');" title="다음"></a> --%>
										<%--           									<a class="active" href="javascript:go_Page('${pageSetting.totalPageCount }');" title="맨끝으로"></a> --%>
										<a
											href="javascript:go_Page('${pageSetting.nextPageNoOnPageList }');"
											class="page-link page-link--next"> <img
											src="/image/common/icon/icon-page-link--next.png" alt="">
										</a> <a
											href="javascript:go_Page('${pageSetting.totalPageCount }');"
											class="page-link page-link--last"> <img
											src="/image/common/icon/icon-page-link--last.png" alt="">
										</a>
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
	<input type="hidden" name="drv_no" id="drv_no" /> <input type="hidden"
		name="acc_id" id="acc_id" />
</form>
