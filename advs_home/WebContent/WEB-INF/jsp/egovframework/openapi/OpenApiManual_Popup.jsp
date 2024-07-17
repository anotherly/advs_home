<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="t" %>

<!DOCTYPE html>
<html lang="ko" >
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OpenApi 사용 매뉴얼</title>
<link rel="stylesheet" href="/css/avsc/style.css" type="text/css" />

<script src="/js/jquery-1.12.4.min.js"></script>
<script src="/js/common.js" type="text/javascript"></script>
<script src="/js/common/commonFunction.js"></script> <!-- 공통 script 함수를 정의 -->
<!-- ie9이하 html5 -->
<!--[if lt IE 9]>
    <script src="../js/respond.min.js"></script>
    <script src="../js/html5shiv.min.js"></script>
<![endif]-->
<!-- ie9이하 input text placeholder -->
<script src="/js/placeholders.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">

  //폼 변수
  var c_form = "";

  $(document).ready(function() {
    c_form = document.listForm; //폼 셋팅

  });

</script>
</head>

<body>
<form:form id="listForm" name="listForm" method="post" >

<!-- 팝업 -->
<div class="modal-content" style="width:800px;">
  <div class="modal-header">OpenApi 사용방법<a href="javascript:self.close();" class="pop_close"></a></div>

  <div class="modal-body">
  <h4>* 서비스 개요</h4>
    <div class="table2 mt10">
      <table summary="" class="">
        <colgroup>
          <col width="25%">
          <col width="">
        </colgroup>
        <tbody>
          <tr>
            <th class="border_l_none">서비스명</th>
            <td class="lh_sm">협의체데이터 조회 서비스</td>
            <th class="border_l_none">서비스 인증/권한</th>
            <td class="lh_sm">서비스 Key</td>
          </tr>
          <tr>
            <th class="border_l_none">메시지 레벨 암호화</th>
            <td class="lh_sm">없음</td>
            <th class="border_l_none">전송 레벨 암호화</th>
            <td class="lh_sm">없음</td>          	
          </tr>
          <tr>
            <th class="border_l_none">인터페이스 표준</th>
            <td class="lh_sm">REST GET Method</td>
            <th class="border_l_none">교환 데이터 표준</th>
            <td class="lh_sm">XML, JSON</td>          	
          </tr>
          <tr>
            <th class="border_l_none">서비스 URL</th>
            <td class="lh_sm" colspan="3">https://avds.kotsa.or.kr/openapi/rest/(xml or json)/getOpenApiConsData.do</td>
          </tr>    
          <tr>
            <th class="border_l_none">메시지 교환 유형</th>
            <td class="lh_sm">Request-Response</td>
            <th class="border_l_none">사용 제약 사항</th>
            <td class="lh_sm">N/A</td>          	
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  
  <div class="modal-body">
  <h4>* 요청 메시지 명세</h4>
    <div class="table2 mt10">
      <table summary="" class="">
        <colgroup>
          <col width="25%">
          <col width="">
        </colgroup>
        <tbody>
          <tr>
            <th class="border_l_none">항목명(영문)</th>
            <th class="border_l_none">항목명(국문)</th>
            <th class="border_l_none">항목크기</th>
            <th class="border_l_none">항목구분</th>
            <th class="border_l_none">샘플데이터</th>
            <th class="border_l_none">항목설명</th>
          </tr>
          <tr>
          	<td class="lh_sm">apiKey</td> 
          	<td class="lh_sm">키</td>
          	<td class="lh_sm">50</td>
          	<td class="lh_sm">1</td>
          	<td class="lh_sm">-</td>
          	<td class="lh_sm">발급받은 apiKey</td>
          </tr>          
          <tr>
          	<td class="lh_sm">consType</td> 
          	<td class="lh_sm">협의체데이터 유형</td>
          	<td class="lh_sm">10</td>
          	<td class="lh_sm">1</td>
          	<td class="lh_sm">VDC</td>
          	<td class="lh_sm">협의체데이터 유형</td>
          </tr>
          <tr>
          	<td class="lh_sm">drivingMode</td> 
          	<td class="lh_sm">드라이빙모드</td>
          	<td class="lh_sm">3</td>
          	<td class="lh_sm">0</td>
          	<td class="lh_sm">101</td>
          	<td class="lh_sm">자율주행자동차 드라이빙 모드 정보</td>
          </tr>    
          <tr>
          	<td class="lh_sm">weather</td> 
          	<td class="lh_sm">날씨</td>
          	<td class="lh_sm">3</td>
          	<td class="lh_sm">0</td>
          	<td class="lh_sm">101</td>
          	<td class="lh_sm">날씨정보</td>
          </tr>      
          <tr>
          	<td class="lh_sm">roadSituation</td> 
          	<td class="lh_sm">도로상태</td>
          	<td class="lh_sm">3</td>
          	<td class="lh_sm">0</td>
          	<td class="lh_sm">101</td>
          	<td class="lh_sm">도로상태 정보</td>
          </tr> 
          <tr>
          	<td class="lh_sm">roadTypeCd</td> 
          	<td class="lh_sm">도로유형</td>
          	<td class="lh_sm">3</td>
          	<td class="lh_sm">0</td>
          	<td class="lh_sm">101</td>
          	<td class="lh_sm">도로유형 정보</td>
          </tr>                                  
         </tbody>
      </table>
    </div>
  </div>
  
  <div class="modal-body">
  <h4>* 협의체 데이터 유형 코드</h4>
    <div class="table2 mt10">
      <table summary="" class="">
        <colgroup>
          <col width="30%">
          <col width="">
        </colgroup>
        <tbody>
          <tr>
            <th class="border_l_none">코드</th>
            <th class="border_l_none">코드명</th>
          </tr>
          <tr>
          	<td class="lh_sm">VDC</td> 
          	<td class="lh_sm">차량거동정보</td>
          </tr>          
          <tr>
          	<td class="lh_sm">DV</td> 
          	<td class="lh_sm">주행영상정보</td>
          </tr> 
          <tr>
          	<td class="lh_sm">SENSOR</td> 
          	<td class="lh_sm">센서정보</td>
          </tr>          
          <tr>
          	<td class="lh_sm">SDL</td> 
          	<td class="lh_sm">자율주행학습정보</td>
          </tr> 
          <tr>
          	<td class="lh_sm">FUSION</td> 
          	<td class="lh_sm">융합정보</td>
          </tr>          
          <tr>
          	<td class="lh_sm">V2X</td> 
          	<td class="lh_sm">V2X정보</td>
          </tr>
          <tr>
          	<td class="lh_sm">ESD</td> 
          	<td class="lh_sm">기타자율주행정보</td>
          </tr>            
         </tbody>
      </table>
    </div>
  </div>
  
  <div class="modal-body">
  <h4>* 오류 코드</h4>
    <div class="table2 mt10">
      <table summary="" class="">
        <colgroup>
          <col width="30%">
          <col width="">
        </colgroup>
        <tbody>
          <tr>
            <th class="border_l_none">코드</th>
            <th class="border_l_none">코드명</th>
          </tr>
          <tr>
          	<td class="lh_sm">00</td> 
          	<td class="lh_sm">성공</td>
          </tr>          
          <tr>
          	<td class="lh_sm">41</td> 
          	<td class="lh_sm">Api Key 미입력</td>
          </tr> 
          <tr>
          	<td class="lh_sm">42</td> 
          	<td class="lh_sm">정의되지 않은 Api Key</td>
          </tr>          
          <tr>
          	<td class="lh_sm">43</td> 
          	<td class="lh_sm">승인되지 않은 Api Key</td>
          </tr> 
          <tr>
          	<td class="lh_sm">51</td> 
          	<td class="lh_sm">협의체데이터구분 미입력</td>
          </tr>          
          <tr>
          	<td class="lh_sm">52</td> 
          	<td class="lh_sm">존재하지 않은 협의체데이터구분</td>
          </tr>
          <tr>
          	<td class="lh_sm">61</td> 
          	<td class="lh_sm">조회 된 협의체데이터 없음</td>
          </tr> 
          <tr>
          	<td class="lh_sm">99</td> 
          	<td class="lh_sm">알수 없는 시스템 오류</td>
          </tr>                        
         </tbody>
      </table>
    </div>
  </div>  
  
  <div class="modal-body">
  <h4>* 요청 예제</h4>
    <div class="table2 mt10">
      <table summary="" class="">
        <colgroup>
          <col width="10%">
          <col width="">
        </colgroup>
        <tbody>
          <tr>
            <th class="border_l_none">XML</th>
            <td class="lh_sm">https://avds.kotsa.or.kr/openapi/rest/xml/getOpenApiConsData.do?apiKey=38JFj398jafjlafJfi39uJF2&consType=VDS</td>
          </tr>
          <tr>
            <th class="border_l_none">JSON</th>
            <td class="lh_sm">https://avds.kotsa.or.kr/openapi/rest/json/getOpenApiConsData.do?apiKey=38JFj398jafjlafJfi39uJF2&consType=VDS</td>
          </tr>          
         </tbody>
      </table>
    </div>
  </div>   
  
  <div class="modal-footer">
    <a href="javascript:self.close();" class="btn_gray btn_lg">확인</a>
  </div>
</div>
<!-- //팝업 -->
</form:form>
</body>
</html>
