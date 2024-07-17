<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>

<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

  /* 상세 화면 function */
  function detail_View(cd, seq) {
    c_form.blbd_div_cd.value = cd;
    c_form.bdwr_seq.value = seq;
    c_form.action = "<c:url value='/bbs/notice/Board_Notc_Info.do'/>";
    c_form.submit();
	}

	/* 목록 화면 function */
	function form_Submit() {
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
				c_form.action = "<c:url value='/bbs/notice/Board_Notc_List.do'/>";
				c_form.submit();
			}
		}
	}

  /* 파일 다운로드  */
  function fn_Download(file_nm) {
    c_form.file_nm.value = file_nm;
    c_form.dir_nm.value = "notc";
    c_form.action = "<c:url value='/common/File_Download.do'/>";
    c_form.submit();
  }

  /* pagination 페이지 링크 function */
	function go_Page(pageNo){
		c_form.iPageNo.value = pageNo;
    c_form.action = "<c:url value='/bbs/notice/Board_Notc_List.do'/>";
		c_form.submit();
	}

</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="iPageNo" id="iPageNo" value="${pageSetting.currentPageNo}" />
<input type="hidden" name="blbd_div_cd" id="blbd_div_cd"/>
<input type="hidden" name="bdwr_seq" id="bdwr_seq"/>
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>
<input type="hidden" name="file_ext" id="file_ext"/>
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
                            <h3 class="lnb__tit">공지사항</h3>
                            <div class="lnb-list">
                                <div class="lnb-item is-active">
                                    <a href="/bbs/notice/Board_Notc_List.do">공지사항</a>
                                </div>
                                <div class="lnb-item">
                                    <a href="/bbs/trend/Board_Trnd_List.do">자율주행 최신동향</a>
                                </div>
                            </div>
                        </div>
                        <div class="layout-content">
                            <div class="layout-content__inner">
                                <div class="layout-content__top">
                                    <h4 class="layout-content__tit">공지사항</h4>
                                    <ul class="location ml-auto">
                                        <li>
                                            <img src="/image/sub/icon/icon-home.png" alt="홈">
                                        </li>
                                        <li>공지사항</li>
                                        <li>공지사항</li>
                                    </ul>
                                </div>
                                <div class="sch-area sch-area--box sch-area--gray">
                                    <div class="sch-form sch-form--row">
                                        <form action="">
                                            <label for="">
                                                <select name="searchType" id="searchType" title="공지사항 구분항목 선택">
													<option value="0" <c:if test="${searchType eq '0' }">selected</c:if>>--선택--</option>
													<option value="1" <c:if test="${searchType eq '1' }">selected</c:if>>제목</option>
													<option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>내용</option>
                                                </select>
                                            </label>
                                            <label for="">
                                                <input type="text" name="searchWord" id="searchWord" title="검색어 입력" placeholder="검색어를 입력해주세요." value="${searchWord }" onkeyup="injectionCheck(this)">
                                            </label>
                                            <button type="button" class="btn btn--sch" title="검색" onclick="location.href='javascript:form_Submit();' "></button>
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
                                    <table class="table-basic table-basic--col table-us_du_03_list">
                                        <caption>자율주행 공지사항 &gt; 공지사항 테이블</caption>
                                        <colgroup>
                                            <col style="width:8%">
                                            <col style="width:auto">
                                            <col style="width:10%">
                                            <col style="width:15%">
                                            <col style="width:12%">
                                            <col style="width:12%">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">번호</th>
                                                <th scope="col">제목</th>
                                                <th scope="col">첨부파일</th>
                                                <th scope="col">등록일</th>
                                                <th scope="col">작성자</th>
                                                <th scope="col">조회수</th>
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
								                  <tr>
								                    <td>${list.bdwrSeq}</td>
								                    <td><a href="javascript:detail_View('${list.blbdDivCd}','${list.bdwrSeq}');">${list.bdwrTtlNm}</a></td>
								                    <c:choose>
								                      <c:when test="${list.attachFilename ne null}">
								                        <td>
								                        	<button type="button" title="${list.attachFilename} 다운로드" onclick="fn_Download('${list.attachFilename}')">
                                                                <img src="/image/common/icon/icon-download.png" alt="">
                                                            </button>
								                        </td>
								                      </c:when>
								                      <c:otherwise>
								                        <td></td>
								                      </c:otherwise>
								                    </c:choose>
								                    <td>${list.regDateView}</td>
								                    <td>${list.userNm}</td>
								                    <td>${list.iqurNctnView}</td>
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
</div>
<!-- //container -->
</form:form>
