/*amd /cm/template/page/11.alert/alert.xml 2046 c127502907c40222dd47d8dd2f3e441fd60b8f675097bec83b30242a37f190bb */
define({declaration:{A:{version:'1.0',encoding:'UTF-8',standalone:'no'}},E:[{T:1,N:'html',A:{xmlns:'http://www.w3.org/1999/xhtml','xmlns:ev':'http://www.w3.org/2001/xml-events','xmlns:w2':'http://www.inswave.com/websquare','xmlns:xf':'http://www.w3.org/2002/xforms'},E:[{T:1,N:'head',E:[{T:1,N:'w2:type',E:[{T:3,text:'COMPONENT'}]},{T:1,N:'w2:buildDate'},{T:1,N:'w2:MSA'},{T:1,N:'xf:model',E:[{T:1,N:'w2:dataCollection',A:{baseNode:'map'}},{T:1,N:'w2:workflowCollection'}]},{T:1,N:'w2:layoutInfo'},{T:1,N:'w2:publicInfo',A:{method:''}},{T:1,N:'script',A:{lazy:'false',type:'text/javascript'},E:[{T:4,cdata:function(scopeObj){with(scopeObj){
			scwin.onpageload = function() {
				$(".btn_pop").click(function(){
					$(".ly_popup").hide("fast");
					$(".dimd").hide();
				});		
			};
		
			scwin.btnOpenLayer_onclick = function() {
				$(".ly_popup").show("fast");
				$(".dimd").show();
			};
		
}}}]}]},{T:1,N:'body',A:{'ev:onpageload':'scwin.onpageload'},E:[{T:1,N:'xf:group',A:{id:'',style:'',class:'sub_contents'},E:[{T:1,N:'xf:group',A:{class:'dfbox',id:'',style:''},E:[{T:1,N:'w2:textbox',A:{class:'df_tit fl',id:'',label:'레이어팝업 호출',style:''}},{T:1,N:'xf:group',A:{class:'fr',id:'',style:''},E:[{T:1,N:'xf:trigger',A:{class:'btn_cm ',id:'btnOpenLayer',style:'',type:'button','ev:onclick':'scwin.btnOpenLayer_onclick'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'팝업띄우기'}]}]}]}]}]},{T:1,N:'xf:group',A:{id:'',style:'',class:'ly_popup'},E:[{T:1,N:'xf:group',A:{id:'',style:'',class:'ly_head'},E:[{T:1,N:'w2:textbox',A:{id:'',style:'',class:'tit',label:'Alert',tagname:'p'}}]},{T:1,N:'xf:group',A:{id:'',style:'',class:'ly_cont'},E:[{T:1,N:'w2:textbox',A:{id:'',style:'',class:'txt1',label:'장애가 발생하였습니다.',tagname:'p'}},{T:1,N:'w2:textbox',A:{id:'',style:'',class:'txt2',label:'장애문의 : admin@admin.com',tagname:'p'}},{T:1,N:'w2:anchor',A:{id:'',style:'',class:'btn_pop',outerDiv:'false'},E:[{T:1,N:'xf:label',E:[{T:4,cdata:'닫기'}]}]}]}]},{T:1,N:'xf:group',A:{id:'',style:'',class:'dimd'}}]}]}]})