/** * sekati.crypt.RUID * @version 1.0.0 * @author jason m horwitz | sekati.com | tendercreative.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.crypt {	import sekati.crypt.IHash;	/**	 * Runtime Unique ID's for runtime Object management and identification.	 */	final public class RUID implements IHash {		private static var _key : String = "__RUID";		private static var _id : int = 0;			/**		 * Generate a runtime unique id		 * @return int		 */		public static function create() : int {			return _id++;		}		/**		 * Return the current RUID id		 * @return int		 */		public static function getCurrentId() : int {			return _id;			}		/**		 * Return the key property used to track RUID's		 * @return String		 */		public static function getKey() : String {			return _key;			}				/**		 * RUID Static Constructor		 */		public function RUID() {			throw new Error( "RUID is a static class and cannot be instantiated." );		}		}	}