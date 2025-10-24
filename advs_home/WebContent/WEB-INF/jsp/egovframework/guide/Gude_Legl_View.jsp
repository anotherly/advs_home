<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!-- <link rel="stylesheet" href="/html/resource/css/lib/fullpage.css"> -->
<!-- <link rel="stylesheet" href="/html/resource/css/ux-common.css"> -->
<!-- <link rel="stylesheet" href="/html/resource/css/sub.css"> -->
<!-- <link rel="stylesheet" href="/html/resource/css/us_ce.css"> -->
<script type="text/javascript" src="/js/lib/jquery/jquery-3.6.1.min.js"></script>
<script type="text/javaScript" language="javascript" defer="defer">
	//폼 변수
	var c_form = "";

	$(document).ready(function() {
		c_form = document.listForm; //폼 셋팅
	});
	
	function grpLink01_onclick() {
		c_form.action = "<c:url value='https://www.law.go.kr/법령/자동차관리법/(19054,20221115)'/>";
	}
	
	function grpLink02_onclick() {
		c_form.action = "<c:url value='https://www.law.go.kr/법령/자동차관리법시행령'/>";
	}
	
	function grpLink03_onclick() {
		c_form.action = "<c:url value='https://www.law.go.kr/법령/자동차관리법시행규칙'/>";
	}
	
	function grpLink04_onclick() {
		c_form.action = "<c:url value='https://www.law.go.kr/행정규칙/자동차운행기록및장치에관한관리지침/(2021-1279,20211126)'/>";
	}
	
</script>

<form:form id="listForm" name="listForm" method="post">
<div class="skip">
	<a href="#container">Go to Content</a>
</div>

<!-- container -->
<div class="wrap">
	<div class="container">
		<div class="container__inner">
			<div class=content>
				<div class="content__inner">
			
					<div class="layout-container layout-full">
	                    <div class="layout-container__inner layout-container--row">
							<div class="lnb">
	                            <h3 class="lnb__tit">이용안내</h3>
	                            <div class="lnb-list">
	                                <div class="lnb-item">
	                                    <a href="/center/introduce/Gude_Avsc_View.do">데이터 공유센터 소개</a>
	                                </div>
	                                <div class="lnb-item">
	                                    <a href="/center/introduce/Gude_Cits_View.do">자율주행 AI 학습용 데이터</a>
	                                </div>
	                                <div class="lnb-item">
	                                    <a href="/center/introduce/Gude_Cons_View.do">데이터공유협의체</a>
	                                </div>
	                                <div class="lnb-item is-active">
	                                    <a href="/center/introduce/Gude_Legl_View.do">법령 및 지침</a>
	                                </div>
	                                <div class="lnb-item">
	                                    <a href="/center/introduce/Gude_Rept_View.do">자율주행차 임시운행허가</a>
	                                </div>
	                            </div>
	                        </div>
	                        
	                        <div class="layout-content">
                           		<div class="layout-content__inner">
                           			<div class="layout-content__top">
	                                    <h4 class="layout-content__tit">법령 및 지침</h4>
	                                    <ul class="location ml-auto">
	                                        <li>
	                                            <img src="/image/sub/icon/icon-home.png" alt="홈">
	                                        </li>
	                                        <li>이용안내</li>
	                                        <li>법령 및 지침</li>
	                                    </ul>
	                                </div>
	                                <h5 class="layout-content__subtit">법령</h5>
									<div class="layout-content__view">
										<div class="table-wrap">
											<table summary="" class="table-basic table-basic--col table-us_ce_04_list" style="width:100%;">
												<colgroup>
													<col width="60%">
													<col width="20%">
													<col width="20%">
												</colgroup>
												<thead>
													<tr>
														<th>자료명</th>
														<th>출처</th>
														<th>링크</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>TS한국교통안전공단 자동차안전연구원 자동차관리법</td>
														<td>법제처 국가법령정보센터</td>
														<td>
															<button id="grpLink01" class="btn btn-color--white btn-width--120" onclick="grpLink01_onclick()">
																<img src="/image/sub/icon-link--abroad.png" alt=""> 바로가기
															</button>
														</td>
													</tr>
													<tr>
														<td>TS한국교통안전공단 자동차안전연구원 자동차관리법 시행령</td>
														<td>법제처 국가법령정보센터</td>
														<td>
															<button id="grpLink02" class="btn btn-color--white btn-width--120" onclick="grpLink02_onclick()">
																<img src="/image/sub/icon-link--abroad.png" alt=""> 바로가기
															</button>
														</td>
													</tr>
													<tr>
														<td>TS한국교통안전공단 자동차안전연구원 자동차관리법 시행규칙</td>
														<td>법제처 국가법령정보센터</td>
														<td>
															<button id="grpLink03" class="btn btn-color--white btn-width--120" onclick="grpLink03_onclick()">
																<img src="/image/sub/icon-link--abroad.png" alt=""> 바로가기
															</button>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
									
									<h5 class="layout-content__subtit mt-30">지침</h5>
									<div class="layout-content__view mb-80">
										<div class="table-wrap">
											<table summary="" class="table-basic table-basic--col table-us_ce_04_list" style="width:100%;">
												<colgroup>
													<col width="60%">
													<col width="20%">
													<col width="20%">
												</colgroup>
												<thead>
													<tr>
														<th>자료명</th>
														<th>출처</th>
														<th>링크</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>자동차 운행기록 및 장치에 관한 관리지침</td>
														<td>법제처 국가법령정보센터</td>
														<td>
															<button id="grpLink04" class="btn btn-color--white btn-width--120" onclick="grpLink04_onclick()">
																<img src="/image/sub/icon-link--abroad.png" alt=""> 바로가기
															</button>
														</td>
													</tr>
												</tbody>
											</table>
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
</div>
<!-- //container -->
</form:form>
