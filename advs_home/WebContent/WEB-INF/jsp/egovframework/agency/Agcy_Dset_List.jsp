<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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

    //펼치기
    $("span[id=sp_on]").click(function() {
    	var idx = $("span[id=sp_on]").index(this);
    	$(this).hide();
    	$("tr[id=plain]:eq("+idx+")").show();
    });
    //접기
    $("span[id=sp_off]").click(function() {
    	var idx = $("span[id=sp_off]").index(this);
    	$("tr[id=plain]:eq("+idx+")").hide();
    	$("span[id=sp_on]:eq("+idx+")").show();
    });
  });

  /* 상세 화면 function 
  2022.12.14. jquery 안먹는 부분이있어 폼 변경*/
	function detail_View(bdwr, bbs) {
		c_form.bdwr_seq.value = bdwr;
		c_form.bbs_seq.value = bbs;
		c_form.action = "<c:url value='/agency/consultative/Agcy_Dset_Info.do'/>";
		c_form.submit();
	}

  /* 등록 화면 function */
	function fn_Add_View(bbs) {
    c_form.bbs_seq.value = bbs;
    c_form.action = "<c:url value='/agency/consultative/Agcy_Dset_Inst.do'/>";
    c_form.submit();
	}

	/* 목록 화면 function */
	function form_Submit() {debugger;
		if(trim(c_form.searchWord.value).length > 0){
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
				c_form.action = "<c:url value='/agency/consultative/Agcy_Dset_List.do'/>";
				c_form.submit();
			}
		}
	}

  /* pagination 페이지 링크 function */
	function go_Page(pageNo){
		c_form.iPageNo.value = pageNo;
		c_form.action = "<c:url value='/agency/consultative/Agcy_Dset_List.do'/>";
		c_form.submit();
	}

  /* 파일 다운로드  */
  function fn_Download(file_nm) {
    c_form.file_nm.value = file_nm;
    c_form.dir_nm.value = "dset";
    c_form.action = "<c:url value='/common/File_Download.do'/>";
    c_form.submit();
  }

