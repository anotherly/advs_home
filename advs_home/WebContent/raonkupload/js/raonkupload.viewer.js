var raonkuploadBrowser=function(){var b=navigator.userAgent.toLowerCase(),a=window.opera,a={ie:-1<b.search("trident")||-1<b.search("msie")||-1<b.search("edge/12")?!0:!1,edge:/(edge)\/((\d+)?[\w\.]+)/i.test(b)?!0:!1,opera:!!a&&a.version,webkit:-1<b.indexOf(" applewebkit/"),mac:-1<b.indexOf("macintosh"),quirks:"BackCompat"==document.compatMode,mobile:-1<b.indexOf("mobile"),iOS:/(ipad|iphone|ipod)/.test(b),isCustomDomain:function(a){if(!this.ie)return!1;var b=a.domain;a=RAONKUPLOAD.util.getDocWindow(a).location.hostname;
var c=!1;try{c=RAONKUPLOAD.EnforceDocumentDomain}catch(m){}return 1==!!c||b!=a&&b!="["+a+"]"},isHttps:"https:"==location.protocol,HTML5Supported:!0};a.gecko="Gecko"==navigator.product&&!a.webkit&&!a.opera;a.ie&&(a.gecko=!1);a.webkit&&(-1<b.indexOf("chrome")?(a.chrome=!0,-1<b.indexOf("opr")&&(a.opera=!0,a.chrome=!1)):a.safari=!0);var c;a.ieVersion=0;a.ie&&(c=a.quirks||!document.documentMode?-1<b.indexOf("msie")?parseFloat(b.match(/msie (\d+)/)[1]):-1<b.indexOf("trident")?parseFloat(b.match(/rv:([\d\.]+)/)[1]):
-1<b.indexOf("edge/12")||-1<b.indexOf("edge/13")?12:7:document.documentMode,a.ieVersion=c,a.ie11=11==c,a.ie10=10==c,a.ie9=9==c,a.ie8=8==c,a.ie7=7==c,a.ie6=7>c||a.quirks);a.gecko&&(c=b.match(/rv:([\d\.]+)/))&&(c=c[1].split("."),c=1E4*c[0]+100*(c[1]||0)+1*(c[2]||0));a.webkit&&(c=parseFloat(b.match(/ applewebkit\/(\d+)/)[1]));a.HTML5Supported="File"in window&&"FileReader"in window&&"Blob"in window;a.WorkerSupported="Worker"in window;return a}();
raonkuploadAjax=function(){var b=function(){if(!raonkuploadBrowser.ie||"file:"!=location.protocol){try{return new XMLHttpRequest}catch(a){}try{return new ActiveXObject("Msxml2.XHLHTTP")}catch(b){}try{return new ActiveXObject("Microsoft.XMLHTTP")}catch(c){}}return null},a=function(a){return 4==a.readyState&&(200<=a.status&&300>a.status||304==a.status||0===a.status||1223==a.status)},c=function(b){return a(b)?b.responseText:null},h=function(b){if(a(b)){var c=b.responseXML;return c?c:b.responseText}return null},
k=function(a,c,f){var g=!!c,d=b();if(!d)return null;d.open("GET",a,g);g&&(d.onreadystatechange=function(){4==d.readyState&&(c(f(d)),d=null)});try{d.send(null)}catch(e){return null}setTimeout(function(){g||d.abort()},5E3);return g?"":f(d)},l=function(a,c,f,g){var d=!!f,e=b();if(!e)return null;e.open("POST",a,d);e.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=UTF-8");d&&(e.onreadystatechange=function(){4==e.readyState&&(f(g(e)),e=null)});try{e.send(c)}catch(h){return null}setTimeout(function(){d||
e.abort()},5E3);return d?"":g(e)};return{load:function(a,b){return k(a,b,c)},loadXml:function(a,b){return k(a,b,h)},postData:function(a,b,f){return l(a,b,f,c)},postFileData:function(a,b){return postFileData(a,b)},createXMLHttpRequest:function(){return b()}}}();function parseDataFromServer(b){var a=b.toLowerCase().indexOf("<raonk>");-1<a&&(b=b.substring(a+7));a=b.toLowerCase().indexOf("</raonk>");-1<a&&(b=b.substring(0,a));return b}
function raonkuploadAjaxText(b,a){raonkuploadAjax.postData(b+"&raonk="+(new Date).getTime(),"",function(b){a(b)})}
function raonkuploadCheckDownloadComplete(b,a,c){var h=0>a.indexOf("?")?a+"?":a+"&";"2"<=c&&(c="1");a=""+("kc"+RaonKBase64._trans_unitAttributeDelimiter+"c16"+RaonKBase64._trans_unitDelimiter);a+="k01"+RaonKBase64._trans_unitAttributeDelimiter+c+RaonKBase64._trans_unitDelimiter;a+="k12"+RaonKBase64._trans_unitAttributeDelimiter+b;a=RaonKBase64.makeEncryptParam(a);var h=h+("k00="+a+"&raonk="+(new Date).getTime()),k=1,l=setInterval(function(){k++;var a=raonkuploadAjax.createXMLHttpRequest();a.open("GET",
h,!1);a.onreadystatechange=function(){if(4==a.readyState)if(200==a.status){var b=parseDataFromServer(a.responseText);""!=b&&(0==b.indexOf("[OK]")?(clearInterval(l),window.close()):20==k&&(clearInterval(l),window.close()))}else 400<=a.status&&600>a.status&&(clearInterval(l),window.close())};a.send(null)},3E3)};
