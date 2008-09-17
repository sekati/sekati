/** * sekati.load.DisplayObjectLoader * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.load {	import flash.display.Bitmap;	import flash.display.Loader;	import flash.display.LoaderInfo;	import flash.events.Event;	import flash.events.HTTPStatusEvent;	import flash.events.IOErrorEvent;	import flash.events.ProgressEvent;	import flash.net.URLRequest;	import flash.system.LoaderContext;	import sekati.load.AbstractLoader;			/**	 * DisplayObjectLoader	 */	public class DisplayObjectLoader extends AbstractLoader {		protected var loader : Loader;		protected var loaderContext : LoaderContext;		/**		 * DisplayObjectLoader Constructor		 */		public function DisplayObjectLoader(url : String = null) {			super( new URLRequest( url ) );			loader = new Loader( );		}		/**		 * @inheritDoc		 */		override public function load(urlRequest : URLRequest = null) : void {			request = urlRequest;			loader.contentLoaderInfo.addEventListener( HTTPStatusEvent.HTTP_STATUS, delegate );			loader.contentLoaderInfo.addEventListener( Event.INIT, loadStop );			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, delegate );			loader.contentLoaderInfo.addEventListener( Event.OPEN, delegate );			loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, delegate );			loader.contentLoaderInfo.addEventListener( Event.UNLOAD, delegate );			super.loadStart( );			loader.load( this.request, loaderContext );				}		/**		 * unload the loaded data.		 */		public function unload() : void {			loader.contentLoaderInfo.removeEventListener( HTTPStatusEvent.HTTP_STATUS, delegate );			loader.contentLoaderInfo.removeEventListener( Event.INIT, loadStop );			loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, delegate );			loader.contentLoaderInfo.removeEventListener( Event.OPEN, delegate );			loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, delegate );			loader.contentLoaderInfo.removeEventListener( Event.UNLOAD, delegate );						try {				var li : LoaderInfo = loader.contentLoaderInfo;				if( li.childAllowsParent && li.content is Bitmap ) {					(li.content as Bitmap).bitmapData.dispose( );				}			} catch (e : Error) {				trace( "DisplayObjectLoader.unload() Error: " + e.message );			}		}		/**		 * @inheritDoc		 */		override public function close() : void {			try {				loader.close( );			} catch (e : Error) {				trace( "DisplayObjectLoader.close() Error: " + e.message );			}			loader.unload( );			loadStop( );		}		/**		 * 		 */		public function getResult() : Loader {			return loader;			}		/**		 * 		 */		public function set context(lc : LoaderContext) : void {			loaderContext = lc;		}		/**		 * 		 */		protected function delegate( e : Event ) : void {      			dispatchEvent( e );		}				/**		 * @inheritDoc		 */		override protected function loadStop(e : Event = null) : void {			super.loadStop( );			dispatchEvent( new Event( Event.COMPLETE ) );			}		}}