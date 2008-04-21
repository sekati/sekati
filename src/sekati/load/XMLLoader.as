/** * sekati.load.XMLLoader * @version 1.0.2 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.load {	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.events.HTTPStatusEvent;	import flash.events.IOErrorEvent;	import flash.events.ProgressEvent;	import flash.events.SecurityErrorEvent;	import flash.net.*;	import sekati.events.XMLEvent;		/**	 * XMLLoader handles the loading of XML documents.	 * @example <listing version="3.0">	 * var loader : XMLLoader = new XMLLoader( "my.xml" );	 * loader.addEventListener ( XMLEvent.ON_READY, xmlHandler );	 * var xmlHandler : Function = function(e:XMLEvent):void {	 * 		trace( "w00t:\n\n" + e.data );	 * };	 * loader.request( );	 * </listing>	 */	public class XMLLoader extends EventDispatcher {		protected var _loader : URLLoader;		protected var _uri : String;		protected var _xml : XML;		/**		 * XMLLoader Constructor		 * @param url 	of the XML document to load.		 * @param init 	begin loading now.		 */		public function XMLLoader(url : String, init : Boolean = true) {			_uri = url;			_loader = new URLLoader( );			_loader.addEventListener( Event.COMPLETE, completeHandler, false, 0, true );			_loader.addEventListener( Event.OPEN, openHandler, false, 0, true );			_loader.addEventListener( ProgressEvent.PROGRESS, progressHandler, false, 0, true );			_loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true );			_loader.addEventListener( HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true );			_loader.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true );			if (init) {				request( );				}		}		/**		 * Return the xml content data.		 */		public function get data( ) : XML {			return _xml;		}		/**		 * Load the xml document defined in the constructor.		 */		public function request( ) : void {			try {				_loader.load( new URLRequest( _uri ) );                			} catch ( error : Error ) {				trace( "Unable to load requested XML document." );			}		}			/**		 * Dispatch the XMLEvent.ON_READY event along with the xml data.		 */		protected function completeHandler(event : Event) : void {			_xml = XML( _loader.data );			var e : XMLEvent = new XMLEvent( XMLEvent.ON_READY, _xml );			dispatchEvent( e );		}		protected function openHandler(e : Event) : void {        	//trace("openHandler: " + e);		}		protected function progressHandler(e : ProgressEvent) : void {        	//trace("progressHandler loaded:" + e.bytesLoaded + " total: " + e.bytesTotal);		}		protected function securityErrorHandler(e : SecurityErrorEvent) : void {            //trace("securityErrorHandler: " + e);		}		protected function httpStatusHandler(e : HTTPStatusEvent) : void {            //trace("httpStatusHandler: " + e);		}		protected function ioErrorHandler(e : IOErrorEvent) : void {            //trace("ioErrorHandler: " + e);		}				}}