/* ----------------------------------------------------------------------------------* *  ____    ____    __  __   ______  ______  ______      ______  ____    ______      * * /\  _`\ /\  _`\ /\ \/\ \ /\  _  \/\__  _\/\__  _\    /\  _  \/\  _`\ /\__  _\     * * \ \,\L\_\ \ \L\_\ \ \/'/'\ \ \L\ \/_/\ \/\/_/\ \/    \ \ \L\ \ \ \L\ \/_/\ \/     * *  \/_\__ \\ \  _\L\ \ , <  \ \  __ \ \ \ \   \ \ \     \ \  __ \ \ ,__/  \ \ \     * *    /\ \L\ \ \ \L\ \ \ \\`\ \ \ \/\ \ \ \ \   \_\ \__   \ \ \/\ \ \ \/    \_\ \__  * *    \ `\____\ \____/\ \_\ \_\\ \_\ \_\ \ \_\  /\_____\   \ \_\ \_\ \_\    /\_____\ * *     \/_____/\/___/  \/_/\/_/ \/_/\/_/  \/_/  \/_____/    \/_/\/_/\/_/    \/_____/ * * ----------------------------------------------------------------------------------* *                                                                                   * *          - http://sekati.googlecode.com | http://api.sekati.com/sekati -          *    *                        - http://docs.sekati.com/sekati -                          *  *                                                                                   * * ----------------------------------------------------------------------------------* * Copyright (c) 2008 jason m horwitz, Sekat LLC. All Rights Reserved.               * * ----------------------------------------------------------------------------------* * Permission is hereby granted, free of charge, to any person obtaining a copy of   * * this software and associated documentation files (the "Software"), to deal in the * * Software without restriction, including without limitation the rights to use,     * * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the   * * Software, and to permit persons to whom the Software is furnished to do so,       * * subject to the following conditions:                                              * *                                                                                   * * The above copyright notice and this permission notice shall be included in all    * * copies or substantial portions of the Software.                                   * *                                                                                   * * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR        * * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS  * * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR    * * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN * * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION   * * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                   *             * ----------------------------------------------------------------------------------*/ /** * sekati.Main * @version 1.1.9 * @author jason m horwitz | sekati.com | tendercreative.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.display {	import flash.system.Security;	import flash.system.fscommand;	import caurina.transitions.properties.*;	import sekati.core.Bootstrap;	import sekati.display.Canvas;	import sekati.display.StageDisplay;	import sekati.events.AppEvent;	import sekati.load.AppLoader;	import sekati.log.Logger;		/**	 * This is the API's main <code>Document Class</code>. Any application wishing to implement the core API 	 * should implement this class directly as the <code>Document Class</code> or extend & override with customizations.	 * 	 * <p>API Initialization Routine:<br/>	 * <ol>	 * <li><code>initMovieProperties</code> - sets SWF movie properties & initializes <code>StageDisplay</code></li>	 * <li><code>AppLoader</code> - instantiates & waits for the SWF file to finish loading.</li>	 * <li><code>initTweenEngine</code> - sets up <code>Tweener</code> shortcut properties.</li>	 * <li><code>initAPI</code> - instantiates <code>Boostrap</code> & waits for the queued initialization routes to complete.</li>	 * <li><code>initEntryPoint</code> - the baseline API has been initialized; the custom code layer begins here.</li>	 * </ol>	 * </p> 	 * 	 * @see sekati.core.Bootstrap	 * @see sekati.core.App	 */	[SWF(width="1075", height="500", frameRate="31", backgroundColor="#000000")]	public class Document extends Canvas {		/**		 * @private		 */		protected var _bootstrap : Bootstrap;		/**		 * @private		 */		protected var _appLoader : AppLoader;		/**		 * Document Constructor begins the sequential API initialization with <code>initMovieProperties()</code> 		 * & instantiating <code>AppLoader</code>. 		 */		public function Document() {			super( );			Logger.$.status( this, "*** - Document Initialized ..." );			initMovieProperties( );			_appLoader = new AppLoader( );			_appLoader.addEventListener( AppEvent.APP_LOAD, setupDocument, false, 0, true );		}		/**		 * Initializes SWF movie properties & <code>StageDisplay</code>.		 * 		 * <p><b>Customization:</b> Override this method & adjust to fit your application spec. 		 * Be sure to either call <code>super.initMovieProperties()</code> or 		 * <code>StageDisplay.$.init()</code> to initialize stage management.</p>		 */		protected function initMovieProperties() : void {			Logger.$.info( this, "*** - Initializing Movie Properties ..." );			Security.allowDomain( "*" );			Security.allowInsecureDomain( "*" );			fscommand( "swLiveConnect", "true" );			fscommand( "allowscale", "false" );			fscommand( "showmenu", "false" );			fscommand( "fullscreen", "false" );			StageDisplay.$.init( );		}		/**		 * The SWF has been fully loaded: removed the <code>AppLoader</code> & execute		 * <code>Document</code> setup code: <code>initTweenEngine()</code> & <code>initAPI()</code>.		 * 		 * <p><b>Customization:</b> Should not be necessary.</p>		 */		protected function setupDocument(e : AppEvent) : void {			_appLoader.removeEventListener( AppEvent.APP_LOAD, setupDocument );			_appLoader = null;			initTweenEngine( );			initAPI( );				}		/**		 * Initialize <code>Tweener</code> specialProperties shortcuts.		 * 		 * <p><b>Customization:</b> When overriding this method only init the shortcuts 		 * needed by your application to minimize memory usage.</p>		 * 		 * @see http://hosted.zeh.com.br/tweener/docs/en-us/		 */		protected function initTweenEngine() : void {			Logger.$.info( this, "*** - Initializing Tween Engine ..." );			FilterShortcuts.init( );			ColorShortcuts.init( );			DisplayShortcuts.init( );			TextShortcuts.init( );			SoundShortcuts.init( );								}		/**		 * Initialize the API <code>Bootstrap</code> queued core initialization routines.		 * 		 * <p><b>Customization:</b> Override this method & adjust to point to your <i>custom</i>		 * <code>Bootstrap</code> (extended from <code>sekati.core.Bootstrap</code>) if custom initialization		 * is necessary.</p>		 * 		 * @see sekati.core.Bootstrap		 */			protected function initAPI() : void {			Logger.$.info( this, "*** - Initializing API ..." );			_bootstrap = new Bootstrap( );			_bootstrap.addEventListener( AppEvent.APP_INIT, setupEntryPoint, false, 0, true );		}		/**		 * The Application API has been fully initialized; remove the <code>Bootstrap</code> & 		 * call <code>initEntryPoint</code>.		 * 		 * <p><b>Customization:</b> Should not be necessary.</p>		 */		protected function setupEntryPoint(e : AppEvent) : void {			_bootstrap.removeEventListener( AppEvent.APP_INIT, setupEntryPoint );			_bootstrap = null;			initEntryPoint( );					}		/**		 * Initialize Entry Point: all custom (non-API) application layer code enters.		 * 		 * <p><b>Customization:</b> When implementing the API you will most likely extend <code>Document</code> 		 * as your <code>Document Class</code> overriding <code>initEntryPoint</code> to instantiate your manager,		 * ui & other core classes.</p>		 */		protected function initEntryPoint() : void {			Logger.$.info( this, "*** - Initializing EntryPoint Execution Layer ..." );		}		/**		 * Return the <code>Boostrap</code> (queued initialization) for adding <code>AppEvent</code> listeners.		 */		public function get bootstrap() : Bootstrap {			return _bootstrap;		}		/**		 * Return the <code>AppLoader</code> instance if load progress checking is desired.		 */		public function get appLoader() : AppLoader {			return _appLoader;		}	}}