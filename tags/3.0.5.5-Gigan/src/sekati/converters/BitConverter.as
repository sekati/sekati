/** * sekati.converters.BitConversion * @version 1.0.2 * @author jason m horwitz | sekati.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.converters {	import sekati.utils.TypeEnforcer;			/**	 * Bit Conversion Utilites	 */	public class BitConverter {		protected static const BYTE : Number = 8;		protected static const KILOBIT : Number = 1024;		protected static const KILOBYTE : Number = 8192;		protected static const MEGABIT : Number = 1048576;		protected static const MEGABYTE : Number = 8388608;		protected static const GIGABIT : Number = 1073741824;		protected static const GIGABYTE : Number = 8589934592; 		protected static const TERABIT : Number = 1.099511628e+12;		protected static const TERABYTE : Number = 8.796093022e+12;		protected static const PETABIT : Number = 1.125899907e+15;		protected static const PETABYTE : Number = 9.007199255e+15;		protected static const EXABIT : Number = 1.152921505e+18;		protected static const EXABYTE : Number = 9.223372037e+18;		public static function byte2bit(n : Number) : Number {			return n * BYTE;		}		public static function kilobit2bit(n : Number) : Number {			return n * KILOBIT;		}		public static function kilobyte2bit(n : Number) : Number {			return n * KILOBYTE;			}		public static function megabit2bit(n : Number) : Number {			return n * MEGABIT;		}		public static function megabyte2bit(n : Number) : Number {			return n * MEGABYTE;		}					public static function gigabit2bit(n : Number) : Number {			return n * GIGABIT;		}		public static function gigabyte2bit(n : Number) : Number {			return n * GIGABYTE;		}		public static function terabit2bit(n : Number) : Number {			return n * TERABIT;			}		public static function terabyte2bit(n : Number) : Number {			return n * TERABYTE;		}		public static function petaabit2bit(n : Number) : Number {			return n * PETABIT;			}		public static function petabyte2bit(n : Number) : Number {			return n * PETABYTE;		}		public static function exabit2bit(n : Number) : Number {			return n * EXABIT;			}		public static function exabyte2bit(n : Number) : Number {			return n * EXABYTE;		}		/**		 * BitConversion Static Constructor		 */		public function BitConverter() {			TypeEnforcer.enforceStatic( BitConverter );		}		}}