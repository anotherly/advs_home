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

  /* 수정 function */
	function fn_Update(bdwr, bbs) {
    if(confirm("등록된 정보를 수정 하시겠습니까?")) {
      c_form.bdwr_seq.value = bdwr;
      c_form.bbs_seq.value = bbs;
      c_form.action = "<c:url value='/agency/consultative/Agcy_Dset_Updt.do'/>";
      c_form.submit();
    }
	}

	/* 삭제 function */
	function fn_Delete(bdwr, bbs) {
		if(confirm("정말 삭제 하시겠습니까?")) {
      c_form.bdwr_seq.value = bdwr;
      c_form.bbs_seq.value = bbs;
			if(confirm("등록된 데이터셋 정보와 업로드된 데이터의 매핑정보는 모두 삭제 됩니다")) {
        c_form.action = "<c:url value='/agency/consultative/Agcy_Dset_Delt_Process.do'/>";
        c_form.submit();
			}
		}
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
						         <div class="lnb-item is-active">
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

                                <div class="table-wrap">
                                    <table class="table-basic table-basic--row table--myUpload">
                                        <caption>협의체데이터 &gt; 데이터셋 &gt; 데이터셋 테이블</caption>
                                        <colgroup>
                                            <col style="width:15%">
                                            <col style="width:auto">
                                        </colgroup>
                                        <tbody>
                                            <tr>
                                                <th scope="row">제목</th>
                                                <td>${dsetInfo.bdwrTtlNm}
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">내용</th>
                                                <td>
                                                    <div class="editor-view">${dsetInfo.bdwrCts}</div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">첨부파일</th>
                                                <td>
									                <c:choose>
									                  <c:when test="${dsetInfo.attachFilename ne null}">
									                    <a href="javascript:void(0);" title="${dsetInfo.attachFilename} 첨부파일입니다" onclick="fn_Download('${dsetInfo.attachFilename}')"><img src="/images/avsc/ico_file.png" alt="다운로드" />&nbsp<i class="font_lGray">${dsetInfo.attachFilename}</i> [${dsetInfo.fileSizeView} Kbyte]</a>
									                  </c:when>
									                  <c:otherwise>
									                    -
									                  </c:otherwise>
									                </c:choose>
<!--                                                     <button class="btn btn--download">파일명, 확장자</button> -->
                                                </td>
                                            </tr>
                                            <tr>
                                                <th scope="row">관련자료</th>
                                                <td>
                                                    <a href="/agency/consultative/Agcy_Cons_List.do?search=Y&searchDetl=Y&searchBdwr=${bdwr_seq}"
                                                    target="_blank" class="editor-view__link">https://avds.kotsa.or.kr/agency/consultative/Agcy_Cons_List.do?search=Y&searchDetl=Y&searchBdwr=${bdwr_seq}</a>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
	                            <div class="btn-wrap btn-row justify-center mt-30 mb-80">
								<c:if test="${dsetInfo.regId eq user_id}">
	                                <a href="javascript:fn_Update('${bdwr_seq}','${bbs_seq}');"><button type="button" class="btn btn-width--l btn-color--white" >수정</button></a>
	                                <a href="javascript:fn_Delete('${bdwr_seq}','${bbs_seq}');"><button type="button" class="btn btn-width--l btn-color--white" >삭제</button></a>
								</c:if>
	                                <a href="/agency/consultative/Agcy_Dset_List.do?bbs_seq=${bbs_seq}"><button type="button" class="btn btn-width--l btn-color--white" >목록으로</button></a>
	                            </div>
							</div>
						</div>						 					
						<!-- 본문:end	-->
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
