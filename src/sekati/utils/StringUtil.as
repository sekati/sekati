/** * sekati.utils.StringUtil * @version 1.1.0 * @author jason m horwitz | sekati.com | tendercreative.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php *  * @see http://lawrence.ecorp.net/inet/samples/regexp-format.php */package sekati.utils {	/**	 * Static class wrapping various String utilities.	 */	public class StringUtil {		public static const LTRIM_EXP : RegExp = /(\s|\n|\r|\t|\v)*$/;		public static const RTRIM_EXP : RegExp = /^(\s|\n|\r|\t|\v)*/m;		/**		 * Search for key in string.		 */		public static function search(str : String, key : String, caseSensitive : Boolean = true) : Boolean {			if (!caseSensitive) {				str = str.toUpperCase( );				key = key.toUpperCase( );				}			return (str.indexOf( key ) <= -1) ? false : true;		}		/**		 * Does a case insensitive compare or two strings and returns true if they are equal.		 */					public static function equals(s1 : String, s2 : String, caseSensitive : Boolean = false) : Boolean {			return (caseSensitive) ? (s1 == s2) : (s1.toUpperCase( ) == s2.toUpperCase( ));		}		/**		 * replace every instance of a string with something else		 */		public static function replace(str : String, oldChar : String, newChar : String) : String {			return str.split( oldChar ).join( newChar );		}		/**		 * Removes all instances of the key from string.		 */			public static function remove(str : String, key : String) : String {			return StringUtil.replace( str, key, "" );		}				/**		 * Remove spaces from string.		 * @param str (String)		 * @return String		 */		public static function removeSpaces(str : String) : String {			return replace( str, " ", "" );		}		/**		 * Remove tabs from string.		 */		public static function removeTabs(str : String) : String {			return replace( str, "	", "" );			}		/**		 * Remove leading & trailing white space.		 */		public static function trim(str : String) : String {			return ltrim( rtrim( str ) );		}		/**		 * Removes whitespace from the front of the specified string.		 */			public static function ltrim(str : String) : String {			return str.replace( LTRIM_EXP, "" );		}		/**		 * Removes whitespace from the end of a string.		 */			public static function rtrim(str : String) : String {			return str.replace( RTRIM_EXP, "" );		}		/**		 * Extreme Trim: remove whitespace, line feeds, carrige returns from string		 */		public static function xtrim(str : String) : String {			var o : String = new String( );			var TAB : Number = 9;			var LINEFEED : Number = 10;			var CARRIAGE : Number = 13;			var SPACE : Number = 32;			for (var i : int = 0; i < str.length ; i++) {				if (str.charCodeAt( i ) != SPACE && str.charCodeAt( i ) != CARRIAGE && str.charCodeAt( i ) != LINEFEED && str.charCodeAt( i ) != TAB) {					o += str.charAt( i );				}			}			return o;		}		/**		 * Trim spaces and camel notate String.		 */		public static function trimCamel(str : String) : String {			var o : String = new String( );			for (var i : int = 0; i < str.length ; i++) {				if (str.charAt( i ) != " ") {					if (justPassedSpace) {						o += str.charAt( i ).toUpperCase( );						justPassedSpace = false;					} else {						o += str.charAt( i ).toLowerCase( );					}				} else {					var justPassedSpace : Boolean = true;				}			}			return o;		}		/**		 * Determines whether the specified string begins with the spcified prefix.		 * @param input The string that the prefix will be checked against.		 * @param prefix The prefix that will be tested against the string.		 * @return True if the string starts with the prefix, false if it does not.		 */		public static function beginsWith(input : String, prefix : String) : Boolean {						return (prefix == input.substring( 0, prefix.length ));		}		/**		 * Determines whether the specified string ends with the spcified suffix.		 * @param input The string that the suffic will be checked against.		 * @param prefix The suffic that will be tested against the string.		 * @return True if the string ends with the suffix, false if it does not 		 */		public static function endsWith(input : String, suffix : String) : Boolean {			return (suffix == input.substring( input.length - suffix.length ));		}					/**		 * format a number with commas - ie. 10000 -> 10,000		 * @param inNum (Object) String or Number		 */		public static function commaFormatNumber(inNum : Object) : String {			var tmp : String = String( inNum );			//step through backwards and insert commas			var outString : String = "";			var l : Number = tmp.length;			for (var i : int = 0; i < l ; i++) {				if (i % 3 == 0 && i > 0) {					//insert commas					outString = "," + outString;				}				outString = tmp.substr( l - (i + 1), 1 ) + outString;			}			return outString;				}		/**		 * Capitalize the first character in the string.		 */		public static function firstToUpper(str : String) : String {			return str.charAt( 0 ).toUpperCase( ) + str.substr( 1 );		}			/**		 * Encode HTML.		 */		public static function htmlEncode(s : String) : String {			s = replace( s, " ", "&nbsp;" );			s = replace( s, "&", "&amp;" );			s = replace( s, "<", "&lt;" );			s = replace( s, ">", "&gt;" );			s = replace( s, "™", '&trade;' );			s = replace( s, "®", '&reg;' );			s = replace( s, "©", '&copy;' );			s = replace( s, "€", "&euro;" );			s = replace( s, "£", "&pound;" );			s = replace( s, "—", "&mdash;" );			s = replace( s, "–", "&ndash;" );			s = replace( s, "…", "&hellip;" );			s = replace( s, "†", "&dagger;" );			s = replace( s, "·", "&middot;" );			s = replace( s, "µ", "&micro;" );			s = replace( s, "«", "&laquo;" );				s = replace( s, "»", "&raquo;" );			s = replace( s, "•", "&bull;" );			s = replace( s, "°", "&deg;" );				s = replace( s, '"', "&quot;" );						return s;		}		/**		 * Decode HTML.		 */		public static function htmlDecode(s : String) : String {			s = replace( s, "&nbsp;", " " );			s = replace( s, "&amp;", "&" );			s = replace( s, "&lt;", "<" );			s = replace( s, "&gt;", ">" );			s = replace( s, "&trade;", '™' );			s = replace( s, "&reg;", "®" );			s = replace( s, "&copy;", "©" );			s = replace( s, "&euro;", "€" );			s = replace( s, "&pound;", "£" );			s = replace( s, "&mdash;", "—" );			s = replace( s, "&ndash;", "–" );			s = replace( s, "&hellip;", '…' );			s = replace( s, "&dagger;", "†" );			s = replace( s, "&middot;", '·' );			s = replace( s, "&micro;", "µ" );			s = replace( s, "&laquo;", "«" );				s = replace( s, "&raquo;", "»" );			s = replace( s, "&bull;", "•" );			s = replace( s, "&deg;", "°" );			s = replace( s, "&ldquo", '"' );			s = replace( s, "&rsquo;", "'" );			s = replace( s, "&rdquo;", '"' );			s = replace( s, "&quot;", '"' );			return s;		}				/**		 * Sanitize <code>null</code> strings for display purposes.		 */		public static function sanitizeNull(str : String) : String {			return ( str == null || str == "null") ? "" : str;		}		/**		 * Strip the zero off floated numbers.		 */			public static function stripZeroOnFloat(n : Number) : String {			var str : String = "";			var a : Array = String( n ).split( "." );			if (a.length > 1) {				str = (a[0] == "0") ? "." + a[1] : String( n );			} else {				str = String( n );			}			return str;		}		/**		 * Add zero in front of floated number.		 */		public static function padZeroOnFloat( n : Number ) : String {			return ( n > 1 || n < 0 ) ? String( n ) : ( "0." + String( n ).split( "." )[1] );			}		/**		 * Remove scientific notation from very small floats when casting to String.		 * @example <listing version="3.0>		 * 	trace( String(0.0000001) ); 		// returns 1e-7		 * 	trace( floatToString(0.0000001) ); 	// returns .00000001		 * </listing>		 */		public static function floatToString(n : Number) : String {			var s : String = String( n );			return (n < 1 && (s.indexOf( "." ) <= -1 || s.indexOf( "e" ) <= -1)) ? "0." + String( n + 1 ).split( "." )[1] : s;		}		/**		 * Strip the zero off floated numbers and remove Scientific Notation.		 */		public static function stripZeroAndRepairFloat(n : Number) : String {			var str : String;			var tmp : String;			var isZeroFloat : Boolean;			// +=1 to prevent scientific notation.			if(n < 1) {				tmp = String( (n + 1) );				isZeroFloat = true;			} else {				tmp = String( n );				isZeroFloat = false;				}			// if we have a float strip the zero (or +=1) off!			var a : Array = tmp.split( "." );			if (a.length > 1) {				str = (a[0] == "1" && isZeroFloat == true) ? "." + a[1] : tmp;			} else {				str = tmp;			}			return str;		}		/**		 * Generate a set of random characters.		 */		public static function randChar(amount : Number) : String {			var str : String = "";			for(var i : int = 0; i < amount ; i++) str += String.fromCharCode( Math.round( Math.random( ) * (126 - 33) ) + 33 );			return str;		}		/**		 * Generate a set of random LowerCase characters.		 */			public static function randLowerChar(amount : Number) : String {			var str : String = "";			for(var i : int = 0; i < amount ; i++) str += String.fromCharCode( Math.round( Math.random( ) * (122 - 97) ) + 97 );			return str;		}		/**		 * Generate a set of random Number characters.		 */				public static function randNum(amount : Number) : String {			var str : String = "";			for(var i : int = 0; i < amount ; i++) str += String.fromCharCode( Math.round( Math.random( ) * (57 - 48) ) + 48 );			return str;		}		/**		 * Generate a set of random Special and Number characters.		 */				public static function randSpecialChar(amount : Number) : String {			var str : String = "";			for(var i : int = 0; i < amount ; i++) str += String.fromCharCode( Math.round( Math.random( ) * (64 - 33) ) + 33 );			return str;		}			/**		 * Strip HTML markup tags.		 */		public static function stripTags(str : String) : String {			var s : Array = new Array( );			var c : Array = new Array( );			for (var i : int = 0; i < str.length ; i++) {				if (str.charAt( i ) == "<") {					s.push( i );				} else if (str.charAt( i ) == ">") {					c.push( i );				}			}			var o : String = str.substring( 0, s[0] );			for (var j : int = 0; j < c.length ; j++) {				o += str.substring( c[j] + 1, s[j + 1] );			}			return o;		}		/**		 * Detect HTML line breaks.		 */		public static function detectBr(str : String) : Boolean {			return (str.split( "<br" ).length > 1) ? true : false;		}		/**		 * Convert single quotes to double quotes.		 */		public static function toDoubleQuote(str : String) : String {			var sq : String = "'";			var dq : String = String.fromCharCode( 34 );			return str.split( sq ).join( dq );		}		/**		 * Convert double quotes to single quotes.		 */		public static function toSingleQuote(str : String) : String {			var sq : String = "'";			var dq : String = String.fromCharCode( 34 );			return str.split( dq ).join( sq );		}		/**		 * Remove all formatting and return cleaned numbers from string.		 * @example <listing version="3.0"> 		 * 	StringUtils.toNumeric("123-123-1234"); // returns 1221231234 		 * </listing>		 */		public static function toNumeric(str : String) : String {			var len : Number = str.length;			var result : String = "";			for (var i : int = 0; i < len ; i++) {				var code : Number = str.charCodeAt( i );				if (code >= 48 && code <= 57) {					result += str.substr( i, 1 );				}			}			return result;		}		/**		 * StringUtils Static Constructor		 */		public function StringUtil() {			throw new Error( "StringUtils is a static class and cannot be instantiated." );		}		}}