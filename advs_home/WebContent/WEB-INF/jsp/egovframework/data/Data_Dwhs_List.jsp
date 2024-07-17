<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" >

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
    $("span[id=sp_off]").hide();

    //펼치기
    $("span[id=sp_on]").click(function() {
    	var idx = $("span[id=sp_on]").index(this);
    	$(this).hide();
    	$("span[id=sp_off]:eq("+idx+")").show();
    	$("tr[id=plain]:eq("+idx+")").show();
    });
    //접기
    $("span[id=sp_off]").click(function() {
    	var idx = $("span[id=sp_off]").index(this);
    	$("tr[id=plain]:eq("+idx+")").hide();
    	$("span[id=sp_on]:eq("+idx+")").show();
    	$("span[id=sp_off]:eq("+idx+")").hide();
    });
  });

	/* 목록 화면 function */

	function form_Submit() {
		if((c_form.searchWord.value).trim('').length > 0){
			var sel = $("#searchType option:selected").val();
			if(sel == 0) {
				alert("검색대상을 선택해주세요");
				c_form.searchType.focus();
				return;
			} else {
				if((c_form.searchWord.value).trim('').length==0){
					alert("검색어를 입력해주세요");
					c_form.searchWord.value="";
					c_form.searchWord.focus();
					return;
				}
				c_form.action = "<c:url value='/data/record/Data_Dwhs_List.do'/>";
				c_form.submit();
			}
		} else {
      c_form.action = "<c:url value='/data/record/Data_Dwhs_List.do'/>";
      c_form.submit();
    }
	}

  /* 평가하기 팝업 화면 function */
  function fn_Add_Popup(id, title) {
    c_form.b_seq.value = id;
    c_form.b_title.value = title;
    window.open('/data/record/Data_Eval_Popup.do', 'eval_inst','left=200, top=100, width=500, height=385');
  }

  /* 파일 다운로드  */
  function fn_Download(file_nm) {
    c_form.file_nm.value = file_nm;
    c_form.dir_nm.value = "dtup";
    c_form.action = "<c:url value='/common/File_Download.do'/>";
    c_form.submit();
  }

  /* pagination 페이지 링크 function */
	function go_Page(pageNo){
		c_form.iPageNo.value = pageNo;
    c_form.action = "<c:url value='/data/record/Data_Dwhs_List.do'/>";
		c_form.submit();
	}

</script>

<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/lib/bootstrap.min.css">
    <link rel="stylesheet" href="/css/lib/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="/css/ux-common.css">
    <link rel="stylesheet" href="/css/sub.css">
    <link rel="stylesheet" href="/css/us_da.css">
    <title>TS 한국교통안전공단</title>
</head>
<body>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="iPageNo" id="iPageNo" value="${pageSetting.currentPageNo}" />
<input type="hidden" name="b_seq" id="b_seq"/>
<input type="hidden" name="b_title" id="b_title"/>
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
                                    <h3 class="lnb__tit">MY DATA</h3>
                                    <div class="lnb-list">
                                        <div class="lnb-item">
                                        
                                            <a href="/data/record/Data_Uphs_List.do">내가 올린 자료</a>
                                        </div>
                                        <div class="lnb-item is-active">
                                            <a href="/data/record/Data_Dwhs_List.do">내가 받은 자료</a>
                                        </div>
