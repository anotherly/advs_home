/*amd /cm/udc/side_main.xml 25548 86228b27b4a290b612a32895547658ba2f3c6756607b90cad178b127f186be70 */
define({declaration:{A:{version:'1.0',encoding:'UTF-8'}},E:[{T:7,N:'xml-stylesheet',instruction:'href="/cm/css/all.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/cm/css/content.css" type="text/css"'},{T:7,N:'xml-stylesheet',instruction:'href="/cm/css/Responsive.css" type="text/css"'},{T:1,N:'html',A:{xmlns:'http://www.w3.org/1999/xhtml','xmlns:ev':'http://www.w3.org/2001/xml-events','xmlns:w2':'http://www.inswave.com/websquare','xmlns:xf':'http://www.w3.org/2002/xforms'},E:[{T:1,N:'head',E:[{T:1,N:'w2:type',A:{palette:'support'},E:[{T:3,text:'COMPONENT'}]},{T:1,N:'w2:buildDate'},{T:1,N:'w2:publicInfo',A:{method:'scwin.fn_getInitData,scwin.setMenuData',component:'dlt_menu,dlt_programAuthority,dma_defInfo'}},{T:1,N:'xf:model',E:[{T:1,N:'w2:dataCollection',A:{baseNode:'map'},E:[{T:1,N:'w2:dataList',A:{id:'dlt_menu',baseNode:'list',saveRemovedData:'true',repeatNode:'map','ev:ondataload':'scwin.dlt_menu_ondataload'},E:[{T:1,N:'w2:columnInfo',E:[{T:1,N:'w2:column',A:{id:'MENU_CD',name:'메뉴코드',dataType:'text'}},{T:1,N:'w2:column',A:{id:'MENU_NM',name:'메뉴명',dataType:'text'}},{T:1,N:'w2:column',A:{id:'IS_USE',name:'사용유무',dataType:'text'}},{T:1,N:'w2:column',A:{id:'SRC_PATH',name:'메뉴경로',dataType:'text'}},{T:1,N:'w2:column',A:{id:'PARENT_MENU_CD',name:'부모메뉴코드',dataType:'text'}},{T:1,N:'w2:column',A:{id:'MENU_LEVEL',name:'메뉴레벨',dataType:'text'}},{T:1,N:'w2:column',A:{id:'SORT_ORDER',name:'정렬순서',dataType:'text'}},{T:1,N:'w2:column',A:{id:'PROGRAM_CD',name:'프로그램코드',dataType:'text'}}]}]},{T:1,N:'w2:dataList',A:{id:'dlt_fav',baseNode:'list',saveRemovedData:'true',repeatNode:'map'},E:[{T:1,N:'w2:columnInfo',E:[{T:1,N:'w2:column',A:{id:'MENU_NM',name:'메뉴명',dataType:'text'}},{T:1,N:'w2:column',A:{id:'SRC_PATH',name:'메뉴경로',dataType:'text'}},{T:1,N:'w2:column',A:{id:'MENU_CD',name:'메뉴코드',dataType:'text'}},{T:1,N:'w2:column',A:{id:'MENU_LEVEL',name:'메뉴레벨',dataType:'text',defaultValue:'0'}}]}]},{T:1,N:'w2:dataMap',A:{baseNode:'map',id:'dma_favInfo'},E:[{T:1,N:'w2:keyInfo',E:[{T:1,N:'w2:key',A:{id:'STATUS',name:'상태',dataType:'text',defaultValue:'R'}},{T:1,N:'w2:key',A:{id:'MENU_CD',name:'메뉴코드',dataType:'text'}},{T:1,N:'w2:key',A:{id:'MENU_NM',name:'메뉴명',dataType:'text'}},{T:1,N:'w2:key',A:{id:'SRC_PATH',name:'메뉴경로',dataType:'text'}}]}]},{T:1,N:'w2:dataMap',A:{baseNode:'map',id:'dma_result'},E:[{T:1,N:'w2:keyInfo',E:[{T:1,N:'w2:key',A:{id:'STATUS',name:'name1',dataType:'text'}},{T:1,N:'w2:key',A:{id:'ICNT',name:'name2',dataType:'text'}},{T:1,N:'w2:key',A:{id:'UCNT',name:'name3',dataType:'text'}},{T:1,N:'w2:key',A:{id:'DCNT',name:'name4',dataType:'text'}},{T:1,N:'w2:key',A:{id:'TYPE',name:'name5',dataType:'text'}}]}]},{T:1,N:'w2:dataMap',A:{baseNode:'map',id:'dma_defInfo'},E:[{T:1,N:'w2:keyInfo',E:[{T:1,N:'w2:key',A:{id:'EMP_CD',name:'사번',dataType:'text'}},{T:1,N:'w2:key',A:{id:'EMP_NM',name:'사원명',dataType:'text'}},{T:1,N:'w2:key',A:{id:'IS_ADMIN',name:'관리자여부',dataType:'text'}},{T:1,N:'w2:key',A:{id:'IS_USE_SHORTCUT',name:'단축키사용여부',dataType:'text'}}]}]},{T:1,N:'w2:dataMap',A:{baseNode:'map',id:'dma_fav'},E:[{T:1,N:'w2:keyInfo',E:[{T:1,N:'w2:key',A:{id:'STATUS',name:'상태',dataType:'text',defaultValue:'R'}},{T:1,N:'w2:key',A:{id:'MENU_CD',name:'메뉴코드',dataType:'text'}}]}]},{T:1,N:'w2:dataList',A:{baseNode:'list',repeatNode:'map',id:'dlt_programAuthority',saveRemovedData:'true'},E:[{T:1,N:'w2:columnInfo',E:[{T:1,N:'w2:column',A:{id:'PROGRAM_CD',name:'프로그램코드',dataType:'text'}},{T:1,N:'w2:column',A:{id:'IS_AUTH_SELECT',name:'조회권한여부',dataType:'text'}},{T:1,N:'w2:column',A:{id:'IS_AUTH_SAVE',name:'저장권한여부',dataType:'text'}},{T:1,N:'w2:column',A:{id:'IS_AUTH_EXCEL',name:'엑셀권한여부',dataType:'text'}}]}]},{T:1,N:'w2:dataList',A:{baseNode:'list',repeatNode:'map',id:'dlt_shortcutList',saveRemovedData:'true'},E:[{T:1,N:'w2:columnInfo',E:[{T:1,N:'w2:column',A:{id:'SHORTCUT_SEQ',name:'단축키순번',dataType:'text'}},{T:1,N:'w2:column',A:{id:'PROGRAM_CD',name:'프로그램코드',dataType:'text'}},{T:1,N:'w2:column',A:{id:'COMPLEX_KEY',name:'복합키',dataType:'text'}},{T:1,N:'w2:column',A:{id:'LAST_KEY',name:'단축키',dataType:'text'}},{T:1,N:'w2:column',A:{id:'EVENT_TYPE',name:'이벤트타입',dataType:'text'}},{T:1,N:'w2:column',A:{id:'EVENT_TARGET',name:'이벤트타겟',dataType:'text'}},{T:1,N:'w2:column',A:{id:'EVENT_DETAIL',name:'이벤트설명',dataType:'text'}},{T:1,N:'w2:column',A:{id:'EVENT_YN',name:'사용여부',dataType:'text'}},{T:1,N:'w2:column',A:{id:'EVENT_NAME',name:'이벤트명',dataType:'text'}}]},{T:1,N:'w2:data',A:{use:'true'},E:[{T:1,N:'w2:row',E:[{T:1,N:'PROGRAM_CD',E:[{T:4,cdata:'TOP'}]},{T:1,N:'COMPLEX_KEY',E:[{T:4,cdata:'altkey'}]}]},{T:1,N:'w2:row',E:[{T:1,N:'PROGRAM_CD',E:[{T:4,cdata:'TOP'}]},{T:1,N:'COMPLEX_KEY',E:[{T:4,cdata:'shiftKey'}]}]},{T:1,N:'w2:row',E:[{T:1,N:'PROGRAM_CD',E:[{T:4,cdata:'TOP'}]},{T:1,N:'COMPLEX_KEY',E:[{T:4,cdata:'ctrlKey'}]}]},{T:1,N:'w2:row',E:[{T:1,N:'PROGRAM_CD',E:[{T:4,cdata:'TOP'}]},{T:1,N:'COMPLEX_KEY',E:[{T:4,cdata:'altShiftKey'}]}]},{T:1,N:'w2:row',E:[{T:1,N:'COMPLEX_KEY',E:[{T:4,cdata:'ctrlAltKey'}]},{T:1,N:'PROGRAM_CD',E:[{T:4,cdata:'TOP'}]}]},{T:1,N:'w2:row',E:[{T:1,N:'COMPLEX_KEY',E:[{T:4,cdata:'ctrlShiftKey'}]},{T:1,N:'PROGRAM_CD',E:[{T:4,cdata:'TOP'}]}]},{T:1,N:'w2:row',E:[{T:1,N:'COMPLEX_KEY',E:[{T:4,cdata:'singleKey'}]},{T:1,N:'PROGRAM_CD',E:[{T:4,cdata:'TOP'}]}]}]}]},{T:1,N:'w2:dataMap',A:{baseNode:'map',id:'dma_shortcut'},E:[{T:1,N:'w2:keyInfo',E:[{T:1,N:'w2:key',A:{id:'PROGRAM_CD',name:'프로그램명',dataType:'text'}}]}]}]},{T:1,N:'xf:submission',A:{id:'sbm_selectFavList',ref:'',target:'data:json,dlt_fav',action:'/main/selectFavList',method:'post',mediatype:'application/json',encoding:'UTF-8',instance:'',replace:'',errorHandler:'',customHandler:'',mode:'asynchronous',processMsg:'','ev:submit':'','ev:submitdone':'','ev:submiterror':''}},{T:1,N:'xf:submission',A:{id:'sbm_initSide',ref:'',target:'',action:'',method:'post',mediatype:'application/json',encoding:'UTF-8',instance:'',replace:'',errorHandler:'',customHandler:'',mode:'asynchronous',processMsg:'','ev:submit':'','ev:submitdone':'','ev:submiterror':''}},{T:1,N:'xf:submission',A:{id:'sbm_updateFav',ref:'data:json,dma_fav',target:'',action:'/main/updateFav',method:'post',mediatype:'application/json',encoding:'UTF-8',instance:'',replace:'',errorHandler:'',customHandler:'',mode:'asynchronous',processMsg:'','ev:submit':'','ev:submitdone':'scwin.setupdateFavCallback','ev:submiterror':'',abortTrigger:''}}]},{T:1,N:'script',A:{type:'text/javascript',lazy:'false'},E:[{T:4,cdata:function(scopeObj){with(scopeObj){
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
	
	scwin.fn_getInitData = function() {
		
		var searchCodeGrpOption = { id : "sbm_InitCont", action : "/main/init", 
									target : 'data:json, [ "dlt_fav", "dma_defInfo", "dlt_programAuthority"]', method : "post",
									mediatype : "application/json", mode : "asynchronous", isShowMeg : false,
									submitDoneHandler : scwin.initDataCallback };
		$c.common.executeSubmission_dynamic($p, searchCodeGrpOption);

	};
	
	
	scwin.setMenuData = function( menuData ){
		dlt_menu.setJSON(menuData);
		
		
		trv_menu.expandNode(0, true);
		gcm.menuComp = dlt_menu; //전체 공통 영역에 메뉴리스트 데이터 변수 설정.
		gcm.shortcutComp = dlt_shortcutList; //전체 공통 영역에 단축키리스트 데이터 변수 설정.
		dma_shortcut.set("PROGRAM_CD", "TOP");
	};
	
	
	
	scwin.initDataCallback = function() {
		var userInfo = dma_defInfo.getJSON() ; //wfm_side.getWindow().dlt_menu.getAllJSON()
		
		if (  $c.common.getHeaderType($p) == "2" ){
			$p.parent().$p.getComponentById("udc_header").setUserInfo(userInfo);
		} else {
			$p.parent().$p.getComponentById("wfm_header").getWindow().txt_empNm.setValue(dma_defInfo.get("EMP_NM"));
		}
		
			
		var isUseShortCut = dma_defInfo.get("IS_USE_SHORTCUT");
		com.isUseShortCut(isUseShortCut);

		

		scwin.openMenu("메인","/cm/xml/main.xml","MAIN");
	};	
	scwin.anc_menu_onclick = function() {
		gr_tab_menu.setStyle("display" , "block");
		gr_tab_menu02.setStyle("display" , "none");
	};
	
	scwin.anc_menu02_onclick = function() {
		gr_tab_menu.setStyle("display" , "none");
		gr_tab_menu02.setStyle("display" , "block");
	};
	
	scwin.trv_menu_onclick = function() {
		if (trv_menu.isLeaf()) { // 트리뷰에 자식노드가 없으면 실행
			var tLabel = trv_menu.getSelectedLabel(); // 선택된 노드 label값을 가져와서 변수에 담는다.
			var tCode = trv_menu.getSelectedValue(); // 선택된 노드 value값을 가져와서 변수에 담는다.
			
			//var tURL = WebSquare.xml.getValue(trv_menu.getSelectedElement(), "SRC_PATH"); //2020.11.30일 수정 SP5
			var tURL = WebSquare.jsonUtil.getValue(trv_menu.getSelectedElement()._element, "SRC_PATH");
			
			if (tURL.trim() !== "") {
				scwin.setMenuRelation(tLabel, tURL, tCode, "Tree");
				
			}
		}
	};
	
	/**
	 * 메뉴를 open할 때 관련된 기능들을 경우에 따라 처리해준다.
	 * @lastUpdate 2016.08.28
	 * @param <String> menuNm 메뉴 명
	 * @param <String> menuUrl 메뉴 URL
	 * @param <String> menuCode 메뉴 코드
	 * @param <String> skipType Tree Node 선택 여부 ("Tree" || null) 
	 * @author InswaveSystems
	 * @since 2016.08.28
	 * @example
	 * scwin.setMenuRelation("인사조회", "/tmp/tmp01.xml", "010001");
	 * scwin.setMenuRelation("인사조회", "/tmp/tmp01.xml", "010001", "Tree");
	 */
	scwin.setMenuRelation = function(menuNm, menuUrl, menuCode, skipType) {
		scwin._menuRelation = {
			"menuNm" : menuNm,
			"menuUrl" : menuUrl,
			"menuCode" : menuCode,
			"skipType" : skipType
		};
		var menuList = dlt_menu.getMatchedJSON("MENU_CD", menuCode, true);
		if (menuList && menuList.length > 0) {
			dma_shortcut.set("PROGRAM_CD", menuList[0]["PROGRAM_CD"]);
			var searchCodeGrpOption = { id : "sbm_selectShortcutList", action : "/main/selectShortcutList", 
									target : '', method : "post",
									mediatype : "application/json", mode : "asynchronous", isShowMeg : false,
									submitDoneHandler : function(e) {
										var rsMsg = e.responseJSON.rsMsg;
										if (rsMsg.statusCode == "S") {
											var searchShortcutList = e.responseJSON.dlt_shortcutList;
											for (var i = 0; i < searchShortcutList.length; i++) {
												var isExistRow = com.dataListFilter("dlt_shortcutList", 
																	"PROGRAM_CD == '"+searchShortcutList[i]["PROGRAM_CD"]+"' && COMPLEX_KEY == '"+searchShortcutList[i]["COMPLEX_KEY"]+"' && LAST_KEY == '"+searchShortcutList[i]["LAST_KEY"]+"'", false);
												if (isExistRow && isExistRow.length > 0) {
													dlt_shortcutList.setRowJSON(0, searchShortcutList[i], true);
												} else {
													var idx = dlt_shortcutList.insertRow();
													dlt_shortcutList.setRowJSON(idx, searchShortcutList[i], true);
												}
											}
											dlt_shortcutList.removeColumnFilterAll();
											dlt_shortcutList.reform();
										}

										scwin.openMenu(scwin._menuRelation["menuNm"], scwin._menuRelation["menuUrl"], scwin._menuRelation["menuCode"]);
										scwin.addHistory(scwin._menuRelation["menuNm"], scwin._menuRelation["menuUrl"], scwin._menuRelation["menuCode"]);
										gen_history.removeClass("hide");
										scwin.historyResize();
										
										if ($p.top().scwin.isMobileSize() == true) {
											$p.top().wfm_header.getWindow().scwin.toggleMenu();
										}
										
										//treeview에서 클릭한 경우는 find를 하지 않는다.
										if (!skipType || skipType !== "Tree") {
											trv_menu.findNodeByValue(scwin._menuRelation["menuCode"], true);
										}
										delete scwin._menuRelation;
									}
			};
			$c.common.executeSubmission_dynamic($p, searchCodeGrpOption, {"dma_shortcut" : dma_shortcut.getJSON()});
		}
	};

	/**
	 * 최근 작업내용을 추가한다.
	 * 
	 * @date 2016.07.19
	 * @param 메뉴 명 
	 * @example
	 * scwin.addHistory(label);
	 */
	scwin.addHistory = function(menuNm, url, menuCode) {
		// 맨 마지막에 열린 화면과 동일한 화면을 다시 오픈하는 경우에는 최근작업목록에 저장하지 않도록 반환한다.
		if (gen_history.getLength() >= 1) {
			var lastMenuCode = gen_history.getChild(0, "btn_History").getUserData("tmpMenuInfo").split("|")[0];
			if (menuCode === lastMenuCode) {
				return;
			}
		}

		gen_history.insertChild(0);
		var curObj = gen_history.getChild(0, "btn_History");

		var tmpHH = $p.getFormattedDate(new Date(), "yyyy-MM-dd HH:mm");
		curObj.setValue(menuNm);
		curObj.setTitle("[" + tmpHH + "] " + menuNm);
		curObj.setUserData("tmpMenuInfo", menuCode + "|" + url);
	};

	
	/**
	 * 파라메터를 참조하여 화면을 연다. 
	 * 메뉴를 최근 작업 항목에 추가하거나 메뉴 트리를 선택하게 하려면 scwin.setMenuRelation를 사용한다.
	 * @lastUpdate 2018.04.10
	 * @param <String> menuNm 메뉴명 - 단위화면에서 해당 값으로 title을 설정한다.
	 * @param <String> url 화면 파일 경로
	 * @param <String> menuCode 메뉴코드 - DB에 저장되어있는 메뉴 코드
	 * @author InswaveSystems
	 * @since 2016.08.28
	 * @example
	 * scwin.openMenu("인사조회","/tmp/tmp01.xml","010001");
	 */
	scwin.openMenu = function(menuNm, url, menuCode, paramObj, menuType) {

		// client에서 url 숨기기 메뉴일 경우에는 새 창으로 띄우기 적용 
		if (url == "/") {
			var url = document.location.href + "/";
			window.open(url, "", "width=1200, height=700, left=450, top=100");
		} else {
			
			var layout = $c.common.getLayoutType();
			
			
			if (scwin.hasFavCode(menuCode) == 0) {
				favStatus = "F";
			} else {
				favStatus = "T";
			}
			
			
			if ( paramObj === "undefined" || paramObj !== "object" ){
			  paramObj = {};
			}
			
			if ( menuCode =="MAIN" ){
				paramObj.closable = false;
			} 
			
			var openAction = "select";
			
			if ( layout == "M" ){
				openAction =  "existWindow";
			}
			
			menuInfo = {
						MENU_CD        : menuCode,         //메뉴코드 ( ID )
						MENU_NM         : menuNm,         //메뉴한글
						SRC_PATH        : url   ,      //메뉴 화면 URL
						openAction      : openAction   ,
						closable        : paramObj.closable ,
						scope           : paramObj.scope,
						favStatus       : favStatus
				
				
			};
			$c.common.openMenu ( $p , menuInfo , paramObj.data );
			
			/**
			menuCode = menuCode || "";
			var layout = $p.top().scwin.getLayoutId();
			var tmpUrl;
			var menuCodeParm = menuCode;
			var frameMode;	// "wframe", "iframe"
			var favStatus;
			var data;

			if (url.indexOf("/") !== 0) {
				url = "/" + url;
			}
			url = gcm.CONTEXT_PATH + url;

			//즐겨찾기가 추가 여부 확인하여 flag 붙임.
			if (scwin.hasFavCode(menuCode) == 0) {
				favStatus = "F";
			} else {
				favStatus = "T";
			}
			
			if ((typeof paramObj !== "undefined") && (paramObj !== null)) {
				data = paramObj;
			} else {
				data = {};
			}
			
			data.menuNm = menuNm;
			data.menuCode = menuCode;
			data.favStatus = favStatus;
			data.menuType = menuType;
			
			var _closable = true;
			if(url == "/cm/xml/main.xml"){
				_closable = false;
			}
			
			var frameMode = "";
			if (layout == "T") {
				var tabObj = { closable : _closable, //main 페이지를 제외하고 탭 닫기 기능 제공
							   openAction : "select", // exist 는 기존 탭을 갱신, new 는 항상 새로, select는 동일 id 가 존재하면 선택, last: 기존 tab을 마지막 tab으로 이동후 선택
							   label : menuNm };
				
				if (com.getFrameMode()  === "wframe") {
					frameMode = "wframePreload";
				} else {
					frameMode = "iframe";
				}
				
				var contObj = {
					frameMode : frameMode,
					scope : true,
					src : url,
					alwaysDraw : false,
					title : menuNm,
					dataObject : {
						type : "json", 
						name : "param", 
						data : data
					}
				};
				var tabComp = $p.parent().tac_layout; //$p.getComponentById("mf_tac_layout");
				tabComp.addTab(menuCode, tabObj, contObj);

				// tabObj의 openAction의 last값의 동작 특이 사항으로 선택이 되지 않은 경우 선택하는 로직 추가
				if (tabComp.getSelectedTabID() !== menuCode) {
					var tabIndex = tabComp.getTabIndex(menuCode);
					if (tabIndex) {
						tabComp.setSelectedTabIndex(tabIndex);
					}
				}
			} else if (layout == "M") {
				if (com.getFrameMode() === "wframe") {
					frameMode = "wframe";
				} else {
					frameMode = "iframe";
				}
				
				var options = {
					title : menuNm,
					src : url,
					windowTitle : menuNm,
					windowId : menuCode,
					openAction : "existWindow",
					frameMode : frameMode,
					dataObject : { 
						type : "json", 
						name : "param", 
						data : data
					}
				}
				var wdcComp = $p.parent().wdc_main; //$p.getComponentById("mf_wdc_main");
				wdcComp.createWindow(options);
				
			}*/
		}
		
		gr_search_field.removeClass("active");
	};
	
	scwin.historyResize = function() {
		var listHeight = gen_history.getSize("height");
		var swhInBoxId = swh_lnbbox.getID();
		$("#" + swhInBoxId + " .w2switch_case").animate({ "bottom" : listHeight + 44 }, 700);
		$(".box_history").animate({ "height" : listHeight + 24 }, 700);
	};
		
	/**
	 * 즐겨찾기 리스트에서 menuCode가 추가되어있는지 확인후 개수 반환.
	 * 없으면 == 0, 있으면 > 0 
	 * @lastUpdate 2016.08.24
	 * @param <String> menuCode
	 * @returns  <int> 존재 개수
	 * @author InswaveSystems
	 * @since 2016.08.24
	 * @example
	 * case 1. scwin.hasFavCode("030001"); return : 0 <br/>
	 * case 2. scwin.hasFavCode("030001"); return : 1
	 */
	scwin.hasFavCode = function(menuCode) {
		return (dlt_fav.getMatchedIndex("MENU_CD", menuCode, true)).length;
	}
		
	scwin.btn_History_onclick = function() {
		var menuInfoStr = this.getUserData("tmpMenuInfo");
		var menuInfoArr = menuInfoStr.split("|");
		scwin.setMenuRelation(this.getValue(), menuInfoArr[1], menuInfoArr[0]);		
	};
	
	/**
	 * 메뉴 전체 확장 버튼 클릭 이벤트
	 */
	scwin.btn_menuExpandAll_onclick = function(e) {
		trv_menu.expandNode(0, true);
	};
	
	/**
	 * 메뉴 전체 축소 버튼 클릭 이벤트
	 */
	scwin.btn_menuCollapseAll_onclick = function(e) {
		trv_menu.collapseNode(0, true);
	};
	scwin.acb_search_onviewchange = function(info) {
		
		
		var tmpNode = trv_menu.findNodeByValue(info.newValue, true);
		
		if ((typeof tmpNode !== "undefined") && (tmpNode !== null)) {
			trv_menu.spanNode(tmpNode.index, true, false);
			scwin.trv_menu_onclick();
			//gr_search_field.removeClass("active");
		}
		
		
	};
	

	scwin.dlt_menu_ondataload = function() {
		$p.top().scwin.setHeaderMenu();
	};
	
	scwin.btn_history_Clear_onclick = function() {
		gen_history.removeAll();
		scwin.historyResize();
	};
	
	
		/**
	 * 즐겨찾기 등록 업데이트 (추가/삭제)
	 * com.updateFav 함수는 Scope=true가 적용된 WFrame에서는 사용해서는 안됨
	 * 
	 * @date 2017.11.30
	 * @param {Array} menuCode [[메뉴코드]:[F|T]]업데이트하기 위한 페이지 정보로 메뉴코드와 추가/삭제 여부에 대한 key값. (e.g., "030001:F", "030001:T")
	 * @param {String} favStatus 적용시킬 상태 값(T, F)
	 * @memberOf scwin
	 * @author InswaveSystems
	 */
	scwin.updateFav = function(menuCode, favStatus) {
		if (favStatus == "F") {
			favStatus = "I";
		} else if (favStatus == "T") {
			favStatus = "D"
		}
		
		dma_fav.set("MENU_CD", menuCode);
		dma_fav.set("STATUS", favStatus);
		com.executeSubmission(sbm_updateFav);
	};
	scwin.setupdateFavCallback = function(e) {
		var updateResult = e.responseJSON.updateResult || "";
		var updateInfoArr = updateResult.split(":");
		var updateStatus = updateInfoArr[0];
		var updateNum = updateInfoArr[1];
		
		// 업데이트가 0건 이상일 경우 즐겨찾기 리스트 갱신
		if (WebSquare.util.getNumber(updateNum) > 0) {
			com.resultMsg(e.responseJSON.rsMsg);
			com.executeSubmission(sbm_selectFavList);
		}
	};
	
	scwin.selectShortcutCallback = function(e) {
		var rsMsg = e.responseJSON.rsMsg;
		if (rsMsg.statusCode === "S") {
			var shortCutList = e.responseJSON.dlt_shortcutList || [];
			dlt_shortcutList.setJSON(shortCutList);
		}
	};	
	
	
		//즐겨찾기 메뉴 node 클릭 시 
	scwin.btn_FavMenuNode_onclick = function() {
		
		var tLabel = this.getSelectedLabel(); // 선택된 노드 label값을 가져와서 변수에 담는다.
		var tCode = this.getSelectedValue(); // 선택된 노드 value값을 가져와서 변수에 담는다.
		var tURL = WebSquare.jsonUtil.getValue(this.getSelectedElement()._element, "SRC_PATH");
		if (tURL.trim() !== "") {
				scwin.setMenuRelation(tLabel, tURL, tCode, "Tree");
				
		}
		//$p.top().wfm_side.getWindow().scwin.setMenuRelation(tLabel, tURL, tCode, "Tree");
	};
	

	
	
}}}]}]},{T:1,N:'body',A:{'ev:onpageload':'scwin.onpageload','ev:onpageunload':'scwin.onpageunload'},E:[{T:1,N:'xf:group',A:{class:'grp_tab',id:'',style:''},E:[{T:1,N:'xf:group',A:{class:'shortcut_box',id:''},E:[{T:1,N:'w2:anchor',A:{class:'btn_all_search',id:'',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'메뉴접기'}]}]},{T:1,N:'w2:anchor',A:{class:'btn_fold',id:'btn_menuCollapseAll',outerDiv:'false',style:'',disabled:'','ev:onclick':'scwin.btn_menuCollapseAll_onclick'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'메뉴접기'}]}]},{T:1,N:'w2:anchor',A:{class:'btn_fold_list on',id:'btn_menuExpandAll',outerDiv:'false',style:'','ev:onclick':'scwin.btn_menuExpandAll_onclick'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'메뉴펼치기'}]}]}]},{T:1,N:'xf:group',A:{class:'tab_tit',id:'',style:'',tagname:'ul'},E:[{T:1,N:'xf:group',A:{class:'on',id:'',style:'',tagname:'li'},E:[{T:1,N:'w2:anchor',A:{class:'','ev:onclick':'scwin.anc_menu_onclick',id:'anc_menu',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'메뉴'}]}]}]},{T:1,N:'xf:group',A:{id:'grp_favMenu',style:'',tagname:'li'},E:[{T:1,N:'w2:anchor',A:{'ev:onclick':'scwin.anc_menu02_onclick',id:'anc_menu02',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'즐겨찾기'}]}]}]}]},{T:1,N:'xf:group',A:{class:'search_field',id:'gr_search_field','ev:onblur':''},E:[{T:1,N:'w2:autoComplete',A:{interactionMode:'',chooseOptionValue:'none',chooseOptionLabel:'메뉴를 검색하세요',visibleRowNum:'5',chooseOption:'true',displayMode:'label','ev:onviewchange':'scwin.acb_search_onviewchange',id:'acb_search',useKeywordHighlight:'false',style:'height:32px;font-size:13px;;',search:'contain',allOption:'',textAlign:'left',submenuSize:'auto',editType:'select',class:'w2gridViewItemTable_main',caseSensitive:'false',noResult:'first',ref:''},E:[{T:1,N:'w2:choices',E:[{T:1,N:'w2:itemset',A:{nodeset:'data:dlt_menu'},E:[{T:1,N:'w2:label',A:{ref:'MENU_NM'}},{T:1,N:'w2:value',A:{ref:'MENU_CD'}}]}]}]}]},{T:1,N:'xf:group',A:{id:'swh_lnbbox'},E:[{T:1,N:'xf:group',A:{style:'',id:'gr_tab_menu',class:'tab_con'},E:[{T:1,N:'w2:treeview',A:{showTreeDepth:'0',tooltipGroupClass:'false',dataType:'listed',labelclass:'','ev:onclick':'scwin.trv_menu_onclick',lineShow:'false',style:'',id:'trv_menu',class:'tw_menu'},E:[{T:1,N:'w2:itemset',A:{nodeset:'data:dlt_menu'},E:[{T:1,N:'w2:label',A:{ref:'MENU_NM'}},{T:1,N:'w2:value',A:{ref:'MENU_CD'}},{T:1,N:'w2:depth',A:{ref:'MENU_LEVEL'}}]}]}]},{T:1,N:'xf:group',A:{style:'display: none;',id:'gr_tab_menu02',class:'tab_con'},E:[{T:1,N:'w2:treeview',A:{showTreeDepth:'0',tooltipGroupClass:'false',dataType:'listed',lineShow:'',style:'',id:'trv_favMenu',class:'tw_menu','ev:onclick':'scwin.btn_FavMenuNode_onclick',toggleEvent:'onclick'},E:[{T:1,N:'w2:itemset',A:{nodeset:'data:dlt_fav'},E:[{T:1,N:'w2:label',A:{ref:'MENU_NM'}},{T:1,N:'w2:value',A:{ref:'MENU_CD'}},{T:1,N:'w2:depth',A:{ref:'MENU_LEVEL'}}]}]}]}]}]},{T:1,N:'xf:group',A:{style:'scrollbar-3dLight-Color: #585a5c; 	scrollbar-arrow-color: #292929; 	scrollbar-base-color: #585a5c; 	scrollbar-Face-Color: #292929; 	scrollbar-Track-Color: #585a5c; 	scrollbar-DarkShadow-Color: #585a5c; 	scrollbar-Highlight-Color: #585a5c; 	scrollbar-Shadow-Color: #585a5c',id:'box_history',class:'recent_work'},E:[{T:1,N:'w2:anchor',A:{outerDiv:'false',style:'',id:'btn_history_Clear',class:'btn_work_clear','ev:onclick':'scwin.btn_history_Clear_onclick'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'All Clear'}]}]},{T:1,N:'w2:generator',A:{style:'overflow-y:auto;max-height:120px;',id:'gen_history',class:'grbox'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'work_item'},E:[{T:1,N:'w2:anchor',A:{class:'on',id:'btn_History',outerDiv:'false',style:'','ev:onclick':'scwin.btn_History_onclick'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'권한관리'}]}]}]}]}]}]}]}]})