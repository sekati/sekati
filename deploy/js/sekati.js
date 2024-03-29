/**
 * sekati.js - Flash : Javascript Companion Library
 * @version 1.3.6
 * @author jason m horwitz | sekati.com
 * Copyright (C) 2007-2012  jason m horwitz, Sekat LLC. All Rights Reserved.
 * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php
 */

if (typeof sekati == "undefined") var sekati = new Object();

/////////////////////////////////////////////////////////////////////////////////
// externalInterface

sekati.external = {
		
	/*
	 * This may be used as an alternative to ExternalInterface.call 
	 * tests for javascript availability in the body tag but is no
	 * longer required by the framework.
	 * 
	 * @usage <body onload="sekati.external.init();"> 
	 */
	ready: false,
	
	isReady: function() {
		return sekati.external.ready;
	},
	
	init: function() {
		sekati.external.ready = true;
	},
	
	// call actionscript function: document.movieID.myFlashFunction( [argumentArray] );
	asCall: function ( id, fn, argArr ) {
		document[ id ][ fn ]( argArr );
	},
	
	setWidth: function ( id, width ) {
		if( window.innerWidth > width ) width = window.innerWidth;
		document.getElementById( id ).style.width = width + "px";
	},
	
	setHeight: function ( id, height ) {
		if( window.innerHeight > height ) height = window.innerHeight;
		document.getElementById( id ).style.height = height + "px";		
	},
	
	resize: function ( id, width, height ) {
		setFlashWidth( id, width );
		setFlashHeight( id, height );
	}, 
	
	isResizable: function ( ) {
		var ua = navigator.userAgent.toLowerCase( );
		var opera = ua.indexOf( "opera" );
		if( document.getElementById ) {
			if ( opera == -1 ) return true;
			else if( parseInt( ua.substr( opera+6, 1 ) ) >= 7 ) return true;
		}
		return false;
	}
	
};

/////////////////////////////////////////////////////////////////////////////////
// interface

sekati.ui = {
	
	// Toggle usage: onclick="sekati.ui.toggle(this,'targetID','show','hide')"
	toggle: function ( link, id ) {
		var box=document.getElementById( id );
		if ( box ) {
			if ( box.style.display ) { box.style.display = ""; } else { box.style.display = "none"; }
		}
	},
	
	// ifocus usage: <input type="text" name="hw" value="hello world" onfocus="sekati.ui.focus(this)" onblur="sekati.ui.blur(this)" />
	focus: function ( inp ) {  
		var defval;  
		if ( inp ) { 
			if ( ( defval = inp.getAttribute( "defval" ) ) && inp.value == defval ) inp.value = "";  
				else if ( !defval ) { inp.setAttribute( "defval", inp.value ); inp.value = ""; } 
			} 
	},
	
	blur: function( inp ) { 
		var defval; 
		if ( inp && inp.value == "" && ( defval = inp.getAttribute( "defval" ) ) ) inp.value = defval; 
	},
	
	// confirmbox usage: <a href="#" onclick="sekati.ui.confirmbox('Are you sure?','yes.html')">delete</a>
	confirmbox: function ( q, a ) { 
		if ( confirm( q ) ) window.location = a; 
	},	
	
	// pop usage: <a href="info.html" target="info" onclick="sekati.ui.pop(this.href, this.target, 500, 400);return false;">info</a>		
	pop: function ( url, win, w, h, x, y, toolbar, location, status, menubar, scrollbars, resizeable ) {
		var sx = (x == "center") ? (screen.availWidth - width) / 2 : x;
		var sy = (y == "center") ? (screen.availHeight - height) / 2 : y;
		var ww = (w == "fullscreen") ? screen.availWidth : w;
		var wh = (h == "fullscreen") ? screen.availHeight : h;
		var tb = (toolbar == true) ? "yes" : "no";
		var lc = (location == true) ? "yes" : "no";
		var st = (status == true) ? "yes" : "no";
		var mb = (menubar == true) ? "yes" : "no";
		var sc = (scrollbars == true) ? "auto" : "no";
		var re = (resizeable == true) ? "yes" : "no";
		var properties = "toolbar=" + tb + ",location=" + lc + ",directories=no,status=" + st + ",menubar=" + mb + ",scrollbars=" + sc + ",resizable=" + re + ",width=" + ww + ",height=" + wh + ",screenX=" + sx + ",screenY=" + sy;
		var pop = window.open(url, win, properties);
		pop.focus();
	}	
};

/////////////////////////////////////////////////////////////////////////////////
// tools

sekati.util = {
	
	isAppleiOS: function(){
		var ua = navigator.userAgent;
		return (ua.match(/iPhone/i)) || (ua.match(/iPod/i)) || (ua.match(/iPad/i));
	},
	
	isAndroid: function(){
		var ua = navigator.userAgent;
		return (ua.match(/Android/i));
	},
	
	isBlackBerry: function(){
		var ua = navigator.userAgent;
		return(ua.match(/^BlackBerry[0-9]*/));
	},
	
	isMobile: function(){
		return (sekati.util.isAppleiOS() || sekati.util.isAndroid() || sekati.util.isBlackBerry());
	},
		
	browserSize: function(){
		if ( self.innerWidth ){
			return { w:self.innerWidth, h:self.innerHeight };
		}else if ( document.documentElement && document.documentElement.clientWidth ){
			return { w:document.documentElement.clientWidth, h:document.documentElement.clientHeight };
		}else if ( document.body ){
			return { w:document.body.clientWidth, h:document.body.clientHeight };
		}
		return false;
	},
	
	// helper functions tied to swfIN (http://swfin.nectere.ca)
	browserW: function() {
		return sekati.util.browserSize().w
	},
	
	browserH: function () {
		return sekati.util.browserSize().h
	},
	
	// get entire url	
	ref: function() {
		return document.location.href;
	},
	
	baseRef: function() {
		return document.location.href.split('#/')[0];
	},
	
	getTitle: function() {
		return document.title;
	},
	
	setTitle: function( title ) {
		return document.title = title;
	},	
	
	forward: function() {
		return window.history.forward();
	},
	
	back: function() {
		return window.history.back();
	},
	
	// clamp a value to its constrains
	clamp: function( val, min, max ) {
		if( val < min ) return min;
		if( val > max ) return max;
		return val;
	},
	
	// Get a query string value by key
	getQueryParam: function( key ) {
		var val = sekati.util.getAllQueryParams()[key];
		return (val != undefined && val != "") ? val : null ;
	},
	
	// Get full querystring
	getAllQueryParams: function(){
		var qs={};
		var params = window.location.search.substring(1).split("&");
		for (var i=0; i<params.length; i++) {
			var keyVal = params[i].split("=");
			qs[ keyVal[0] ] = keyVal[1];
		}
		return qs;
	},
	
	// Get a hash param value by index (0 based array index)
	getHashParam: function( index ){
		var hp = sekati.util.getAllHashParams();
		return (hp.length>=index) ? hp[index] : undefined;
	},
	
	// Get full hash params as array
	getAllHashParams: function(){
		var path = window.location.href.split('#')[1];
		var parr = (path && path.length > 0) ? sekati.util.cleanArray( path.split('/') ) : [];		
		// remove bang to support hashbang'd urls:
		if(parr.length > 0) {
			if(parr[0].indexOf('!') > -1) parr.splice(0,1);
		}
		return parr;
	},
	
	// Remove empty elements from an array (returning a clean array).
	cleanArray: function(arr){
		var clean=[];
		for(var i = 0; i<arr.length; i++){
			if (arr[i]) clean.push(arr[i]);
		}
		return clean;
	}
	
};
