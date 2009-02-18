/** * sekati.display.DocumentPreloader * @version 1.0.2 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.display {	import flash.display.StageQuality;		import flash.system.fscommand;		import flash.system.Security;		import flash.display.Loader;	import flash.display.Sprite;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	import flash.events.ProgressEvent;	import flash.net.URLLoader;	import flash.net.URLRequest;			/**	 * The <code>DocumentPreloader</code> class is an <b>API independent shell</b> designed to load <i>Sekati API</i> <code>Document</code> driven SWF applications	 * In other words; <code>DocumentPreloader</code> should be extended and used as the <b>Main Document Class</b> for a <i>preloader SWF</i>.	 * 	 * <p>The three main methods that can be overridden are:<br>	 * <ol><li><code>addedToStage(e:Event)</code> - to init the visual preloader</li>	 * <li><code>animateProgress(perc:Number)</code> -  to show load progress on a scale of 0.0 to 1.0</li>	 * <li><code>animateComplete()</code> - to execute a visual 'out' for the preloader. Otherwise <code>initLoadedSwf()</code> will be called automatically.</li></ol>	 * 	 * <b>Note:</b> that the API bootstrap sequence will begin when the loaded API swf is added to the stage in <code>initLoadedSwf()</code>.	 * @see sekati.display.Document	 */	 	public class DocumentPreloader extends Sprite {		/**		 * The disposable <code>XML URLLoader</code> to manage the <code>config.xml</code>.		 */		protected var _xmlLoader : URLLoader;				/**		 * The <code>Loader</code> containing the <code>Document</code> drive API Application SWF.		 */		protected var _loader : Loader;		/**		 * The percentage of the Application SWF that has loaded.		 */		protected var _percent : Number;		/**		 * DocumentPreloader Constructor		 */		public function DocumentPreloader() {			addEventListener( Event.ADDED_TO_STAGE, onStage );			stage.addEventListener( Event.RESIZE, resizeHandler );		}		/**		 * Initialize once the stage is available available.		 */		protected function onStage(e : Event = null) : void {			removeEventListener( Event.ADDED_TO_STAGE, onStage );			initMovieProperties( );			configUI( );			loadConfig( );		}				/**		 * Initializes the preloader movie properties.		 * 		 * <p><b>Customization:</b> Override this method & adjust to fit your preloader specification.</p>		 */		protected function initMovieProperties() : void {			Security.allowDomain( "*" );			Security.allowInsecureDomain( "*" );			fscommand( "swLiveConnect", "true" );			fscommand( "allowscale", "false" );			fscommand( "showmenu", "false" );			fscommand( "fullscreen", "false" );						stage.frameRate = 31;			stage.align = StageAlign.TOP_LEFT;			stage.scaleMode = StageScaleMode.NO_SCALE;			stage.quality = StageQuality.HIGH;			stage.stageFocusRect = false;			}		/**		 * Stub <code>Function</code> invoked when the stage becomes available & the <code>config.xml</code> has begun loading.		 * 		 * <p><b>Customization:</b> Override this method to execute any custom code, such as creating the visual preloader.</p>		 */		protected function configUI() : void {		}		/**		 * Load the API Application <code>config.xml</code>.		 */		protected function loadConfig() : void {			var confURI : String = ( !root.loaderInfo.parameters['conf_uri'] ) ? "xml/config.xml" : root.loaderInfo.parameters['conf_uri'];							_xmlLoader = new URLLoader( );			_xmlLoader.load( new URLRequest( confURI ) );			_xmlLoader.addEventListener( Event.COMPLETE, loadApplication );		}		/**		 * Load then API Application SWF.		 */		protected function loadApplication(e : Event) : void {			_xmlLoader.removeEventListener( Event.COMPLETE, loadApplication );			XML.ignoreWhitespace = XML.ignoreComments = true;			var xml : XML = new XML( e.target.data );			var applicationURI : String = xml.uri.application;			var request : URLRequest = new URLRequest( applicationURI ); 			_loader = new Loader( );			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, initApplication );			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, progress );			_loader.load( request );		}		/**		 * Initialize the loaded API Application SWF.		 * 		 * <p><b>Customization:</b> Override this method to delay API SWF initialization, and execute any visual 		 * preloader '<i>outro</i>' animation before application initializes. If this method is not overridden, 		 * the API SWF will initialize as soon as its load completes.</p>		 */		protected function initApplication(e : Event = null) : void {			_xmlLoader = null;			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, initApplication );			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, progress );			stage.removeEventListener( Event.RESIZE, resizeHandler );			addChild( _loader.content );		}		/**		 * API Application SWF progress handler.		 * 		 *<p><b>Customization:</b> Override this method to execute any custom code to visualize progress in your preloader.</p>		 */		protected function progress(e : ProgressEvent) : void {			_percent = e.bytesLoaded / e.bytesTotal;		}					/**		 * Wrap the <code>resize</code> method with a <code>try ... catch</code> to address the known stage related		 * <a href="http://bugs.adobe.com/jira/browse/FP-434">Flash Player bug</a>.		 * @see http://bugs.adobe.com/jira/browse/FP-434		 * @see http://hubflanger.com/stage-resize-and-the-stagewidth-and-stageheight-properties/		 */		private function resizeHandler(e : Event) : void {			try {				resize( e );			} catch ( err : Error) {			}		}		/**		 * Stub function to invoke upon a stage resize.		 * 		 *<p><b>Customization:</b> Override this method to execute any custom resize logic as the API has yet to initialize.</p>		 */		protected function resize(e : Event = null) : void {		}					/**		 * The percentage of the Application SWF currently loaded.		 */		public function get percent() : Number {			return _percent || 0;		}	}}