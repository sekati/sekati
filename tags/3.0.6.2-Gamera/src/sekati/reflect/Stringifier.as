/** * sekati.reflect.Stringifier * @version 1.0.2 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.reflect {	import sekati.core.KeyFactory;	import sekati.utils.TypeEnforcer;		import flash.utils.getQualifiedClassName;			/**	 * Stringify class or class instance fully qualified name.	 * @see com.sekati.core.CoreInterface	 */	public class Stringifier {		/**		 * Return the class or class instances fully qualified class name and runtime unique id.		 * @param o class or class instance to stringify.		 * @return String		 */		public static function stringify(o : *) : String {			return className( o ) + ':' + KeyFactory.getKey( o );		}		/**		 * Return the class or class instances fully qualified class name.		 * @param o class or class instance to stringify.		 * @return String		 */		public static function className(o : *) : String {			return getQualifiedClassName( o );		}		/**		 * Stringifier Static Constructor		 */		public function Stringifier() {			TypeEnforcer.enforceStatic( Stringifier );		}		}}