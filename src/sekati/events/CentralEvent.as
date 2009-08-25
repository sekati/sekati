/** * sekati.events.CentralEvent * @version 1.3.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.events {	import flash.events.Event;	/**	 * CentralEvent provides a baseline application event object 	 * with optional data transport capabilities.	 * 	 * @see sekati.events.CentralEventDispatcher	 */	 	public class CentralEvent extends Event {		/**		 * The <code>data</code> property can be used to pass information with <code>CentralEvent</code>'s.		 * This may be useful when the developer does not wish to extend <code>CentralEvent</code> (though		 * it is recommended that event classes be written for each type of core <code>CentralEvent</code> 		 * when appropriate).		 */		public var data : *;		/**		 * CentralEvent Constructor		 */		public function CentralEvent(type : String, eventData : * = null, bubbles : Boolean = false, cancelable : Boolean = false) {			super( type, bubbles, cancelable );			data = eventData;		}		/**		 * Allows for easy dispatching of the <code>CentralEvent</code> instance via the <code>CentralEventDispatcher</code>.		 * @see sekati.events.CentralEventDispatcher		 */		public function dispatch() : Boolean {			return CentralEventDispatcher.$.dispatchEvent( this );		}		/**		 * @inheritDoc		 */		override public function clone() : Event {			return new CentralEvent( type, data, bubbles, cancelable );		}										}}