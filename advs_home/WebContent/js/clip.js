
function goClipreport(oReport) {
	window.open(url, 'window_clip', 'toolbar=no,status=yes,scrollbars=yes,menubar=no,resizable=yes,location=no,width=450,height=270');
}

function GetfnParamSet() { 
	return new clipreports("0");
}
var rex_gsPreViewFeatures = "center=yes,scrollbars=no,status=no,toolbar=no,resizable=1,location=no,menu=no,width=835,height=600";

function clipreports(id){ 
	
	this.id = id;
	this.type; 
	this.rptname ="";
	this.params = {};
	this.httpparams = {};
	this.xmlpath ="";
	this.connectionUrl="";
	this.memo;
	
	this.connectionData;
	this.event ;
	
	clipreports.prototype.type  = function(id) {
		if (this.type[id] == undefined) {
			this.type[id] =  {};
		} 
		return this.type[id];
	}
	
	clipreports.prototype.memo  = function(id) {
		if (this.memo[id] == undefined) {
			this.memo[id] =  {};
		} 
		return this.memo[id];
	}
	
	clipreports.prototype.connectionUrl  = function(id) {
		if (this.connectionUrl[id] == undefined) {
			this.connectionUrl[id] =  {};
		} 
		return this.connectionUrl[id];
	}
	
	clipreports.prototype.rptname  = function(id) {
		if (this.rptname[id] == undefined) {
			this.rptname[id] =  {};
		} 
		return this.rptname[id];
	}
	
	clipreports.prototype.param  = function(id) {
		if (this.params[id] == undefined) {
			this.params[id] =  {};
		} 
		return this.params[id];
	}
	
	clipreports.prototype.httpparam  = function(id) {
		if (this.httpparams[id] == undefined) {
			this.httpparams[id] =  {};
		} 
		return this.httpparams[id];
	}
	
	clipreports.prototype.xmlpath  = function(id) {
		if (this.xmlpath[id] == undefined) {
			this.xmlpath[id] =  {};
		} 
		return this.xmlpath[id];
	}
	
	clipreports.prototype.connectionData  = function(id) {
		if (this.connectionData[id] == undefined) {
			this.connectionData[id] =  {};
		} 
		return this.connectionData[id];
	}
	
	clipreports.prototype.event   = function(id) { 
		 return null;
	}
	
	clipreports.prototype.open  = function() { 
		var $cform = $("<form></form>");
		
		this.win = window.open("about:blank", this.rptname, rex_gsPreViewFeatures);
		var url ="avds_viewer.jsp";
		if(this.rptname == "driveReport" || this.rptname == "Agcy_Off_Inst" || this.rptname == "Car_Reserve_Inst"){
			url ="avds_viewer_e.jsp";
			//url ="parentView.jsp";
			
		}
		//this.rptname = "viewTest";
		$cform.attr("action", "/ClipReport4/"+url+"?showme="+this.rptname);
		$cform.attr("method", "POST");
		$cform.attr("target", this.rptname );
		$cform.appendTo('body'); 
		
		var rptname = "<input type='hidden' name='rptname' value='"+this.rptname+"' />";   
		var paramData = "";
		$.each(this.params, function(idx, item){ 
			paramData += "<input type='hidden' name='"+idx+"' value='"+item.value+"'/>";
		});
		
		$cform.append(rptname).append(paramData);
	 
		$cform.submit();
	}
	
	
	
}