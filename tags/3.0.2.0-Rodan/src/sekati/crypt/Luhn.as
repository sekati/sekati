/** * sekati.crypt.Luhn * @version 1.0.0 * @author jason m horwitz | sekati.com | tendercreative.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */ package sekati.crypt {	import sekati.crypt.IHash;	/**	 * Validate a number with the Luhn Algorithm (aka Mod10) which is standard 	 * for pre-validating card numbers before being processed for approval.	 * @see http://en.wikipedia.org/wiki/Luhn_algorithm	 */	public class Luhn implements IHash {		/**		 * Validate a credit card number with mod10		 * @param strNumber (String) 		 * @return Boolean		 */		public static function mod10(strNumber : String) : Boolean {					// Seperate each number into it's own index in an array.			var aNumbers : Array = strNumber.split( "" );					// Hold the sums of some calculations that will be made shortly.			var nSum_1 : Number = 0;			var nSum_2 : Number = 0;			var nSum_Total : Number = 0;					// Check to see if the length of the card number is odd or even. This will			// be used to determine which indicies are doubled before being summed up.			var nParity : Number = aNumbers.length % 2;					// Loop through the card numbers.			for(var i : Number = 0; i < aNumbers.length ; i++) {				// Type cast each digit to a number.				aNumbers[i] = Number( aNumbers[i] );							// Compare the parity of the index to the parity of the card number length				// to determine how the value of the current index is handled.				if(i % 2 == nParity) {					// Double each number.					aNumbers[i] *= 2;									// If the resulting value is greater than '9', subtract '9' from it.					aNumbers[i] = aNumbers[i] > 9 ? aNumbers[i] - 9 : aNumbers[i];									// Add each value together.					nSum_1 += aNumbers[i];				} else {					// Add each value together.					nSum_2 += aNumbers[i];				}			}			// Find the total sum of the two groups.			nSum_Total = nSum_1 + nSum_2;					// If the sum is divisible by '10', the card number is valid.			return (nSum_Total % 10 == 0);		}				/**		 * Luhn Static Constructor		 */		public function Luhn() {			throw new Error( "Luhn is a static class and cannot be instantiated." );		}		}}