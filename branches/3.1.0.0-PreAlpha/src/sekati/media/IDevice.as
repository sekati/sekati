/** * sekati.media.IDevice * @version 1.0.1 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.media {	import flash.events.IEventDispatcher;		/**	 * IDevice provides a common interface for all user devices.	 */	public interface IDevice extends IEventDispatcher {		/**		 * Request access to the <code>IDevice</code> from the user.		 */		function pollDevice() : void;		/**		 * The list of available <i>device drivers</i>.		 */		function get devices() : Array;		/**		 * The <code>index</code> of the currently active <i>device driver</i>.		 */		function get deviceIndex() : int;					/**		 * The <i>name</i> of the currently connected <i>device driver</i>.		 */		function get deviceName() : String;					/**		 * The amount of activity the device is detecting. Ranges from <code>0</code> (no activity 		 * detected) to <code>100</code> (a large amount of activity detected).		 */		function get activityLevel() : Number;		/**		 * Indicates whether the user has denied access to the device (<code>true</code>) or allowed access (<code>false</code>) in the Flash Player Privacy dialog box.		 */		function get muted() : Boolean;					/**		 * Set the Device loopback.		 */		function get loopback() : Boolean;				/*** @private */		function set loopback(b:Boolean) : void;				/**		 * The number of milliseconds which must elapse without activity to invoke the <code>activity</code> event.		 */		function get timeout() : int;		/*** @private */		function set timeout(timeout : int) : void;			}}