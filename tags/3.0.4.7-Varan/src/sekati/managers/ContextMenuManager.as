﻿/** * sekati.managers.ContextMenuManager * @version 1.1.3 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.managers {	import flash.events.ContextMenuEvent;	import flash.events.EventDispatcher;	import sekati.core.App;	import sekati.display.Canvas;	import sekati.display.StageDisplay;	import sekati.log.Logger;	import sekati.net.NetBase;	import sekati.ui.ContextualMenu;	import sekati.validators.FlashValidator;	import sekati.validators.StringValidator;		/**	 * ContextMenuManager provides a customizable application level <code>ContextMenu</code>	 * when implementing the API. A basic set of items are set at default; such as	 * application name, version & fullscreen toggle. These may be controlled via	 * <code>config.xml</code>. Customizations may be made easily via the <code>menu</code>	 * getter.	 * @see sekati.ui.ContextualMenu	 * @see sekati.core.App	 * @see sekati.core.Bootstrap	 */	final public class ContextMenuManager extends EventDispatcher {		private static var _instance : ContextMenuManager;		private var _this : ContextMenuManager;		private var _menu : ContextualMenu;		/**		 * ContextMenuManager Singleton Constructor		 * @param $ SingletonEnforcer - internal to the AS file; the param prevents external instantiation without error.		 */		public function ContextMenuManager( $ : SingletonEnforcer = null) {			if (!$) {				throw new ArgumentError( "sekati.managers.ContextMenuManager is a Singleton and may only be accessed via its accessor methods: 'getInstance()' or '$'." );				}			Logger.$.info( this, " - ContextMenu Management Initializes ..." );			_this = this;			build( );		}		/**		 * Singleton Accessor		 * @return ContextMenuManager		 */		public static function getInstance() : ContextMenuManager {			if( _instance == null ) _instance = new ContextMenuManager( new SingletonEnforcer( ) );			return _instance;		}		/**		 * Shorthand singleton accessor getter		 * @return ContextMenuManager		 */		public static function get $() : ContextMenuManager {			return ContextMenuManager.getInstance( );			}		/**		 * Build (or rebuild) the <code>ContextualMenu</code> to display the App info, 		 * credits, controls, fullscreen & other customizations.		 */		public function build() : void {			_menu = new ContextualMenu( Canvas.root );			var appString : String = (StringValidator.isBlank( App.APP_VERSION )) ? App.APP_NAME : App.APP_NAME + " / v" + App.APP_VERSION;			_menu.addItem( ":: " + appString + " ::" );			if (App.FULLSCREEN_ENABLE) {				var fsCaption : String = "Fullscreen    [Esc]";				KeyManager.$.addKeyListener( fullscreenHandler, false, KeyManager.$['ESCAPE'] );				_menu.addItem( fsCaption, fullscreenHandler );			}			if (App.API_INFO) {				_menu.addItem( "Built with: " + App.API_NAME + " / " + App.API_VERSION, apiHandler );				_menu.addItem( FlashValidator.playerInfo, null, true, false );			}		}		/**		 * Link API credits in <code>ContextMenu</code>.		 */		protected function apiHandler(e : ContextMenuEvent) : void {			NetBase.getURL( App.API_URL, "_blank" );			}		/**		 * Handle fullscreen <code>ContextMenu</code> selection.		 */		protected function fullscreenHandler(e : ContextMenuEvent = null) : void {			//Logger.$.notice( this, "fullscreenHandler() fired ..." );			StageDisplay.$.toggleFullscreen( );		}		/**		 * Return the <code>ContextualMenu</code> for direct manipulation.		 */		public function get menu() : ContextualMenu {			return _menu;			}	}}/** * Internal class is accessible only to this AS file and is used  * as a constructor param to enforce proper Singleton behavior. */internal class SingletonEnforcer {}