/** * sekati.utils.KeyFactory * @version 1.0.3 * @author jason m horwitz | sekati.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.utils {	import sekati.utils.TypeEnforcer;		import flash.utils.Dictionary;		/**	 * KeyFactory provides a <code>RUID</code> hash table of runtime application objects & instances. 	 */	final public class KeyFactory {		private static const HASH_TABLE : Dictionary = new Dictionary( true );		private static const KEY_PREFIX : String = "RUID";		private static var key : Number = 0;		/**		 * Return the objects key or create a key entry if one does not exist.		 */		public static function getKey( o : * ) : String {			if( !hasKey( o ) ) {				HASH_TABLE[ o ] = getNextKey( );			}			return (HASH_TABLE[ o ] as String);		}		/**		 * Determine if the object has a key entry.		 */		public static function hasKey( o : * ) : Boolean {			return (HASH_TABLE[ o ] != null);		}		/**		 * Return the next available key.		 */		public static function getNextKey() : String {			return (KEY_PREFIX + key++);		}		/**		 * Return the value of the upcoming key.		 */		public static function previewNextKey() : String {			return (KEY_PREFIX + key);		}		/**		 * KeyFactory Static Constructor		 */		public function KeyFactory() {			TypeEnforcer.enforceStatic( KeyFactory );		}	}}