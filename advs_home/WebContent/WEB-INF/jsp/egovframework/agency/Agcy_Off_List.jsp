<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
//String user_id = (String)session.getAttribute("user_id");
//String agcy_nm = (String)session.getAttribute("agcy_nm");
//boolean login = user_id == null ? false: true;
%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" defer>
	//폼 변수
	var c_form = "";

	$(document).ready(function() {
		c_form = document.listForm; //폼 셋팅
	});
	
	/* 상세 화면 function */
	function detail_View(docSeq) {debugger;
	    c_form.docSeq.value = docSeq;
		c_form.action = "<c:url value='/agency/off/Agcy_Off_Info.do'/>";
		c_form.submit();
	}

	function fn_goList() {
		location.href = "<c:url value='/agency/off/Agcy_Off_List.do'/>";
	}
	
	/* 조회버튼 클릭 */
	function form_Submit() {debugger;

	    if(trim(c_form.searchWord.value).length == 0 ) {
	      alert("검색조건을 하나이상 선택해주세요");
	      return;
	    }else {
	      if(trim(c_form.searchWord.value).length > 0) {
	        var sel = $("#searchType option:selected").val();
	        if(sel == 0) {
	          alert("검색대상을 선택해주세요");
	          c_form.searchType.focus();
	          return;
	        } else {
	          if(trim(c_form.searchWord.value).length==0){
	            alert("검색어를 입력해주세요");
	            c_form.searchWord.value="";
	            c_form.searchWord.focus();
	            return;
	          }
	          if(trim(c_form.searchWord.value).length < 2){
	            alert("검색어는 2글자 이상 입력해주세요");
	            c_form.searchWord.focus();
	            return;
	          }
	        }
	      }
	      
	      c_form.action = "<c:url value='/agency/off/Agcy_Off_List.do'/>";
	      c_form.submit();
	    }
	}	
	 /* pagination 페이지 링크 function */
	function go_Page(pageNo){
		c_form.iPageNo.value = pageNo;
    c_form.action = "<c:url value='/agency/off/Agcy_Off_List.do'/>";
		c_form.submit();
	}
</script>

<form:form id="listForm" name="listForm" method="post">
	<input type="hidden" name="iPageNo" id="iPageNo" value="${pageSetting.currentPageNo}" />
	<input type="hidden" name="drv_no" id="drv_no" />
	<input type="hidden" name="acc_id" id="acc_id" />
	<input type="hidden" name="file_nm" id="file_nm" />
	<input type="hidden" name="dir_nm" id="dir_nm" />
	<input type="hidden" name="docSeq" id="docSeq" value="${docSeq}" />
