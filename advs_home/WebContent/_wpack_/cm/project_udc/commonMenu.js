/*amd /cm/project_udc/commonMenu.xml 12351 1add5d814d36fba5f2cb66c8ba96910fa3a898d87cfb4a23f188aa146828fb58 */
define({declaration:{A:{version:'1.0',encoding:'UTF-8'}},E:[{T:1,N:'html',A:{xmlns:'http://www.w3.org/1999/xhtml','xmlns:ev':'http://www.w3.org/2001/xml-events','xmlns:w2':'http://www.inswave.com/websquare','xmlns:xf':'http://www.w3.org/2002/xforms'},E:[{T:1,N:'head',E:[{T:1,N:'w2:type',E:[{T:3,text:'COMPONENT'}]},{T:1,N:'w2:buildDate'},{T:1,N:'w2:publicInfo',A:{method:'scwin.initCommonMenu,scwin.getHeaderType,scwin.setHeaderType,\r\n		                       scwin.openMenu,scwin.getSideType,scwin.setSideType,\r\n							   scwin.setLayoutType,  scwin.getLayoutType, scwin.setLayoutId, \r\n							   scwin.getMenuInfo,scwin.setMenuInfo,scwin.getMenuDataList'}},{T:1,N:'xf:model',E:[{T:1,N:'w2:dataCollection',A:{baseNode:'map'}},{T:1,N:'w2:workflowCollection'},{T:1,N:'xf:submission',A:{id:'sbm_menuData',ref:'',target:'data:json,dataList1',action:'',method:'post',mediatype:'application/json',encoding:'UTF-8',instance:'',replace:'',errorHandler:'',customHandler:'',mode:'asynchronous',processMsg:'','ev:submit':'','ev:submitdone':'scwin.sbm_menuData_submitdone','ev:submiterror':'',abortTrigger:''}}]},{T:1,N:'w2:layoutInfo'},{T:1,N:'script',A:{type:'text/javascript',lazy:'false'},E:[{T:4,cdata:function(scopeObj){with(scopeObj){
		
//메뉴관련 array
	scwin.menuCallBackArr = [];
   // 메뉴 관련 변수 셋팅 START
	scwin.COMMON_MENU_INFO   =  {
								  DATA_LIST       : "dlt_menu",   //시스템 오픈시 권한에 따른 전체 메뉴를 관리하는 DATA LIST
								  LEVEL_FIELD     : "MENU_LEVEL",      //메뉴DEPTH
								  ID_FIELD        : "MENU_CD",         //메뉴코드 ( ID )
								  NAME_FIELD      : "MENU_NM",         //메뉴한글
								  SRC_FIELD       : "SRC_PATH",        //메뉴 화면 URL
								  PARENT_FIELD    : "PARENT_MENU_CD",  //상위 메뉴 코드 (ID)
								  FILED_ARR       : [ "BIZ_TYPE","IS_USE","SORT_ORDER","PROGRAM_CD"] 
						        };
	scwin.MENU_COMPONENT_TYPE =  {
									SIDE   : "2",  // WFRAME일 경우 '1', UDC일 경우 '2' , 메인 LAYOUT과 하나의 페이지로 구성되어 있을 경우 '3'
									HEADER : "2"   // WFRAME일 경우 '1', UDC일 경우 '2' , 메인 LAYOUT과 하나의 페이지로  구성되어 있을 경우 '3'   
			                      };
			                      
    scwin.LAYOUT_TYPE       = "T";// 메인 LAYOUT 의 MDI가 TAB CONTROL일 경우 'T' , WINDOW CONTAINER 일 경우 'M', SDI 일 경우 'S'
    scwin.LAYOUT_ID         = "";  // 메인 LAYOUT 의 MDI가 TAB CONTROL ID or  WINDOW CONTAINER ID
        
	if ( scwin.LAYOUT_TYPE == "T" ){
		scwin.LAYOUT_ID =  "tac_layout" ;
	} else if ( scwin.LAYOUT_TYPE == "M" ){
		scwin.LAYOUT_ID =  "wdc_main" ;
	} else if ( scwin.LAYOUT_TYPE == "S" ){
		scwin.LAYOUT_ID =  "wfm_main";
	} 
	
	scwin.selMenuAction = "/main/init";
	scwin.codeActionMethod = "post";
   // 메뉴 관련 변수 셋팅 END


   //팝업관련 변수 셋팅 end

	scwin.onpageload = function() {
        
	};

/////////////////////////////////////////////////
/////////////////////////////////////////////////
//		                                       //
//		main menu 관련  project udc start        //
//		                                       //
/////////////////////////////////////////////////	
/////////////////////////////////////////////////	
 /**
  * @method
  * @name initCommonMenu
  * @description $c.common.menu 초기화 함수 ( menu dataList 동적생성  , 메뉴조회  )
  * @param <object> _$p 호출한 페이지의 scope 객체 
  * @param <object> _callBack 호출한 화면에서 메뉴리스트 조회후 후처리 함수 
  * @hidden N
  * @exception 
  * @sample 
  */ 
 
 	scwin.initCommonMenu = function ( _$p , _callBack ){
		scwin.menuCallBackArr.push(_callBack); // call back함수 - menu data를 서버에서 가져온 다음에 side/header 화면 등에 메뉴데이타를 set하기 위한 콜백함수
		scwin.createCommonMenuDataList();				
	};
	
	
	scwin.getMenuInfo = function(){
		return scwin.COMMON_MENU_INFO;
	};
	
	scwin.setMenuInfo = function( menuInfo ){
		scwin.COMMON_MENU_INFO = menuInfo;
	};
   /**
    * @method
    * @name getHeaderType
    * @description 메인화면 상단 헤더의 컴퍼넌트 타입 조회
    * @return <string> WFRAME일 경우 '1', UDC일 경우 '2' 
    * @hidden N
    * @exception 
    * @sample 
    */ 
 
   scwin.getHeaderType = function( ){
   		return scwin.MENU_COMPONENT_TYPE.HEADER;
   };
   
   scwin.setHeaderType = function( headerType ){
   		scwin.MENU_COMPONENT_TYPE.HEADER = headerType;
   };  
  
 /**
  * @method
  * @name getSideType
  * @description 메인화면 (좌측) 메뉴의 컴퍼넌트 타입 조회
  * @return <string> WFRAME일 경우 '1', UDC일 경우 '2' 
  * @hidden N
  * @exception 
  * @sample 
  */
  
  scwin.getSideType = function(  ){
   		return scwin.MENU_COMPONENT_TYPE.SIDE;
   };	

 
   scwin.setSideType = function(  sideType ){
   		scwin.MENU_COMPONENT_TYPE.SIDE = sideType;
   };	
   
 /**
  * @method
  * @name getLayoutType
  * @description main MDI가 TabCONTROL일 경우 'T' , WINDOW CONTAINER 일 경우 'M'
  * @return <string> TABCONTROL일경우 'T' , WINDOW CONTAINER 일 경우 'M'
  * @hidden N
  * @exception 
  * @sample 
  */   	
   scwin.getLayoutType = function(){
		return scwin.LAYOUT_TYPE;
   };
   
 /**
  * @method
  * @name setLayoutType
  * @description main 화면에서 tabControl  , WINDOW CONTAINER을 변경하는 경우 셋팅
  * @param <String> type TABCONTROL일경우 'T' , WINDOW CONTAINER 일 경우 'M' 
  * @hidden N
  * @exception 
  * @sample 
  */ 
   scwin.setLayoutType = function( type ){
		scwin.LAYOUT_TYPE = type;
	   
	};
	
	
	scwin.setLayoutId = function( id){
		scwin.LAYOUT_ID =  id;
	   
	}; 

	/**
	 * @method
	 * @name createCommonMenuDataList
	 * @description $c.common 메뉴 dataList 동적생성
	 * @hidden Y
	 * @exception 
	 * @sample 
	 */ 
	scwin.createCommonMenuDataList = function(){
		var columnInfoJson = {};
		var columnInfoList = [];

		scwin.COMMON_MENU_INFO.FILED_ARR.push(scwin.COMMON_MENU_INFO.LEVEL_FIELD);
		scwin.COMMON_MENU_INFO.FILED_ARR.push(scwin.COMMON_MENU_INFO.ID_FIELD);
		scwin.COMMON_MENU_INFO.FILED_ARR.push(scwin.COMMON_MENU_INFO.NAME_FIELD);
		scwin.COMMON_MENU_INFO.FILED_ARR.push(scwin.COMMON_MENU_INFO.SRC_FIELD);
		scwin.COMMON_MENU_INFO.FILED_ARR.push(scwin.COMMON_MENU_INFO.PARENT_FIELD);


		var len = scwin.COMMON_MENU_INFO.FILED_ARR.length;
		
		
		for( var j = 0 ; j < len ; j++){
			columnInfoJson = {
				"id"   : scwin.COMMON_MENU_INFO.FILED_ARR[j],
				"name" : scwin.COMMON_MENU_INFO.FILED_ARR[j],
				"dataType" : "text"
			};	
			columnInfoList.push(columnInfoJson);
		}
		
		$c.common.createDataList ( $p , scwin.COMMON_MENU_INFO.DATA_LIST , columnInfoList );
		
//		var dlt_options = {
//				"id" : scwin.COMMON_MENU_INFO.DATA_LIST,
//				"type" : "dataList",
//				"option":{ 
//		                "baseNode":"list" ,
//		               "repeatNode":"map"
//						},
//		        "columnInfo": columnInfoList 
//		};
//		$p.data.create( dlt_options );

		scwin.getTranMenuData();
	}; 	
	
	/**
	 * @method
	 * @name getTranMenuData
	 * @description $c.common 의 메뉴 데이터 조회 함수
	 * @hidden Y
	 * @exception 
	 * @sample 
	 */ 
	scwin.getTranMenuData = function( ){
		
		
		
		var submit = $p.getSubmission("sbm_menuData");
		submit.action = scwin.selMenuAction;
		submit.target = "data:json,"+scwin.COMMON_MENU_INFO.DATA_LIST;
		$p.executeSubmission(sbm_menuData);
	};
	
	scwin.sbm_menuData_submitdone = function(e) {
		var jsonData = $p.getComponentById(scwin.COMMON_MENU_INFO.DATA_LIST).getAllJSON();
		scwin.menuCallBackArr[0]( jsonData );
		
		scwin.menuCallBackArr.shift(); // 배열의 첫번째 요소를 제거\
		
		
		
	};
	
	scwin.getMenuDataList = function(){
	    return $p.getComponentById(scwin.COMMON_MENU_INFO.DATA_LIST);
	};
	

	/**
	 * @method
	 * @name openMenu
	 * @description 메뉴클릭시 TAB CONTROL, WINDOW CONTAINER에 화면추가하기 위한 함수 
	 * @param <object:N> _$p desc
 	 * @param <object:Y> menuInfo 화면url , 화면ID, 화면명 등을 설정한 객체 
 	 * @param <object:N> 화면오픈시 화면에 전달할 데이터 객체 
	 * @hidden N
	 * @exception 
	 * @sample 
	 */ 
	scwin.openMenu = function( _$p, menuNm, url, menuCode, paramObj, menuType, closable){
		
		if (url == "/") {
			var url = document.location.href + "/";
			window.open(url, "", "width=1200, height=700, left=450, top=100");
		} else {
		    menuCode = menuCode || "";
			var layout = $p.top().scwin.getLayoutId();
			var tmpUrl;
			var menuCodeParm = menuCode;
			var data;
	
			if (url.indexOf("/") !== 0) {
				url = "/" + url;
			}
			url = gcm.CONTEXT_PATH + url;
	
			if ((typeof paramObj !== "undefined") && (paramObj !== null)) {
				data = paramObj;
			} else {
				data = {};
			}	
			
			var frameMode = "";
			data.menuNm = menuNm;
			data.menuCode = menuCode;
			data.menuType = menuType;
			data.url = url;
			data.closable = closable;
			data.frameMode = frameMode;
			
			if ( scwin.LAYOUT_TYPE == "T" ){ // 시스템 메인이 TAB CONTROL로 구성되어 있음. 
				data.openAction = "select";
				scwin.addTab( _$p, data );
			} else if ( scwin.LAYOUT_TYPE == "M" ){
				data.openAction = "existWindow";
				scwin.addWindows(_$p, data);
			} else {
				scwin.replaceWindows(_$p, data);
			}
	   }
	};
	
	scwin.replaceWindows  = function(_$p,   data){
		var win_main = _$p.top().$p.getComponentById(scwin.LAYOUT_ID);
		var url = data.url
		var obj = { 
            dataObject: {"type" : "json","name" : "param","data" : data  } 
        }; 
        
		//현재화면과 동일한 화면을 오픈할  경우 return;
		
        if ( win_main.getSrc() == url ) return;   
		win_main.setSrc(url, obj);
		
	};

	scwin.addWindows  = function(_$p,  data){
		var win_main = _$p.top().$p.getComponentById(scwin.LAYOUT_ID);
			
		var menuId = data.menuCode;
		var menuNm = data.menuNm; ;
		var url = data.url; ;
		var openAction = data.openAction  || "existWindow" ;  
		var frameMode = data.frameMode || "wframe";
		var closable = data.closable   ;
		
		if( typeof closable === "undefined" || closable == "true" || closable === true ){
			closable =  true;
		} else {
			closable = false;
		}
		
			
		var options = {
			title : menuNm,
			src : url,
			windowTitle : menuNm,
			windowId : menuId,
			openAction : openAction,
			frameMode : frameMode,
			dataObject : { 
				type : "json", 
				name : "param", 
				data : data
			}
		}
		
		
		win_main.createWindow( options );

	};
	

	scwin.addTab  = function( _$p, data ){ 
		
		
		var menuId = data.menuCode;
		var menuNm = data.menuNm; ;
		var url = data.url; ;
		var openAction = data.openAction  ; // 새창으로 열기. // exist/select/new
		var frameMode = data.frameMode || "wframePreload";
		var closable = data.closable   ;
		
		if( typeof closable === "undefined" || closable == "true" || closable === true ){
			closable =  true;
		} else {
			closable = false;
		}
		
		var tabOptions = {
				label : menuNm || "",
				openAction : openAction , 
				closable : closable
			};
		var contentsOptions = {
				frameMode : frameMode,
				wframe : true,
				scope: true ,
				src : url,
				dataObject : { 
					type : "json", 
					name : "param", 
					data : data
				}
		};
		
		var tab_main = _$p.top().$p.getComponentById(scwin.LAYOUT_ID);
		
		var tabID = tab_main.addTab(menuId, tabOptions, contentsOptions);
		var tabIndex = tab_main.getTabIndex( tabID );
		
		if( !tab_main.isLoaded( tabIndex ) ){
			tab_main.setSelectedTabIndex( tabIndex );
		} 
	};



/////////////////////////////////////////////////
/////////////////////////////////////////////////
//		                                       //
//		main menu 관련  project udc end          //
//		                                       //
/////////////////////////////////////////////////	
/////////////////////////////////////////////////	


	
}}}]}]},{T:1,N:'body',A:{'ev:onpageload':'scwin.onpageload'}}]}]})