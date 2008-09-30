/** * sekati.log.LogLevel * @version 1.2.1 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.log {	/**	 * LogLevel provides the various <code>LogEvent</code> levels provided by <code>Logger</code>.	 */	public class LogLevel {		/**		 * <code>TRACE</code> is a log level denoting a standard log event.		 */			public static const TRACE : uint = 0;		/**		 * <code>INFO</code> is a log level denoting an informational event.		 */				public static const INFO : uint = 1;		/**		 * <code>STATUS</code> is a log level denoting a status event.		 */				public static const STATUS : uint = 2;		/**		 * <code>NOTICE</code> is a log level denoting an event of interest.		 */				public static const NOTICE : uint = 3;		/**		 * <code>DEBUG</code> is a log level denoting an informational event which may require investigation.		 */				public static const DEBUG : uint = 4;		/**		 * <code>WARN</code> is a log level denoting an event of concern.		 */				public static const WARN : uint = 5;		/**		 * <code>ERROR</code> is a log level denoting a error type event.		 */				public static const ERROR : uint = 6;		/**		 * <code>FATAL</code> is a log level denoting a fatal type event.		 */				public static const FATAL : uint = 7;		/**		 * <code>OBJECT</code> is a special log level which delivers origin object recursion.		 */				public static const OBJECT : uint = 8;		/**		 * Resolve the <code>LogEvent</code> level id to a level name.		 */		public static function resolveLevelName(level : uint) : String {			switch(level) {				case TRACE:					return "trace";					break;				case INFO:					return "info";					break;				case STATUS:					return "status";					break;				case NOTICE:					return "notice";					break;				case DEBUG:					return "debug";					break;				case WARN:					return "warn";					break;				case ERROR:					return "error";					break;				case FATAL:					return "fatal";					break;				case OBJECT:					return "object";					break;								default:					return "trace";			}		}				/**		 * Resolve the <code>LogEvent</code> level id to a level name.		 */		public static function resolveFirebugLevelName(level : uint) : String {			switch(level) {				case TRACE:				case DEBUG:				case OBJECT:					return "log";					break;							case INFO:				case STATUS:				case NOTICE:					return "info";					break;				case WARN:					return "warn";					break;				case ERROR:				case FATAL:					return "error";					break;								default:					return "log";			}		}				/**		 * LogLevel Static Constructor		 */		public function LogLevel() {			throw new Error( "LogLevel is a static class and cannot be instantiated." );		}					}}