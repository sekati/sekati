/**
 * SWFMouse - Mac MouseWheel Support for Flash & Ajax.
 * @version 1.1.1
 * @author jason m horwitz | sekati.com
 * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved.
 * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php
 */
 
 /**
  * SWFMouse offers Mac MouseWheel support for Flash & Ajax.
  * Natively it supports both swfObject (http://code.google.com/p/swfobject/)
  * as well as swfIN (http://code.google.com/p/swfin/).
  * @param swfInstance - the swfIN or swfObject instance.
  */
 function SWFMouse ( swfInstance ) {
 	this.so = swfInstance;
 	this.isSWFObject = (typeof swfobject != 'undefined')  ? true : false;
 	this.isSWFIN = (typeof swfIN != 'undefined')  ? true : false;
 	var isMac = navigator.appVersion.toLowerCase().indexOf( "mac" ) != -1;
 	if (isMac) this.init();
 	if (this.isSWFObject == true || this.isSWFIN == true) {
 		if (isMac) this.init();
 	} else {
 		alert("SWFMouse Error: the constructor argument 'swfInstance' is not a supported type (SWFObject or swfIN).");
 	}
 } 

SWFMouse.prototype = {	
	
	/**
	 * Initialization: listen for browser mousewheel event.
	 */
	init: function() {
		SWFMouse.instance = this;
		//alert("swfObject: "+this.isSWFObject+", swfIN: "+this.isSWFIN);
		if (window.addEventListener) window.addEventListener( 'DOMMouseScroll', SWFMouse.instance.wheel, false );
		window.onmousewheel = document.onmousewheel = SWFMouse.instance.wheel;
	},
	
	/**
	 * constrain the value to confines. 
	 */
	clamp: function( val, min, max ) {
		if( val < min ) return min;
		if( val > max ) return max;
		return val;
	},	
	
	/**
	 * mousewheel event handler
	 */
	handle: function( delta ){
		if (this.isSWFIN == true) {
			document[ this.so.getSWFID() ].externalMouseEvent( delta );
		} else if (this.isSWFObject == true) {
			document[ this.so.getObjectById( "id" ) ].externalMouseEvent( delta );
		}
	},
	
	/**
	 * sanitize the mouse wheel event data & pass to handler.
	 */
	wheel: function( event ){
		var delta = 0;
		if (event.wheelDelta) {
			// internet explorer & opera
			delta = event.wheelDelta / 120;
			if (window.opera) delta = -delta;
		} else if (event.detail) {
			// mozilla
			delta = -event.detail / 3;
		}		
		// safari
       	if(/AppleWebKit/.test( navigator.userAgent )) delta /= 3;
		// normalize the delta
		delta = SWFMouse.instance.clamp( delta );
		// pass to handler		
		if (delta) SWFMouse.instance.handle( delta );
		if (event.preventDefault) event.preventDefault();
		event.returnValue = false;
	}
};