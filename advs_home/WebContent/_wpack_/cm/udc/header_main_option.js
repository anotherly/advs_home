/*amd /cm/udc/header_main_option.xml 5045 ed7c34c11a2d4d5158dc1f49118198d2a63c4d0234d29cbe76f8c5a3fda504c2 */
define({declaration:{A:{version:'1.0',encoding:'UTF-8'}},E:[{T:7,N:'xml-stylesheet',instruction:'href="/cm/css/all.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/cm/css/content.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/cm/css/Responsive.css" type="text/css"'},{T:1,N:'html',A:{xmlns:'http://www.w3.org/1999/xhtml','xmlns:ev':'http://www.w3.org/2001/xml-events','xmlns:w2':'http://www.inswave.com/websquare','xmlns:xf':'http://www.w3.org/2002/xforms'},E:[{T:1,N:'head',E:[{T:1,N:'w2:type',A:{palette:'support'},E:[{T:3,text:'COMPONENT'}]},{T:1,N:'w2:buildDate'},{T:1,N:'w2:publicInfo',A:{method:'scwin.setUserInfo,scwin.show,scwin.hide',component:''}},{T:1,N:'xf:model',E:[{T:1,N:'w2:dataCollection',A:{baseNode:'map'}},{T:1,N:'w2:workflowCollection'}]},{T:1,N:'publicInfo',A:{method:''}},{T:1,N:'script',A:{type:'text/javascript',lazy:'false'},E:[{T:4,cdata:function(scopeObj){with(scopeObj){
        /**
         * @component
         * @company 
         * @developer inswave008
         * @variableClone true
         * @notSupportBrowser 
         * @version 
         * @htmlRender 
         * @icon 
         * @disableIcon 
         * @width 
         * @height 
         * @description 
         */ 
        
	scwin.onpageload = function() {
	};
	
	scwin.onpageunload = function() {
		
	};
	
	
	scwin.btn_logout_onclick = function() {
		com.logout();
	};
	
	scwin.btn_changePassword_onclick = function() {
		var winWid = $(window).width();
		var winHei = $(window).height();
		
		var popWid = 500;
		var popHei = 330;
		
		if (com.isAdmin()) {
			popHei -= 44;
		}
		
		var sumLeft = (winWid - popWid) / 2;
		var sumTop = (winHei - popHei) / 2;
		
		// global data ?
		
		if ( $c.common.getSideType() == "1" ){ 
			var data = { "empCd" : $p.top().wfm_side.getWindow().dma_defInfo.get("EMP_CD") };
		} else {
			var data = { "empCd" : $p.parent().$p.parent().$p.getComponentById( 'udc_side').dma_defInfo.get("EMP_CD") };
		}
		
		
		var opts = {
		"id" : "settingPassword",
		"width" : popWid + "px",
		"height" : popHei + "px",
		"top" : sumTop, 
		"left" : sumLeft,
		"popupName" : "비밀번호변경",
		"modal" : true, 
		"useIFrame" : false,
		"title" : "비밀번호변경",
		"useATagBtn" : true,
		"frameMode" : "wframe"
		};
		com.openPopup("/cm/xml/settingPassword.xml", opts, data);
	};
	
	scwin.btn_setting_onclick = function() {
		var data = { "data" : "", callbackFn : "scwin.callbackSetting" };
		var winWid = $(window).width();
		var winHei = $(window).height();
		var popWid = 500;
		var popHei = 250;
		var sumLeft = (winWid - popWid) / 2;
		var sumTop = (winHei - popHei) / 2;
		
		
		var opts = {
			"id" : "mainSettingPop",
			"width" : popWid + "px",
			"height" : popHei + "px",
			"top" : sumTop, 
			"left" : sumLeft,
			"popupName" : "환경설정 관리",
			"modal" : true, 
			"useIFrame" : false,
			"title" : "환경설정 관리",
			"useATagBtn" : true,
			"frameMode" : "wframe"
		};
		
		com.openPopup("/cm/xml/settingPop.xml", opts, data);
	};
	
	scwin.callbackSetting = function() {
		$c.common.confirm($p ,"정상 처리되었습니다. 화면을 갱신하시겠습니까?", "scwin.execUpdateMainSettingConfirmCallback");
	};
	
	scwin.execUpdateMainSettingConfirmCallback = function(isConfirm) {
		if (isConfirm === true) {
			com.goHome();
		}
	};
	
	
	
	scwin.show = function(){
		// this = udc_header_option	을 찾고 싶은 경우, $p.getFrame().
		$p.getFrame().show();
	};
	
	scwin.hide = function(){
		$p.getFrame().hide();
	};
	
	scwin.setUserInfo = function(userInfo){
		scwin.userInfo = userInfo;
		txt_empNm.setValue(scwin.userInfo.EMP_NM);
	};
	
	
	
	
	
	
}}}]}]},{T:1,N:'body',A:{'ev:onpageload':'scwin.onpageload','ev:onpageunload':'scwin.onpageunload'},E:[{T:1,N:'xf:group',A:{class:'option_box',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'',id:'',style:'',tagname:'ul'},E:[{T:1,N:'xf:group',A:{class:'on mypage',id:'',style:'',tagname:'li'},E:[{T:1,N:'w2:anchor',A:{class:'btn_mypage',disabled:'','ev:onclick':'',id:'txt_empNm',outerDiv:'false',style:'',target:'',title:'aa'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'HONG KIL DONG'}]}]},{T:1,N:'xf:group',A:{class:'items',id:'',style:'',tagname:'ul'},E:[{T:1,N:'xf:group',A:{class:'',id:'',style:'',tagname:'li'},E:[{T:1,N:'w2:anchor',A:{'ev:onclick':'scwin.btn_changePassword_onclick',id:'btn_changePassword',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'비밀번호 변경'}]}]}]},{T:1,N:'xf:group',A:{class:'',id:'',style:'',tagname:'li'},E:[{T:1,N:'w2:anchor',A:{class:'','ev:onclick':'scwin.btn_logout_onclick',id:'btn_logout',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'Logout'}]}]}]}]}]},{T:1,N:'xf:group',A:{class:'set',id:'',style:'',tagname:'li'},E:[{T:1,N:'w2:anchor',A:{class:'btn_setting','ev:onclick':'scwin.btn_setting_onclick',id:'btn_setting',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'Setting'}]}]}]}]}]}]}]}]})