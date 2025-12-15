/* 페이지 이동 function */
/*
 * URL 이동
 * parameter : :url
 */
function urlReplace(url) {
	location.replace(url);
}
/*
 * 로그아웃
 * parameter : url:url, auth:권한
 */
function fn_Logout() {
	if(confirm("로그아웃 하시겠습니까?")) {
		var url = "/account/Logout_Process.do";
		urlReplace(url);
	} else {
		return;
	}
}
/*
 * 페이지 : 공공데이터개방
 * parameter : url:url, auth:권한
 */
function fn_OpenView(url, auth, user) {
	if( !nullCheck(user) ) {
		url = "https://www.kotsa.or.kr/mbs/inqFrmLogin.do?nextPage=https://avds.kotsa.or.kr/sso/CreateRequest.jsp?RelayState=https://avds.kotsa.or.kr/main/Connect_Log_Process.do";
	} else {
		if( !nullCheck(auth) ) {
			if(confirm("등록된 사용자가 아닙니다. 권한신청을 하시겠습니까?")) {
				url = "/supervise/Power_Rights_List.do";
			} else {
				return;
			}
		}
	}
	urlReplace(url);
}
/*
 * 페이지 : 협의체데이터
 * parameter : url:url, auth:권한
 */
function fn_AgcyView(url, auth, user) {
	if( !nullCheck(user) ) {
		url = "https://www.kotsa.or.kr/mbs/inqFrmLogin.do?nextPage=https://avds.kotsa.or.kr/sso/CreateRequest.jsp?RelayState=https://avds.kotsa.or.kr/main/Connect_Log_Process.do";
	} else {
		if( !nullCheck(auth) ) {
			if(confirm("등록된 사용자가 아닙니다. 권한신청을 하시겠습니까?")) {
				url = "/supervise/Power_Rights_List.do";
			} else {
				return;
			}
		} else {
			if(auth == '101' || auth == '104') {
				alert('협의체기관만 접근이 가능합니다');
				url = "/center/introduce/Gude_Cons_View.do";
			}
		}
	}
	urlReplace(url);
}
/*
 * 페이지 : 운행정보보고
 * parameter : url:url, auth:권한
 */
function fn_DutyView(url, auth, user) {
	console.log(" 페이지 : 운행정보보고 fn_DutyView");
	if( !nullCheck(user) ) {
		url = "https://www.kotsa.or.kr/mbs/inqFrmLogin.do?nextPage=https://avds.kotsa.or.kr/sso/CreateRequest.jsp?RelayState=https://avds.kotsa.or.kr/main/Connect_Log_Process.do";
	} else {
		if( !nullCheck(auth) ) {
			if(confirm("등록된 사용자가 아닙니다. 권한신청을 하시겠습니까?")) {
				url = "/supervise/Power_Rights_List.do";
			} else {
				return;
			}
		} else {
			if(auth == '101' || auth == '102') {
				alert('임시운행기관만 접근이 가능합니다');
				url = "/center/introduce/Gude_Rept_View.do";
			}
		}
	}
	urlReplace(url);
}
/*
 * 페이지 : 데이터업로드
 * parameter : url:url, auth:권한
 */
function fn_DtupView(url, auth, user) {
	if( !nullCheck(user) ) {
		url = "https://www.kotsa.or.kr/mbs/inqFrmLogin.do?nextPage=https://avds.kotsa.or.kr/sso/CreateRequest.jsp?RelayState=https://avds.kotsa.or.kr/main/Connect_Log_Process.do";
	} else {
		if( !nullCheck(auth) ) {
			if(confirm("등록된 사용자가 아닙니다. 권한신청을 하시겠습니까?")) {
				url = "/supervise/Power_Rights_List.do";
			} else {
				return;
			}
		} else {
			if(auth == '101' || auth == '104') {
				alert('사용 권한이 없습니다');
				url = "/center/introduce/Gude_Cons_View.do";
			}
		}
	}
	urlReplace(url);
}

/* 문자열 체크 function */
/*
 * input 문자 입력체크 함수
 * parameter : (입력 text, 최대 text)
 * 함수 onkeyup로 입력
 * 입력 예 : onkeyup="checkLength(this,100)"
 */
function checkLength(inputStr, strSize) {
	var tempStr;
	var tempCode;
	var strCount=0;
	var limit=strSize;
	var strLen = inputStr.value.length;
	for(var i=0;i<strLen;i++) {
		tempStr = inputStr.value.charAt(i);
		tempCode = inputStr.value.charCodeAt(i);
		if(escape(tempStr).length>4) {
			strCount +=2;
		} else if(tempStr=='\n') {
			if(inputStr.value.charAt(i-1)!='\r') {
				strCount +=1;
			}
		} else if(tempStr=='<'||tempStr=='>') {
			strCount+=4;
		} else if(tempCode>=12592) {
			strCount+=2;
		} else {
			strCount ++;
		}
	}
	if(strCount>limit) {
		var overSize = strCount-limit;
		alert("내용은 "+limit+"Byte까지 허용이 됩니다. \n ※ "+overSize+"Byte를 초과했습니다. ");
		/*var temp_index = 0;
		if(inputStr.value.charCodeAt(strLen-1)>=12592){
			temp_index = 1;
		}
		alert(strLen-overSize);*/
		inputStr.value = inputStr.value.substr(0, (strLen-overSize));
		inputStr.focus();
	}
}


