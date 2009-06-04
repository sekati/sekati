/* ---------------------------------------------------------------------------------- *  ____    ____    __  __   ______  ______  ______      ______  ____    ______       * /\  _`\ /\  _`\ /\ \/\ \ /\  _  \/\__  _\/\__  _\    /\  _  \/\  _`\ /\__  _\      * \ \,\L\_\ \ \L\_\ \ \/'/'\ \ \L\ \/_/\ \/\/_/\ \/    \ \ \L\ \ \ \L\ \/_/\ \/      *  \/_\__ \\ \  _\L\ \ , <  \ \  __ \ \ \ \   \ \ \     \ \  __ \ \ ,__/  \ \ \      *    /\ \L\ \ \ \L\ \ \ \\`\ \ \ \/\ \ \ \ \   \_\ \__   \ \ \/\ \ \ \/    \_\ \__   *    \ `\____\ \____/\ \_\ \_\\ \_\ \_\ \ \_\  /\_____\   \ \_\ \_\ \_\    /\_____\  *     \/_____/\/___/  \/_/\/_/ \/_/\/_/  \/_/  \/_____/    \/_/\/_/\/_/    \/_____/  * ---------------------------------------------------------------------------------- *                                                                                    *          - http://sekati.googlecode.com | http://api.sekati.com/sekati -              *                        - http://docs.sekati.com/sekati -                            *                                                                                    * ---------------------------------------------------------------------------------- * Copyright (c) 2008-2009 jason m horwitz, Sekat LLC. All Rights Reserved.                * ---------------------------------------------------------------------------------- * Permission is hereby granted, free of charge, to any person obtaining a copy of    * this software and associated documentation files (the "Software"), to deal in the  * Software without restriction, including without limitation the rights to use,      * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the    * Software, and to permit persons to whom the Software is furnished to do so,        * subject to the following conditions:                                               *                                                                                    * The above copyright notice and this permission notice shall be included in all     * copies or substantial portions of the Software.                                    *                                                                                    * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR         * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS   * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR     * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN  * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION    * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                                * ----------------------------------------------------------------------------------*/ /** * sekati.display.Application * @version 1.3.8 * @author jason m horwitz | sekati.com * Copyright (C) 2008-2009 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.core {	import caurina.transitions.properties.*;		import sekati.core.Bootstrap;	import sekati.core.Configuration;	import sekati.display.Canvas;	import sekati.events.BootstrapEvent;	import sekati.load.ApplicationLoader;	import sekati.log.Logger;	import sekati.managers.StageManager;		import flash.events.Event;	import flash.system.Security;	import flash.system.fscommand;		/**	 * This is the API's main <code>Application Class</code>. Any application wishing to implement the core API 	 * should extend their projects <code>Application Class</code> with <code>sekati.display.Application</code> &	 * override with customizations as needed.	 * 	 * <p><b>API Initialization Routine:</b><br/>	 * <ol>	 * <li><code>initApplication</code> - initializes the <code>Application</code>'s <code>Canvas</code> on <code>ADDED_TO_STAGE</code> event (which enables support for the loading of API applications), or effectively on SWF initialization as the <code>Application</code> subclass <i>is</i> the <code>Stage</code> itself.</li>	 * <li><code>initMovieProperties</code> - sets SWF movie properties & initializes <code>StageDisplay</code>.</li>	 * <li><code>ApplicationLoader</code> - instantiates & waits for the SWF file to finish loading.</li>	 * <li><code>initTweenEngine</code> - sets up <code>Tweener</code> shortcut properties.</li>	 * <li><code>initAPI</code> - instantiates <code>Boostrap</code> & waits for the queued initialization routines to complete.</li>	 * <li><code>initEntryPoint</code> - the baseline API has been initialized; the developers custom code layer enters here.</li>	 * </ol>	 * </p> 	 * 	 * @see sekati.display.ApplicationPreloader	 * @see sekati.display.Canvas	 * @see sekati.core.Bootstrap	 * @see sekati.core.Configuration	 */	public class Application extends Canvas {		/*** @private */		protected var _bootstrap : Bootstrap;				/*** @private */		protected var _preloader : ApplicationLoader;		/**		 * Application Constructor begins the sequential API initialization with <code>initMovieProperties()</code> 		 * & instantiating <code>ApplicationLoader</code>. 		 */		public function Application() {			super( );			addEventListener( Event.ADDED_TO_STAGE, initApplication );			}		/**		 * Initialize the Application & update the <code>Canvas</code> references.		 */		protected function initApplication(e : Event) : void {			Logger.$.status( this, "*** - Application Initialized [Built on " + Configuration.API_NAME + " / " + Configuration.API_VERSION + " - " + Configuration.API_URL + "]." );			removeEventListener( Event.ADDED_TO_STAGE, initApplication );						super.setReferences( );			initMovieProperties( );						_preloader = new ApplicationLoader( this.stage );			_preloader.addEventListener( BootstrapEvent.APP_LOAD, applicationHandler, false, 0, true );		}		/**		 * Initializes SWF movie properties & <code>StageDisplay</code>.		 * 		 * <p><b>Customization:</b> Override this method & adjust to fit your application specification. 		 * Be sure to either call <code>super.initMovieProperties()</code> or 		 * <code>StageDisplay.$.init()</code> to initialize stage management.</p>		 */		protected function initMovieProperties() : void {			Logger.$.info( this, "*** - Initializing Movie Properties ..." );			Security.allowDomain( "*" );			Security.allowInsecureDomain( "*" );			fscommand( "swLiveConnect", "true" );			fscommand( "allowscale", "false" );			fscommand( "showmenu", "false" );			fscommand( "fullscreen", "false" );			StageManager.$.init( );		}		/**		 * Initialize <code>Tweener specialProperties</code> shortcuts.		 * 		 * <p><b>Customization:</b> When overriding this method only init the shortcuts 		 * needed by your application to minimize memory usage.</p>		 * 		 * @see http://hosted.zeh.com.br/tweener/docs/en-us/		 */		protected function initTweenEngine() : void {			Logger.$.info( this, "*** - Initializing Tween Engine ..." );			ColorShortcuts.init( );			DisplayShortcuts.init( );			FilterShortcuts.init( );			TextShortcuts.init( );			SoundShortcuts.init( );								}		/**		 * Initialize the API <code>Bootstrap</code> queued core initialization routines.		 * @param hasBootstrap defines whether the Application initializes the API <code>Bootstrap</code> sequence or runs the API <i>"dumb"</i>.		 * 		 * <p><b>Customization:</b> Override this method & adjust to point to your <i>custom</i> <code>Bootstrap</code> (extended from 		 * <code>sekati.core.Bootstrap</code>) if custom initialization is required or override and alter the default:		 * <code>hasBootstrap = true</code> to <code>false</code> if no bootstrapping is needed.</p>		 * 		 * @example If you would like to skip the API Bootstrapping sequence & run the API <i>"dumb"</i>; in your Main		 * Application "Document" Class (which extends </code>sekati.core.Application</code>):		 * <listing version="3.0">		 * 	override protected function initAPI(hasBootstrap : Boolean = false) : void {		 * 		super.initAPI( hasBootstrap );		 * 	}		 * </listing>		 * 		 * @see sekati.core.Bootstrap		 */			protected function initAPI(hasBootstrap : Boolean = true) : void {			if (hasBootstrap) {				Logger.$.info( this, "*** - Initializing API [Bootstrap] ..." );				_bootstrap = new Bootstrap( );				_bootstrap.addEventListener( BootstrapEvent.APP_INIT, entryPointHandler, false, 0, true );			} else {				Logger.$.info( this, "*** - Initializing API (skipping Bootstrap: running 'dumb') ..." );				initEntryPoint( );			}		}		/**		 * Initialize Entry Point: all custom (non-API) application layer code enters.		 * 		 * <p><b>Customization:</b> When implementing the API you will most likely extend <code>Application</code> 		 * as your <code>Document Class</code> overriding <code>initEntryPoint</code> to instantiate your manager,		 * ui & other core classes.</p>		 */		protected function initEntryPoint() : void {			Logger.$.info( this, "*** - Initializing EntryPoint Execution Layer ..." );		}		/**		 * The SWF has been fully loaded: removed the <code>ApplicationLoader</code> & execute		 * <code>Application</code> setup code: <code>initTweenEngine()</code> & <code>initAPI()</code>.		 * 		 * <p><b>Customization:</b> Should not be necessary.</p>		 */		protected function applicationHandler(e : BootstrapEvent) : void {			_preloader.removeEventListener( BootstrapEvent.APP_LOAD, applicationHandler );			_preloader = null;						initTweenEngine( );			initAPI( );				}		/**		 * The Application API has been fully initialized; remove the <code>Bootstrap</code> & 		 * call <code>initEntryPoint</code>.		 * 		 * <p><b>Customization:</b> Should not be necessary.</p>		 */		protected function entryPointHandler(e : BootstrapEvent) : void {			_bootstrap.removeEventListener( BootstrapEvent.APP_INIT, entryPointHandler );			_bootstrap = null;						initEntryPoint( );					}				/**		 * The <code>Boostrap</code> (queued initialization) for adding <code>BootstrapEvent</code> listeners.		 */		public function get bootstrap() : Bootstrap {			return _bootstrap;		}		/**		 * The <code>ApplicationLoader</code> instance if load progress checking is desired via <code>BootstrapEvent.APP_LOAD</code> listeners.		 */		public function get preloader() : ApplicationLoader {			return _preloader;		}	}}