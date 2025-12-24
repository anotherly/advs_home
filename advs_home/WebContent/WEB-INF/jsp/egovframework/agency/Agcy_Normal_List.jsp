<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" defer>
  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅

    $(".bTitle").each(function(){
        var length = 14;
        $(this).each(function(){
            if( $(this).text().length > length ){
                $(this).text( $(this).text().substr(0,length-2)+'...')
            }
        });
    });
    
    //상세검색 펼치기
    if('${searchDetl}' == "Y") {
      $(".searchWrap").show();
    } else {
      $(".searchWrap").hide();
    }

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

    $("#searchWord").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
    $("#searchButton").click(function(e) { form_Submit(); });
    $("#searchBseq").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
    $("#searchScenarioCode1").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
    $("#searchScenarioCode2").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
    $("#searchScenarioCode3").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
    $("#searchRoad").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
    $("#searchBdwr").keypress(function(e) { if(e.keyCode == 13) form_Submit(); });
    $("#regist").click(function(e) { go_RegistPage(); });
    $("#regist").keypress(function(e) { go_RegistPage(); });
    
    
  });

	/* 목록 화면 function */
	function form_Submit() {
    var searchBseq = $("#searchBseq option:selected").val();
    var searchScenarioCode1 = $("#searchScenarioCode1 option:selected").val();
    var searchScenarioCode2 = $("#searchScenarioCode2 option:selected").val();
    var searchScenarioCode3 = $("#searchScenarioCode3 option:selected").val();
    var searchRoad = $("#searchRoad option:selected").val();
    var searchBdwr = $("#searchBdwr option:selected").val();

    /* if(trim(c_form.searchDetl.value) != "Y") {
      $("#searchBseq").val("").attr("selected","selected");
      $("#searchScenarioCode1").val("").attr("selected","selected");
      $("#searchScenarioCode2").val("").attr("selected","selected");
      $("#searchScenarioCode3").val("").attr("selected","selected");
      $("#searchRoad").val("").attr("selected","selected");
      $("#searchBdwr").val("").attr("selected","selected");
    } */

    if( searchBseq == "" && searchScenarioCode1 == "" && searchScenarioCode2 == "" && searchScenarioCode3 == "" && searchRoad == "" && searchBdwr == "" && trim(c_form.searchWord.value).length == 0 ) {
      alert("검색조건을 하나이상 선택해주세요");
      return;
    } else {
      if(trim(c_form.searchWord.value).length > 0) {
        var sel = $("#searchType option:selected").val();
        if(sel == 0) {
          //alert("검색대상을 선택해주세요");
          //c_form.searchType.focus();
          //return;
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
      c_form.search.value="Y";
      c_form.action = "<c:url value='/open/normal/Open_Normal_List.do'/>";
      c_form.submit();
    }
	}

  /* 파일 다운로드  */
  function fn_Download_Hist(seq, file_nm) {
    c_form.b_seq.value = seq;
    c_form.file_nm.value = file_nm;
//    c_form.dir_nm.value = "cits";
    c_form.dir_nm.value = "cits";
    c_form.action = "<c:url value='/common/File_Download_Hist.do'/>";
    c_form.submit();
  }

  /* 다운로드 요청 팝업 화면 function */
  /* function fn_Add_Popup(id) {
    window.open('/agency/consultative/Agcy_Dtdw_Popup.do?b_seq='+id, 'dtdw_pop','left=200, top=100, width=500, height=385');
  } */

  /* pagination 페이지 링크 function */
	function go_Page(pageNo){
		c_form.iPageNo.value = pageNo;
    	c_form.action = "<c:url value='/open/normal/Open_Normal_List.do'/>";
		c_form.submit();
	}

  /* 상세 화면 function */
	function detail_View(bSeq, bbs) {
		c_form.b_seq.value = bSeq;
		c_form.bbs_seq.value = bbs;
		c_form.action = "<c:url value='/open/normal/Open_Normal_View.do'/>";
		c_form.submit();
	}

	
	  /* 등록 화면 function */
	function fn_Add_View(bbs) {
	    c_form.bbs_seq.value = bbs;
	    c_form.action = "<c:url value='/open/normal/Open_Normal_Inst.do'/>";
	    c_form.submit();
	}
  //checkbox 값 설정
	function fn_check_box(obj) {
		if(obj.checked) {
      c_form.searchDetl.value = "Y";
      $(".searchWrap").show();
		} else {
      c_form.searchDetl.value = "N";
      $("#searchBseq").val("").attr("selected","selected");
      $("#searchScenarioCode1").val("").attr("selected","selected");
      $("#searchScenarioCode2").val("").attr("selected","selected");
      $("#searchScenarioCode3").val("").attr("selected","selected");
      $("#searchRoad").val("").attr("selected","selected");
      $("#searchBdwr").val("").attr("selected","selected");
      $(".searchWrap").hide();
		}
	}

  //검색 검색초기화
  function fn_searchReset() { 
    $("#searchWord").val("");
    $("#searchBseq").val("").attr("selected","selected");
    $("#searchScenarioCode1").val("").attr("selected","selected");
    $("#searchScenarioCode2").val("").attr("selected","selected");
    $("#searchScenarioCode3").val("").attr("selected","selected");
    $("#searchRoad").val("").attr("selected","selected");
    $("#searchBdwr").val("").attr("selected","selected");
  }

  /* 시나리오 코드 안내 */
  function fn_scenarioInfo_Popup(bbsSeq) {
    window.open('/common/Data_Scenario_Popup.do?bbs_seq='+bbsSeq, 'scenario','left=200, top=100, width=718, height=553, scrollbars=no');
  }  
</script>

<form:form id="listForm" name="listForm" method="post" >
<input type="hidden" name="iPageNo" id="iPageNo" value="${pageSetting.currentPageNo}" />
<input type="hidden" name="b_seq" id="b_seq"/>
<input type="hidden" name="bbs_seq" id="bbs_seq" value="${bbs_seq}" />
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>
<input type="hidden" name="search" id="search" value="${search}" />
<input type="hidden" name="searchDetl" id="searchDetl" value="${searchDetl}" />

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
						        <div class="lnb-item"><a href="/agency/off/Agcy_Off_Main.do">오프라인 공유 <br/>안내 및 신청</a></div>
						        <div class="lnb-item">
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
	                       <div class="layout-content">
	                           <div class="layout-content__inner">
	                               <div class="layout-content__top">
	                               <c:if test="${bbs_seq eq '2080'}">
									   <h4 class="layout-content__tit">일반시나리오 데이터셋</h4>
						           </c:if>
						           <c:if test="${bbs_seq eq '2090'}">
						           	   <h4 class="layout-content__tit">엣지케이스 시나리오 데이터셋</h4>
						           </c:if>
						           <c:if test="${bbs_seq eq '2100'}">
						           	   <h4 class="layout-content__tit">V2X 데이터셋</h4>
						           </c:if>
	                                   <ul class="location ml-auto">
	                                       <li>
	                                           <img src="/image/sub/icon/icon-home.png" alt="홈">
	                                       </li>
	                                       <li>협의체데이터</li>
	                                       <c:if test="${bbs_seq eq '2080'}">
										   	   <li>일반시나리오 데이터셋</li>
								           </c:if>
								           <c:if test="${bbs_seq eq '2090'}">
								           	   <li>엣지케이스 시나리오 데이터셋</li>
								           </c:if>
								           <c:if test="${bbs_seq eq '2100'}">
								           	   <li>V2X 데이터셋</li>
								           </c:if>
	                                   </ul>
	                               </div>
			     <div class="sch-area sch-area--box sch-area--gray">
			     	<div class="sch-form sch-form--row">
			     		<%-- <select id="searchBseq" name="searchBseq" class="w170px" title="검색대상 선택">
				          <c:choose>
				            <c:when test="${bbs_list eq null || empty bbs_list}">
				              <option value=""><< 데이터유형 선택 >></option>
				            </c:when>
				            <c:otherwise>
				              <option value=""><< 데이터유형 선택 >></option>
				              <c:forEach var="list" items="${bbs_list}" varStatus="loop">
				                <option value="${list.bbsSeq}" <c:if test="${list.bbsSeq eq searchBseq}">selected</c:if>>${list.bbsNm}</option>
				              </c:forEach>
				            </c:otherwise>
				          </c:choose>
				        </select> --%>
		        <select id="searchScenarioCode1" name="searchScenarioCode1" class="w140px" title="검색대상 선택">
		          <c:choose>
		            <c:when test="${scenario_code1 eq null || empty scenario_code1}">
		              <option value="">시간</option>
		            </c:when>
		            <c:otherwise>
		              <option value="">시간</option>
		              <c:forEach var="list" items="${scenario_code1}" varStatus="loop">
		                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq searchScenarioCode1}">selected</c:if>>${list.codeDetlNm}</option>
		              </c:forEach>
		            </c:otherwise>
		          </c:choose>
		        </select>
		        <select id="searchScenarioCode2" name="searchScenarioCode2" class="w150px" title="검색대상 선택">
		          <c:choose>
		            <c:when test="${scenario_code2 eq null || empty scenario_code2}">
		              <option value="">도로/상황</option>
		            </c:when>
		            <c:otherwise>
		              <option value="">도로/상황</option>
		              <c:forEach var="list" items="${scenario_code2}" varStatus="loop">
		                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq searchScenarioCode2}">selected</c:if>>${list.codeDetlNm}</option>
		              </c:forEach>
		            </c:otherwise>
		          </c:choose>
		        </select>
		        <select id="searchScenarioCode3" name="searchScenarioCode3" class="w150px" title="검색대상 선택">
		          <c:choose>
		            <c:when test="${scenario_code3 eq null || empty scenario_code3}">
		              <option value="">날씨</option>
		            </c:when>
		            <c:otherwise>
		              <option value="">날씨</option>
		              <c:forEach var="list" items="${scenario_code3}" varStatus="loop">
		                <option value="${list.codeDetlCd}" <c:if test="${list.codeDetlCd eq searchScenarioCode3}">selected</c:if>>${list.codeDetlNm}</option>
		              </c:forEach>
		            </c:otherwise>
		          </c:choose>
		        </select>
				<label for="">
					<select name="searchType" id="searchType" title="전체/제목/내용 선택">
			          <option value="0" <c:if test="${searchType eq '0' }">selected</c:if>>--전체--</option>
			          <option value="1" <c:if test="${searchType eq '1' }">selected</c:if>>제목</option>
			          <option value="2" <c:if test="${searchType eq '2' }">selected</c:if>>내용</option>
					</select>
				</label>
				<label for="">
					<input type="text" name="searchWord" id="searchWord" title="검색어 입력" placeholder="검색어를 입력해주세요." value="${searchWord}">
				</label>
				<button type="button" class="btn btn--sch" id="searchButton" title="검색"></button>
				<!-- 시나리오코드 안내 팝업 -->
				<a href="javascript:fn_scenarioInfo_Popup(${bbs_seq})" class="quest_box" style="cursor:pointer;" ></a>
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
             <table class="table-basic table-basic--col table--us_ag_01_list">
             	<c:if test="${bbs_seq eq '2080'}">
                 <caption>협의체데이터 &gt; 일반시나리오 데이터셋 테이블</caption>
                </c:if>
                <c:if test="${bbs_seq eq '2090'}">
                 <caption>협의체데이터  &gt; 엣지케이스 시나리오 데이터셋</caption>
                </c:if>
                <c:if test="${bbs_seq eq '2100'}">
                 <caption>협의체데이터 &gt; V2X 데이터셋</caption>
                </c:if>
                 <colgroup>
                     <col style="width:7%">
                     <col style="width:10%">
                     <col style="width:10%">
                     <col style="width:12%">
                     <col style="width:auto">
                     <col style="width:13%">
                     <col style="width:16%">
                     <col style="width:10%">
                 </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">시간</th>
                                <th scope="col">도로/상황</th>
                                <th scope="col">날씨</th>
                                <th scope="col">제목</th>
                                <th scope="col">주행모드</th>
                                <th scope="col">수집일자</th>
                                <th scope="col">등록기관</th>
                            </tr>
                        </thead>
                        <tbody>
            <c:choose>
              <c:when test="${resultList eq null || empty resultList}">
                <tr>
                  <td colspan="7" >등록된 정보가 없습니다</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach var="list" items="${resultList}" varStatus="status">
                            <tr onClick="javascript:detail_View('${list.bSeq}','${list.bbsSeq}');" style="cursor:pointer;">
                                <td>${list.listcnt}</td>
                                <td>${list.scenarioCode1}</td>
                                <td>${list.scenarioCode2}</td>
                                <td>
