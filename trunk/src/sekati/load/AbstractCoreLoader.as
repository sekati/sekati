/** * sekati.loaders.AbstractCoreLoader * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.load {	import sekati.log.Logger;	import flash.display.Loader;	import flash.events.ErrorEvent;	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.events.IOErrorEvent;	import flash.events.ProgressEvent;	import flash.events.SecurityErrorEvent;	import flash.media.Sound;	import flash.net.URLLoader;			/**	 * AbstractCoreLoader	 */	public class AbstractCoreLoader extends EventDispatcher {		protected var _loader : *;		protected var _loaderType : Class;		private var _listenerPrefix : String;		private var _contentSuffix : String;		private var _bytesTotal : uint;		private var _bytesLoaded : uint;		/**		 * AbstractCoreLoader Constructor		 */		public function AbstractCoreLoader(loaderType : Class) {			super( );			_loaderType = loaderType;			switch (_loaderType) { 				case Loader: 					_listenerPrefix = "contentLoaderInfo";					_contentSuffix = 'content';					break; 			  				case URLLoader:					_listenerPrefix = null;					_contentSuffix = 'data';					break;				case Sound:					_listenerPrefix = null;					_contentSuffix = null; 					break;					 				default: 					trace( "Defaulting: neither value0 or value1 evaluated." );			}			_listenerPrefix = (_loaderType == Loader) ? 'contentLoaderInfo' : null;			_contentSuffix = (_loaderType == Loader) ? 'content' : 'data';		}		/**		 * Configure the adding and removing of loader listeners.		 * @param isAdd 	<code>true</code> add's the listeners, <code>false</code> removes them.		 */		protected function configListeners(isAdd : Boolean = true) : void {			var setListener : String = (isAdd) ? "addEventListener" : "removeEventListener";			_loader.contentLoaderInfo[setListener]( Event.OPEN, startHandler );			_loader.contentLoaderInfo[setListener]( ProgressEvent.PROGRESS, progressHandler );			_loader.contentLoaderInfo[setListener]( Event.INIT, initHandler );			_loader.contentLoaderInfo[setListener]( IOErrorEvent.IO_ERROR, ioErrorHandler );			_loader.contentLoaderInfo[setListener]( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );		}		/**		 * <code>Event.OPEN</code> handler.		 */		protected function startHandler(e : Event) : void {		}		/**		 * <code>ProgressEvent.PROGRESS</code> handler.		 */		protected function progressHandler(e : ProgressEvent) : void {			_bytesTotal = e.bytesTotal;			_bytesLoaded = e.bytesLoaded;			//dispatchEvent(LoaderEvent.PROGRESS);					}		/**		 * <code>Event.INIT</code> handler.		 */		protected function initHandler(e : Event) : void {		}		/**		 * <code>IOErrorEvent.IO_ERROR</code> handler.		 */		protected function ioErrorHandler(e : IOErrorEvent) : void {			genericErrorHandler( e );		}		/**		 * <code>SecurityErrorEvent.SECURITY_ERROR</code> handler.		 */		protected function securityErrorHandler(e : SecurityErrorEvent) : void {			genericErrorHandler( e );		}		/**		 * Generic processor for <code>ErrorEvent</code>'s.		 */				protected function genericErrorHandler(e : ErrorEvent) : void {			Logger.$.error( this, "Unable to load Image: " + e.text );		}		/**		 * Dispatch ImageEvent.PROGRESS		protected function progressHandler(e : ProgressEvent) : void {			_bytesLoaded = e.bytesLoaded;			_bytesTotal = e.bytesTotal;			dispatchEvent( new Event( ProgressEvent.PROGRESS, true ) );		}		 */				/**		 * Dispatch ImageEvent.INIT		protected function initHandler(e : Event) : void {			_isLoaded = true;			_isRunning = false;			_bmp = e.target.content as Bitmap;			_bmp.smoothing = true;			addChild( _bmp );			configListeners( false );			dispatchEvent( new Event( Event.INIT, true ) );		}				 */	}}