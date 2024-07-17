<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>

<script type="text/javaScript" defer>

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

  /* 파일 다운로드  */
  function fn_Download(file_nm) {
    c_form.file_nm.value = file_nm;
    c_form.dir_nm.value = "trnd";
    c_form.action = "<c:url value='/common/File_Download.do'/>";
    c_form.submit();
  }
  
  /* 상세 화면 function */
	function detail_View(cd, seq) {
	  c_form.blbd_div_cd.value = cd;
	  c_form.bdwr_seq.value = seq;
	  c_form.action = "<c:url value='/bbs/trend/Board_Trnd_Info.do'/>";
	  c_form.submit();
	}
  
	function go_List(){
		c_form.action = "<c:url value='/bbs/trend/Board_Trnd_List.do'/>";
		c_form.submit();
	}
</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="bdwr_seq" id="bdwr_seq"/>
<input type="hidden" name="blbd_div_cd" id="blbd_div_cd"/>
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
                        <div class="lnb">
                            <h3 class="lnb__tit">공지사항</h3>
                            <div class="lnb-list">
                                <div class="lnb-item">
                                    <a href="/bbs/notice/Board_Notc_List.do">공지사항</a>
                                </div>
                                <div class="lnb-item is-active">
                                    <a href="/bbs/trend/Board_Trnd_List.do">자율주행 최신동향</a>
                                </div>
                            </div>
                        </div>
                        <div class="layout-content">
                            <div class="layout-content__inner">
                                <div class="layout-content__top">
                                    <h4 class="layout-content__tit">자율주행 최신동향</h4>
                                    <ul class="location ml-auto">
                                        <li>
                                            <img src="/image/sub/icon/icon-home.png" alt="홈">
                                        </li>
                                        <li>공지사항</li>
                                        <li>자율주행 최신동향</li>
                                    </ul>
                                </div>
                                <div class="layout-content__view">
                                    <div class="noticeView-wrap">
                                        <div class="noticeView__top">
                                            <h5 class="noticeView__tit">${trndInfo.bdwrTtlNm}</h5>
                                            <dl class="noticeView__capt">
                                                <dt>작성일</dt>
                                                <dd>${trndInfo.regDateView}</dd>
                                                <dt>조회</dt>
                                                <dd>${trndInfo.iqurNctnView}</dd>
                                            </dl>
                                        </div>
                                        <c:choose>
								            <c:when test="${trndInfo.attachFilename ne null}">
		                                        <div class="noticeView__crack">
		                                            <p class="crack__tit">첨부파일</p>
		                                            <div class="crack__links">
		                                                <a href="javascript:void(0);" title="${trndInfo.attachFilename} 첨부파일입니다" onclick="fn_Download('${trndInfo.attachFilename}')">${trndInfo.attachFilename}    (${trndInfo.fileSizeView} Bytes)</a>
		                                            </div>
		                                        </div>
								            </c:when>
								            <c:otherwise>
								            </c:otherwise>
								        </c:choose>
                                        <div class="noticeView__cont">
                                            <div class="noticeView__cont__inner">
                                                ${trndInfo.bdwrCts}
                                            </div>
                                        </div>
                                        <div class="noticeView__link">
                                            <div class="link-next">
                                                <div class="link-next__capt">다음</div>
												<c:choose>
													<c:when test="${trndInfo.nextBdwrSeq ne null}">
														<a href="javascript:detail_View('${trndInfo.blbdDivCd}','${trndInfo.nextBdwrSeq}');">${trndInfo.nextBdwrTtlNm}</a>
													</c:when>
													<c:otherwise>
														<a href="javascript:void(0);">다음글이 없습니다.</a>
													</c:otherwise>
												</c:choose>
                                            </div>
                                            <div class="link-prev">
                                                <div class="link-prev__capt">이전</div>
												<c:choose>
													<c:when test="${trndInfo.prevBdwrSeq ne null}">
														<a href="javascript:detail_View('${trndInfo.blbdDivCd}','${trndInfo.prevBdwrSeq}');">${trndInfo.prevBdwrTtlNm}</a>
													</c:when>
													<c:otherwise>
														<a href="javascript:void(0);">이전글이 없습니다.</a>
													</c:otherwise>
												</c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="btn-wrap btn-row justify-center mt-30 mb-80">
                                    <button type="button" class="btn btn-width--l btn-color--navy" onclick="go_List()">목록으로</button>
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
