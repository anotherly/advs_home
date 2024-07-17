/*amd /cm/udc/header_main.xml 8642 99742493d0144ad6bc9d59d852e389e39260c68ef37543dc9fa6df5baa10937b */
define({declaration:{A:{version:'1.0',encoding:'UTF-8'}},E:[{T:7,N:'xml-stylesheet',instruction:'href="/cm/css/all.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/cm/css/content.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/cm/css/Responsive.css" type="text/css"'},{T:1,N:'html',A:{xmlns:'http://www.w3.org/1999/xhtml','xmlns:ev':'http://www.w3.org/2001/xml-events','xmlns:w2':'http://www.inswave.com/websquare','xmlns:xf':'http://www.w3.org/2002/xforms'},E:[{T:1,N:'head',E:[{T:1,N:'w2:type',A:{palette:'support'},E:[{T:3,text:'COMPONENT'}]},{T:1,N:'w2:buildDate'},{T:1,N:'w2:publicInfo',A:{method:'scwin.setUserInfo,scwin.setGenerator,scwin.setMenuCss',component:''}},{T:1,N:'xf:model',E:[{T:1,N:'w2:dataCollection',A:{baseNode:'map'}},{T:1,N:'w2:workflowCollection'}]},{T:1,N:'publicInfo',A:{method:''}},{T:1,N:'script',A:{type:'text/javascript',lazy:'false'},E:[{T:4,cdata:function(scopeObj){with(scopeObj){
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
         * @width 100%
         * @height 100%
         * @description 
         */ 
 
        /**
         * @property
         * @name id
         * @category 04.Action
         * @type string
         * @option 
         * @necessary N
         * @description desc
         */ 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 /**
  * @property
  * @name style
  * @category 01.Basic & ETC
  * @type string
  * @option 
  * @necessary N
  * @description desc
  */ 
 
 /**
  * @property
  * @name class
  * @category 01.Basic & ETC
  * @type string
  * @option 
  * @necessary N
  * @description desc
  */ 
 
 
 
 
 
 
 
 
        
	scwin.onpageload = function() {
		scwin.udc = {
    		prefix : '',
    		options : '',
    		aliasDataList : '',
    		data : { 
    			menuData : ''
    		},
    		//-------------------
    		firstGenInx : -1, 
    		loginYn : false
    	};	
    	
    	scwin.udc.prefix = $p.id ;
		scwin.udc.options = $p.getOptions();
		
		
		var _useDefaultOptBox = scwin.udc.options.useDefaultOptionBox;
		
		if( WebSquare.util.getBoolean(_useDefaultOptBox) ){
			udc_header_option.show();
		}
		else {
			udc_header_option.hide();	
		}
		
	};
	
	scwin.onpageunload = function() {
		scwin.udc.loginYn = false;
	};
	
	
	
	scwin.setGenerator = function(tmpDataArr) {
	//scwin.createMenu = function(tmpDataArr){
		scwin.udc.data.menuData = tmpDataArr;
		
		gen_firstGenerator.removeAll();
	
		//첫번째 메뉴 세팅
		for (var i = 0; i < tmpDataArr.length; i++) {
			var headerData_obj = tmpDataArr[i];
			var menuDepth = headerData_obj.MENU_LEVEL;
			var parentKey = headerData_obj.PARENT_MENU_CD; // m1, m2, m3
			var tmpIdx = 0, tmpIdx2 = 0;
			if (menuDepth == "1") {
				tmpParentIdx = gen_firstGenerator.insertChild();
				var firstMenuLabel = gen_firstGenerator.getChild(tmpParentIdx, "btn_menu1_Label");
				firstMenuLabel.setValue(headerData_obj.MENU_NM);
				firstMenuLabel.setUserData("ins_webPath", headerData_obj.SRC_PATH);
				firstMenuLabel.setUserData("ins_key", headerData_obj.PARENT_MENU_CD);
				firstMenuLabel.setUserData("ins_label", headerData_obj.MENU_NM);
				firstMenuLabel.setUserData("ins_code", headerData_obj.MENU_CD);
			} else if (menuDepth == "2") {
				
				var secondGene = gen_firstGenerator.getChild(tmpParentIdx, "gen_SecondGenerator");
				tmpIdx = secondGene.insertChild();
				var secondMenuLabel = secondGene.getChild(tmpIdx, "btn_menu2_Label");
				secondMenuLabel.setValue(headerData_obj.MENU_NM);
				thirdIndex = tmpIdx;
			} else if (menuDepth == "3") {
				var thirdGene = secondGene.getChild(thirdIndex, "gen_thirdGenerator");
				tmpIdx2 = thirdGene.insertChild();
				var thirdMenuLabel = thirdGene.getChild(tmpIdx2, "btn_menu3_Label");
				thirdMenuLabel.setValue(headerData_obj.MENU_NM);
				thirdMenuLabel.setUserData("ins_webPath", headerData_obj.SRC_PATH);
				thirdMenuLabel.setUserData("ins_key", headerData_obj.PARENT_MENU_CD);
				thirdMenuLabel.setUserData("ins_label", headerData_obj.MENU_NM);
				thirdMenuLabel.setUserData("ins_code", headerData_obj.MENU_CD);
			}
		}
	};
	
	
	/** 
	 * 생성된 메뉴의 css 적용한다.
	 */
	scwin.setMenuCss = function() {
		// GNB MENU
		$(function() {
			$(".gnb_menu a").click(function(){
			
				if(!$(this).parent().hasClass("on")){
					$(this).parent().addClass("on").siblings().removeClass("on");
				}
			});
			$(".dep2 li a").click(function(){ 
				var pTop = $(this).parent().position().top;
				$(this).siblings().css("top", pTop + "px");
			});
			$(".dep2").mouseleave(function(){
				$(this).parent().removeClass("on");
				$(this).children().removeClass("on");
			});
			$(".items").mouseleave(function(){
				$(this).removeClass("on");
			});
			
		});
	};
	
	
	scwin.setUserInfo = function( userInfo ){
		scwin.userInfo = userInfo;
		udc_header_option.setUserInfo(scwin.userInfo );
	};
	
	
	
	
	
	/**
	 * header에 속한 메뉴 클릭 이벤트 1depth
	 */
	scwin.btn_menu1_Label_onclick = function() {
			
		
		var urlPath = this.getUserData("ins_webPath");
		
		if( urlPath && urlPath != ""){
			var label = this.getUserData("ins_label");
			var pageCode = this.getUserData("ins_code");
			if ( $c.common.getSideType($p) == "2" ){
				$p.top().udc_side.setMenuRelation(label, urlPath, pageCode);	
			} else {
				$p.top().wfm_side.getWindow().scwin.setMenuRelation(label, urlPath, pageCode);
			}

			
			$(".dep2").removeClass('on');
			$(".search_box").removeClass('hid');
			$(".gnb_menu").removeClass('show');
			//$p.parent().wrap.setStyle('overflow', 'visible');
		}

	};
	
	scwin.btn_menu2_Label_onclick = function() {
		var urlPath = this.getUserData("ins_webPath");
		
		if(urlPath && urlPath != ""){
			var label = this.getUserData("ins_label");
			var pageCode = this.getUserData("ins_code");
			if ( $c.common.getSideType($p) == "2" ){
				$p.top().udc_side.setMenuRelation(label, urlPath, pageCode);	
			} else {
				$p.top().wfm_side.getWindow().scwin.setMenuRelation(label, urlPath, pageCode);
			}
			$(".dep2").removeClass('on');
			$(".search_box").removeClass('hid');
			$(".gnb_menu").removeClass('show');
			$(".gnb_menu li").removeClass('on');		
		}
		
	};
	
	scwin.btn_menu3_Label_onclick = function() {
		var urlPath = this.getUserData("ins_webPath");
		if(urlPath && urlPath != ""){
			var label = this.getUserData("ins_label");
			var pageCode = this.getUserData("ins_code");
			if ( $c.common.getSideType($p) == "2" ){
				$p.top().udc_side.setMenuRelation(label, urlPath, pageCode);	
			} else {
				$p.top().wfm_side.getWindow().scwin.setMenuRelation(label, urlPath, pageCode);
			}
			$(".dep2 li").removeClass('on');
			$(".gnb_menu li").removeClass('on');		
		}	
	};
	
}}}]},{T:1,N:'w2:require',A:{as:'udc_header_main_option',type:'page',src:'/cm/udc/header_main_option.xml'}}]},{T:1,N:'body',A:{'ev:onpageload':'scwin.onpageload','ev:onpageunload':'scwin.onpageunload'},E:[{T:1,N:'w2:anchor',A:{class:'btn_toggle_menu','ev:onclick':'scwin.btn_toggle_menu_onclick',href:'',id:'btn_toggle_menu',name:'',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'slide'}]}]},{T:1,N:'xf:group',A:{class:'',id:'',style:'',tagname:'h1'},E:[{T:1,N:'w2:anchor',A:{class:'logo',id:'header_logo',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'inswave systems'}]}]}]},{T:1,N:'w2:generator',A:{class:'gnb_menu',id:'gen_firstGenerator',style:'',tagname:'ul'},E:[{T:1,N:'xf:group',A:{id:'',style:'',tagname:'li'},E:[{T:1,N:'w2:anchor',A:{'ev:onclick':'scwin.btn_menu1_Label_onclick',id:'btn_menu1_Label',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'1depth 메뉴'}]}]},{T:1,N:'w2:generator',A:{class:'dep2',id:'gen_SecondGenerator',style:'',tagname:'ul'},E:[{T:1,N:'xf:group',A:{id:'',style:'',tagname:'li'},E:[{T:1,N:'w2:anchor',A:{'ev:onclick':'scwin.btn_menu2_Label_onclick',id:'btn_menu2_Label',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'2depth 메뉴'}]}]},{T:1,N:'w2:generator',A:{class:'dep3',id:'gen_thirdGenerator',style:'',tagname:'ul'},E:[{T:1,N:'xf:group',A:{id:'',style:'',tagname:'li'},E:[{T:1,N:'w2:anchor',A:{'ev:onclick':'scwin.btn_menu3_Label_onclick',id:'btn_menu3_Label',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'3depth 메뉴'}]}]}]}]}]}]}]}]},{T:1,N:'w2:udc_header_main_option',A:{style:'width: 100%;',id:'udc_header_option'}}]}]}]})