<!--                                         <div class="lnb-item"> -->
<!--                                             <a href="/data/record/Data_Car_Inst.do">차량등록</a> -->
<!--                                         </div> -->
                                        <div class="lnb-item">
                                            <a href="/data/record/Data_Car_List.do">차량관리</a>
                                        </div>
                                        <div class="lnb-item">
                                            <a href="/data/request/Data_Delega_Auth.do">권한위임</a>
                                        </div>
                                    </div>
                                </div>
                                <div class="layout-content">
                                    <div class="layout-content__inner">
                                        <div class="layout-content__top">
                                            <h4 class="layout-content__tit">내가 받은 자료</h4>
                                            <ul class="location ml-auto">
                                                <li>
                                                    <img src="/image/sub/icon/icon-home.png" alt="홈">
                                                </li>
                                                <li>MY DATA</li>
                                                <li>내가 받은 자료</li>
                                            </ul>
                                        </div>
                                        <div class="sch-area sch-area--box sch-area--gray">
                                            <div class="sch-form sch-form--row">
                                                 <label for="">
                                                    <select id="searchBord" name="searchBord" title="대상 데이터 선택" class="w250px">
											          <c:choose>
											            <c:when test="${code_bbsseq eq null || empty code_bbsseq}">
											              <option value="">데이터구분 전체</option>
											            </c:when>
											            <c:otherwise>
											              <option value="">데이터구분 전체</option>
											              <c:forEach var="list" items="${code_bbsseq }" varStatus="loop">
											                <option value="${list.bbsSeq }" <c:if test="${list.bbsSeq eq searchBord }">selected</c:if>>${list.bbsNm }</option>
											              </c:forEach>
											            </c:otherwise>
											          </c:choose>
									        		</select>
                                                 </label>
                                                 <label for="">
                                                     <select id="searchType" name="searchType" title="검색대상 선택">
											          <option value="0" <c:if test="${searchType eq '0' }">selected</c:if>>--선택--</option>
											          <option value="1" <c:if test="${searchType eq '1' }">selected</c:if>>제목</option>
											          <option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>내용</option>
									        		</select>
									        	</label>
									        	<label for="">
                                                    <input type="text" placeholder="검색어를 입력해 주세요." class="w250px" id="searchWord" name="searchWord" value="${searchWord }" onkeyup="injectionCheck(this)" />
                                                </label>
                                                	<button type="button" class="btn btn--sch" title="검색" onclick="form_Submit();">
                                                	</button>
                                            </div>
                                        </div>
                                        <div class="table-wrap">
                                            <div class="table-cap">
                                                <p class="table-cap__count">
                                                	총 <span>${pageSetting.totalRecordCount} </span> 건 
                                                </p>
                                                <p class="table-cap__page">
                                                   	페이지 <span>${pageSetting.currentPageNo}</span>/${pageSetting.totalPageCount}
                                                </p>
                                            </div>
                                            <table class="table-basic table-basic--col table--myUpload">
                                                <caption>MY DATA &gt; 내가올린자료 테이블</caption>
                                                <colgroup>
                                                    <col style="width:16%">
                                                    <col style="width:auto%">
                                                    <col style="width:16%">
                                                    <col style="width:16%">
<!--                                                     <col style="width:8%"> -->
                                                    <col style="width:16%">
                                                </colgroup>
                                                <thead>
                                                    <tr>
                                                        <th scope="col">데이터구분</th>
                                                        <th scope="col">제목</th>
                                                        <th scope="col">파일명</th>
                                                        <th scope="col">등록일</th>
<!--                                                         <th scope="col">다운수</th> -->
                                                        <th scope="col">보기</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                	<c:choose>
								              <c:when test="${resultList eq null || empty resultList}">
								                <tr>
								                  <td colspan="6" style="text-align:center">등록된 정보가 없습니다</td>
								                </tr>
								              </c:when>
								              <c:otherwise>
								                  <c:forEach var="list" items="${resultList}" varStatus="status">
								                  <tr>
								                  	<td style="word-break:keep-all;" class="left border_l_none lh_sm">${list.bbsNm}</td>
								                    <td style="word-break:keep-all;" class="left border_l_none lh_sm">${list.bTitle}</td>
								                    <td style="word-break:break-all;" class="left border_l_none lh_sm">${list.saveNm}</td>
								                    <td style="word-break:break-all;" class="border_l_none lh_sm">${list.regDateView}</td>
