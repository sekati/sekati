/** * sekati.utils.DateUtil * @version 1.1.1 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.utils {	import sekati.converters.TimeConverter;	import sekati.math.Range;	import sekati.utils.TypeEnforcer;		/**	 * Static class for handling dates & converting them into readable strings. Note that all day & month collections are 0-indexed.	 */	public class DateUtil {		public static const MONTHS : Array = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ];		public static const WEEKDAYS : Array = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ];		public static const DAYS_IN_JANUARY : int = 31;		public static const DAYS_IN_FEBRUARY : int = 28;		public static const DAYS_IN_FEBRUARY_LEAP_YEAR : int = 29;		public static const DAYS_IN_MARCH : int = 31;		public static const DAYS_IN_APRIL : int = 30;		public static const DAYS_IN_MAY : int = 31;		public static const DAYS_IN_JUNE : int = 30;		public static const DAYS_IN_JULY : int = 31;		public static const DAYS_IN_AUGUST : int = 31;		public static const DAYS_IN_SEPTEMBER : int = 30;		public static const DAYS_IN_OCTOBER : int = 31;		public static const DAYS_IN_NOVEMBER : int = 30;		public static const DAYS_IN_DECEMBER : int = 31;		public static const DAYS_IN_YEAR : int = 365;		public static const DAYS_IN_LEAP_YEAR : int = 366;		public static const DAYS_IN_MONTHS : Array = [ DAYS_IN_JANUARY, DAYS_IN_FEBRUARY, DAYS_IN_MARCH, DAYS_IN_APRIL, DAYS_IN_MAY, DAYS_IN_JUNE, DAYS_IN_JULY, DAYS_IN_AUGUST, DAYS_IN_SEPTEMBER, DAYS_IN_OCTOBER, DAYS_IN_NOVEMBER, DAYS_IN_DECEMBER ];		/**		 * An array of abbreviated days of the week. E.g. <code>Sun, Mon, Tue, Wed, Thu, Fri, Sat</code>.		 */		public static function get MONTHS_SHORT() : Array {			var a : Array = new Array( );			for (var i : int = 0; i < MONTHS.length ; i++) a.push( MONTHS[i].substr( 0, 3 ) );			return a;		}		/**		 * An array of abbreviated days of the week. E.g. <code>Sun, Mon, Tue, Wed, Thu, Fri, Sat</code>.		 */		public static function get WEEKDAYS_SHORT() : Array {			var a : Array = new Array( );			for (var i : int = 0; i < WEEKDAYS.length ; i++) a.push( WEEKDAYS[i].substr( 0, 3 ) );			return a;		}		/**		 * An array of initials for the days of the week. E.g. <code>S, M, T, W, T, F, S</code>.		 */		public static function get WEEKDAYS_INITIALS() : Array {			var a : Array = new Array( );			for (var i : int = 0; i < WEEKDAYS.length ; i++) a.push( WEEKDAYS[i].substr( 0, 1 ) );			return a;		}		/**		 * Determines if the input year is a leap year (with 366 days, rather than 365).		 * @param year	the year value as stored in a Date object.		 * @return		true if the year input is a leap year		 */		public static function isLeapYear(year : int) : Boolean {			if(year % 100 == 0) {				return year % 400 == 0;			}			return year % 4 == 0;		}		/**		 * Check if birthdate entered meets required age.		 */		public static function isValidAge(year : int, month : int, day : int, requiredAge : int) : Boolean {			if (!isValidDate( year, month, day, true )) return false;			var now : Date = new Date( );			var bd : Date = new Date( year + requiredAge, month, day );			return (now.getTime( ) > bd.getTime( ));		}		/**		 * Check if a valid date can be created with inputs.		 */		public static function isValidDate(year : Number, month : Number, day : Number, mustBeInPast : Boolean) : Boolean {			if(!Range.isInRange( year, 1800, 3000 ) || isNaN( year )) return false;			if(!Range.isInRange( month, 0, 11 ) || isNaN( month )) return false;			if(!Range.isInRange( day, 1, 31 ) || isNaN( day )) return false;			if(day > getTotalDaysInMonth( year, month )) return false;			if(mustBeInPast && dateDiff( new Date( year, month, day ) ) < 0) return false;			return true;		}		/**		 * Time values of the Date class prior to the 15th October 1582 pre-date the		 * introduction of the modern Gregorian Calendar (used by Actionscript, JavaScript, UNIX, etc).		 */		public static function isValidGregorian( d1 : Date ) : Boolean {			var d2 : Date = new Date( Date.UTC( 1582, 9, 15, 0, 0, 0, 0 ) );			return ( d1.time >= d2.time );		}		/**		 * Gets the name of the month specified by index. This is the month value		 * as stored in a Date object.		 * @param index		the numeric value of the month		 * @return			the string name of the month in English		 */		public static function getMonthName(index : int) : String {			return MONTHS[index];		}		/**		 * Gets the abbreviated month name specified by index. This is the month value		 * as stored in a Date object.		 * @param index		the numeric value of the month		 * @return			the short string name of the month in English		 */		public static function getShortMonthName(index : int) : String {			return MONTHS_SHORT[index];		}							/**		 * Takes 24hr hours and converts to 12 hour with am/pm.		 */		public static function getHoursAmPm(hour24 : int) : Object {			if(hour24 > 24 || hour24 < 0) throw new ArgumentError( '"hour24" argument integer is limited to 0 - 24' );				var returnObj : Object = new Object( );			returnObj['ampm'] = (hour24 < 12) ? "am" : "pm";			var hour12 : Number = hour24 % 12;			if (hour12 == 0) {				hour12 = 12;			}			returnObj['hours'] = hour12;			return returnObj;		}		/**		 * Return the number of dates in a specific month.		 */		public static function getTotalDaysInMonth(year : int, month : int) : int {			return TimeConverter.ms2days( dateDiff( new Date( year, month, 1 ), new Date( year, month + 1, 1 ) ) );		}		/**		 * Returns the number of days in a specific year.		 */		public static function getTotalDaysInYear(year : int) : int {			return TimeConverter.ms2days( dateDiff( new Date( year, 0, 1 ), new Date( year + 1, 0, 1 ) ) );		}			/**		 * Rounds a date up to the nearest time unit.		 * @param d			date to round		 * @param timeUnit 	the time unit to round up to		 * @return			the the date object rounded up to		 */		public static function dateCeil(d : Date, timeUnit : String = "day") : Date {			d = new Date( d.valueOf( ) );			switch(timeUnit) {				case "year":				case "years":									d.year++;					d.month = 0;					d.date = 1;					d.hours = 0;					d.minutes = 0;					d.seconds = 0;					d.milliseconds = 0;					break;				case "month":				case "months":									d.month++;					d.date = 1;					d.hours = 0;					d.minutes = 0;					d.seconds = 0;					d.milliseconds = 0;					break;				case "day":				case "days":									d.date++;					d.hours = 0;					d.minutes = 0;					d.seconds = 0;					d.milliseconds = 0;					break;				case "hour":									case "hours":					d.hours++;					d.minutes = 0;					d.seconds = 0;					d.milliseconds = 0;					break;				case "minute":									case "minutes":					d.minutes++;					d.seconds = 0;					d.milliseconds = 0;					break;				case "second":									case "seconds":					d.seconds++;					d.milliseconds = 0;					break;				case "millisecond":									case "milliseconds":					d.milliseconds++;					break;			}			return d;		}		/**		 * Rounds a date down to the nearest time unit.		 * @param d			date to round		 * @param timeUnit	the time unit to round down to		 * @return			the the date object rounded up to		 */		public static function dateFloor(d : Date, timeUnit : String = "day") : Date {			d = new Date( d.valueOf( ) );			switch(timeUnit) {				case "year":				case "years":									d.month = 0;					d.date = 1;					d.hours = 0;					d.minutes = 0;					d.seconds = 0;					d.milliseconds = 0;					break;				case "month":				case "months":									d.date = 1;					d.hours = 0;					d.minutes = 0;					d.seconds = 0;					d.milliseconds = 0;					break;				case "day":				case "days":									d.hours = 0;					d.minutes = 0;					d.seconds = 0;					d.milliseconds = 0;					break;				case "hour":				case "hours":									d.minutes = 0;					d.seconds = 0;					d.milliseconds = 0;					break;				case "minute":				case "minutes":									d.seconds = 0;					d.milliseconds = 0;					break;				case "second":				case "seconds":									d.milliseconds = 0;					break;			}			return d;		}		/**		 * Convert a DB formatted date string into a Flash Date Object.		 * @param dbDate	date in <b>YYYY-MM-DD HH:MM:SS</b> <i>or</i> <b>YYYY-MM-DD</b> format.		 */		public static function dateFromDB(dbdate : String) : Date {			var tmp : Array = dbdate.split( " " );			var dates : Array = tmp[0].split( "-" );			var hours : Array;			var d : Date;			if(tmp[1]) {				hours = tmp[1].split( ":" );				d = new Date( dates[0], dates[1] - 1, dates[2], hours[0], hours[1], hours[2] );			} else {				d = new Date( dates[0], dates[1] - 1, dates[2] );			}			return d;		}		/**		 * Get the differences between two Dates in milliseconds.		 * @return 	difference between two dates in ms		 */		public static function dateDiff(d1 : Date, d2 : Date = null) : Number {			if(!d2) d2 = new Date( );			return d2.getTime( ) - d1.getTime( );		}		/**		 * The number of days between the start value and the end value. The result		 * may contain a fractional part, so cast it to int if a whole number is desired.		 * @param start	the starting date of the range		 * @param end	the ending date of the range		 * @return 		the number of days between start and end		 */		public static function countDays(start : Date, end : Date) : Number {			return Math.abs( end.valueOf( ) - start.valueOf( ) ) / (1000 * 60 * 60 * 24);		}		/**		 * Convert seconds to a formatted time string.		 */		public static function secToFormattedTime(seconds : Number) : String {			var input : Number = seconds;			var time : String = (input > 3600 ? Math.floor( input / 3600 ) + ":" : "") + (input % 3600 < 600 ? "0" : "") + Math.floor( input % 3600 / 60 ) + ":" + (input % 60 < 10 ? "0" : "") + input % 60;			return time;		}				/**		 * Pads hours, Minutes or Seconds with a leading 0, 12:01 doesn't end up 12:1		 */		public static function padTime(n : int) : String {			return (String( n ).length < 2) ? String( "0" + n ) : n as String;		}							/**		 * DateUtil Static Constructor		 */		public function DateUtil() {			TypeEnforcer.enforceStatic( DateUtil );		}			}}