<!-- 	<input type="hidden" name="searchWord" id="searchWord"/> -->
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
									<div
										class="lnb-item <c:if test="${bbs_seq eq '2080'}">is-active</c:if>">
										<a href="/open/normal/Open_Normal_List.do?bbs_seq=2080">일반시나리오
											데이터셋</a>
									</div>
									<div
										class="lnb-item <c:if test="${bbs_seq eq '2090'}">is-active</c:if>">
										<a href="/open/edge/Open_Edge_List.do?bbs_seq=2090">엣지케이스
											시나리오<br />데이터셋
										</a>
									</div>
									<div
										class="lnb-item <c:if test="${bbs_seq eq '2100'}">is-active</c:if>">
										<a href="/open/v2x/Open_V2x_List.do?bbs_seq=2100">V2X 데이터셋</a>
									</div>
									<%-- 								<div class="lnb-item <c:if test="${bbs_seq eq '2110'}">is-active</c:if>"><a href="/open/off/Open_Off_Info.do?bbs_seq=2110">V2X 데이터셋</a></div> --%>
									<div class="lnb-item is-active">
										<a href="/agency/off/Agcy_Off_Main.do">오프라인 공유 <br />안내 및
											신청
										</a>
									</div>
									<div class="lnb-item">
										<a href="/agency/consultative/Agcy_Dset_List.do">데이터셋(21년 이전)</a>
										<ul class="lnb-depth--02 lists lists-cir--s">
											<li><a
												href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2010">차량거동정보</a>
											</li>
											<li><a
												href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2030">센서정보</a>
											</li>
											<li><a
												href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2040">자율주행
													학습정보</a></li>
											<li><a
												href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2050">융합정보</a>
											</li>
											<li><a
												href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2060">V2X
													정보</a></li>
											<li><a
												href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2070">기타자율주행정보</a>
											</li>
											<li><a href="/agency/consultative/Agcy_Dset_List.do">데이터셋</a>
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
											<li><img src="/image/sub/icon/icon-home.png" alt="홈">
											</li>
											<li>협의체데이터</li>
											<li>오프라인 공유 안내 및 신청</li>
										</ul>
									</div>
									<div class="sch-area sch-area--box sch-area--gray">
										<div class="sch-form sch-form--row">
											<form action="">
												<label for=""> <select name="searchType"
													id="searchType" title="운행정보보고 교통사고 구분항목 선택">
														<option value="0"
															<c:if test="${searchType eq '0' }">selected</c:if>>전체</option>
														<option value="1"
															<c:if test="${searchType eq '1' }">selected</c:if>>제목</option>
														<option value="2"
															<c:if test="${searchType eq '2' }">selected</c:if>>내용</option>
												</select>
												</label> <label for=""> <input type="text"
													placeholder="검색어를 입력해 주세요." class="w250px" id="searchWord"
													name="searchWord" value="${searchWord}"
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
										<table
											class="table-basic table-basic--col table-us_du_01_list">
											<caption>공공데이터 &gt; 일반시나리오 데이터셋 테이블</caption>
											<colgroup>
												<col style="width: 8%">
												<col style="width: auto">
												<col style="width: 18%">
												<col style="width: 18%">
												<col style="width: 18%">
											</colgroup>
											<thead>
												<tr>
													<th scope="col">번호</th>
													<th scope="col">공유 데이터 제목</th>
													<th scope="col">희망 방문일시</th>
													<th scope="col">신청일자</th>
													<th scope="col">신청기관</th>
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
														<c:forEach var="list" items="${resultList}"
															varStatus="status">
															<tr onClick="javascript:detail_View('${list.docSeq}');" style="cursor: pointer;">
																<td>${list.listcnt}</td>
																<td>${list.docTit}</td>
																<td>${list.dsrVstDt}</td>
																<td>${list.appcntDt}</td>
																<td>${list.reqOrg}</td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
									</div>
									<c:if test="${fn:length(resultList) > 0 }">
		                                <div class="page-wrap">
		                                    <div class="paging">
		                                        <a href="javascript:go_Page('1');" class="page-link page-link--first" title="처음으로">
		                                            <img src="/image/common/icon/icon-page-link--first.png" alt="">
		                                        </a>
		                                        <a href="javascript:go_Page('${pageSetting.prvePageNoOnPageList }');" class="page-link page-link--prev"  title="이전">
		                                            <img src="/image/common/icon/icon-page-link--prev.png" alt="">
		                                        </a>
		                                        <c:forEach var="i"  begin="${pageSetting.firstPageNoOnPageList }" end="${pageSetting.lastPageNoOnPageList }">
										            <c:choose>
										              <c:when test="${pageSetting.currentPageNo eq i }">
										                <a href="javascript:void(0);" class="active"  title="선택됨">${i }</a>
										              </c:when>
										              <c:otherwise>
										                <a href="javascript:void(0);" onclick="go_Page('${i }')">${i }</a>
										               </c:otherwise>
										             </c:choose>
										          </c:forEach>
		                                        <a href="javascript:go_Page('${pageSetting.nextPageNoOnPageList }');" class="page-link page-link--next" title="다음">
		                                            <img src="/image/common/icon/icon-page-link--next.png" alt="">
		                                        </a>
		                                        <a href="javascript:go_Page('${pageSetting.totalPageCount }');" class="page-link page-link--last" title="맨끝으로">
		                                            <img src="/image/common/icon/icon-page-link--last.png" alt="">
		                                        </a>
		                                    </div>
		                                </div>
									</c:if>

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
