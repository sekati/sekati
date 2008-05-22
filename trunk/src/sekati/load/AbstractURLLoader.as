/** * sekati.load.AbstractURLLoader * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.load {	import flash.events.Event;	import flash.events.HTTPStatusEvent;	import flash.events.IOErrorEvent;	import flash.events.ProgressEvent;	import flash.events.SecurityErrorEvent;	import flash.net.URLLoader;	import flash.net.URLRequest;		/**	 * AbstractURLLoader provides a common URLLoader API for textual data transports.	 * 	 * @example <listing version="3.0">	 * 	 * </listing>	 */	public class AbstractURLLoader extends URLLoader {		protected var _this : AbstractURLLoader;		protected var _urlRequest : URLRequest;		protected var RETRY_ATTEMPT : uint = 0;		protected var RETRY_MAX : uint;			/**		 * AbstractURLLoader Constructor		 * @param maxRetryAttempts 	Number of times to retry each method in bootstrap before fatal error.		 */		public function AbstractURLLoader(urlRequest : URLRequest = null, init : Boolean = true, maxRetryAttempts : uint = 5) {			_this = this;			_urlRequest = urlRequest;			RETRY_MAX = maxRetryAttempts;			configureListeners( true );			if (init) {				//load( );				}					}		/**		 * Load the xml document defined in the constructor.		 */		/* 		override public function load( request : URLRequest = null ) : void {			try {				super.load( request );                			} catch ( e : Error ) {				trace( "Unable to load requested document: " + e.message );			}		}			*/		protected function configureListeners(isAdd : Boolean ) : void {			var listenAction : String = (!isAdd) ? 'addEventListener' : 'removeEventListener';			_this[listenAction]( Event.COMPLETE, completeHandler );			_this[listenAction]( Event.OPEN, openHandler );			_this[listenAction]( ProgressEvent.PROGRESS, progressHandler );			_this[listenAction]( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );			_this[listenAction]( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );			_this[listenAction]( IOErrorEvent.IO_ERROR, ioErrorHandler );		}		// HANDLERS				/**		 * Dispatch the XMLEvent.ON_READY event along with the xml data.		 */		protected function completeHandler(event : Event) : void {			configureListeners( false );			//var e : XMLEvent = new XMLEvent( XMLEvent.ON_READY, _xml );			//dispatchEvent( e );		}		protected function openHandler(e : Event) : void {        	//trace("openHandler: " + e);		}		protected function progressHandler(e : ProgressEvent) : void {        	//trace("progressHandler loaded:" + e.bytesLoaded + " total: " + e.bytesTotal);		}		protected function securityErrorHandler(e : SecurityErrorEvent) : void {            //trace("securityErrorHandler: " + e);		}		protected function httpStatusHandler(e : HTTPStatusEvent) : void {            //trace("httpStatusHandler: " + e);		}		protected function ioErrorHandler(e : IOErrorEvent) : void {            //trace("ioErrorHandler: " + e);		}								}}