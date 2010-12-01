/**
 * SWFMouse - Mac MouseWheel Support for Flash & Ajax.
 * @description Native support for both swfObject (http://code.google.com/p/swfobject/) & swfIN (http://code.google.com/p/swfin/).
 * @version 2.2.0
 * @author jason m horwitz | sekati.com
 * Copyright (C) 2008-2010  jason m horwitz, Sekat LLC. All Rights Reserved.
 * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php
 * 
 * 
 * @param swfInstance - the swfIN or swfObject (pre v2.2) instance.
 * 
 * @example (swfIN || SWFObject <2.2): 
 * 			var mousewheel = new SWFMouse( {swfIN || swfObject instance } );
 * 
 * @example (SWFObject >=2.2):
 * 			var attributes = { id:'my_swf', name:'my_swf' }; 
 * 			embedSWF( "my.swf", "my_div", "100%", "100%", "10.0", flashvars, params, attributes );
 * 			var mousewheel = new SWFMouse();
 * 			swfmacmousewheel.registerObject(attributes.id);
 */
 function SWFMouse ( swfInstance ) {
 	this.so = swfInstance;
 	this.regObjArr = [];
 	this.isSWFObject = (typeof swfobject != 'undefined')  ? true : false;
 	this.isSWFIN = (typeof swfIN != 'undefined')  ? true : false;
	
 	var u = navigator.userAgent.toLowerCase();
	var p = navigator.platform.toLowerCase();
	var isMac = p ? /mac/.test(p) : /mac/.test(u);
 	if(isMac && (this.isSWFObject || this.isSWFIN)) this.init();
 } 

SWFMouse.prototype = {	
	
	/**
	 * Initialization: listen for browser mousewheel event.
	 */
	init: function() {
		SWFMouse.instance = this;
		//alert("swfObject: "+this.isSWFObject+", swfIN: "+this.isSWFIN);
		if (window.addEventListener) window.addEventListener( 'DOMMouseScroll', SWFMouse.instance.deltaFilter, false );
		window.onmousewheel = document.onmousewheel = SWFMouse.instance.deltaFilter;
	},
	
	/**
	 * Register an object for mac mousewheel events.
	 * @param the object id to be registered.
	 */
	registerObject: function( objectIdStr ){
		this.regObjArr.push( objectIdStr );
	},
	
	/**
	 * Helper function: constrain the value to confines. 
	 */
	clamp: function( val, min, max ) {
		if( val < min ) return min;
		if( val > max ) return max;
		return val;
	},	
	
	/**
	 * Mouse Wheel event handler / dispatcher
	 */
	deltaDispatch: function( delta ){
		try {
			if (this.isSWFIN == true) {
				document[ this.so.getSWFID() ].externalMouseEvent( delta );
			} else if (this.isSWFObject == true) {
				if(this.regObjArr.length == 0 ) {
					document[ this.so.getObjectById( "id" ) ].externalMouseEvent( delta );
				} else {
					var obj;
					for(var i=0; i<this.regObjArr.length; i++){
						obj = swfobject.getObjectById(this.regObjArr[i]);
						if( typeof( obj.externalMouseEvent ) == 'function' ) obj.externalMouseEvent( delta );
					}
				}
			}
		}catch(e){}
	},
	
	/**
	 * Sanitize the mouse wheel event data & dispatch.
	 */
	deltaFilter: function( event ){
		var delta = 0;
		if (event.wheelDelta) {
			// internet explorer & opera
			delta = event.wheelDelta / 120;
			if (window.opera) delta = -delta;
		} else if (event.detail) {
			// mozilla
			delta = -event.detail / 3;
		}		
		// safari - since v4.x this seems not to be necessary!
       	//if(/AppleWebKit/.test( navigator.userAgent )) delta /= 3;
		// normalize the delta
		delta = SWFMouse.instance.clamp( delta );
		// pass to handler		
		if (delta) SWFMouse.instance.deltaDispatch( delta );
		if (event.preventDefault) event.preventDefault();
		event.returnValue = false;
	}	
};