<%--                                     <button type="button" class="btn btn--download" title="${list.mxfile} 첨부파일입니다" onclick="location.href='javascript:fn_Download_Hist('${list.bSeq}','${list.mxfile}');' ">${list.mxfile} [${list.fileSizeView} Kbyte]</button> --%>
									${list.scenarioCode3}
                                </td>
                                <td class="bTitle">${list.bTitle}</td>
                                <td>${list.drivingModeView}</td>
                                <td>${list.collectDay}</td>
                                <td>${list.agencyNm}</td>
                            </tr>
				                </c:forEach>
				              </c:otherwise>
				            </c:choose>
                        </tbody>
                    </table>
                    <!-- pagenum : s -->
                    <div class="page-wrap">
			            <div class="paging">
		                    <c:if test="${fn:length(resultList) >= 0 }">
			                    <a href="javascript:go_Page('1');" title="처음으로" class="page-link page-link--first">
			                        <img src="/image/common/icon/icon-page-link--first.png" alt="">
			                    </a>
			                    <a href="javascript:go_Page('${pageSetting.prvePageNoOnPageList }');" title="이전" class="page-link page-link--prev">
			                        <img src="/image/common/icon/icon-page-link--prev.png" alt="">
			                    </a>
			                    <c:forEach var="i"  begin="${pageSetting.firstPageNoOnPageList }" end="${pageSetting.lastPageNoOnPageList }">
						            <c:choose>
						              <c:when test="${pageSetting.currentPageNo eq i }">
						                <a href="javascript:void(0);" class="active" title="선택됨">${i }</a>
						              </c:when>
						              <c:otherwise>
						                <a href="javascript:void(0);" onclick="go_Page('${i }')">${i }</a>
						               </c:otherwise>
						             </c:choose>
						          </c:forEach>
			                    <a href="javascript:go_Page('${pageSetting.nextPageNoOnPageList }');" title="다음" class="page-link page-link--next">
			                        <img src="/image/common/icon/icon-page-link--next.png" alt="">
			                    </a>
			                    <a href="javascript:go_Page('${pageSetting.totalPageCount }');" title="맨끝으로" class="page-link page-link--last">
			                        <img src="/image/common/icon/icon-page-link--last.png" alt="">
			                    </a>
		      				</c:if>
		                    <div class="btn-wrap pos-ab--right pos-ab--top">
		                        <button type="button" class="btn btn-width--l btn-color--navy" onClick="javascript:fn_Add_View('${bbs_seq}');">등록</button>
		                    </div>
		                </div>
					</div>
					<!-- //pagenum : e -->
	              </div>
	          </div>
	        </div>
	   	   </div>
		  </div>
         </div>
        </div>
    </div>
	
</div>
</form:form>
