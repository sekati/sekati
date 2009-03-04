/** * sekati.events.LogEvent * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.events {	import flash.events.Event;	/**	 * LogEvent provides the main <code>Event</code> object for the API <code>Logger</code> facility.	 * @see sekati.log.Logger	 */	public class LogEvent extends Event {		/**		 * @eventType onLogEvent fires when a log entry is created via <code>Logger</code>.		 */		public static const LOG_EVENT : String = "onLog";		protected var _id : uint;		protected var _level : uint;		protected var _origin : Object;		protected var _message : String;		protected var _benchmark : uint;		protected var _timestamp : String;		/**		 * LogEvent Constructor		 */		public function LogEvent(type : String, id : uint, level : uint, origin : Object, message : String, benchmark : uint, timestamp : String, bubbles : Boolean = false, cancelable : Boolean = false) {			super( type, bubbles, cancelable );			_id = id;			_level = level;			_origin = origin;			_message = message;			_benchmark = benchmark;			_timestamp = timestamp;		}		/**		 * The LogEvent id		 */		public function get id() : uint {			return _id;		}		/**		 * The LogEvent level		 */		public function get level() : uint {			return _level;		}		/**		 * The LogEvent origin		 */		public function get origin() : Object {			return _origin;		}		/**		 * The LogEvent message		 */		public function get message() : String {			return _message;		}		/**		 * The LogEvent bench		 */		public function get benchmark() : uint {			return _benchmark;		}		/**		 * The LogEvent timestamp		 */		public function get timestamp() : String {			return _timestamp;		}		/**		 * @inheritDoc		 */		override public function clone() : Event {			return new LogEvent( type, _id, _level, _origin, _message, _benchmark, _timestamp, bubbles, cancelable );		}			}}