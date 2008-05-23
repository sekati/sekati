/*////////////////////////////////////////////////////////////////////////////////////////

  swfIN 2.2.1  -  2008-05-20
  javascript toolkit for flash developers
  � 2005-2008 Francis Turmel  |  swfIN.nectere.ca  |  www.nectere.ca  |  francis@nectere.ca
  released under the MIT license

/*////////////////////////////////////////////////////////////////////////////////////////
if(typeof swfIN=="undefined"){var swfIN=function(B,C,D,A){this.params=[];this.flashVars=[];this.swfPath=B;this.swfID=C;this.containerDivID="div_"+C;this.width=String(D);this.height=String(A);this.scrollbarWidth=null;this.scrollbarHeight=null;this.requiredVersion=[0,0,0];this.redirectURL=null;this.redirectUseParams=false;this.xiPath=null;this.xiWidth=null;this.xiHeight=null;this.is_written=false;this.showDivName=null;swfIN._static.init()};swfIN.prototype={addParam:function(A,B){if(A!=""){this.params[A]=B
}},addVar:function(A,B){if(A!=""){this.flashVars[A]=B}},addVars:function(B){for(var A in B){this.addVar(A,B[A])}},scrollbarAt:function(B,A){this.scrollbarWidth=B;this.scrollbarHeight=A;if(this.isWritten()){this.refresh()}},resize:function(B,A){this.width=B;this.height=A;if(this.isWritten()){this.refresh()}},detect:function(B,C,A){this.detectRedirect(B,C,A)},detectRedirect:function(B,C,A){this.requiredVersion=B;this.redirectURL=C;this.redirectUseParams=A||false},detectShowDiv:function(B,C,A){this.requiredVersion=B;
this.showDivName=C},useExpressInstall:function(B,C,A){this.xiPath=B;this.xiWidth=C;this.xiHeight=A},useSWFAddress:function(){if(typeof SWFAddress!="undefined"){SWFAddress.setId(this.getSWFID())}else{this._error("Can't find the SWFAddress js lib. Remove the .useSWFAddress() call if you're not using it.")}},callback:function(E){var A=arguments.length-1;var D=window.document[this.getSWFID()];var B=arguments;var C=E;if(A>15){this._error(".callback supports a maximum of 15 extra args. You currently have "+A)
}switch(A){case 0:D[C]();break;case 1:D[C](B[1]);break;case 2:D[C](B[1],B[2]);break;case 3:D[C](B[1],B[2],B[3]);break;case 4:D[C](B[1],B[2],B[3],B[4]);break;case 5:D[C](B[1],B[2],B[3],B[4],B[5]);break;case 6:D[C](B[1],B[2],B[3],B[4],B[5],B[6]);break;case 7:D[C](B[1],B[2],B[3],B[4],B[5],B[6],B[7]);break;case 8:D[C](B[1],B[2],B[3],B[4],B[5],B[6],B[7],B[8]);break;case 9:D[C](B[1],B[2],B[3],B[4],B[5],B[6],B[7],B[8],B[9]);break;case 10:D[C](B[1],B[2],B[3],B[4],B[5],B[6],B[7],B[8],B[9],B[10]);break;case 11:D[C](B[1],B[2],B[3],B[4],B[5],B[6],B[7],B[8],B[9],B[10],B[11]);
break;case 12:D[C](B[1],B[2],B[3],B[4],B[5],B[6],B[7],B[8],B[9],B[10],B[11],B[12]);break;case 13:D[C](B[1],B[2],B[3],B[4],B[5],B[6],B[7],B[8],B[9],B[10],B[11],B[12],B[13]);break;case 14:D[C](B[1],B[2],B[3],B[4],B[5],B[6],B[7],B[8],B[9],B[10],B[11],B[12],B[13],B[14]);break;case 15:D[C](B[1],B[2],B[3],B[4],B[5],B[6],B[7],B[8],B[9],B[10],B[11],B[12],B[13],B[14],B[15]);break}},write:function(){if(!swfIN.detect.isPlayerVersionValid(this.requiredVersion)&&swfIN.detect.isPlayerVersionValid(swfIN._memory.expressInstallVersion)&&this.xiPath!=null&&swfIN.utils.getQueryParam("detect")!="false"){this.addParam("scale","noScale");
document.title=document.title.slice(0,47)+" - Flash Player Installation";this.addVar("MMdoctitle",document.title);this.addVar("MMplayerType",(swfIN.detect.nsPlugin())?"PlugIn":"ActiveX");this.addVar("MMredirectURL",window.location);this.width=this.xiWidth||this.width;if(this.width<swfIN._memory.expressInstallMinSize.w){this.width=swfIN._memory.expressInstallMinSize.w}this.height=this.xiHeight||this.height;if(this.height<swfIN._memory.expressInstallMinSize.h){this.height=swfIN._memory.expressInstallMinSize.h
}this.swfPath=this.xiPath;document.write(this.getHTML());this.is_written=true}else{if(swfIN.detect.isPlayerVersionValid(this.requiredVersion)||swfIN.utils.getQueryParam("detect")=="false"){document.write(this.getHTML());this.is_written=true}else{if(this.redirectURL!=null){var A=(this.redirectUseParams)?this.redirectURL+"?required="+this.requiredVersion.join(".")+"&installed="+swfIN.detect.getPlayerVersionString():this.redirectURL;location.href=A}}}if(this.isWritten()){if(this.showDivName){swfIN.utils.$delete(this.showDivName)
}this._checkForConflicts();swfIN._memory.swf_stack.push(this);this.refresh();this._formFix()}},isWritten:function(){return this.is_written},hideSEO:function(A){swfIN.utils.$delete(A)},getDivID:function(){return this.containerDivID},getDivRef:function(){return swfIN.utils.$(this.getDivID())},getSWFID:function(){return this.swfID},getSWFRef:function(){return swfIN.utils.$(this.getSWFID())},refresh:function(){var A=this.getDivRef();A.style.width=this._calculateWidth();A.style.height=this._calculateHeight()
},getHTML:function(){var E="";for(var C in this.flashVars){var B=(E=="")?"":"&";E+=B+C+"="+escape(this.flashVars[C])}var D=[];D.quality="high";D.menu="false";D.swLiveConnect="true";D.pluginspage=swfIN._memory.player_download;D.allowScriptAccess="always";D.FlashVars=E;for(var C in this.params){D[C]=this.params[C]}var A="<object classid='clsid:D27CDB6E-AE6D-11cf-96B8-444553540000'  id='"+this.swfID+"' width='100%' height='100%' align='top' hspace='0' vspace='0'><param name='movie' value='"+this.swfPath+"'>";
for(var C in D){A+="<param name='"+C+"' value='"+D[C]+"'>"}A+="<embed src='"+this.swfPath+"' width='100%' height='100%' align='top' hspace='0' vspace='0' type='application/x-shockwave-flash' name='"+this.swfID+"' ";for(var C in D){A+=C+"='"+D[C]+"' "}A+="></embed></object>";A="<div id='"+this.containerDivID+"' style='width:"+this._calculateWidth()+"; height:"+this._calculateHeight()+"'>"+A+"</div>";return A},_formFix:function(){if(swfIN.detect.ie()){window[this.getSWFID()]=document[this.getSWFID()]
}},_calculateWidth:function(){return this._sizeHelper("Width")},_calculateHeight:function(){return this._sizeHelper("Height")},_sizeHelper:function(C){var D=String(this["scrollbar"+C]);var A=String(this[C.toLowerCase()]);if(D!=null&&A.indexOf("%")>-1){var B=swfIN.detect.getBrowserSize()[C.substr(0,1).toLowerCase()]*(A.split("%")[0]/100);A=(D>B)?D:A}return(A.indexOf("%")>-1)?A:A+"px"},_checkForConflicts:function(){if(this.swfID==null){this._error("The swf's id cannot be empty")}if(this.containerDivID==null){this._error("The container div's id cannot be empty")
}if(this.swfID.indexOf(" ")>-1){this._error("The swf's id cannot contain spaces")}if(this.containerDivID.indexOf(" ")>-1){this._error("The container div's id cannot contain spaces")}if(this.getDivID()==this.getSWFID()){this._error("You cannot name swfs or divs by the same id. Please revise the ids currently in use.")}var A=swfIN._memory.swf_stack;for(var B=0;B<A.length;B++){if(A[B].getDivID()==this.getDivID()||A[B].getDivID()==this.getSWFID()||A[B].getSWFID()==this.getDivID()||A[B].getSWFID()==this.getSWFID()){this._error("You cannot name swfs or divs by the same id. Please revise the ids currently in use.")
}}},_error:function(A){alert("swfIN error!\n"+A)}};swfIN._static={init:function(){if(!swfIN._memory.is_init){if(Array.prototype.push==null){Array.prototype.push=function(A){this[this.length]=A;return this.length}}swfIN.utils.addEventListener(window,"resize",swfIN._static.refreshAll);swfIN._memory.is_init=true;document.write('<iframe src="" id="swfIN_proxy_div" width=1 height=1 style="width:0px; height:0px; border:0px"></iframe>')}},refreshAll:function(){var B=swfIN._memory.swf_stack;for(var C=0;C<B.length;
C++){var A=B[C];if(A.isWritten()){A.refresh()}}}};swfIN._memory={swf_stack:[],is_init:false,player_download:"http://www.adobe.com/go/getflash/",user_agent:navigator.userAgent.toLowerCase(),expressInstallMinSize:{w:214,h:137},expressInstallVersion:[6,0,65],fullscreenModeVersion:[9,0,28],vistaVersion:[9,0,28]};swfIN.detect={getPlayerVersion:function(){var C=[0,0,0];var D;if(navigator.plugins&&navigator.mimeTypes.length){var A=navigator.plugins["Shockwave Flash"];if(A&&A.description){C=A.description.replace(/([a-zA-Z]|\s)+/,"").replace(/(\s+r|\s+b[0-9]+)/,".").split(".")
}}else{if(navigator.userAgent&&navigator.userAgent.indexOf("Windows CE")>=0){D=1;var B=3;while(D){try{B++;D=new ActiveXObject("ShockwaveFlash.ShockwaveFlash."+B);C=[B,0,0]}catch(E){D=null}}}else{try{D=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.7")}catch(E){try{D=new ActiveXObject("ShockwaveFlash.ShockwaveFlash.6");C=[6,0,21];D.AllowScriptAccess="always"}catch(E){if(C[0]==6){return C}}try{D=new ActiveXObject("ShockwaveFlash.ShockwaveFlash")}catch(E){}}if(D!=null){C=D.GetVariable("$version").split(" ")[1].split(",")
}}}return C},isPlayerVersionValid:function(B){var A=swfIN.detect.getPlayerVersion();if(A[0]<B[0]){return false}if(A[0]>B[0]){return true}if(A[1]<B[1]){return false}if(A[1]>B[1]){return true}if(A[2]<B[2]){return false}return true},getPlayerVersionString:function(){return swfIN.detect.getPlayerVersion().join(".")},ns4:function(){return(document.layers!=null)},ie5_mac:function(){return(swfIN._memory.user_agent.indexOf("msie 5")!=-1&&swfIN._memory.user_agent.indexOf("mac")!=-1)},ie7:function(){return(swfIN._memory.user_agent.indexOf("msie 7")!=-1)
},ie:function(){return(swfIN._memory.user_agent.indexOf("msie")!=-1)},safari:function(){return(swfIN._memory.user_agent.indexOf("applewebkit")!=-1)},mac:function(){return(swfIN._memory.user_agent.indexOf("mac")!=-1)},nsPlugin:function(){return(navigator.plugins&&navigator.mimeTypes&&navigator.mimeTypes.length>0)},getBrowserSize:function(){if(self.innerWidth){return{w:self.innerWidth,h:self.innerHeight}}else{if(document.documentElement&&document.documentElement.clientWidth){return{w:document.documentElement.clientWidth,h:document.documentElement.clientHeight}
}else{if(document.body){return{w:document.body.clientWidth,h:document.body.clientHeight}}else{return{w:null,h:null}}}}},getFullScreenSize:function(){return{w:screen.width,h:screen.height}},getAvailScreenSize:function(){return{w:screen.availWidth,h:screen.availHeight}}};swfIN.utils={$:function(A){return document.getElementById(A)},$delete:function(B){var A=swfIN.utils.$(B);A.parentNode.removeChild(A)},splice:function(D,B){var A=[];for(var C=B;C<D.length;C++){A[C-B]=D[C]}return A},delegate:function(B,A){var C=function(){var E=arguments.callee.t;
var D=arguments.callee.f;var F=arguments.callee.a;return D.apply(E,F)};C.t=B;C.f=A;C.a=swfIN.utils.splice(arguments,2);return C},addEventListener:function(A,C,B){if(A.addEventListener){A.addEventListener(C,B,true)}else{A.attachEvent("on"+C,B)}},popUp:function(A,B,M,F,L,K,D){var J=swfIN.detect.getFullScreenSize();var I=swfIN.detect.getAvailScreenSize();M=(M=="full")?I.w:M;F=(F=="full")?I.h:F;L=(L=="center")?(J.w-M)/2:L;K=(K=="center")?(J.h-F)/2:K;var C=[];C.width=M;C.innerWidth=M;C.height=F;C.innerHeight=F;
C.toolbar=0;C.location=0;C.directories=0;C.status=0;C.menubar=0;C.scrollbars=0;C.resizable=0;C.copyhistory=0;C.fullscreen=0;for(var E in D){C[E]=D[E]}var H="";for(var E in C){H+=(H=="")?E+"="+C[E]:","+E+"="+C[E]}var G=window.open(A,B,H);G.resizeTo(M,F);G.moveTo(0,0);G.moveBy(L,K);G.focus()},getQueryParam:function(A){var B=swfIN.utils.getAllQueryParams()[A];return(B!=undefined&&B!="")?B:null},getAllQueryParams:function(){var B=[];var D=window.location.search.substring(1).split("&");for(var C=0;C<D.length;
C++){var A=D[C].split("=");B[A[0]]=A[1]}return B},proxyCall:function(A){document.getElementById("swfIN_proxy_div").src=A}}};