<%-- 								                    <td style="word-break:break-all;" class="border_l_none lh_sm">${list.cnt}</td> --%>
								                    <td class="right">
								                      <c:choose>
								                        <c:when test="${list.evalPoint ne null}">
								                          <div class="starWrap star_select mr10">
								                            <c:set var="point" value="${list.evalPoint}" />
								                            <c:choose>
								                              <c:when test="${point eq '5'}">
								                                <a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class="active"></a>
								                              </c:when>
								                              <c:when test="${point eq '4'}">
								                                <a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class=""></a>
								                              </c:when>
								                              <c:when test="${point eq '3'}">
								                                <a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class=""></a><a href="javascript:void(0);" class=""></a>
								                              </c:when>
								                              <c:when test="${point eq '2'}">
								                                <a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class=""></a><a href="javascript:void(0);" class=""></a><a href="javascript:void(0);" class=""></a>
								                              </c:when>
								                              <c:when test="${point eq '1'}">
								                                <a href="javascript:void(0);" class="active"></a><a href="javascript:void(0);" class=""></a><a href="javascript:void(0);" class=""></a><a href="javascript:void(0);" class=""></a><a href="javascript:void(0);" class=""></a>
								                              </c:when>
								                              <c:otherwise>
								                                <a href="javascript:void(0);" class=""></a><a href="javascript:void(0);" class=""></a><a href="javascript:void(0);" class=""></a><a href="javascript:void(0);" class=""></a><a href="javascript:void(0);" class=""></a>
								                              </c:otherwise>
								                            </c:choose>
								                          </div>
								                        </c:when>
								                        <c:otherwise>
								                          <a href="javascript:fn_Add_Popup('${list.bSeq}','${list.bTitle}');" class="" title="새창 열림">평가하기 &nbsp; | &nbsp;</a>
								                        </c:otherwise>
								                      </c:choose>
								                      <span id="sp_on"><a href="javascript:void(0);" class="btn_l_sky btn_sm">펼치기</a></span>
								                      <span id="sp_off"><a href="javascript:void(0);" class="btn_l_sky btn_sm">접기</a></span>
								                    </td> 
								                  </tr>
								                  <tr id="plain" style="display:none" class="gray_box">
								                    <td colspan="6" class="left border_l_none tdCont">
								                      <div class="cont">${list.bContent}</div>
<!-- 								                      <ul class="bot"> -->
<%-- 								                        <li class="l">첨부 <a href="javascript:void(0);" title="${list.saveNm} 첨부파일입니다" onclick="fn_Download('${list.saveNm}')">${list.saveNm} [${list.fileSizeView} Kbyte] </a></li> --%>
<!-- 								                        <li class="r"><span id="sp_off"><a href="javascript:void(0);" class="btn_l_sky btn_sm w70px">접기</a></span></li> -->
<!-- 								                      </ul> -->
								                      <div class="bot">
								                        <div class="l">첨부 <a href="javascript:void(0);" title="${list.saveNm} 첨부파일입니다" onclick="fn_Download('${list.saveNm}')">${list.saveNm} [${list.fileSizeView} Kbyte] </a></div>
								                      </div>
								                    </td>
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
                                            
<%--                                             <a class="active" href="javascript:go_Page('${pageSetting.nextPageNoOnPageList }');" title="다음"></a> --%>
<%--           									<a class="active" href="javascript:go_Page('${pageSetting.totalPageCount }');" title="맨끝으로"></a> --%>
                                            
                                            <a href="javascript:go_Page('${pageSetting.nextPageNoOnPageList }');" class="page-link page-link--next">
                                                <img src="/image/common/icon/icon-page-link--next.png" alt="">
                                            </a>
                                            <a href="javascript:go_Page('${pageSetting.totalPageCount }');" class="page-link page-link--last">
                                                <img src="/image/common/icon/icon-page-link--last.png" alt="">
                                            </a>
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
