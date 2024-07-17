<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%
	/* 로그인 여부 */
	//String user_id = (String)session.getAttribute("user_id");
	//String agcy_nm = (String)session.getAttribute("agcy_nm");
	//boolean login = user_id == null ? false: true;
%>

<script type="text/javascript" src="/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅
  });

  /* 등록 function */
	function fn_Save(bdwr, bbs) {
		if(confirm("저장 하시겠습니까?")) {
      oEditors.getById["bdwr_cts"].exec("UPDATE_CONTENTS_FIELD", []);

      c_form.bdwr_seq.value = bdwr;
      c_form.bbs_seq.value = bbs;

			if(trim(c_form.bdwr_ttl_nm.value).length==0){
				alert("제목을 입력해주세요");
				c_form.bdwr_ttl_nm.value="";
				c_form.bdwr_ttl_nm.focus();
				return;
			}

      if($('#bdwr_cts').val().length < 5){
				alert("내용을 5글자 이상 입력해주세요");
				c_form.bdwr_cts.value="";
				c_form.bdwr_cts.focus();
				return;
			}

			document.listForm.action = "<c:url value='/agency/consultative/Agcy_Dset_Updt_Process.do'/>";
			document.listForm.submit();
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

<form:form id="listForm" name="listForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="bdwr_seq" id="bdwr_seq"/>
<input type="hidden" name="bbs_seq" id="bbs_seq"/>
<input type="hidden" name="file_nm" id="file_nm"/>
<input type="hidden" name="dir_nm" id="dir_nm"/>

<div class="skip">
  <a href="#container">Go to Content</a>
</div>

<!-- container -->
<div id="container">
  <%
	//메뉴ID 하드코딩(고도화 시간 부족으로 인한 하드코딩 - 메뉴ID 가지고 다닐려면 모든 프로그램 수정해야됨, 추후 작업은 각 메뉴별 JSP마다 하드코딩하거나 DB로 불러와 가지고 다니게 수정할것)
  	//게시판소스는 bbs_seq별로 하드코딩해줌
  	String cMenuId = "B8000";
  	String pMenuId = "B0000";
  %>
  <jsp:include page="/include/Left.jsp">
  	<jsp:param value="<%=cMenuId %>" name="cMenuId"/>
  	<jsp:param value="<%=pMenuId %>" name="pMenuId"/>
  	<jsp:param value="BOARD" name="leftType"/>
  </jsp:include> 

  <!--  contWrap -->
  <div class="contWrap">
    <div class="location">
      <b>데이터셋 정보 수정</b>
      <ul>
        <li></li>
        <li>협의체데이터</li>
        <li>데이터셋 정보 수정</li>
      </ul>
    </div>

    <!-- contents -->
    <div class="contents">
      <div class="table2">
        <table summary="" class="">
          <colgroup>
            <col width="15%">
            <col width="">
          </colgroup>
          <tbody>
            <tr>
              <th class="border_l_none">제목</th>
              <td>
                <input type="text" class="w100p" id="bdwr_ttl_nm" name="bdwr_ttl_nm" value="${dsetInfo.bdwrTtlNm}" onkeyup="checkLength(this,255)">
              </td>
            </tr>
            <tr>
              <th class="border_l_none">내용</th>
              <td>
                <textarea title="내용 입력" style="width:100%; height:300px;background-color:#fff; display:none;" name="bdwr_cts" id="bdwr_cts" value="" title="">${dsetInfo.bdwrCts}</textarea>
              </td>
            </tr>
            <!--
            <tr>
              <th class="border_l_none">데이터 형태</th>
              <td>
                <input type="text" class="w100p" id="data_form" name="data_form" value="${dsetInfo.dataForm}" onkeyup="checkLength(this,100)">
              </td>
            </tr>
            -->
            <tr>
              <th rowspan="3" class="border_l_none">첨부파일</th>
              <td>
                <c:choose>
                  <c:when test="${dsetInfo.attachFilename ne null}">
                    <a href="javascript:void(0);" title="${dsetInfo.attachFilename} 첨부파일입니다" onclick="fn_Download('${dsetInfo.attachFilename}')"><img src="/images/avsc/ico_file.png" alt="다운로드" />&nbsp<i class="font_lGray">${dsetInfo.attachFilename}</i> [${dsetInfo.fileSizeView} Kbyte]</a>
                  </c:when>
                  <c:otherwise>
                    -
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
            <tr>
              <td>
                <div class="fileBox lg">
                  <input type="file" name="file_info" id="file_info" class="uploadBtn" onChange="fileExtCheck(this);">
                  <input type="text" name="filename_a" id="filename_a" class="fileName" readonly placeholder="선택된 파일 없음">
                  <label for="file_info" class="btn_file btn_md btn_l_gray">파일선택</label>
                </div>
              </td>
            </tr>
            <tr>
              <td class="left border_l_none lh_sm"><i class="font_orange">※ 파일을 선택하시면 기존 등록된 파일이 삭제됩니다</i></td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="center mt20">
        <a href="javascript:fn_Save('${bdwr_seq}','${bbs_seq}');" class="btn_sky btn_lg mr5">저장</a>
        <a href="/agency/consultative/Agcy_Dset_Info.do?bdwr_seq=${bdwr_seq}&bbs_seq=${bbs_seq}" class="btn_gray btn_lg">취소</a>
      </div>
    </div>
    <!-- //contents -->
  </div>
  <!--  contWrap -->
</div>
<!-- //container -->

<script type="text/javaScript">
	var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "bdwr_cts",
		sSkinURI: "/se2/SmartEditor2Skin.html",
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : false,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			fOnBeforeUnload : function(){
				//alert("완료!");
			}
		}, //boolean
		fOnAppLoad : function(){
			//예제 코드
			//oEditors.getById["ir1"].exec("PASTE_HTML", ["로딩이 완료된 후에 본문에 삽입되는 text입니다."]);
		},
		fCreator: "createSEditor2"
	});
</script>

</form:form>
