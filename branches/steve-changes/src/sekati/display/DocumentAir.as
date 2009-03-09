/* ---------------------------------------------------------------------------------- *  ____    ____    __  __   ______  ______  ______      ______  ____    ______       * /\  _`\ /\  _`\ /\ \/\ \ /\  _  \/\__  _\/\__  _\    /\  _  \/\  _`\ /\__  _\      * \ \,\L\_\ \ \L\_\ \ \/'/'\ \ \L\ \/_/\ \/\/_/\ \/    \ \ \L\ \ \ \L\ \/_/\ \/      *  \/_\__ \\ \  _\L\ \ , <  \ \  __ \ \ \ \   \ \ \     \ \  __ \ \ ,__/  \ \ \      *    /\ \L\ \ \ \L\ \ \ \\`\ \ \ \/\ \ \ \ \   \_\ \__   \ \ \/\ \ \ \/    \_\ \__   *    \ `\____\ \____/\ \_\ \_\\ \_\ \_\ \ \_\  /\_____\   \ \_\ \_\ \_\    /\_____\  *     \/_____/\/___/  \/_/\/_/ \/_/\/_/  \/_/  \/_____/    \/_/\/_/\/_/    \/_____/  * ---------------------------------------------------------------------------------- *                                                                                    *          - http://sekati.googlecode.com | http://api.sekati.com/sekati -              *                        - http://docs.sekati.com/sekati -                            *                                                                                    * ---------------------------------------------------------------------------------- * Copyright (c) 2008-2009 jason m horwitz, Sekat LLC. All Rights Reserved.                * ---------------------------------------------------------------------------------- * Permission is hereby granted, free of charge, to any person obtaining a copy of    * this software and associated documentation files (the "Software"), to deal in the  * Software without restriction, including without limitation the rights to use,      * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the    * Software, and to permit persons to whom the Software is furnished to do so,        * subject to the following conditions:                                               *                                                                                    * The above copyright notice and this permission notice shall be included in all     * copies or substantial portions of the Software.                                    *                                                                                    * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR         * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS   * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR     * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN  * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION    * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                                * ----------------------------------------------------------------------------------*/ /** * sekati.display.Document * @version 1.3.6 * @author jason m horwitz | sekati.com * Copyright (C) 2008-2009 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.display {	import flash.events.Event;	import flash.system.fscommand;		import caurina.transitions.properties.*;		import sekati.core.Bootstrap;	import sekati.display.Canvas;	import sekati.display.StageDisplay;	import sekati.events.BootstrapEvent;	import sekati.log.Logger;			/**	 * This is the API's main <code>Document Class</code>. Any application wishing to implement the core API 	 * should extend their projects <code>Document Class</code> with <code>sekati.display.Document</code> &	 * override with customizations as needed.	 * 	 * <p><b>API Initialization Routine:</b><br/>	 * <ol>	 * <li><code>initDocument</code> - initializes the Application <code>Document</code>'s <code>Canvas</code> on <code>ADDED_TO_STAGE</code> (to support the option of loadable API applications), or effectively on SWF initialization as the <code>Document</code> subclass <i>is</i> the <code>Stage</code> itself.</li>	 * <li><code>initMovieProperties</code> - sets SWF movie properties & initializes <code>StageDisplay</code>.</li>	 * <li><code>ApplicationLoader</code> - instantiates & waits for the SWF file to finish loading.</li>	 * <li><code>initTweenEngine</code> - sets up <code>Tweener</code> shortcut properties.</li>	 * <li><code>initAPI</code> - instantiates <code>Boostrap</code> & waits for the queued initialization routines to complete.</li>	 * <li><code>initEntryPoint</code> - the baseline API has been initialized; the developers custom code layer enters here.</li>	 * </ol>	 * </p> 	 * 	 * @see sekati.display.DocumentPreloader	 * @see sekati.display.Canvas	 * @see sekati.core.Bootstrap	 * @see sekati.core.App	 */	public class DocumentAir extends Canvas {		/*** @private */		protected var _bootstrap : Bootstrap;		/**		 * Document Constructor begins the sequential API initialization with <code>initMovieProperties()</code> 		 * & instantiating <code>ApplicationLoader</code>. 		 */		public function DocumentAir() {			super( );			addEventListener( Event.ADDED_TO_STAGE, initDocument );			}		/**		 * Initialize the Document & update the <code>Canvas</code> references.		 */		protected function initDocument(e : Event) : void {			Logger.$.status( this, "*** - Document Initialized ..." );			removeEventListener( Event.ADDED_TO_STAGE, initDocument );						super.setReferences( );			initMovieProperties( );			initTweenEngine( );			initAPI( );				}		/**		 * Initializes SWF movie properties & <code>StageDisplay</code>.		 * 		 * <p><b>Customization:</b> Override this method & adjust to fit your application specification. 		 * Be sure to either call <code>super.initMovieProperties()</code> or 		 * <code>StageDisplay.$.init()</code> to initialize stage management.</p>		 */		protected function initMovieProperties() : void {			Logger.$.info( this, "*** - Initializing Movie Properties ..." );			fscommand( "allowscale", "false" );			StageDisplay.$.init( );		}		/**		 * Initialize <code>Tweener specialProperties</code> shortcuts.		 * 		 * <p><b>Customization:</b> When overriding this method only init the shortcuts 		 * needed by your application to minimize memory usage.</p>		 * 		 * @see http://hosted.zeh.com.br/tweener/docs/en-us/		 */		protected function initTweenEngine() : void {			Logger.$.info( this, "*** - Initializing Tween Engine ..." );			FilterShortcuts.init( );			ColorShortcuts.init( );			DisplayShortcuts.init( );			TextShortcuts.init( );			SoundShortcuts.init( );								}		/**		 * Initialize the API <code>Bootstrap</code> queued core initialization routines.		 * @param hasBootstrap defines whether the Document initializes the API <code>Bootstrap</code> sequence or runs the API <i>"dumb"</i>.		 * 		 * <p><b>Customization:</b> Override this method & adjust to point to your <i>custom</i>		 * <code>Bootstrap</code> (extended from <code>sekati.core.Bootstrap</code>) if custom initialization		 * is required or override and alter the default <code>hasBootstrap = true</code> to <code>false</code> if no bootstrapping is needed.</p>		 * 		 * @example If you would like to skip the API Bootstrapping sequence & run the API <i>"dumb"</i>; in your Main		 * Document class (which extends </code>sekati.display.Document</code>):		 * <listing version="3.0">		 * 	override protected function initAPI(hasBootstrap : Boolean = false) : void {		 * 		super.initAPI( hasBootstrap );		 * 	}		 * </listing>		 * 		 * @see sekati.core.Bootstrap		 */			protected function initAPI(hasBootstrap : Boolean = true) : void {			if (hasBootstrap) {				Logger.$.info( this, "*** - Initializing API [Bootstrap] ..." );				_bootstrap = new Bootstrap( );				_bootstrap.addEventListener( BootstrapEvent.APP_INIT, entryPointHandler, false, 0, true );			} else {				Logger.$.info( this, "*** - Initializing API (skipping Bootstrap: running 'dumb') ..." );				initEntryPoint( );			}		}		/**		 * Initialize Entry Point: all custom (non-API) application layer code enters.		 * 		 * <p><b>Customization:</b> When implementing the API you will most likely extend <code>Document</code> 		 * as your <code>Document Class</code> overriding <code>initEntryPoint</code> to instantiate your manager,		 * ui & other core classes.</p>		 */		protected function initEntryPoint() : void {			Logger.$.info( this, "*** - Initializing EntryPoint Execution Layer ..." );		}		/**		 * The Application API has been fully initialized; remove the <code>Bootstrap</code> & 		 * call <code>initEntryPoint</code>.		 * 		 * <p><b>Customization:</b> Should not be necessary.</p>		 */		protected function entryPointHandler(e : BootstrapEvent) : void {			_bootstrap.removeEventListener( BootstrapEvent.APP_INIT, entryPointHandler );			_bootstrap = null;			initEntryPoint( );					}				/**		 * The <code>Boostrap</code> (queued initialization) for adding <code>BootstrapEvent</code> listeners.		 */		public function get bootstrap() : Bootstrap {			return _bootstrap;		}	}}