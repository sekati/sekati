/** * sekati.core.Bootstrap * @version 1.1.0 * @author jason m horwitz | sekati.com | tendercreative.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.core {	import flash.events.*;	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.system.Security;	import flash.text.StyleSheet;		import sekati.converters.BoolConverter;	import sekati.core.App;	import sekati.events.BootstrapEvent;	import sekati.external.Urchin;	import sekati.log.Logger;	import sekati.managers.ContextMenuManager;	import sekati.utils.StringUtil;	import sekati.validators.StringValidator;		/**	 * Bootstrap provides a common bootstrapping command & load	 * sequencer used to initialize API based applications. 	 * 	 * <p>Bootstrap is one of the three core components comprising	 * the base API; along side <code>sekati.display.Document</code>	 * (which instatiates <code>Bootstrap</code>) and <code>sekati.core.App</code>	 * (which stores the data the <code>Bootstrap</code> loads).</p>	 * 	 * <p>By default <code>Bootstrap</code> loads core configuration & XML data, 	 * CSS stylesheets & other customizable settings in to 	 * <code>sekati.core.App</code>. for storage & retrieval.</p>	 * 	 * <p>Each step in the <code>Bootstrap</code> sequence fires	 * a <i>"staging"</i> <code>BootstrapEvent</code> to notify the application	 * of its <i>"boot phase"</i>. If any boot phase in the 	 * <code>_sequenceChain</code> fails its execution it will be retried 	 * until the <code>RETRY_MAX</code> limit has been exceeded at which 	 * point a the <code>BootstrapEvent.APP_FAIL</code> event will be dispatched	 * to notify the application of boot failure.</p>	 * 	 * <p><b>Customizations</b> may be made by extending and 	 * overriding the <code>Bootstrap</code> methods and 	 * <code>_sequenceChain</code>.</p>	 * 	 * @see sekati.core.App	 * @see sekati.display.Document	 * @see sekati.events.BootstrapEvent	 */	public class Bootstrap extends EventDispatcher {		/**		 * The <code>_sequenceChain</code> defines a set of method references which are executed in sequence to prepare the API framework core.		 */		protected static var _sequenceChain : Array = [ 'loadConfig', 'loadData', 'loadStyle' ];				/**		 * The <code>_sequenceCount</code> bootstrap stage counter.		 */				protected static var _sequenceCount : uint = 0;				/**		 * The <code>RETRY_ATTEMPT</code> tracks bootstrap rety attempts.		 */					protected static var RETRY_ATTEMPT : uint = 0;				/**		 * code>RETRY_MAX</code>  maximum retries before Bootstrap errors out.		 */		protected static var RETRY_MAX : uint;					/**		 * @private		 */		protected var _this : Bootstrap;		/**		 * Bootstrap Constructor		 * @param maxRetryAttempts 	Number of times to retry each method in bootstrap before fatal error.		 */		public function Bootstrap(maxRetryAttempts : uint = 5) {			super( );			RETRY_MAX = maxRetryAttempts;			_this = this;			Logger.$.status( _this, "	@@@ - Bootstrap Initialized ..." );			Urchin.track( "home" );			run( );		}		/**		 * Iterate through the <code>_sequenceChain</code> method & fire the <code>BootstrapEvent.APP_INIT</code> event on completion.		 * @see sekati.events.BootstrapEvent		 */		protected function run() : void {			if (_sequenceCount < _sequenceChain.length - 1) {				var methodName : String = _sequenceChain[_sequenceCount];				Logger.$.info( _this, "	--- Sequence => (" + (_sequenceCount + 1) + "/" + _sequenceChain.length + "): '" + methodName + "()'" );				_this[methodName]( );				_sequenceCount++;			} else {				dispatchEvent( new BootstrapEvent( BootstrapEvent.APP_INIT ) );				Logger.$.status( _this, "	@@@ Sequence => (" + (_sequenceCount + 1) + "/" + _sequenceChain.length + "): Bootstrap Success => '" + BootstrapEvent.APP_INIT + "'" );			}		}		/**		 * A method in the sequence chain failed - make retry attempts at each phase or dispatch the <code>BootstrapEvent.APP_FAILURE</code> event.		 */		protected function retry() : void {			if (RETRY_ATTEMPT < RETRY_MAX) {				var _adjustedSequenceCount : uint = _sequenceCount - 1;				Logger.$.warn( _this, "??? - Sequence Attempt [" + (RETRY_ATTEMPT + 1) + "/" + RETRY_MAX + "] Failure => stage (" + _sequenceCount + "/" + _sequenceChain.length + "): '" + _sequenceChain[_adjustedSequenceCount] + "'" );				RETRY_ATTEMPT++;				_this[_sequenceChain[_adjustedSequenceCount]]( );			} else {				dispatchEvent( new BootstrapEvent( BootstrapEvent.APP_FAIL ) );				Logger.$.fatal( _this, "!!! - BOOTSTRAP DEATH [Maximum Retries Exceeded: " + RETRY_ATTEMPT + "/" + RETRY_MAX + "] => stage (" + _sequenceCount + "/" + _sequenceChain .length + "): '" + _sequenceChain[_sequenceCount] + "' => Sorry, I tried but the application failed to boot." );				throw new Error( "Bootstrap Death" );			}		}			// SEQUENCED BOOTSTRAP METHODS		/**		 * Loads & parse <code>config.xml</code> to <code>App.config</code>		 * & dispatch <code>BootstrapEvent.APP_CONFIG</code>.		 */		protected function loadConfig() : void {			var request : URLRequest = new URLRequest( App.CONF_URI );			var loader : URLLoader = new URLLoader( );			// remove listeners			var clean : Function = function():void {				loader.removeEventListener( Event.COMPLETE, onLoadXML );				loader.removeEventListener( IOErrorEvent.IO_ERROR, onErrorXML );				loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorXML );							};			var onLoadXML : Function = function(ev : Event):void {				clean( );				try {					var cXML : XML = new XML( ev.target['data'] );					// parse and deserialize core configuration:					App.APP_NAME = cXML['app'].name;					App.APP_VERSION = cXML['app'].version;					App.CROSSDOMAIN_URI = (!StringValidator.isBlank( cXML['uri'].crossdomain )) ? cXML['uri'].crossdomain : App.CROSSDOMAIN_URI;					App.DATA_URI = cXML['uri'].data;					App.CSS_URI = cXML['uri'].css;					App.MANAGED_MENU = BoolConverter.toBoolean( cXML['option'].managed_menu );					App.API_CREDIT = BoolConverter.toBoolean( cXML['option'].api_credit );					App.FULLSCREEN_ENABLE = BoolConverter.toBoolean( cXML['option'].fullscreen );					App.TRACK_ENABLE = BoolConverter.toBoolean( cXML['option'].track );					App.KEY_ENABLE = BoolConverter.toBoolean( cXML['option'].key );					App.DEEPLINK_ENABLE = BoolConverter.toBoolean( cXML['option'].deeplink );					App.LOG_ENABLE = BoolConverter.toBoolean( cXML['option'].log );					App.MEMORY_ALARM = int( cXML['option'].memory_alarm );					// parse & load the crossdomain uri:					var xDom : String = (!StringUtil.beginsWith( App.CROSSDOMAIN_URI, '/' ) || !StringUtil.beginsWith( App.CROSSDOMAIN_URI, 'http' )) ? (App.PATH + App.CROSSDOMAIN_URI) : App.CROSSDOMAIN_URI; 					Logger.$.info( _this, "	... - Loading Crossdomain Policy ... " );					Security.loadPolicyFile( xDom );					// initialize context menu management:					if(App.MANAGED_MENU) {						ContextMenuManager.getInstance( );										}					// configure logger:					if (!App.LOG_ENABLE) {						App.log = Logger.getInstance( );						Logger.$.warn( _this, "!!! - Logger disabled via config.xml: Goodbye World!" );						Logger.$.enabled = App.LOG_ENABLE;					}					// dispatch the APP_CONFIG event & continue bootstrap ...					dispatchEvent( new BootstrapEvent( BootstrapEvent.APP_CONFIG ) );					run( );									} catch (er : TypeError) {					Logger.$.error( _this, "!!! - loadConfig: XML parser failed (probably malformed) => " + er.message );				}							};			var onErrorXML : Function = function(e : Event):void {				clean( );				retry( );			};			loader.addEventListener( Event.COMPLETE, onLoadXML, false, 0, true );			loader.addEventListener( IOErrorEvent.IO_ERROR, onErrorXML, false, 0, true );			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorXML, false, 0, true );			loader.load( request );		}		/**		 * Loads & parse data from <code>App.DATA_URI</code> provided in <code>config.xml</code>.		 * Store it in <code>App.data</code> & dispatch <code>BootstrapEvent.APP_DATA</code>.		 */		protected function loadData() : void {			var request : URLRequest = new URLRequest( App.DATA_URI );			var loader : URLLoader = new URLLoader( );			// remove listeners			var clean : Function = function():void {				loader.removeEventListener( Event.COMPLETE, onLoadXML );				loader.removeEventListener( IOErrorEvent.IO_ERROR, onErrorXML );				loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorXML );							};						var onLoadXML : Function = function(ev : Event):void {				clean( );				try {					var dXML : XML = new XML( ev.target['data'] );					// persist the xml data object										App.db['data'] = dXML;					dispatchEvent( new BootstrapEvent( BootstrapEvent.APP_DATA ) );					//trace(App.db.data.person.(@name == "Jason M Horwitz").age);					run( );									} catch (er : TypeError) {					Logger.$.error( _this, "!!! - loadData: XML parser failed (probably malformed) => " + er.message );				}							};			var onErrorXML : Function = function(e : Event):void {				clean( );				retry( );			};			loader.addEventListener( Event.COMPLETE, onLoadXML, false, 0, true );			loader.addEventListener( IOErrorEvent.IO_ERROR, onErrorXML, false, 0, true );			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorXML, false, 0, true );			loader.load( request );		}			/**		 * Loads & parse the stylesheet from <code>App.CSS_URI</code> provided in <code>config.xml</code>.		 * Store it in <code>App.css</code> & dispatch <code>BootstrapEvent.APP_STYLE</code>.		 * @example <listing version="3.0">		 * tf.styleSheet = App.css;		 * tf.htmlText = "<span class='test''>Hello World</span>";		 * </listing>		 */		protected function loadStyle() : void {			var request : URLRequest = new URLRequest( App.CSS_URI );			var loader : URLLoader = new URLLoader( );			// remove listeners			var clean : Function = function():void {				loader.removeEventListener( Event.COMPLETE, onLoadCSS );				loader.removeEventListener( IOErrorEvent.IO_ERROR, onErrorCSS );				loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorCSS );							};						var onLoadCSS : Function = function(ev : Event):void {				clean( );				var sheet : StyleSheet = new StyleSheet( );  				sheet.parseCSS( loader.data );				App.css = sheet;				dispatchEvent( new BootstrapEvent( BootstrapEvent.APP_STYLE ) );				run( );			};			var onErrorCSS : Function = function (e : Event):void {				clean( );				retry( );			};			loader.addEventListener( Event.COMPLETE, onLoadCSS, false, 0, true );			loader.addEventListener( IOErrorEvent.IO_ERROR, onErrorCSS, false, 0, true );			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorCSS, false, 0, true );			loader.load( request );							}	}}