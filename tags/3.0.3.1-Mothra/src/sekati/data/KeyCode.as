/** * sekati.ui.KeyCode * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.data {	/**	 * KeyCode provides some basic alpha keyCodes which are otherwise only provided in the Flex3 AIR implementation 	 * of the Keyboard class (the <code>flash.ui.Keyboard</code> class ommits them for some strange reason).	 */	public class KeyCode {		public static const A : uint = 65;		public static const B : uint = 66;		public static const C : uint = 67;		public static const D : uint = 68;		public static const E : uint = 69;		public static const F : uint = 70;		public static const G : uint = 71;		public static const H : uint = 72;		public static const I : uint = 73;		public static const J : uint = 74;		public static const K : uint = 75;		public static const L : uint = 76;		public static const M : uint = 77;		public static const N : uint = 78;		public static const O : uint = 79;		public static const P : uint = 80;		public static const Q : uint = 81;		public static const R : uint = 82;		public static const S : uint = 83;		public static const T : uint = 84;		public static const U : uint = 85;		public static const V : uint = 86;		public static const W : uint = 87;		public static const X : uint = 88;		public static const Y : uint = 89;		public static const Z : uint = 90;		//		public static const ALTERNATE : uint = 18;		public static const BACKQUOTE : uint = 192;		public static const BACKSLASH : uint = 220;		public static const COMMA : uint = 188;		public static const COMMAND : uint = 15;		public static const EQUAL : uint = 187;		/**		 * KeyCode Static Constructor		 */		public function KeyCode() {			throw new Error( "KeyCode is a static class and cannot be instantiated." );		}	}}