/** * sekati.converters.NumberConverter * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2010  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.converters {	import sekati.utils.TypeEnforcer;			/**	 * Number Conversion Utilities.	 */	public class NumberConverter {				/*** @private */		protected static var WORDS : Array = [ "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen", "Twenty" ];		WORDS[30] = "Thirty";		WORDS[40] = "Forty";    	WORDS[50] = "Fifty";		WORDS[60] = "Sixty";		WORDS[70] = "Seventy";		WORDS[80] = "Eighty";    	WORDS[90] = "Ninety";						/**		 * Convert any integer number to a plain english word string.		 * @param n 	The number to be converted.		 * @return the word string representation of the number.		 * @example <listing version="3.0">		 * 	NumberConverter.toWord( 31137 ); // returns "Thirty-One Thousand One-Hundred and Thirty-Seven"		 * </listing>		 */		public static function toWord( n : int ) : String {			var v : int;			var vWord : String = '';			var vString : String;			if (n < 21) {				vWord += WORDS[n];			} else if (n < 100) {				vWord += WORDS[10 * Math.floor( n / 10 )];				v = n % 10;				vString = (String( n ).substr( -1 ) == "0") ? " " : "-";				if (v > 0) vWord += vString + WORDS[v];			} else if (n < 1000) {				vString = (String( n ).substr( -2 ) == "00") ? " Hundred" : " Hundred And";						vWord += WORDS[Math.floor( n / 100 )] + vString;				v = n % 100;						if (v > 0) vWord += " " + toWord( v );			} else if (n < 1000000) {				vString = (String( n ).substr( -3 ) == "000") ? " Thousand" : " Thousand And";				vWord += toWord( Math.floor( n / 1000 ) ) + vString;				v = n % 1000;				if (v > 0) {					vWord += " ";					if (v < 100)				vWord += " ";					vWord += toWord( v );				}			} else {				vString = (String( n ).substr( -6 ) == "000000") ? " Million" : " Million And";				vWord += toWord( Math.floor( n / 1000000 ) ) + vString;				v = n % 1000000;				if (v > 0) {					vWord += " ";					if (v < 100)				vWord += " ";					vWord += toWord( v );				}			}			return vWord;		}		/**		 * NumberConverter Static Constructor		 */		public function NumberConverter() {			TypeEnforcer.enforceStatic( this );		}	}}