/* ----------------------------------------------------------------------------------* *  ____    ____    __  __   ______  ______  ______      ______  ____    ______      * * /\  _`\ /\  _`\ /\ \/\ \ /\  _  \/\__  _\/\__  _\    /\  _  \/\  _`\ /\__  _\     * * \ \,\L\_\ \ \L\_\ \ \/'/'\ \ \L\ \/_/\ \/\/_/\ \/    \ \ \L\ \ \ \L\ \/_/\ \/     * *  \/_\__ \\ \  _\L\ \ , <  \ \  __ \ \ \ \   \ \ \     \ \  __ \ \ ,__/  \ \ \     * *    /\ \L\ \ \ \L\ \ \ \\`\ \ \ \/\ \ \ \ \   \_\ \__   \ \ \/\ \ \ \/    \_\ \__  * *    \ `\____\ \____/\ \_\ \_\\ \_\ \_\ \ \_\  /\_____\   \ \_\ \_\ \_\    /\_____\ * *     \/_____/\/___/  \/_/\/_/ \/_/\/_/  \/_/  \/_____/    \/_/\/_/\/_/    \/_____/ * * ----------------------------------------------------------------------------------* *                                                                                   * *          - http://sekati.googlecode.com | http://api.sekati.com/sekati -          *    *                        - http://docs.sekati.com/sekati -                          *  *                                                                                   * * ----------------------------------------------------------------------------------* * Copyright (c) 2008 jason m horwitz, Sekat LLC. All Rights Reserved.               * * ----------------------------------------------------------------------------------* * Permission is hereby granted, free of charge, to any person obtaining a copy of   * * this software and associated documentation files (the "Software"), to deal in the * * Software without restriction, including without limitation the rights to use,     * * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the   * * Software, and to permit persons to whom the Software is furnished to do so,       * * subject to the following conditions:                                              * *                                                                                   * * The above copyright notice and this permission notice shall be included in all    * * copies or substantial portions of the Software.                                   * *                                                                                   * * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR        * * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS  * * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR    * * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN * * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION   * * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                   *             * ----------------------------------------------------------------------------------*/ /** * sekati.Main * @version 1.1.1 * @author jason m horwitz | sekati.com | tendercreative.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.display {	import flash.system.Security;	import flash.system.fscommand;		import caurina.transitions.properties.*;		import sekati.core.Bootstrap;	import sekati.display.Canvas;	import sekati.display.StageDisplay;	import sekati.events.AppEvent;	import sekati.load.AppLoader;	import sekati.log.Logger;		/**	 * This is the main <code>Document Class</code> for 	 * Sekati API. Any application wishing to fully implement	 * the API should either use this class as the main 	 * <code>Document Class</code> or extend & override it as 	 * needed to make the necessary customizations.	 * 	 * @see sekati.core.Bootstrap	 * @see sekati.core.App	 */	public class Document extends Canvas {		/**		 * Queued initialization routines.		 */		protected var bootstrap : Bootstrap;				/**		 * Basic application preloader.		 */		protected var appLoader : AppLoader;		/**		 * Document Constructor initializes the application,		 * firing <code>setMovieProps</code> to set core		 * movie properties, <code>initTweenEngine</code>		 * to initialize <code>Tweener</code> properties,		 * and finally <code>buildCompositions</code> which		 * initializes bootstraps, managers and other core		 * application code.		 */		public function Document() {			super( );			Logger.$.status( this, "*** - Document Initialized ..." );			appLoader = new AppLoader( );			appLoader.addEventListener( AppEvent.APP_LOAD, initDocument );		}		/**		 * Initialize the <code>Document</code> code now that		 * the file has been fully loaded.		 */		protected function initDocument(e : AppEvent) : void {			appLoader.removeEventListener( AppEvent.APP_LOAD, initDocument );			setMovieProps( );			initAPI( );			initTweenEngine( );			initEntryPoint( );					}		/**		 * General movie property setup.		 */		protected function setMovieProps() : void {			Logger.$.info( this, "*** - Setting Movie Properties ..." );			Security.allowDomain( "*" );			Security.allowInsecureDomain( "*" );			fscommand( "swLiveConnect", "true" );			fscommand( "allowscale", "false" );			fscommand( "showmenu", "false" );			fscommand( "fullscreen", "false" );			StageDisplay.$.init( );		}		/**		 * Initialize the API <code>Bootstrap</code> queued core initialization routines.		 */			protected function initAPI() : void {			Logger.$.info( this, "*** - Initializing API ..." );			bootstrap = new Bootstrap( );		}		/**		 * Initialize <code>Tweener</code> specialProperties shortcuts.		 * 		 * <p><b>Customization:</b> When overriding this method only		 * init the shortcuts necessary for your application to minimize		 * memory usage.</p>		 * 		 * @see http://hosted.zeh.com.br/tweener/docs/en-us/		 */		protected function initTweenEngine() : void {			Logger.$.info( this, "*** - Initializing Tween Engine ..." );			FilterShortcuts.init( );			ColorShortcuts.init( );			DisplayShortcuts.init( );			TextShortcuts.init( );			SoundShortcuts.init( );								}		/**		 * Initialize Entry Point: this is where the custom (non-API) application layer core code enters.		 * 		 * <p><b>Customization:</b> When implementing the API you will most likely extend <code>Document</code> 		 * as your <code>Document Class</code> overriding <code>initEntryPoint</code> to instantiate your manager,		 * ui & other core classes which require instantiation.</p>		 */		protected function initEntryPoint() : void {			Logger.$.info( this, "*** - Initializing EntryPoint Execution Layer ..." );		}	}}