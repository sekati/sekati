/** * sekati.formats.qrcode.MaskPattern * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.formats.qrcode {	import sekati.utils.TypeEnforcer;			/**	 * MaskPattern	 */	internal class MaskPattern {		/**		 * マスクパターン000		 */		public static const PATTERN000 : int = 0;		/**		 * マスクパターン001		 */		public static const PATTERN001 : int = 1;		/**		 * マスクパターン010		 */		public static const PATTERN010 : int = 2;		/**		 * マスクパターン011		 */		public static const PATTERN011 : int = 3;		/**		 * マスクパターン100		 */		public static const PATTERN100 : int = 4;		/**		 * マスクパターン101		 */		public static const PATTERN101 : int = 5;		/**		 * マスクパターン110		 */		public static const PATTERN110 : int = 6;		/**		 * マスクパターン111		 */		public static const PATTERN111 : int = 7;				/**		 * MaskPattern Static Constructor		 */		public function MaskPattern() {			TypeEnforcer.enforceStatic( this );		}	}}