/** * APILoader * @version 1.0.0 * @author pj ahlberg * Copyright (C) 2009  pj ahlberg. All Rights Reserved. */package sekati.display {	import flash.display.Loader;	import flash.display.Sprite;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	import flash.events.ProgressEvent;	import flash.net.URLLoader;	import flash.net.URLRequest;		/**	 * The <code>APILoader</code> class is an API independent shell for specifically loading a Sekati API swf with the option for a visual preloader.	 * 	 * <code>APILoader</code> should be extended, and used as the main document class for the preloader swf.	 * 	 * <p>The three main methods that can be overridden are:<br>	 * <ol><li><code>addedToStage(e:Event)</code> - to init the visual preloader</li>	 * <li><code>animateProgress(perc:Number)</code> -  to show load progress on a scale of 0.0 to 1.0</li>	 * <li><code>animateComplete()</code> - to execute a visual 'out' for the preloader. Otherwise <code>initLoadedSwf()</code> will be called automatically.</li></ol>	 * 	 * <b>Note:</b> that the API bootstrap sequence will begin when the loaded API swf is added to the stage in <code>initLoadedSwf()</code>.	 */	public class APILoader extends Sprite {		/*** @private */		protected var _xmlLoader : URLLoader;		/*** @private */		protected var _xml : XML;		/*** @private */		protected var _loader : Loader;		/**		 * APILoader Constructor sets event listeners for added to stage.		 */		public function APILoader() {			stage.scaleMode = StageScaleMode.NO_SCALE;			stage.align = StageAlign.TOP_LEFT;						this.addEventListener( Event.ADDED_TO_STAGE, addedToStage );			this.addEventListener( Event.ADDED_TO_STAGE, loadXML );		}		/**		 * Initialize any custom code as the stage becomes available		 * 		 *<p><b>Customization:</b> Override this method to execute any custom code, such as creating the visual preloader.</p>		 */		protected function addedToStage(e : Event) : void {									this.removeEventListener( Event.ADDED_TO_STAGE, addedToStage );		}		/**		 * <p>Load API swf based on <code>config.xml</code> <b>conf_uri</b> param.</p>		 */		protected function loadXML(e : Event) : void {						this.removeEventListener( Event.ADDED_TO_STAGE, loadXML );						_xml = new XML( );						var xmlPath : String = ( !root.loaderInfo.parameters['conf_uri'] ) ? "xml/config.xml" : root.loaderInfo.parameters['conf_uri'];								_xmlLoader = new URLLoader( );			_xmlLoader.load( new URLRequest( xmlPath ) );			_xmlLoader.addEventListener( Event.COMPLETE, xmlLoadComplete );		}		/**		 * <p>Handle XML load complete and call <code>initLoader</code></p>		 */		protected function xmlLoadComplete(e : Event) : void {			XML.ignoreWhitespace = true;			XML.ignoreComments = true;			_xml = new XML( e.target.data );			_xmlLoader.removeEventListener( Event.COMPLETE, xmlLoadComplete );			initLoader( );		}		/**		 * <p>Begin loading API swf.</p>		 */		protected function initLoader() : void {						_loader = new Loader( );			_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, swfLoadComplete );			_loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, swfProgress );			_loader.load( new URLRequest( _xml.uri.applicationswf ) );		}		/**		 * <p>SWF progress handler and call <code>animateProgress</code> for preloader animation </p>		 */		protected function swfProgress(e : ProgressEvent) : void {			var percentLoaded : Number = e.bytesLoaded / e.bytesTotal;			animateProgress( percentLoaded );		}		/**		 * Progress handler for swf loader.		 * 		 *<p><b>Customization:</b> Override this method to execute any custom code for showing progress in the preloader.</p>		 */		protected function animateProgress(perc : Number) : void {		}		/**		 * <p>SWF complete handler and call <code>animateComplete</code></p>		 */		protected function swfLoadComplete(e : Event) : void {			_loader.contentLoaderInfo.removeEventListener( Event.COMPLETE, swfLoadComplete );			_loader.contentLoaderInfo.removeEventListener( ProgressEvent.PROGRESS, swfProgress );						animateComplete( );		}		/**		 * Custom handler for swf loader complete.		 * 		 *<p><b>Customization:</b> Override this method to delay API swf initialization, and execute any visual preloader 'out' animation before application initializes.		 *If this method is not overridden, the API swf will initialize as soon as its load completes via <code>swfLoadComplete</code>.</p>		 */		protected function animateComplete() : void {			initLoadedSwf( );		}		/**		 * Init API application by attaching it to the stage. 		 * 		 * <p>If <code>animateComplete</code> is overridden, <code>initLoadedSwf</code> must be called explicitly.</p>		 */		protected function initLoadedSwf() : void {			addChild( _loader.content );		}	}}