/*
 * input 숫자 입력체크 함수 : 키 이벤트로 문자 입력을 제한
 * parameter : (이벤트, 정수입력:false/실수입력:true, 객체, 입력제한 byte)
 * maxlength와 함계 사용, 함수 onkeypress로 입력
 * 입력 예 : maxlength="10" onkeypress="return numbersonly(event, false, this, 10)"
 */
function numbersonly(e, decimal, obj, num) { //숫자처리
	var key;
	var keychar;
	if (window.event) {
		key = window.event.keyCode;
	} else if (e) {
		key = e.which;
	} else {
		return true;
	}

	keychar = String.fromCharCode(key);

	var tt = obj.value.indexOf(".");
	if ((keychar>33 && keychar <45) ||(keychar >46 && keychar < 48) || keychar > 57) {
		return false;
	} else if (obj.value.length >= num){  //숫자제한부분
		return false;
	} else if ((("0123456789").indexOf(keychar) > -1)) {
		return true;
	} else if ( (obj.value.indexOf(".")==-1 && decimal==true && keychar == ".")) {
		return true;
	} else {
		return false;
	}
}

//공백 제거 함수
function trim(str){
	var i,j = 0;
 	var objstr;
 	if(str == "" || str == " ") {
 		return "";
 	} else {
 	 	for(var i=0; i< str.length; i++){
 	 		if(str.charAt(i) == ' ')
 				j=j + 1;
 	 		else
 				break;
 	 	}
 	 	str = str.substring(j, str.length - j + 1);
 	 	i,j = 0;
 	 	for(var i = str.length-1;i>=0; i--){
 			if(str.charAt(i) == ' ')
 		 		j=j + 1;
 	 		else
 				break;
 	 	}
 	 	return str.substring(0, str.length - j);
 	}
}

//모든 공백 제거
function allSpaceRemove(val){
	var reult_str = ""; //반환값
	for(var i=0 ; i < val.length ; i++){
		var temp_str = val.charAt(i);
		if(temp_str == " "){
			temp_str = "";
		}
		reult_str += temp_str;
	}
	return reult_str;
}

//null 체크 함수
function nullCheck(str) {
	if( str == null || str == '' || str == 'null') {
		return false;
	} else {
		return true;
	}

}

//숫자 체크 함수
function intCheck(str) {
	if( str == null || str == '' || str == 'null') {
		return 0;
	} else {
		return parseInt(str);
	}

}

/* 파일 사이즈 체크 function */
/*
 * input file 타입 : 파일 사이즈 체크 함수
 * parameter : (입력 file type, 제한 사이즈 limit)
 * submit 전 체크
 * 입력 예 : fileSizeCheck(file, 100) 100MB 제한 확인"
 */
function fileSizeCheck(file, limit) {
	var maxSize  = limit * 1024 * 1024;  //MB 단위
	var fileSize = 0;
	// 브라우저 확인
	var browser = navigator.appName;
	// 익스플로러일 경우
	if (browser=="Microsoft Internet Explorer") {
		var oas = new ActiveXObject("Scripting.FileSystemObject");
		fileSize = oas.getFile( file.value ).size;
	} else {
		fileSize = file.files[0].size;
	}
	if(fileSize > maxSize) {
		alert("[파일사이즈 : "+ fileSize +"], 첨부파일 사이즈는 100MB 이내로 등록 가능합니다");
		file.focus();
		return false;
	} else {
		return true;
	}
}

/*
 * input file 타입 : 파일 확장자 체크 함수
 * parameter : (입력 file object)
 * submit 전 체크
 * 입력 예 : fileExtCheck(this) "
 */
function fileExtCheck(obj) {
	var strFilePath = obj.value;
	// 정규식
	//var RegExtFilter = /\.(jsp|asp|php|html)$/i;
	//if (strFilePath.match(RegExtFilter) == null) alert("허용하지 않는 확장자 (1)");
	//if (RegExtFilter.test(strFilePath) == false) alert("허용하지 않는 확장자 (2)");

	// inArray
	var strExt = strFilePath.split('.').pop().toLowerCase();
	if ($.inArray(strExt, ["asa","asp","cdx","cer","htr","aspx","jsp","jspx","html","htm","php","php3","php4","php5","sh","exe"]) > -1)	{
		alert("jsp,asp,php,html 파일은 업로드 할 수 없습니다");
		obj.value = "";
		//obj.outerHTML = obj.outerHTML;
	}
}

//문자 태그 처리 함수
function injectionCheck(obj) {
	var str = obj.value;
	if( str == null || str == '' || str == 'null') {
		obj.value = "";
	} else {
		str = str.replace(/</g,"");
		str = str.replace(/>/g,"");
		str = str.replace(/\"/g,"");
		str = str.replace(/\'/g,"");
		str = str.replace(/\n/g,"");
		obj.value = str;
	}
}
