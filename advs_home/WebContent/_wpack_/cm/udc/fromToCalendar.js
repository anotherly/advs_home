/*amd /cm/udc/fromToCalendar.xml 7816 93182b158e14e5bc50ebb5551e83af406cff2140889197fdc9733472501241bc */
define({declaration:{A:{version:'1.0',encoding:'UTF-8'}},E:[{T:1,N:'html',A:{xmlns:'http://www.w3.org/1999/xhtml','xmlns:ev':'http://www.w3.org/2001/xml-events','xmlns:w2':'http://www.inswave.com/websquare','xmlns:xf':'http://www.w3.org/2002/xforms'},E:[{T:1,N:'head',A:{},E:[{T:1,N:'w2:type',A:{palette:'support'},E:[{T:3,text:'COMPONENT'}]},{T:1,N:'w2:buildDate'},{T:1,N:'w2:publicInfo',A:{method:'scwin.setInitDate'}},{T:1,N:'w2:MSA'},{T:1,N:'xf:model',E:[{T:1,N:'w2:dataCollection',A:{baseNode:'map'},E:[{T:1,N:'w2:aliasDataMap',A:{scope:'',id:'aliasDataMap',userData1:''}}]},{T:1,N:'w2:workflowCollection'}]},{T:1,N:'w2:layoutInfo'},{T:1,N:'script',A:{lazy:'false',type:'text/javascript'},E:[{T:4,cdata:function(scopeObj){with(scopeObj){

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

/**
 * @property
 * @name id
 * @category 01.Basic & ETC
 * @type string
 * @option 
 * @default udc_fromToCal
 * @necessary Y
 * @description 메인화면에서 사용할 UDC ID
 */   

/**
 * @property
 * @name class
 * @category 01.Basic & ETC
 * @type string
 * @option 
 * @default 
 * @necessary N
 * @description Class ID
 */  

/**
 * @property
 * @name style
 * @category 01.Basic & ETC
 * @type string
 * @option 
 * @default 
 * @necessary N
 * @description 메안화면의 style
 */   

/**
 * @property
 * @name refStDt
 * @category 03.Data
 * @type string
 * @option 
 * @default 
 * @necessary Y
 * @description bind 할 메인화면의  dataMap 컬럼 ID ( 시작날짜 )
 */               

 

/**
 * @property
 * @name refEdDt
 * @category 03.Data
 * @type string
 * @option 
 * @default 
 * @necessary Y
 * @description bind 할 메인화면의  dataMap 컬럼 ID ( 종료날짜 )
 */            

/**
 * @property
 * @name refDataMap
 * @category 03.Data
 * @type string
 * @option 
 * @default 
 * @necessary Y
 * @description bind 할 메인화면의 dataMap  ID (메인화면의 데이타 맵인 경우   예: ../dataMapid )
 */       

   




/**
 * @method
 * @name setInit
 * @description desc
 * @return None|없음.
 * @param 
 * @hidden Y
 * @exception 
 * @sample 
 */      
	scwin.onpageload = function() {
		scwin.setInit();
		
	};
	
	scwin.setInit = function(){
		
		var bindData = $p.getOptions();
		
		var refDataMap = bindData.refDataMap;
		
		if ( !refDataMap ) return;
		aliasDataMap.setScope(refDataMap);
		ipt_from.setRef("data:aliasDataMap."+bindData.refStDt);
		ipt_To.setRef("data:aliasDataMap."+bindData.refEdDt);
		var refStDt = aliasDataMap.get(bindData.refStDt);
		var refEdDt = aliasDataMap.get(bindData.refEdDt);
		
		scwin.setInitDate(refStDt,refEdDt);
		
	};
	
/**
 * @method
 * @name setInitDate
 * @description desc
 * @return None|없음
 * @param <String>|fromDate|desc
 * @param <String>|toDate|desc 
 * @hidden N
 * @exception 
 * @sample 
 */    
	scwin.setInitDate = function(fromDate , toDate ){
		gr_cal.setStyle( "display" , "none" );
		scwin.disFlag = true;
		
		if ( fromDate.length == 8 ){
			scwin.setInitFromDate(fromDate);
		}
		if ( toDate.length == 8 ){
			scwin.setInitToDate(toDate);
		}
		
		cal_fr.gotoCalendar(fromDate);	
		cal_to.gotoCalendar(toDate);	
		
		scwin.disableBeforeDate(fromDate);
		scwin.disableAfterDate(toDate);
		
	};
/**
 * @method
 * @name setInitFromDate
 * @description desc
 * @return None|없음
 * @param <String>|dateStr|desc 
 * @hidden Y
 * @exception 
 * @sample 
 */     
	scwin.setInitFromDate = function(dateStr){
		ipt_from.setValue(dateStr);
		//scwin.setMainFromDate(dateStr);
	};
		
/**
 * @method
 * @name setInitToDate
 * @description desc
 * @return None|없음
 * @param <String>|dateStr|desc 
 * @hidden Y
 * @exception 
 * @sample 
 */   
	scwin.setInitToDate = function(dateStr){
		ipt_To.setValue(dateStr);
		//scwin.setMainFromDate(dateStr);
	};
		
	scwin.img_Cal_onclick = function(e) {
		if (scwin.disFlag){
			scwin.disFlag = false;
			gr_cal.setStyle( "display" , "flex" );
			
		
			if ( ipt_To.getValue()  && ipt_To.getValue().length == 8 ){
				cal_to.gotoCalendar(ipt_To.getValue());
			} else {
				cal_to.gotoCalendar($p.getCurrentServerDate( "yyyyMMdd" ));
			}
			if ( ipt_from.getValue()  && ipt_from.getValue().length == 8 ){
				cal_fr.gotoCalendar(ipt_from.getValue());
			} else {
				cal_fr.gotoCalendar($p.getCurrentServerDate( "yyyyMMdd" ));
			}
		} else {
			scwin.disFlag = true;
			gr_cal.setStyle( "display" , "none" );
		}
    				
	};
	
	scwin.cal_fr_ondateselect = function(dateStr,dateObj) {
		if ( dateStr >  ipt_To.getValue() && ipt_To.getValue() != "" ){
 			$c.popup.alert($p,"TO DATE 보다 미래일자 입니다.");
 			ipt_from.setValue("");
 		} else {
 			ipt_from.setValue( dateStr );
 			if ( dateStr ){
 				cal_fr.gotoCalendar(dateStr);
 			} else {
 				cal_fr.gotoCalendar($p.getCurrentServerDate( "yyyyMMdd" ));
 			}
 					//cal_to.options.disableBeforeDate = dateStr;
  			if ( ipt_To.getValue() ){
  				scwin.disFlag = true;
  				gr_cal.setStyle( "display" , "none" );
  			}
 		}
 				
 		scwin.disableBeforeDate( dateStr);		
 		
		
	};
	

	
	scwin.cal_to_ondateselect = function(dateStr,dateObj) {
		if ( dateStr < ipt_from.getValue() && ipt_from.getValue() != "" ){
    		$c.popup.alert($p,"FROM DATE 보다 과거일자 입니다.");
    					
			ipt_To.setValue("");
		} else {
 			ipt_To.setValue( dateStr );
 			cal_to.gotoCalendar(dateStr);
 				
 			if ( dateStr ){
				cal_to.gotoCalendar(dateStr);
			} else {
				cal_to.gotoCalendar($p.getCurrentServerDate( "yyyyMMdd" ));
			}
 			if ( ipt_from.getValue() ){
 				scwin.disFlag = true;
 				gr_cal.setStyle( "display" , "none" );
 			}
		}
				
		scwin.disableAfterDate	( dateStr );	
		
	};
	
	scwin.disableBeforeDate = function( dateStr ){
		if ( dateStr ){
			var date1 = $p.dateAdd( dateStr , 0 );
			cal_to.options.disableBeforeDate = date1;
		} else {
			cal_to.options.disableBeforeDate = false;
		}
	};
	
	scwin.disableAfterDate = function( dateStr ){
		
		;
		if ( dateStr ){
			var date1 = $p.dateAdd( dateStr , 0 );
			
			cal_fr.options.disableAfterDate = date1;
		} else {
			cal_fr.options.disableAfterDate = false;
		}
	};
	
	scwin.ipt_from_onviewchange = function(info) {
		
		var val = info.newValue;
		
		
		scwin.cal_fr_ondateselect (val);
	};
	
	scwin.ipt_To_onviewchange = function(info) {
		var val = info.newValue;
		scwin.cal_to_ondateselect (val);
	};
	
}}}]}]},{T:1,N:'body',A:{'ev:onpageload':'scwin.onpageload()'},E:[{T:1,N:'xf:group',A:{style:'display: flex',id:''},E:[{T:1,N:'xf:group',A:{style:'display: block;',id:''},E:[{T:1,N:'xf:input',A:{adjustMaxLength:'false',dataType:'date',displayFormat:'yyyy-MM-dd',id:'ipt_from',renderType:'',rightAlign:'false',style:'width: 40%;','ev:onviewchange':'scwin.ipt_from_onviewchange',ref:''}},{T:1,N:'w2:span',A:{id:'',label:'~',style:''}},{T:1,N:'xf:input',A:{adjustMaxLength:'false',dataType:'date',displayFormat:'yyyy-MM-dd',id:'ipt_To',renderType:'',rightAlign:'false',style:'width: 40%;','ev:onviewchange':'scwin.ipt_To_onviewchange'}},{T:1,N:'xf:image',A:{id:'img_Cal',src:'/cm/images/ico_calendar.png',style:'width:20px;height:20px;','ev:onclick':'scwin.img_Cal_onclick'}}]},{T:1,N:'xf:group',A:{style:'display: none;z-index: 2000;position: absolute;top:45px;',id:'gr_cal'},E:[{T:1,N:'xf:group',A:{style:'position: relative;float:left;',id:''},E:[{T:1,N:'w2:calendar',A:{footerDiv:'false',style:'width: 100px;height: 100px;position: relative;',id:'cal_fr','ev:ondateselect':'scwin.cal_fr_ondateselect'}}]},{T:1,N:'xf:group',A:{style:'position: relative;float:left;margin-left: 10px;',id:''},E:[{T:1,N:'w2:calendar',A:{footerDiv:'false',style:'width: 100px;height: 100px;position: relative;',id:'cal_to','ev:ondateselect':'scwin.cal_to_ondateselect'}}]}]}]}]}]}]})