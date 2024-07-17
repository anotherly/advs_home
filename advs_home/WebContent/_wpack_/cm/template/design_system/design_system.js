/*amd /cm/template/design_system/design_system.xml 32295 4d6c3add59a0b4a656bea48f56fdb58c1d122443138a82a984d74d6a36e6f92c */
define({declaration:{A:{version:'1.0',encoding:'UTF-8'}},E:[{T:7,N:'xml-stylesheet',instruction:'href="/cm/template/design_system/design_system.css" type="text/css"'},{T:1,N:'html',A:{xmlns:'http://www.w3.org/1999/xhtml','xmlns:ev':'http://www.w3.org/2001/xml-events','xmlns:w2':'http://www.inswave.com/websquare','xmlns:xf':'http://www.w3.org/2002/xforms'},E:[{T:1,N:'head',E:[{T:1,N:'w2:type',E:[{T:3,text:'DEFAULT'}]},{T:1,N:'w2:buildDate'},{T:1,N:'xf:model',E:[{T:1,N:'w2:dataCollection',A:{baseNode:'map'},E:[{T:1,N:'w2:dataList',A:{baseNode:'list',repeatNode:'map',id:'dataList1',saveRemovedData:'true'},E:[{T:1,N:'w2:columnInfo',E:[{T:1,N:'w2:column',A:{id:'id',name:'id',dataType:'text'}},{T:1,N:'w2:column',A:{id:'category',name:'category',dataType:'text'}},{T:1,N:'w2:column',A:{id:'title',name:'타이틀',dataType:'text'}},{T:1,N:'w2:column',A:{id:'iconSrc',name:'아이콘자원',dataType:'text'}},{T:1,N:'w2:column',A:{id:'previewSrc',name:'미리보기자원',dataType:'text'}},{T:1,N:'w2:column',A:{id:'xmlpath',name:'xml자원',dataType:'text'}}]},{T:1,N:'w2:data',E:[{T:1,N:'w2:row'}]}]}]},{T:1,N:'w2:workflowCollection'}]},{T:1,N:'script',A:{type:'text/javascript',src:'/cm/template/design_system/studioAPI.js'}},{T:1,N:'script',A:{type:'text/javascript',lazy:'false'},E:[{T:4,cdata:function(scopeObj){with(scopeObj){
  /*  var json1 = {
    "action" : "READ_FILE_LIST",
    "msgType" : "RESPONSE",
    "req" : {},
    "res": {
            "status" : "200",                  // state code 
      "category" :  [                            // sideMenu
              {id : "00_화면시작",iconSrc : "/cm/template/snippets/00_화면시작/00_화면시작.png",path: "/cm/template/snippets/00_화면시작"},
              {id : "01_화면분할",iconSrc : "/cm/template/snippets/01_화면분할/01_화면분할.png",path: "/cm/template/snippets/01_화면분할"},
              {id : "02_타이틀",iconSrc : "/cm/template/snippets/02_타이틀/02_타이틀.png",path: "/cm/template/snippets/02_타이틀"},
              {id : "03_조회영역",iconSrc : "/cm/template/snippets/03_조회영역/03_조회영역.png",path: "/cm/template/snippets/03_조회영역"},
              {id : "04_탭", iconSrc : "/cm/template/snippets/04_탭/04_탭.png",path: "/cm/template/snippets/04_탭"},
              {id : "05_입출력테이블", iconSrc : "/cm/template/snippets/05_입출력테이블/05_입출력테이블.png",path: "/cm/template/snippets/05_입출력테이블"},
              {id : "06_그리드", iconSrc : "/cm/template/snippets/06_그리드/06_그리드.png",path: "/cm/template/snippets/06_그리드"},
              {id : "07_트리", iconSrc : "/cm/template/snippets/07_트리/07_트리.png",path: "/cm/template/snippets/07_트리"},
              {id : "08_버튼", iconSrc : "/cm/template/snippets/08_버튼/08_버튼.png",path: "/cm/template/snippets/08_버튼"},
              {id : "09_아코디언", iconSrc : "/cm/template/snippets/09_아코디언/09_아코디언.png",path: "/cm/template/snippets/09_아코디언"},
              {id : "10_입력폼_서식", iconSrc : "/cm/template/snippets/10_입력폼_서식/10_입력폼_서식.png",path: "/cm/template/snippets/10_입력폼_서식"},
              {id : "11_메시지", iconSrc : "/cm/template/snippets/11_메시지/11_메시지.png",path: "/cm/template/snippets/11_메시지"}
                     ],
      "resource" : [
                       {                    
                         id : "00_화면시작/01_페이지시작.xml",
                         category : "00_화면시작", 
                         title : "01 페이지시작",
                         iconSrc : "/cm/template/snippets/00_화면시작/01_페이지시작_icon.png",    
                         previewSrc : "/cm/template/snippets/00_화면시작/00_페이지시작_preview.png",
                         xmlpath : "/cm/template/snippets/00_화면시작/01 페이지시작.xml"
                       }, 
            {                    
                         id : "00_화면시작/02_팝업페이지시작.xml",
                         category : "00_화면시작", 
                         title : "02 팝업페이지시작",
                         iconSrc : "/cm/template/snippets/00_화면시작/02_팝업페이지시작_icon.png",    
                         previewSrc : "/cm/template/snippets/00_화면시작/02_팝업페이지시작_preview.png",
                         xmlpath : "/cm/template/snippets/00_화면시작/02 팝업페이지시작.xml"
                       }, 
            {                    
                         id : "01_화면분할/01 가변 2단 분할.xml",
                         category : "01_화면분할", 
                         title : "01 가변 2단 분할",
                         iconSrc : "/cm/template/snippets/01_화면분할/01_가변 2단 분할_icon.png",    
                         previewSrc : "/cm/template/snippets/01_화면분할/01 가변 2단 분할_preview.png",
                         xmlpath : "/cm/template/snippets/01_화면분할/01 가변 2단 분할.xml"
                       }, 
            {                    
                         id : "01_화면분할/02 가변 3단 분할.xml",
                         category : "01_화면분할", 
                         title : "02 가변 3단 분할",
                         iconSrc : "/cm/template/snippets/01_화면분할/02_가변 3단 분할_icon.png",    
                         previewSrc : "/cm/template/snippets/01_화면분할/02 가변 3단 분할_preview.png",
                         xmlpath : "/cm/template/snippets/01_화면분할/02 가변 3단 분할.xml"
                       }, 
            {                    
                         id : "01_화면분할/03 가변 3단 분할_width값 고정 33.3%.xml",
                         category : "01_화면분할", 
                         title : "03 가변 3단 분할_width값 고정 33.3%",
                         iconSrc : "/cm/template/snippets/01_화면분할/03_가변 3단 분할_width값 고정 33per_icon.png",    
                         previewSrc : "/cm/template/snippets/01_화면분할/03 가변 3단 분할_width값 고정 33.3%_preview.png",
                         xmlpath : "/cm/template/snippets/01_화면분할/03 가변 3단 분할_width값 고정 33.3%.xml"
                       }, 
            {                    
                         id : "01_화면분할/04 가변 4단 분할_width값 고정 25%.xml",
                         category : "01_화면분할", 
                         title : "04 가변 4단 분할_width값 고정 25%",
                         iconSrc : "/cm/template/snippets/01_화면분할/04_가변 4단 분할_width값 고정 25per_icon.png",    
                         previewSrc : "/cm/template/snippets/01_화면분할/04 가변 4단 분할_width값 고정 25%_preview.png",
                         xmlpath : "/cm/template/snippets/01_화면분할/04 가변 4단 분할_width값 고정 25%.xml"
                       }, 
            {                    
                         id : "01_화면분할/05 좌측 고정 2단 분할_width값 200px.xml",
                         category : "01_화면분할", 
                         title : "05 좌측 고정 2단 분할_width값 200px",
                         iconSrc : "/cm/template/snippets/01_화면분할/05_좌측 고정 2단 분할_width값 200px_icon.png",    
                         previewSrc : "/cm/template/snippets/01_화면분할/05 좌측 고정 2단 분할_width값 200px_preview.png",
                         xmlpath : "/cm/template/snippets/01_화면분할/05 좌측 고정 2단 분할_width값 200px.xml"
                       }, 
            {                    
                         id : "01_화면분할/06 좌측 고정 2단 분할_width값 300px.xml",
                         category : "01_화면분할", 
                         title : "06 좌측 고정 2단 분할_width값 300px",
                         iconSrc : "/cm/template/snippets/01_화면분할/06_좌측 고정 2단 분할_width값 300px_icon.png",    
                         previewSrc : "/cm/template/snippets/01_화면분할/06 좌측 고정 2단 분할_width값 300px_preview.png",
                         xmlpath : "/cm/template/snippets/01_화면분할/06 좌측 고정 2단 분할_width값 300px.xml"
                       }, 
            {                    
                         id : "02_타이틀/01 페이지타이틀.xml",
                         category : "02_타이틀", 
                         title : "01 페이지타이틀",
                         iconSrc : "/cm/template/snippets/02_타이틀/01_페이지타이틀_icon.png",    
                         previewSrc : "/cm/template/snippets/02_타이틀/01_페이지타이틀_preview.png",
                         xmlpath : "/cm/template/snippets/02_타이틀/01 페이지타이틀.xml"
                       }, 
            {                    
                         id : "02_타이틀/02 서브타이틀.xml",
                         category : "02_타이틀", 
                         title : "02 서브타이틀",
                         iconSrc : "/cm/template/snippets/02_타이틀/02_서브타이틀_icon.png",    
                         previewSrc : "/cm/template/snippets/02_타이틀/02_서브타이틀_preview.png",
                         xmlpath : "/cm/template/snippets/02_타이틀/02 서브타이틀.xml"
                       }, 
            {                    
                         id : "03_조회영역/01 조회조건1행.xml",
                         category : "03_조회영역", 
                         title : "01 조회조건1행",
                         iconSrc : "/cm/template/snippets/03_조회영역/01_조회조건1행_icon.png",    
                         previewSrc : "/cm/template/snippets/03_조회영역/01_조회조건1행_preview.png",
                         xmlpath : "/cm/template/snippets/03_조회영역/01 조회조건1행.xml"
                       }, 
            {                    
                         id : "03_조회영역/02 조회조건2행.xml",
                         category : "03_조회영역", 
                         title : "02 조회조건2행",
                         iconSrc : "/cm/template/snippets/03_조회영역/02_조회조건2행_icon.png",    
                         previewSrc : "/cm/template/snippets/03_조회영역/02_조회조건2행_preview.png",
                         xmlpath : "/cm/template/snippets/03_조회영역/02 조회조건2행.xml"
                       }, 
            {                    
                         id : "04_탭/01_탭.xml",
                         category : "04_탭", 
                         title : "01_탭",
                         iconSrc : "/cm/template/snippets/04_탭/01_탭_icon.png",    
                         previewSrc : "/cm/template/snippets/04_탭/01_탭_preview.png",
                         xmlpath : "/cm/template/snippets/04_탭/01_탭.xml"
                       }, 
            {                    
                         id : "04_탭/02_탭_탭스크롤추가.xml",
                         category : "04_탭", 
                         title : "02_탭_탭스크롤추가",
                         iconSrc : "/cm/template/snippets/04_탭/02_탭_탭스크롤추가_icon.png",    
                         previewSrc : "/cm/template/snippets/04_탭/02_탭_탭스크롤추가_preview.png",
                         xmlpath : "/cm/template/snippets/04_탭/02_탭_탭스크롤추가.xml"
                       }, 
            {                    
                         id : "05_입출력테이블/01_1단테이블.xml",
                         category : "05_입출력테이블", 
                         title : "01_1단테이블",
                         iconSrc : "/cm/template/snippets/05_입출력테이블/01_1단테이블_icon.png",    
                         previewSrc : "/cm/template/snippets/05_입출력테이블/01_1단테이블_preview.png",
                         xmlpath : "/cm/template/snippets/05_입출력테이블/01_1단테이블.xml"
                       }, 
            {                    
                         id : "05_입출력테이블/02_2단테이블.xml",
                         category : "05_입출력테이블", 
                         title : "02_2단테이블",
                         iconSrc : "/cm/template/snippets/05_입출력테이블/02_2단테이블_icon.png",    
                         previewSrc : "/cm/template/snippets/05_입출력테이블/02_2단테이블_preview.png",
                         xmlpath : "/cm/template/snippets/05_입출력테이블/02_2단테이블.xml"
                       }, 
            {                    
                         id : "05_입출력테이블/03_3단테이블.xml",
                         category : "05_입출력테이블", 
                         title : "03_3단테이블",
                         iconSrc : "/cm/template/snippets/05_입출력테이블/03_3단테이블_icon.png",    
                         previewSrc : "/cm/template/snippets/05_입출력테이블/03_3단테이블_preview.png",
                         xmlpath : "/cm/template/snippets/05_입출력테이블/03_3단테이블.xml"
                       }, 
            {                    
                         id : "05_입출력테이블/04_4단테이블.xml",
                         category : "05_입출력테이블", 
                         title : "04_4단테이블",
                         iconSrc : "/cm/template/snippets/05_입출력테이블/04_4단테이블_icon.png",    
                         previewSrc : "/cm/template/snippets/05_입출력테이블/04_4단테이블_preview.png",
                         xmlpath : "/cm/template/snippets/05_입출력테이블/04_4단테이블.xml"
                       }, 
            {                    
                         id : "05_입출력테이블/05_테이블 기본버튼.xml",
                         category : "05_입출력테이블", 
                         title : "05_테이블 기본버튼",
                         iconSrc : "/cm/template/snippets/05_입출력테이블/05_테이블 기본버튼_icon.png",    
                         previewSrc : "/cm/template/snippets/05_입출력테이블/05_테이블 기본버튼_preview.png",
                         xmlpath : "/cm/template/snippets/05_입출력테이블/05_테이블 기본버튼.xml"
                       }, 
            {                    
                         id : "05_입출력테이블/06_테이블 돋보기버튼.xml",
                         category : "05_입출력테이블", 
                         title : "06_테이블 돋보기버튼",
                         iconSrc : "/cm/template/snippets/05_입출력테이블/06_테이블 돋보기버튼_icon.png",    
                         previewSrc : "/cm/template/snippets/05_입출력테이블/06_테이블 돋보기버튼_preview.png",
                         xmlpath : "/cm/template/snippets/05_입출력테이블/06_테이블 돋보기버튼.xml"
                       }, 
            {                    
                         id : "05_입출력테이블/07_에러메시지.xml",
                         category : "05_입출력테이블", 
                         title : "07_에러메시지",
                         iconSrc : "/cm/template/snippets/05_입출력테이블/07_에러메시지_icon.png",    
                         previewSrc : "/cm/template/snippets/05_입출력테이블/07_에러메시지_preview.png",
                         xmlpath : "/cm/template/snippets/05_입출력테이블/07_에러메시지.xml"
                       }, 
            {                    
                         id : "06_그리드/01_그리드.xml",
                         category : "06_그리드", 
                         title : "01_그리드",
                         iconSrc : "/cm/template/snippets/06_그리드/01_그리드_icon.png",    
                         previewSrc : "/cm/template/snippets/06_그리드/01_그리드_preview.png",
                         xmlpath : "/cm/template/snippets/06_그리드/01_그리드.xml"
                       }, 
            {                    
                         id : "06_그리드/02_그리드_순번_상태.xml",
                         category : "06_그리드", 
                         title : "02_그리드_순번_상태",
                         iconSrc : "/cm/template/snippets/06_그리드/02_그리드_순번_상태_icon.png",    
                         previewSrc : "/cm/template/snippets/06_그리드/02_그리드_순번_상태_preview.png",
                         xmlpath : "/cm/template/snippets/06_그리드/02_그리드_순번_상태.xml"
                       }, 
            {                    
                         id : "06_그리드/03_페이지리스트.xml",
                         category : "06_그리드", 
                         title : "03_페이지리스트",
                         iconSrc : "/cm/template/snippets/06_그리드/03_페이지리스트_icon.png",    
                         previewSrc : "/cm/template/snippets/06_그리드/03_페이지리스트_preview.png",
                         xmlpath : "/cm/template/snippets/06_그리드/03_페이지리스트.xml"
                       }, 
            {                    
                         id : "07_트리/01_트리.xml",
                         category : "07_트리", 
                         title : "01_트리",
                         iconSrc : "/cm/template/snippets/07_트리/01_트리_icon.png",    
                         previewSrc : "/cm/template/snippets/07_트리/01_트리_preview.png",
                         xmlpath : "/cm/template/snippets/07_트리/01_트리.xml"
                       }, 
            {                    
                         id : "08_버튼/01_전체제어버튼.xml",
                         category : "08_버튼", 
                         title : "01_전체제어버튼",
                         iconSrc : "/cm/template/snippets/08_버튼/01_전체제어버튼_icon.png",    
                         previewSrc : "/cm/template/snippets08_버튼/01_전체제어버튼_preview.png",
                         xmlpath : "/cm/template/snippets/08_버튼/01_전체제어버튼.xml"
                       }, 
            {                    
                         id : "09_아코디언/01_아코디언.xml",
                         category : "09_아코디언", 
                         title : "01_아코디언",
                         iconSrc : "/cm/template/snippets/09_아코디언/01_아코디언_icon.png",    
                         previewSrc : "/cm/template/snippets/09_아코디언/01_아코디언_preview.png",
                         xmlpath : "/cm/template/snippets/09_아코디언/01_아코디언.xml"
                       }                                          
                     ]

           }
    };
            */
  scwin.onpageload = function() {
    // requestJson data 생성
    var requestJson = {
      "type": "REQUEST",
      "payload": {
        "type": "READ_FILE_LIST",
        // 전체 리스트를 조회하는 경우는 wds로 날려야함.
        "req": {
          "id": "wds"
        }
      }
    }
          
    studioAPI.exec(scwin.jsonDataCallBack, {}, requestJson);      
    
    // LEFT메뉴 리사이징
    $(window).resize(function(){
      var win_w = $(this).width();
      
        if(win_w < 400){
        $(".designSystem_layout").removeClass("hide_menu");
        $(".designSystem_layout").addClass("hide_menu");
      }   
    });
    
    // Snippet 미리보기
    $(".btn_snippet").on("click", function(){
      $(".designSystem_zoom_box").addClass("on");
      $(".designSystem_dim").addClass("on");
    });
    $(".btn_zoom_close").on("click", function(){
      $(".designSystem_zoom_box").removeClass("on");
      $(".designSystem_dim").removeClass("on");
    });
    
    // Snippet 즐겨찾기
    $(".btn_snp_favorit").on("click", function(){
      $(this).toggleClass("on");
    });
  };
  
  scwin.onpageunload = function() {
    
  };
  
  scwin.jsonDataCallBack = function(jsonData) {
    var jsonResource = jsonData && jsonData.res ? jsonData.res.resource : [];
      var jsonCategory = jsonData && jsonData.res ? jsonData.res.category : [];
      
      //debugger;
      dataList1.setJSON(jsonResource);
      //category 
      for(var i = 0; i < jsonCategory.length; i++){
        console.log("start["+i+"]"+jsonCategory[i].id);
        //mf_categoryGen_1_categoryTitleGrp
        
        var genCatogoryIdx = categoryGen.insertChild();
        
        var strCategory = jsonCategory[i].id;
        var strCategoryMenuIcon = jsonCategory[i].iconSrc;
        var objCategoryTitle = categoryGen.getChild(genCatogoryIdx, "categoryTitle");
        //debugger;
        objCategoryTitle.setValue(strCategory);//category anchor title setting
        var tagCategoryId = objCategoryTitle.getID();//좌측메뉴 클릭시 찾아갈 객체 id 얻어오기
        
        var objResourceListGen = categoryGen.getChild(genCatogoryIdx, "resourceListGen");
        
        //category menu setting
        var genCatogoryMenuIdx = categoryMenuGen.insertChild();
        var objCategoryMenu = categoryMenuGen.getChild(genCatogoryMenuIdx, "categoryMenu");
        objCategoryMenu.setValue(strCategory);
        objCategoryMenu.setHref("#"+tagCategoryId);
        
        var objCategoryMenuIcon = categoryMenuGen.getChild(genCatogoryMenuIdx, "categoryMenuIcon");
        //debugger;
        objCategoryMenuIcon.setSrc(strCategoryMenuIcon);
      
        //resource
        var filterCon = {type:'row', colIndex:'category', key:"00_화면시작", condition:'and'};
        filterCon.key = strCategory;
        dataList1.clearFilter();
        dataList1.setColumnFilter(filterCon);
        
        var jsonResForCategory = dataList1.getAllFilteredJSON();
        
        for(var j = 0; j < jsonResForCategory.length; j++){
          console.log("["+j+"]"+jsonResForCategory[j].id);
          //debugger;
          var strRessourceTitle = jsonResForCategory[j].title;
          var strRessourceIcon = jsonResForCategory[j].iconSrc;
          //hidden
          var strResourceId = jsonResForCategory[j].id;
          var strResourceCategory = jsonResForCategory[j].category;
          var strResourcePreviewSrc = jsonResForCategory[j].previewSrc;
          var strResourceXmlpath = jsonResForCategory[j].xmlpath;

          var genResourceIdx = objResourceListGen.insertChild();
          
          //debugger;         
          var objResourceTitle = objResourceListGen.getChild(genResourceIdx,"resourceTitle");
          objResourceTitle.setValue(strRessourceTitle);//resource anchor title setting
          
          var objResourceIcon = objResourceListGen.getChild(genResourceIdx,"resourceIcon");
        objResourceIcon.setSrc(strRessourceIcon);
        
        var objResourceIconSrc = objResourceListGen.getChild(genResourceIdx,"resourceIconSrc");
        objResourceIconSrc.setValue(strRessourceIcon);
        
        var objResourceId = objResourceListGen.getChild(genResourceIdx,"resourceId");
        objResourceId.setValue(strResourceId);

        var objResourceCategory = objResourceListGen.getChild(genResourceIdx,"resourceCategory");
        objResourceCategory.setValue(strResourceCategory);

        var objResourcePreviewSrc = objResourceListGen.getChild(genResourceIdx,"resourcePreviewSrc");
        objResourcePreviewSrc.setValue(strResourcePreviewSrc);        

        var objResourceXmlpath = objResourceListGen.getChild(genResourceIdx,"resourceXmlpath");
        objResourceXmlpath.setValue(strResourceXmlpath);            
        }       
        
      }
      
    //left menu 하단 고정 메뉴
    var genCatogoryFixMenuIdx = categoryMenuGen.insertChild();
    //var objCategoryMenu = 
    (categoryMenuGen.getChild(genCatogoryFixMenuIdx, "categoryMenu")).setValue("즐겨찾기");
    (categoryMenuGen.getChild(genCatogoryFixMenuIdx, "categoryMenuIcon")).setSrc("/cm/images/ico_fav.png");
    
    genCatogoryFixMenuIdx = categoryMenuGen.insertChild();
    (categoryMenuGen.getChild(genCatogoryFixMenuIdx, "categoryMenu")).setValue("최근검색");
    (categoryMenuGen.getChild(genCatogoryFixMenuIdx, "categoryMenuIcon")).setSrc("/cm/images/ico_recent.png");
    //objCategoryMenu.setValue("즐겨찾기");
    
    //var genCatogoryFixMenuIdx = categoryMenuGen.insertChild();
    //var objCategoryMenu = categoryMenuGen.getChild(genCatogoryFixMenuIdx, "categoryMenu");
    //objCategoryMenu.setValue("즐겨찾기");
    };
  
    // LEFT메뉴 버튼 토클
  scwin.btnDsSlide_onclick = function() {
     $(".designSystem_layout").toggleClass("hide_menu");
  };
  
  scwin.resourceIcon_onclick = function(e) {
    var genIdx = this.getGeneratedIndex();
 
      var resourceIdObj = this.getGeneratedComponent("resourceId");
      var resourceCategoryObj = this.getGeneratedComponent("resourceCategory");
      var resourceTitelObj = this.getGeneratedComponent("resourceTitle");
      var resourceIconSrcObj = this.getGeneratedComponent("resourceIconSrc");
      var resourcePreviewSrcObj = this.getGeneratedComponent("resourcePreviewSrc");
    var resourceXmlpathObj = this.getGeneratedComponent("resourceXmlpath");
    
      console.log(genIdx+"번째 , click한  값 : "+resourceIdObj.getValue()+"\n"+resourceCategoryObj.getValue()+"\n"+
      resourceTitelObj.getValue()+"\n"+
      resourceIconSrcObj.getValue()+"\n"+
      resourcePreviewSrcObj.getValue()+"\n"+
      resourceXmlpathObj.getValue()
      );
      debugger;
      
      // request json 의 스펙을 생성한다.
    var reqJson = {
      "type": "REQUEST",
      "payload": {
        "type": "INSERT_SNIPPETS",
        "req": {
          "id": "",
          "category": "",
          "title": "",
          "iconSrc": "",
          "previewSrc": "",
          "xmlpath": ""
        },
        "res": {}
      }
    }
        
    reqJson.payload.req.id = resourceIdObj.getValue();
    reqJson.payload.req.category = resourceCategoryObj.getValue();
    reqJson.payload.req.title = resourceTitelObj.getValue();
    reqJson.payload.req.iconSrc = resourceIconSrcObj.getValue();
    reqJson.payload.req.previewSrc = resourcePreviewSrcObj.getValue();  
    reqJson.payload.req.xmlpath = resourceXmlpathObj.getValue();
    
    studioAPI.exec({}, {}, reqJson);
    console.log("=====reqJson======\n"+reqJson.req.xmlpath);    
  };  
}}}]}]},{T:1,N:'body',A:{'ev:onpageload':'scwin.onpageload','ev:onpageunload':'scwin.onpageunload',style:''},E:[{T:1,N:'xf:group',A:{id:'layout',class:'designSystem_layout',style:''},E:[{T:1,N:'xf:group',A:{class:'designSystem_search',id:'',style:''},E:[{T:1,N:'w2:anchor',A:{class:'btn_designSystem_slide','ev:onclick':'scwin.btnDsSlide_onclick',id:'btnDsSlide',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'메뉴'}]}]},{T:1,N:'xf:input',A:{adjustMaxLength:'false',id:'',placeholder:'Search ...',style:''}},{T:1,N:'xf:group',A:{class:'switchbox',id:'',style:'',tagname:''},E:[{T:1,N:'xf:select',A:{appearance:'full',class:'input_switch',cols:'',disabled:'',falseValue:'',id:'switch1',itemTagname:'',nextTabID:'',ref:'',renderType:'native',rows:'',selectedindex:'-1',style:'',tooltipFormatter:'',tooltipItemLabel:'',useLocale:''},E:[{T:1,N:'xf:choices',E:[{T:1,N:'xf:item',E:[{T:1,N:'xf:label'},{T:1,N:'xf:value'}]}]}]},{T:1,N:'xf:group',A:{class:'label_switch',id:'',style:'',tabIndex:'',tagname:'label',text:'',tooltipFormatter:'',userData3:''},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:for',E:[{T:3,text:'mf_switch1'}]}]},{T:1,N:'w2:span',A:{class:'marble',id:'',label:'',ref:'',style:''}},{T:1,N:'w2:span',A:{class:'on',id:'',label:'On',style:''}},{T:1,N:'w2:span',A:{class:'off',id:'',label:'Off',style:''}}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'designSystem_side'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'designSystem_menu'},E:[{T:1,N:'w2:generator',A:{id:'categoryMenuGen',style:'',tagname:'ul'},E:[{T:1,N:'xf:group',A:{id:'',style:'',tagname:'li'},E:[{T:1,N:'xf:group',A:{id:'',tagname:'a'},E:[{T:1,N:'w2:attributes',E:[{T:1,N:'w2:href',E:[{T:3,text:'#mf_layout'}]}]},{T:1,N:'xf:image',A:{id:'categoryMenuIcon',src:'/cm/template/snippets/00_화면시작/00_화면시작.png',style:'width:16px;height:16px;'}}]},{T:1,N:'w2:anchor',A:{class:'designSystem_m_tit',href:'#mf_layout',id:'categoryMenu',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'화면시작'}]}]}]}]}]}]},{T:1,N:'w2:generator',A:{style:'',id:'categoryGen',class:'designSystem_cont'},E:[{T:1,N:'xf:group',A:{class:'designSystem_dfbox',id:'categoryTitleGrp',style:''},E:[{T:1,N:'w2:textbox',A:{class:'designSystem_df_tit',id:'categoryTitle',label:'화면시작',style:''}}]},{T:1,N:'w2:generator',A:{class:'designSystem_list',id:'resourceListGen',style:'',tagname:'ul'},E:[{T:1,N:'xf:group',A:{class:'item',id:'',style:'',tagname:'li'},E:[{T:1,N:'xf:group',A:{class:'img_box',id:''},E:[{T:1,N:'xf:image',A:{id:'resourceIcon',src:'/cm/template/snippets/00_화면시작/0_01%20페이지시작_icon.png',style:'',tabIndex:'','ev:onclick':'scwin.resourceIcon_onclick'}},{T:1,N:'xf:input',A:{adjustMaxLength:'false',id:'resourceId',style:'width: 144px;height: 21px;',type:'hidden'}},{T:1,N:'xf:input',A:{adjustMaxLength:'false',id:'resourceCategory',style:'width: 144px;height: 21px;',type:'hidden'}},{T:1,N:'xf:input',A:{adjustMaxLength:'false',id:'resourcePreviewSrc',style:'width: 144px;height: 21px;',type:'hidden'}},{T:1,N:'xf:input',A:{adjustMaxLength:'false',id:'resourceXmlpath',style:'width: 144px;height: 21px;',type:'hidden'}},{T:1,N:'xf:input',A:{adjustMaxLength:'false',id:'resourceIconSrc',style:'width: 144px;height: 21px;',type:'hidden'}},{T:1,N:'xf:group',A:{class:'sc_area',id:'',style:''},E:[{T:1,N:'w2:anchor',A:{class:'btn_snippet',id:'',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'미리보기'}]}]},{T:1,N:'w2:anchor',A:{class:'btn_snp_favorit',id:'',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'즐겨찾기'}]}]}]}]},{T:1,N:'w2:anchor',A:{id:'resourceTitle',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'01_페이지시작_icon'}]}]}]}]}]},{T:1,N:'xf:group',A:{style:'display: none',id:'',class:'designSystem_cont'},E:[{T:1,N:'xf:group',A:{style:'',id:'',class:'designSystem_dfbox'},E:[{T:1,N:'w2:textbox',A:{style:'',id:'',label:'화면시작',class:'designSystem_df_tit'}}]},{T:1,N:'w2:generator',A:{style:'',id:'',class:'designSystem_list',tagname:'ul'},E:[{T:1,N:'xf:group',A:{class:'item',id:'',tagname:'li',style:''},E:[{T:1,N:'xf:group',A:{class:'img_box',id:''},E:[{T:1,N:'xf:image',A:{id:'',src:'/cm/template/snippets/00_화면시작/01_페이지시작_icon.png',style:'',tabIndex:''}},{T:1,N:'xf:group',A:{class:'sc_area',id:'',style:''},E:[{T:1,N:'w2:anchor',A:{class:'btn_snippet',id:'',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'미리보기'}]}]},{T:1,N:'w2:anchor',A:{class:'btn_snp_favorit',id:'',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'즐겨찾기'}]}]}]}]},{T:1,N:'w2:anchor',A:{id:'',outerDiv:'false',style:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'01_페이지시작_icon'}]}]}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'designSystem_zoom_box'},E:[{T:1,N:'xf:image',A:{id:'',src:'/cm/images/img_temp00.png',style:''}},{T:1,N:'w2:anchor',A:{outerDiv:'false',style:'',id:'',class:'btn_zoom_close',ref:''},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'Insert Text'}]}]}]},{T:1,N:'xf:group',A:{style:'',id:'',class:'designSystem_dim'}}]}]}]}]})