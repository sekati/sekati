/** * sekati.validators.CreditCardValidator * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.validators {	import sekati.utils.StringUtil;	import sekati.crypt.Luhn;		/**	 * CreditCardValidator provides basic Credit Card validation before sending to a CC gateway.	 * @see sekati.crypt.Luhn	 */	public class CreditCardValidator {		protected static const DEFAULT_ENCODE_DIGITS_SHOWN : int = 4;		protected static const DEFAULT_ENCODE_CHARACTER : String = '*';		protected static const MINIMUM_CARD_LENGTH : int = 13;		protected static const MAXIMUM_CARD_LENGTH : int = 16;		/**		 * Validate a credit card's expiration date.		 * @example <listing version="3.0">		 * 	var isValidDate:Boolean = CreditCardValidator.isValidExDate( 11, 2010 );		 * </listing>		 */		public static function isValidExDate(month : int, year : int) : Boolean {			var d : Date = new Date( );			var currentMonth : int = d.getMonth( ) + 1;			var currentYear : int = d.getFullYear( );			if((year > currentYear) || (year == currentYear && month >= currentMonth)) {				return true;			}			return false;		}		/**		 * Validate a credit card number as much as possible before submitting for approval.		 * @param strNumber 	credit card number as string		 * @example <listing version="3.0">		 * var isValidNumber:Boolean = CreditCardValidator.isValidNumber("1234567890123456");		 * </listing>		 */		public static function isValidNumber(strNumber : String) : Boolean {			var ccNumber : String = StringUtil.toNumeric( strNumber );			if(ccNumber.length > 0 && !isNaN( ccNumber as Number ) && (ccNumber.length >= MINIMUM_CARD_LENGTH && ccNumber.length <= MAXIMUM_CARD_LENGTH)) {				return Luhn.mod10( ccNumber );			}			return false;		}		/**		 * Encode a credit card number as a string and encode all digits except the last </code>digitsShown</code>.		 * @param strNumber 	credit card number as string		 * @param digitsShown 	display this many digits at the end of the card number for security purposes		 * @param encodeChar 	optional encoding character to use instead of default '*'		 * @example <listing version="3.0">		 * trace(CreditCardValidator.EncodeNumber("1234567890123456")); // ************3456		 * trace(CreditCardValidator.EncodeNumber("1234567890123456", 5, "x"));  // xxxxxxxxxxx23456		 * </listing>		 */		public static function encodeNumber(strNumber : String, digitsShown : uint = DEFAULT_ENCODE_DIGITS_SHOWN, encodeChar : String = DEFAULT_ENCODE_CHARACTER) : String {			var encoded : String = "";			for(var i : Number = 0; i < strNumber.length - digitsShown ; i++) {				encoded += encodeChar;			}			encoded += strNumber.slice( -digitsShown );			return encoded;		}				/**		 * CreditCardValidator Static Constructor		 */		public function CreditCardValidator() {			throw new Error( "CreditCardValidator is a static class and cannot be instantiated." );		}			}}