</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="iPageNo" id="iPageNo" value="${pageSetting.currentPageNo}" />
<input type="hidden" name="bdwr_seq" id="bdwr_seq"/>
<input type="hidden" name="bbs_seq" id="bbs_seq"/>
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>
<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div class="container">
	<div class="container__inner">
		<div class="content">
			<div class="content__inner">
				<div class="layout-container layout-full">
					<div class="layout-container__inner layout-container--row">
						<!-- left 메뉴 -->
						 <div class="lnb">
						     <h3 class="lnb__tit">협의체데이터</h3>
						     <div class="lnb-list">
						         <div class="lnb-item <c:if test="${bbs_seq eq '2080'}">is-active</c:if>"><a href="/open/normal/Open_Normal_List.do?bbs_seq=2080">일반시나리오 데이터셋</a></div>
	 							<div class="lnb-item <c:if test="${bbs_seq eq '2090'}">is-active</c:if>"><a href="/open/edge/Open_Edge_List.do?bbs_seq=2090">엣지케이스 시나리오<br/>데이터셋</a></div>
	                            <div class="lnb-item <c:if test="${bbs_seq eq '2100'}">is-active</c:if>"><a href="/open/v2x/Open_V2x_List.do?bbs_seq=2100">V2X 데이터셋</a></div>
						         <div class="lnb-item"><a href="/agency/off/Agcy_Off_Main.do">오프라인 공유 <br/>안내 및 신청</a></div>
						         <div class="lnb-item is-active is-open">
						            <a href="/agency/consultative/Agcy_Dset_List.do">데이터셋(21년 이전)</a>
						            <ul class="lnb-depth--02 lists lists-cir--s">
		                                <li><a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2010">차량거동정보</a></li>
		                                <li><a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2030">센서정보</a></li>
		                                <li><a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2040">자율주행 학습정보</a></li>
		                                <li><a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2050">융합정보</a></li>
		                                <li><a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2060">V2X 정보</a></li>
		                                <li><a href="/agency/consultative/Agcy_Cons_List.do?bbs_seq=2070">기타자율주행정보</a></li>
		                                <li><a href="/agency/consultative/Agcy_Dset_List.do">데이터셋</a></li>
						            </ul>
						        </div>	
						     </div>
						 </div>
						<!--leftmenu END -->
						
						<!-- 본문	-->
						<div class="layout-content">
	                        <div class="layout-content__inner">
	                            <div class="layout-content__top">
	                                <h4 class="layout-content__tit">데이터셋(21년 이전)</h4>
	                                <ul class="location ml-auto">
	                                    <li>
	                                        <img src="/image/sub/icon/icon-home.png" alt="홈">
	                                    </li>
	                                    <li>협의체데이터</li>
	                                    <li>데이터셋(21년 이전)</li>
	                                    <li>데이터셋</li>
	                                </ul>
	                            </div>
	                            <h5 class="layout-content__subtit">데이터셋</h5>
	                            <div class="sch-area sch-area--box sch-area--gray">
	                                <div class="sch-form sch-form--row">
	                                    <form action="">
	                                        <label for="">
										        <select id="searchType" name="searchType" title="데이터셋 데이터셋 검색구분 선택">
										          <option value="0" <c:if test="${searchType eq '0' }">selected</c:if>>--선택--</option>
										          <option value="1" <c:if test="${searchType eq '1' }">selected</c:if>>제목</option>
										          <option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>내용</option>
										        </select>
	                                        </label>
	                                        <label for="">
	                                            <input type="text" name="searchWord" id="searchWord" title="검색어 입력" value="${searchWord}" placeholder="검색어를 입력해주세요." onkeyup="injectionCheck(this)"/>
	                                        </label>
	                                        <button type="button" class="btn btn--sch" title="검색" onclick="form_Submit()"></button>
	                                    </form>
	                                </div>
	                            </div>
	                            <div class="table-wrap">
	                                <div class="table-cap">
	                                    <p class="table-cap__count">
											총 <span>${pageSetting.totalRecordCount}</span> 건
	                                    </p>
	                                    <p class="table-cap__page">
											(<span>${pageSetting.currentPageNo}</span>/${pageSetting.totalPageCount} 페이지)
	                                    </p>
	                                </div>
	                                <table class="table-basic table-basic--col table-us_ag_05_07_list">
	                                    <caption>협의체데이터 &gt; 데이터셋 &gt; 데이터셋 테이블</caption>
	                                    <colgroup>
	                                        <col style="width:auto">
	                                        <col style="width:10%">
	                                        <col style="width:15%">
	                                    </colgroup>
	                                    <thead>
	                                        <tr>
	                                            <th scope="col">제목</th>
	                                            <th scope="col">첨부파일</th>
	                                            <th scope="col">등록일시</th>
	                                        </tr>
	                                    </thead>
	                                    <tbody>
								            <c:choose>
								              <c:when test="${resultList eq null || empty resultList}">
								                <tr>
								                  <td colspan="3" >등록된 정보가 없습니다</td>
								                </tr>
								              </c:when>
								              <c:otherwise>
								                <c:forEach var="list" items="${resultList}" varStatus="status">
								                  <tr>
								                    <td><a href="javascript:detail_View('${list.bdwrSeq}','${list.bbsSeq}');">${list.bdwrTtlNm}</a></td>
								                    <td>
														<button type="button" title="${list.attachFilename} 첨부파일입니다">
															<img src="/image/common/icon/icon-download.png" onclick="fn_Download('${list.attachFilename}')" alt="">
														</button>										                    
								                    </td>
								                    <td>${list.regDateView}</td>
								                  </tr>
								                </c:forEach>
								              </c:otherwise>
								            </c:choose>
	                                    </tbody>
	                                </table>
	                            </div>
	                            <div class="paging">
	                                <a href="javascript:go_Page('1');" class="page-link page-link--first">
	                                    <img src="/image/common/icon/icon-page-link--first.png" alt="">
	                                </a>
	                                <a href="javascript:go_Page('${pageSetting.prvePageNoOnPageList }');" class="page-link page-link--prev">
	                                    <img src="/image/common/icon/icon-page-link--prev.png" alt="">
	                                </a>
							          <c:forEach var="i"  begin="${pageSetting.firstPageNoOnPageList }" end="${pageSetting.lastPageNoOnPageList }">
							            <c:choose>
							              <c:when test="${pageSetting.currentPageNo eq i }">
							                <a href="javascript:void(0);" class="active">${i }</a>
							              </c:when>
							              <c:otherwise>
							                <a href="javascript:void(0);" onclick="go_Page('${i }')">${i }</a>
							               </c:otherwise>
							             </c:choose>
							          </c:forEach>
	                                
	                                <a href="javascript:go_Page('${pageSetting.nextPageNoOnPageList }');" class="page-link page-link--next">
	                                    <img src="/image/common/icon/icon-page-link--next.png" alt="">
	                                </a>
	                                <a href="javascript:go_Page('${pageSetting.totalPageCount }');" class="page-link page-link--last">
	                                    <img src="/image/common/icon/icon-page-link--last.png" alt="">
	                                </a>
	                            </div>
								<!--페이징:end -->
							</div>
						</div>						 					
						<!-- 본문:end	-->
								
								<!-- 데이터 등록 임시제거 2022.12.14 조용현 최종기능 보고 다시 원복-->
<!-- 						      <div class="right mt20"> -->
<%-- 						        <c:if test="${user_chk > 0}"> --%>
<%-- 						          <a href="javascript:fn_Add_View('${bbs_seq}');" class="btn_sky btn_md">데이터셋 정보 등록</a> --%>
<%-- 						        </c:if> --%>
<!-- 						      </div> -->

  					</div>
					<!--   					layout-container__inner layout-container--row -->
	  			</div>
				<!--   			layout-container layout-full -->
  			</div>
			<!--   			content__inner -->
  		</div>
		<!--   		content -->
  	</div>
	<!-- container__inner -->
</div>
<!-- //container -->
</form:form>