/** * sekati.net.LocalSharedObject * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.net {	import flash.net.SharedObject;	import flash.net.SharedObjectFlushStatus;	import flash.system.Security;	import flash.system.SecurityPanel;			/**	 * LocalSharedObject provides a common <i>"maintain local persistence, 	 * immediate write"</i> style <code>SharedObject</code> to the API.	 */	public class LocalSharedObject {		protected var _so : SharedObject;		protected var _name : String;			/**		 * LocalSharedObject Constructor		 * @param name	of the local shared object		 */		public function LocalSharedObject(name : String) {			_name = name;			_so = SharedObject.getLocal( _name );				}		/**		 * Read the value from a <code>LocalSharedObject</code> property.		 */		public function read(property : String) : * {			return _so[property];			}		/**		 * Write a property value pair to the <code>LocalSharedObject</code>.		 * @return <code>true</code> if the write was successful, <code>false</code> 		 * if there was not enough disk space for the write - in which case the user 		 * is prompted to allow more.		 */		public function write(property : String, value : *) : Boolean {			_so.data[property] = value;			var writeStatus : String = _so.flush( );			return (writeStatus == SharedObjectFlushStatus.FLUSHED) ? true : false;		}		/**		 * Display the FlashPlayer local storage settings panel to the user.		 */		public function showSettings() : void {			Security.showSettings( SecurityPanel.LOCAL_STORAGE );		}		/**		 * Purge all data from the shared objects contents and remove it from disk.		 */		public function clear() : void {			_so.clear( );		}		/**		 * Destroy sharedObject data and instance		 */		public function destroy() : void {			clear( );			_so = null;			_name = null;			delete this;		}						/**		 * Return all data contained in the shared object.		 */		public function get data() : Object {			return _so.data;		}		/**		 * Return the name of the shared object.		 */		public function get name() : String {			return _name;			}		/**		 * The current size of the shared object, in bytes.		 */		public function get size() : uint {			return _so.size;		}	}}