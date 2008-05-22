/** * sekati.crypt.GUID * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.crypt {	import flash.system.Capabilities;		import sekati.crypt.IHash;	import sekati.crypt.SHA1;		/**	 *  Genuine Unique IDentifier string.	 */	final public class GUID implements IHash {		private static var counter : int = 0;		/**		 * Creates a new Genuine Unique IDentifier.		 * @return String		 */		public static function create() : String {			var id1 : Number = new Date( ).getTime( );			var id2 : Number = Math.random( ) * Number.MAX_VALUE;			var id3 : String = Capabilities.serverString;			return SHA1.calculate( id1 + id3 + id2 + counter++ );		}					/**		 * GUID Static Constructor		 */		public function GUID() {			throw new Error( "GUID is a static class and cannot be instantiated." );		}		}}