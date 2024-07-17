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
  });

  /* 상세 화면 function */
	function detail_View(no, id) {
    c_form.drv_no.value = no;
    c_form.acc_id.value = id;
    c_form.action = "<c:url value='/duty/incident/Duty_Incd_Info.do'/>";
    c_form.submit();
	}

  /* 등록 화면 function */
	function fn_Add_View() {
    c_form.action = "<c:url value='/duty/incident/Duty_Incd_Inst.do'/>";
    c_form.submit();
	}

	/* 목록 화면 function */
	function form_Submit() {
		if(trim(c_form.searchWord.value).length > 0){
			var sel = $("#searchType option:selected").val();
			if(sel == 0) {
				alert("검색대상을 선택해 주세요");
				c_form.searchType.focus();
				return;
			} else {
				if(trim(c_form.searchWord.value).length==0){
					alert("검색어를 입력해 주세요");
					c_form.searchWord.value="";
					c_form.searchWord.focus();
					return;
				}
				c_form.action = "<c:url value='/duty/incident/Duty_Incd_List.do'/>";
				c_form.submit();
			}
		}
	}

  /* 임시운행등록번호 팝업 화면 function */
  function fn_Add_Popup() {
    window.open('/common/Duty_Tpsv_Popup.do', 'tpsv_inst','left=200, top=100, width=700, height=392, scrollbars=no');
  }

  /* pagination 페이지 링크 function */
	function go_Page(pageNo){
		c_form.iPageNo.value = pageNo;
		c_form.action = "<c:url value='/duty/incident/Duty_Incd_List.do'/>";
		c_form.submit();
	}

</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="iPageNo" id="iPageNo" value="${pageSetting.currentPageNo}" />
<input type="hidden" name="drv_no" id="drv_no"/>
<input type="hidden" name="acc_id" id="acc_id"/>
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
                    	<div class="lnb">
                        	<h3 class="lnb__tit">운행정보보고</h3>
                            	<div class="lnb-list">
                                     <div class="lnb-item is-active">
                                         <a href="/duty/incident/Duty_Incd_List.do">교통사고</a>
                                     </div>
                                     <div class="lnb-item">
                                         <a href="/duty/driving/Duty_Drvg_List.do">운행정보보고서</a>
                                     </div>
                                     <div class="lnb-item">
                                         <a href="/duty/device/Duty_Devc_List.do">장치 및 기능변경</a>
                                     </div>
                                 </div>
                             </div>
                             <div class="layout-content">
                                 <div class="layout-content__inner">
                                     <div class="layout-content__top">
                                         <h4 class="layout-content__tit">교통사고</h4>
                                         <ul class="location ml-auto">
                                             <li>
                                                 <img src="/image/sub/icon/icon-home.png" alt="홈">
                                             </li>
                                             <li>운행정보보고</li>
                                             <li>교통사고</li>
                                         </ul>
                                     </div>
                                     <div class="sch-area sch-area--box sch-area--gray">
                                         <div class="sch-form sch-form--row">
                                             <form action="">
                                                 <label for="">
                                                     <select name="searchType" id="searchType" title="운행정보보고 교통사고 구분항목 선택">
                                                          <option value="0" <c:if test="${searchType eq '0' }">selected</c:if>>전체</option>
												          <option value="1" <c:if test="${searchType eq '1' }">selected</c:if>>임시운행기관</option>
												          <option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>임시운행등록번호</option>
                                                     </select>
                                                 </label>
                                                 <label for="">
                                                     <input type="text" placeholder="검색어를 입력해 주세요." class="w250px" id="searchWord" name="searchWord" value="${searchWord }" onkeyup="injectionCheck(this)" />
                                                 </label>
                                                 <button type="button" class="btn btn--sch" onclick="javascript:form_Submit()" title="검색"></button>
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
                                         <table class="table-basic table-basic--col table-us_du_01_list">
                                             <caption>운행정보보고 &gt; 교통사고 테이블</caption>
                                             <colgroup>
                                                 <col style="width:20%">
                                                 <col style="width:20%">
                                                 <col style="width:auto">
                                                 <col style="width:20%">
                                                 <col style="width:20%">
                                             </colgroup>
                                             <thead>
                                                 <tr>
                                                     <th scope="col">임시운행기관</th>
                                                     <th scope="col">임시운행등록번호</th>
                                                     <th scope="col">사고장소</th>
                                                     <th scope="col">사고일시</th>
                                                     <th scope="col">등록일시</th>
                                                 </tr>
                                             </thead>
                                             <tbody>
							            <c:choose>
							              <c:when test="${resultList eq null || empty resultList}">
							                <tr>
							                  <td colspan="6" >등록된 정보가 없습니다</td>
							                </tr>
							              </c:when>
							              <c:otherwise>
							                <c:forEach var="list" items="${resultList}" varStatus="status">
							                  <tr onClick="javascript:detail_View('${list.tmpRaceNumber}','${list.accId}');" style="cursor:pointer;">
							                    <td>${list.tmpRaceAgency}</td>
							                    <td>${list.tmpRaceNumber}</td>
							                    <td class="left border_l_none">${list.place}</td>
							                    <td>${list.accDateView}</td>
							                    <c:choose>
							                      <c:when test="${list.coldiff > paramInfo.data1 }">
							                        <td><i class="font_red">${list.regDateView}</i></td>
							                      </c:when>
							                      <c:otherwise>
							                        <td>${list.regDateView}</td>
							                      </c:otherwise>
							                    </c:choose>
							                  </tr>
							                </c:forEach>
							              </c:otherwise>
							            </c:choose>
							          </tbody>
                                         </table>
                                     </div>
                                     <div class="page-wrap2">
                                     	 <div class="btn-wrap">
		                                     <button type="button" class="btn btn-width--l btn-color--navy" onclick="fn_Add_Popup()">임시운행등록번호 추가</button>
		                                     <c:if test="${drvChk > 0}">
		                                     	<button type="button" class="btn btn-width--m btn-color--navy" onclick="fn_Add_View()">교통사고 등록</button>
		                                     </c:if>
		                                 </div>
                                         <div class="paging">
<%-- 	                                         <c:if test="${fn:length(resultList) > 0 }"> --%>
									          <a class="page-link page-link--first" href="javascript:go_Page('1');" title="처음으로">
									          	<img src="/image/common/icon/icon-page-link--first.png" alt="">
									          </a>
									          <a class="page-link page-link--prev" href="javascript:go_Page('${pageSetting.prvePageNoOnPageList }');" title="이전">
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
									          <a class="page-link page-link--next" href="javascript:go_Page('${pageSetting.nextPageNoOnPageList }');" title="다음">
									          	<img src="/image/common/icon/icon-page-link--next.png" alt="">
									          </a>
									          <a class="page-link page-link--last" href="javascript:go_Page('${pageSetting.totalPageCount }');" title="맨끝으로">
									          	<img src="/image/common/icon/icon-page-link--last.png" alt="">
									          </a>
			<%-- 									      </c:if> --%>
			                                 
                                 </div>
                            	</div>
                        	 </div>
                    	 </div>
                	 </div>
            	 </div>
        	 </div>
   		</div>
	</div>
</div>
<!-- //container -->
</form:form>
