﻿﻿/** * sekati.core.Bootstrap * @version 1.5.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.core {	import sekati.converters.BoolConverter;	import sekati.core.Configuration;	import sekati.display.Canvas;	import sekati.events.BootstrapEvent;	import sekati.external.Urchin;	import sekati.log.LogTarget;	import sekati.log.Logger;	import sekati.managers.BrowserManager;	import sekati.managers.ContextMenuManager;	import sekati.managers.FontManager;	import sekati.profiler.PerformanceMonitor;	import sekati.utils.StringUtil;	import sekati.utils.XMLUtil;	import sekati.validators.StringValidator;		import flash.display.Loader;	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.events.IOErrorEvent;	import flash.events.SecurityErrorEvent;	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.system.LoaderContext;	import flash.system.Security;	import flash.text.StyleSheet;			/**	 * Bootstrap provides a common bootstrapping command & load sequencer used to initialize API based applications. 	 * 	 * <p>Bootstrap is one of the three core components comprising the base API; along side <code>sekati.display.Application</code>	 * (which instatiates <code>Bootstrap</code>) and <code>sekati.core.Configuration</code> (which stores the data that 	 * <code>Bootstrap</code> loads).</p>	 * 	 * <p>By default <code>Bootstrap</code> loads a core configuration XML file, a data XML file, a CSS stylesheet	 * & a Crossdomain Policy File; storing configuration settings and data in <code>sekati.core.Configuration</code>. for later 	 * storage & retrieval. The XML data, CSS stylesheet & crossdomain policy locations, as well as other API settings, are 	 * defined in the core configuration XML file.</p>	 * 	 * <p>Each step in the <code>Bootstrap</code> sequence fires a <i>"staging"</i> <code>BootstrapEvent</code> to notify 	 * the application of its <i>"boot phase"</i>. If any boot phase in the <code>sequenceChain</code> fails its execution 	 * it will be retried until the <code>RETRY_MAX</code> limit has been exceeded at which point a the 	 * <code>BootstrapEvent.APP_FAIL</code> event will be dispatched to notify the application of boot failure.</p>	 * 	 * <p><b>Customizations</b> may be made by extending and  overriding the <code>Bootstrap</code> methods and 	 * <code>sequenceChain</code>.</p>	 * 	 * @see sekati.display.Application	 * @see sekati.events.BootstrapEvent	 * @see sekati.core.Configuration	 */	public class Bootstrap extends EventDispatcher {		/**		 * The <code>sequenceChain</code> defines a set of method references which are executed in sequence to prepare the API framework core.		 */		protected static var sequenceChain : Array = [ 'loadConfig', 'loadData', 'loadStyleSheet', 'loadFontLibrary' ];		/**		 * The <code>sequenceCount</code> bootstrap stage counter.		 */				protected static var sequenceCount : int = 0;		/**		 * The <code>RETRY_ATTEMPT</code> tracks bootstrap rety attempts.		 */					protected static var RETRY_ATTEMPT : int = 0;		/**		 * <code>RETRY_MAX</code> maximum retries before Bootstrap errors out.		 */		protected static var RETRY_MAX : int;			/*** @private */		protected var _this : Bootstrap;		/**		 * Bootstrap Constructor		 * @param maxRetryAttempts 	Number of times to retry each method in bootstrap before fatal error.		 */		public function Bootstrap(maxRetryAttempts : int = 5) {			super( );			RETRY_MAX = maxRetryAttempts;			_this = this;			Logger.$.status( _this, "	@@@ - Bootstrap Initialized ..." );			run( );		}		/**		 * Iterate through the <code>sequenceChain</code> method & fire the <code>BootstrapEvent.APP_INIT</code> event on completion.		 * @see sekati.events.BootstrapEvent		 */		protected function run() : void {			if (sequenceCount < sequenceChain.length) {				var methodName : String = sequenceChain[sequenceCount];				Logger.$.info( _this, "	--- Sequence => (" + (sequenceCount + 1) + "/" + sequenceChain.length + "): '" + methodName + "()'" );				sequenceCount++;				_this[methodName]( );			} else {				dispatchEvent( new BootstrapEvent( BootstrapEvent.APP_INIT ) );				Logger.$.status( _this, "	@@@ Sequence => (" + sequenceCount + "/" + sequenceChain.length + "): Bootstrap Success => '" + BootstrapEvent.APP_INIT + "'" );			}		}		/**		 * A method in the sequence chain failed - make retry attempts at each phase or dispatch the <code>BootstrapEvent.APP_FAILURE</code> event.		 * @throws Error if <code>RETRY_MAX</code> is reached.		 */		protected function retry() : void {			if (RETRY_ATTEMPT < RETRY_MAX) {				var _adjustedSequenceCount : uint = sequenceCount - 1;				Logger.$.warn( _this, "??? - Sequence Attempt [" + (RETRY_ATTEMPT + 1) + "/" + RETRY_MAX + "] Failure => stage (" + sequenceCount + "/" + sequenceChain.length + "): '" + sequenceChain[_adjustedSequenceCount] + "'" );				RETRY_ATTEMPT++;				_this[sequenceChain[_adjustedSequenceCount]]( );			} else {				dispatchEvent( new BootstrapEvent( BootstrapEvent.APP_FAIL ) );				Logger.$.fatal( _this, "!!! - BOOTSTRAP DEATH [Maximum Retries Exceeded: " + RETRY_ATTEMPT + "/" + RETRY_MAX + "] => stage (" + sequenceCount + "/" + sequenceChain .length + "): '" + sequenceChain[sequenceCount - 1] + "' => Sorry, I tried but the application failed to boot." );				throw new Error( "Bootstrap Death." );			}		}			// SEQUENCED BOOTSTRAP METHODS		/**		 * Loads & parse <code>config.xml</code> to <code>Configuration.config</code>		 * & dispatch <code>BootstrapEvent.APP_CONFIG</code>.		 */		protected function loadConfig() : void {			Logger.$.info( _this, "	... - Loading Configuration (" + Configuration.CONF_URI + ") ... " );			var request : URLRequest = new URLRequest( Configuration.CONF_URI );			var loader : URLLoader = new URLLoader( );			// remove listeners			var clean : Function = function() : void {				loader.removeEventListener( Event.COMPLETE, onLoadXML );				loader.removeEventListener( IOErrorEvent.IO_ERROR, onErrorXML );				loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorXML );							};			XML.ignoreWhitespace = XML.ignoreComments = true;			var onLoadXML : Function = function(ev : Event) : void {				clean( );				try {					var cXML : XML = new XML( ev.target['data'] );					// parse and deserialize core configuration:					Configuration.APP_NAME = cXML['app'].name;					Configuration.APP_VERSION = cXML['app'].version;					Configuration.CROSSDOMAIN_URI = (!StringValidator.isBlank( cXML['load'].crossdomain )) ? cXML['load'].crossdomain : '/crossdomain.xml';					Configuration.CROSSDOMAIN_BOOTLOAD = BoolConverter.toBoolean( cXML['load'].crossdomain.@load );					Configuration.DATA_URI = cXML['load'].data;					Configuration.DATA_BOOTLOAD = BoolConverter.toBoolean( cXML['load'].data.@load );					Configuration.CSS_URI = cXML['load'].stylesheet;					Configuration.CSS_BOOTLOAD = BoolConverter.toBoolean( cXML['load'].stylesheet.@load );					Configuration.FONT_BOOTLOAD = BoolConverter.toBoolean( cXML['load'].fonts.@load );					Configuration.FONT_URI = XMLUtil.byAttribute( cXML['load'].fonts.*, 'lang', cXML['load'].fonts.@default ).toString( );					Configuration.MANAGED_MENU = BoolConverter.toBoolean( cXML['option'].context_menu_management.@enable );					Configuration.API_INFO = BoolConverter.toBoolean( cXML['option'].context_menu_management.@with_api_version );					Configuration.FULLSCREEN_ENABLE = BoolConverter.toBoolean( cXML['option'].fullscreen_support.@enable );					Configuration.TRACK_ENABLE = BoolConverter.toBoolean( cXML['option'].google_analytics.@enable );					Configuration.DEEPLINK_ENABLE = BoolConverter.toBoolean( cXML['option'].browser_management.@enable );					Configuration.LOG_ENABLE = BoolConverter.toBoolean( cXML['option'].logger.@enable );					Configuration.PERFORMANCE_MONITOR_ENABLE = BoolConverter.toBoolean( cXML['option'].performance_monitor.@enable );					// persist the configuration as XML if the <custom> node contains content:					if(cXML['custom'].*.length( ) > 0) {						Logger.$.info( _this, "	... - Persisting Raw '" + Configuration.CONF_URI + "' in Configuration.db['config'] (set via '" + Configuration.CONF_URI + "') ... " );						Configuration.db['config'] = cXML;					}				} catch (er : TypeError) {					Logger.$.error( _this, "!!! - loadConfig: XML parser failed (probably malformed) => " + er.message + "\n" + er.getStackTrace( ) );				}				// attempt to intialize the API layer based on the configuration				try {					// parse & load the crossdomain uri:					if( Configuration.CROSSDOMAIN_BOOTLOAD ) {						var xDom : String = (!StringUtil.beginsWith( Configuration.CROSSDOMAIN_URI, '/' ) && !StringUtil.beginsWith( Configuration.CROSSDOMAIN_URI, 'http' )) ? (Configuration.PATH + Configuration.CROSSDOMAIN_URI) : Configuration.CROSSDOMAIN_URI;						Logger.$.info( _this, "	... - Loading Crossdomain Policy File (" + xDom + ") ... " );						Security.loadPolicyFile( xDom );					} else {						Logger.$.notice( _this, "	... - Skipping: 'Crossdomain Policy' (set via '" + Configuration.CONF_URI + "'): moving on ... " );					}										// initialize context menu management:					if( Configuration.MANAGED_MENU ) {							ContextMenuManager.getInstance( );										}										// initialize urchin tracking:					if( Configuration.TRACK_ENABLE ) {						Logger.$.info( _this, " - Urchin Tracker Initialized ..." );						Urchin.base = Configuration.APP_NAME;						Urchin.track( "home" );					}					// initialize browser manager for monitored deeplinking:					if( Configuration.DEEPLINK_ENABLE ) {						BrowserManager.getInstance( );						/*						Logger.$.info( _this, " - Deeplinking Initialized ..." );						if(!BrowserAddress.anchor) {							//BrowserAddress.title = ":: " + Configuration.APP_NAME + " :: Home";							BrowserAddress.anchor = "home/";						}						 */					}										// configure logger:					if ( !Configuration.LOG_ENABLE ) {						Logger.$.warn( _this, "!!! - Logger disabled via '" + Configuration.CONF_URI + "': Goodbye World!" );						Logger.$.enabled = Configuration.LOG_ENABLE;					} else {						var withFirebug : Boolean = BoolConverter.toBoolean( cXML['option'].logger.@with_firebug );						var withIDE : Boolean = BoolConverter.toBoolean( cXML['option'].logger.@with_ide );						var logTarget : int;						if(withFirebug && withIDE) {							logTarget = LogTarget.ALL;						} else if (withFirebug) {							logTarget = LogTarget.FIREBUG;						} else if (withIDE) {							logTarget = LogTarget.IDE;						} else {							logTarget = LogTarget.NONE;						}												//var level : String = (LogTarget.resolveTarget( cXML['option'].log.@target ) < LogTarget.ALL) ? "warn" : "status";						var level : String = ( logTarget < LogTarget.ALL) ? 'warn' : 'status';						Logger.$[level]( _this, " - Logger output target set via '" + Configuration.CONF_URI + "', withFirebug: " + cXML['option'].logger.@with_firebug + ", withIDE: " + cXML['option'].logger.@with_ide );											}					//Logger.$.outputMode = LogTarget.resolveTarget( cXML['option'].log.@target, true );					Logger.$.outputMode = logTarget;					//					// configure performance monitor:					if( Configuration.PERFORMANCE_MONITOR_ENABLE ) {						new PerformanceMonitor( Canvas.stage );					}					// dispatch the APP_CONFIG event & continue bootstrap ...					dispatchEvent( new BootstrapEvent( BootstrapEvent.APP_CONFIG ) );					run( );									} catch (e : Error) {					Logger.$.error( _this, "!!! - loadConfig: Config initialization failed (likely inaccessible external) => " + e.message );				}			};			var onErrorXML : Function = function(e : Event):void {				clean( );				retry( );			};			loader.addEventListener( Event.COMPLETE, onLoadXML );			loader.addEventListener( IOErrorEvent.IO_ERROR, onErrorXML );			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorXML );			loader.load( request );		}		/**		 * Loads & parse data from <code>Configuration.DATA_URI</code> provided in <code>config.xml</code>.		 * Store it in <code>Configuration.data</code> & dispatch <code>BootstrapEvent.APP_DATA</code>.		 */		protected function loadData() : void {			if( !Configuration.DATA_BOOTLOAD ) {				Logger.$.notice( _this, "	... - Skipping: 'loadData': disabled via '" + Configuration.CONF_URI + "': moving on ... " );				run( );				return;				}			var request : URLRequest = new URLRequest( Configuration.DATA_URI );			var loader : URLLoader = new URLLoader( );			// remove listeners			var clean : Function = function() : void {				loader.removeEventListener( Event.COMPLETE, onLoadXML );				loader.removeEventListener( IOErrorEvent.IO_ERROR, onErrorXML );				loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorXML );							};						var onLoadXML : Function = function(ev : Event) : void {				clean( );				try {					var dXML : XML = new XML( ev.target['data'] );					// persist the xml data object										Configuration.db['data'] = dXML;					dispatchEvent( new BootstrapEvent( BootstrapEvent.APP_DATA ) );					run( );									} catch (er : TypeError) {					Logger.$.error( _this, "!!! - loadData: XML parser failed (probably malformed) => " + er.message );				}							};			var onErrorXML : Function = function(e : Event) : void {				clean( );				retry( );			};			loader.addEventListener( Event.COMPLETE, onLoadXML );			loader.addEventListener( IOErrorEvent.IO_ERROR, onErrorXML );			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorXML );			loader.load( request );		}			/**		 * Loads & parse the stylesheet from <code>Configuration.CSS_URI</code> provided in <code>config.xml</code>.		 * Store it in <code>Configuration.css</code> & dispatch <code>BootstrapEvent.APP_STYLE</code>.		 * @example <listing version="3.0">		 * tf.styleSheet = Configuration.css;		 * tf.htmlText = "<span class='test''>Hello World</span>";		 * </listing>		 */		protected function loadStyleSheet() : void {			if( !Configuration.CSS_BOOTLOAD ) {				Logger.$.notice( _this, "	... - Skipping: 'loadStyleSheet': disabled via '" + Configuration.CONF_URI + "': moving on ... " );				run( );				return;				}			var request : URLRequest = new URLRequest( Configuration.CSS_URI );			var loader : URLLoader = new URLLoader( );			// remove listeners			var clean : Function = function() : void {				loader.removeEventListener( Event.COMPLETE, onLoadCSS );				loader.removeEventListener( IOErrorEvent.IO_ERROR, onErrorCSS );				loader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorCSS );							};						var onLoadCSS : Function = function(ev : Event) : void {				clean( );				var sheet : StyleSheet = new StyleSheet( );  				sheet.parseCSS( loader.data );				Configuration.css = sheet;				dispatchEvent( new BootstrapEvent( BootstrapEvent.APP_STYLE ) );				run( );			};			var onErrorCSS : Function = function (e : Event) : void {				clean( );				retry( );			};			loader.addEventListener( Event.COMPLETE, onLoadCSS );			loader.addEventListener( IOErrorEvent.IO_ERROR, onErrorCSS );			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorCSS );			loader.load( request );							}		/**		 * Load and store the font library from <code>Configuration.FONT_URI</code> provided in <code>config.xml</code>.		 * Store it in <code>Configuration.db.fonts</code> & dispatch <code>Bootstrap.APP_FONT</code>.		 */		protected function loadFontLibrary() : void {			if( !Configuration.FONT_BOOTLOAD ) {				Logger.$.notice( _this, "	... - Skipping: 'loadFontLibrary': disabled via '" + Configuration.CONF_URI + "': moving on ... " );				run( );				return;				}			//return;				var request : URLRequest = new URLRequest( Configuration.FONT_URI );			var loader : Loader = new Loader( );					var context : LoaderContext = new LoaderContext( );			context.checkPolicyFile = true;			// remove listeners			var clean : Function = function() : void {				loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLoadFont );				loader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onErrorFont );				loader.contentLoaderInfo.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorFont );							};						var onLoadFont : Function = function(ev : Event) : void {				clean( );				Configuration.font = loader.content;				dispatchEvent( new BootstrapEvent( BootstrapEvent.APP_FONT ) );				FontManager.getInstance( );				run( );			};			var onErrorFont : Function = function (e : Event) : void {				clean( );				retry( );			};						loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadFont );			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onErrorFont );			loader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorFont );						loader.load( request, context );						}	}}