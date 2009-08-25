/**
 * sekati.core.IRunnable
 * @version 1.0.1
 * @author David Dahlstroem | hello@daviddahlstroem.com & jason m horwitz | sekati.com
 * Copyright (C) 2009 David Dahlstroem, jason m horwitz, Sekat LLC. All Rights Reserved.
 * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php
 */
package sekati.core {
	/**
	 * IRunnable implementors may be ran.
	 */	public interface IRunnable {
		/**
		 * Starts the runnable object.
		 */
		function start() : void;
		/**
		 * Stops the runnable object.
		 */
		function stop() : void;
		/**
		 * Indicates whether the runnable object is currently running.
		 */
		function get running() : Boolean;	}}