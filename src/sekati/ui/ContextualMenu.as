/** * sekati.ui.ContextualMenu * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.ui {	import flash.display.InteractiveObject;	import flash.events.ContextMenuEvent;	import flash.events.EventDispatcher;	import flash.ui.ContextMenu;	import flash.ui.ContextMenuItem;		import sekati.utils.ArrayUtils;		/**	 * ContextualMenu provides a common <code>ContextMenu</code> interface.	 */	public class ContextualMenu extends EventDispatcher {		protected var _target : InteractiveObject;		protected var _isEnabled : Boolean;		protected var _hasBuiltInItems : Boolean;		protected var _items : Array;		protected var _backup : Array;				/**		 * ContextualMenu Constructor		 */		public function ContextualMenu(target : InteractiveObject, hasBuiltInItems : Boolean = false, enable : Boolean = true ) {			_target = target;			_hasBuiltInItems = hasBuiltInItems;			_isEnabled = enable;			_items = new Array( );			_backup = new Array( );				buildMenu( );				}		/**		 * Add a new item to the <code>ContextualMenu</code>.		 * @param caption 	item caption (must be a unique string).		 * @param cb 		item callback function fired when the item is selected.		 * @param div 		item has a divider seperating it from the items above.		 * @param enable	item interactivity enabled.		 * @return uint 	<code>ContextualMenu</code> item id.		 */	 		public function addItem(caption : String, cb : Function = null, div : Boolean = true, enable : Boolean = true) : uint {			if (cb == null) cb = voidClick;			var id : uint = _items.push( {caption:caption, cb:cb, div:div, enable:enable} );			buildMenu( );			return id;		}		/**		 * Edit an existing code>ContextualMenu</code> item.		 * @param id		of the existing item to be edited.		 * @param caption 	item caption.		 * @param cb 		item callback function fired when the item is selected.		 * @param div 		item has a divider seperating it from the items above.		 * @param enable	item interactivity enabled.		 * @throws Error if invalid item id was passed.		 */		public function editItem(id : uint, caption : String, cb : Function = null, div : Boolean = true, enable : Boolean = true) : void {			if( isNaN( id ) || id >= _items.length) {				throw new Error( "@@@ sekati.ui.ContextualMenu.editItem() Error: " + id + " is not a valid index in the menu item array '" + _items.toString( ) + "'." );			}			if (cb == null) cb = voidClick;			_items[id] = {caption:caption, cb:cb, div:div, enable:enable};			buildMenu( );		}		/**		 * Enable an existing item in the <code>ContextualMenu</code>		 * @param id		of the item to be enabled.		 * @throws Error if invalid item id was passed.		 */		public function enableItem(id : uint) : void {			if( isNaN( id ) || id >= _items.length) {				throw new Error( "@@@ sekati.ui.ContextualMenu.enableItem() Error: " + id + " is not a valid index in the menu item array '" + _items.toString( ) + "'." );			}			_items[id].enable = true;			buildMenu( );				}		/**		 * Disable an existing item in the <code>ContextualMenu</code>		 * @param id		of the item to be disabled.		 * @throws Error if invalid item id was passed.		 */		public function disableItem(id : uint) : void {			if( isNaN( id ) || id >= _items.length) {				throw new Error( "@@@ sekati.ui.ContextualMenu.disableItem() Error: " + id + " is not a valid index in the menu item array '" + _items.toString( ) + "'." );			}						_items[id].enable = false;			buildMenu( );		}		/**		 * Remove an item from the Context Menu		 * @param name (String) the caption name of the item to be removed		 * @throws Error if invalid item id was passed.		 */		public function removeItem(id : uint) : void {			if( isNaN( id ) || id >= _items.length) {				throw new Error( "@@@ sekati.ui.ContextualMenu.removeItem() Error: " + id + " is not a valid index in the menu item array '" + _items.toString( ) + "'." );			}							// instead of splicing we empty the index to persist existing item id's			_items[id] = {};			buildMenu( );		}		/**		 * Returns the <code>ContextualMenu</code> item id that matches the <code>caption</code> arguments caption.		 * @param caption 	the <code>ContextualMenu</code> item's <code>caption</code>.		 * @return uint		the <code>ContextualMenu</code> item id or <code>NaN</code> if no match was found.		 */		public function getItemId(caption : String) : uint {			return ArrayUtils.locatePropValIndex( _items, "caption", caption );			}		/**		 * Build the custom <code>ContextualMenu</code>.		 */			protected function buildMenu() : void {			var m : ContextMenu = new ContextMenu( );			if (!_hasBuiltInItems) {				m.hideBuiltInItems( );			}			for (var i : int = 0; i < _items.length ; i++) {				if (_items[i].caption != null) {					//caption : String, separatorBefore : Boolean = false, enabled : Boolean = true, visible : Boolean = true);					var cmi : ContextMenuItem = new ContextMenuItem( _items[i].caption, _items[i].div, _items[i].enable );					cmi.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, _items[i].cb, false, 0, true );					m.customItems.push( cmi );				}			}			_target.contextMenu = m;		}		/**		 * Void function assigned to added items without callback.		 */		protected function voidClick(e : ContextMenuEvent) : void {		}		/**		 * Menu enabled setter		 * @param b (Boolean) - enable (true) or disable (false) the custom Context Menu [default: true].		 * @return void		 */		public function set enabled(b : Boolean) : void {			if (b == false) {				if (_isEnabled != false) {					_isEnabled = false;					_backup = _items;					_items = [];					buildMenu( );				}			} else {				if (_isEnabled != true) {					_isEnabled = true;					_items = _backup;					buildMenu( );				}			}		}		/**		 * Menu enabled getter		 * @return Boolean		 */		public function get enabled() : Boolean {			return _isEnabled;			}			/**		 * Menu builtInItems setter		 * @param b (Boolean) - enable (true) or disable (false) the Context Menu's built in items [default: false].		 * @return void		 */		public function set builtInItems(b : Boolean) : void {			_hasBuiltInItems = b;			}		/**		 * Menu builtInItems getter		 * @return Boolean		 */		public function get builtInItems() : Boolean {			return _hasBuiltInItems;			}		}}