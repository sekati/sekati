/** * sekati.core.Bootstrap * @version 1.0.0 * @author jason m horwitz | sekati.com | tendercreative.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.core {	import sekati.core.App;	import sekati.events.AppEvent;	/*	import sekati.convert.BoolConversion;	import sekati.log.Logger;	import sekati.net.NetBase;	import sekati.validate.StringValidation;	 */	import flash.net.URLLoader; 	import flash.net.URLRequest;		import flash.events.*;	import flash.text.StyleSheet;	/**	 * Bootstrap provides a common bootstrapping command & load	 * sequencer for all applications implementing the API. 	 * Bootstrap is one of the three main components comprising	 * the core API; along side <code>sekati.display.Document</code>	 * (which implements <code>Bootstrap</code>) and <code>sekati.core.App</code>	 * (which stores the data <code>Bootstrap</code> loads).	 * 	 * <p>The <code>_sequenceChain</code> defines a set of method 	 * references which are executed in sequence to prepare the 	 * API framework core.</p>	 * 	 * <p>By default core configuration & data XML's, CSS stylesheets 	 * & other customizable settings are loaded in to 	 * <code>sekati.core.App</code>. for storage & retrieval.</p>	 * 	 * <p>Each step in the default <code>Bootstrap</code> fires	 * a <i>"staging"</i> <code>AppEvent</code> to notify the application	 * of its <i>"boot phase"</i>. If any boot phase in the 	 * <code>_sequenceChain</code> fails its execution will be retried until	 * the <code>RETRY_MAX</code> limit has been exceeded at which point a 	 * verbose <code>BootstrapException</code> will be thrown.</p>	 * 	 * <p><b>Customizations</b> may be made by extending and 	 * overriding the <code>Bootstrap</code> methods and 	 * <code>_sequenceChain</code>.</p>	 */	public class Bootstrap extends EventDispatcher {				/**		 * The <code>_sequenceChain</code> contains a list of methods to run during the bootstrap process.		 */		protected static var _sequenceChain : Array = [ 'loadConfig', 'loadData', 'loadStyle' ];				/**		 * The <code>_sequenceCount</code> bootstrap stage counter.		 */				protected static var _sequenceCount : uint = 0;				/**		 * The <code>RETRY_ATTEMPT</code> tracks bootstrap rety attempts.		 */					protected static var RETRY_ATTEMPT : uint = 0;				/**		 * code>RETRY_MAX</code>  maximum retries before Bootstrap errors out.		 */		protected static var RETRY_MAX : uint;			protected var _this : Bootstrap;		/**		 * Bootstrap Constructor		 * @param maxRetryAttempts 	Number of times to retry each method in bootstrap before fatal error.		 */		public function Bootstrap(maxRetryAttempts : uint = 5) {			super( );			RETRY_MAX = maxRetryAttempts;			_this = this;			trace( "*** - Bootstrap Initialized ...\n" );			//Urchin.track( "home" );			run( );		}		/**		 * Iterate through <code>_sequenceChain</code> method array then fire the <code>"onAppConfigured"</code> events.		 * @see sekati.events.AppEvent		 */		protected function run() : void {			if (_sequenceCount < _sequenceChain.length) {				var methodName : String = _sequenceChain[_sequenceCount];				trace( _sequenceCount + " of " + _sequenceChain.length );				trace( "running method [" + _sequenceCount + "]" + methodName );				//Logger.$.trace( _this, "running method [" + _sequenceCount + "]" + methodName );				_sequenceCount++;				_this[methodName]( );			} else {				dispatchEvent( new AppEvent( AppEvent.APP_INIT ) );				//Logger.$.status( _this, "@@@ Application Configured: auto-initialization via broadcast event ..." );				trace( "@@@ Application Configured: auto-initialization via dispatched event ... " + AppEvent.APP_INIT );			}		}		/**		 * A method in the sequence chain failed - make retry attempts 		 * at each phase or die with fatal exception.		 * @throws FatalOperationException		 */		protected function retry() : void {			if (RETRY_ATTEMPT < RETRY_MAX) {				trace( "Bootstrap attempt failed in sequence chain " + _sequenceCount + ": " + _sequenceChain[_sequenceCount] + "()\n Retry Attempt: [" + RETRY_ATTEMPT + " of " + RETRY_MAX + "]" );				//Logger.$.warn( _this, "Bootstrap attempt failed in sequence chain " + _sequenceCount + ": " + _sequenceChain[_sequenceCount] + "()\n Retry Attempt: [" + RETRY_ATTEMPT + " of " + RETRY_MAX + "]" );				RETRY_ATTEMPT++;				_this[_sequenceChain[_sequenceCount]]( );			} else {				var msg : String = "Bootstrap died in sequence chain " + _sequenceCount + ": " + _sequenceChain[_sequenceCount] + "()\nRetry Attempt: [" + RETRY_ATTEMPT + " of " + RETRY_MAX + "]\n Sorry, I tried but the application failed to boot.";				trace( msg );				//Logger.$.fatal( _this, msg );				//throw new FatalOperationException( _this, msg, arguments );			}		}			// SEQUENCED BOOTSTRAP METHODS		/**		 * loads and parses config.xml then broadcasts "onConfig"		 */		protected function loadConfig() : void {			var request : URLRequest = new URLRequest( App.CONF_URI );			var loader : URLLoader = new URLLoader( );			var onLoadXML : Function = function(ev : Event):void {				try {					var cXML : XML = new XML( ev.target.data );					App.db.config = cXML;										dispatchEvent( new AppEvent( AppEvent.APP_CONFIG ) );					//Logger.$.status( _this, "$$$ - Data loaded (App.db) ..." );					run( );									} catch (er : TypeError) {					// Could not convert the data, probably because is not formatted properly					trace( "Could not parse the XML" );					trace( er.message );				}							};			var onErrorXML : Function = function(e : Event):void {				retry( );			};			loader.addEventListener( Event.COMPLETE, onLoadXML );			loader.addEventListener( IOErrorEvent.IO_ERROR, onErrorXML );			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorXML );			loader.load( request );						/*			App.db.config = o.config;			// dump core config values into static App constants			App.APP_NAME = o.config.attributes.name + " v" + o.config.attributes.version;							App.CROSSDOMAIN_URI = (o.config.crossdomain_uri.data != undefined) ? o.config.crossdomain_uri.data : "crossdomain.xml";			App.CROSSDOMAIN_URI = (StringValidation.isURL( App.CROSSDOMAIN_URI )) ? App.CROSSDOMAIN_URI : NetBase.getPath( ) + App.CROSSDOMAIN_URI;			App.DATA_URI = o.config.data_uri.data;			App.CSS_URI = o.config.css_uri.data;							App.DEBUG_ENABLE = BoolConversion.toBoolean( o.config.debug_enable.data );			App.FLINK_ENABLE = BoolConversion.toBoolean( o.config.flink_enable.data );			App.TRACK_ENABLE = BoolConversion.toBoolean( o.config.track_enable.data );			App.KEY_ENABLE = BoolConversion.toBoolean( o.config.key_enable.data );			App.FLV_BUFFER_TIME = Number( o.config.flv_buffer_time.data );			if (App.DEBUG_ENABLE == true) {			App.log = Logger.getInstance( );			Logger.$.isIDE = true, 			Logger.$.isLC = true, 			Logger.$.isSWF = false;								Logger.$.info( _this, "@@@ Debug enabled ..." );			}							// enable context menu 			Logger.$.info( _this, "@@@ Setting ContextMenu ..." );			//App.cmenu.addItem( App.APP_NAME );						// load crossdomain policy 			Logger.$.info( _this, "@@@ loading crossdomain policy: " + App.CROSSDOMAIN_URI );			//System.security.loadPolicyFile( App.CROSSDOMAIN_URI );			delete oXML;			delete o;			Logger.$.status( _this, "$$$ - Config loaded ..." );			//Broadcaster.$.broadcast( "onLoadAppConfig" );			run( );			};			oXML.onLoad = parseConfiguration;			oXML.load( App.CONF_URI );			 */		}		/**		 * load App data from {@code DATA_URI} during {@link bootstrap} sequence.		 */		protected function loadData() : void {			var request : URLRequest = new URLRequest( App.db.config.data_uri );			var loader : URLLoader = new URLLoader( );			var onLoadXML : Function = function(ev : Event):void {				try {					var dXML : XML = new XML( ev.target.data );					App.db.data = dXML;					dispatchEvent( new AppEvent( AppEvent.APP_DATA ) );					//trace( App.db.data );					//trace(App.db.data.person.(@name == "Jason M Horwitz").age);					//Logger.$.status( _this, "$$$ - Data loaded (App.db) ..." );					run( );									} catch (er : TypeError) {					// Could not convert the data, probably because is not formatted properly					trace( "Could not parse the XML" );					trace( er.message );				}							};			var onErrorXML : Function = function(e : Event):void {				retry( );			};			loader.addEventListener( Event.COMPLETE, onLoadXML );			loader.addEventListener( IOErrorEvent.IO_ERROR, onErrorXML );			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorXML );			loader.load( request );		}			/**		 * load App stylesheet css from {@code CSS_URI} during {@link bootstrap} sequence.		 * <p>Usage:<code><br>		 * 	tf.styleSheet = App.css;<br>		 * 	tf.htmlText = "<span class='righthead_credit'>Hello World</span>";		 * </code></p>		 */		protected function loadStyle() : void {			var request : URLRequest = new URLRequest( App.db.config.css_uri );			var loader : URLLoader = new URLLoader( );			var onLoadCSS : Function = function(ev : Event):void {				var sheet : StyleSheet = new StyleSheet( );  				sheet.parseCSS( loader.data );				App.css = sheet;				dispatchEvent( new AppEvent( AppEvent.APP_STYLE ) );				//Logger.$.status( _this, "$$$ - Styles loaded (App.CSS) ..." );				run( );			};			var onErrorCSS : Function = function (e : Event):void {				retry( );			};			loader.addEventListener( Event.COMPLETE, onLoadCSS );			loader.addEventListener( IOErrorEvent.IO_ERROR, onErrorCSS );			loader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onErrorCSS );			loader.load( request );							}	}}