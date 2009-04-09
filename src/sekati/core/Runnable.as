/**
 * @version 1.0
 * @author David Dahlstroem | hello@daviddahlstroem.com
 * 
 * Copyright (C) 2009 David Dahlstroem. All Rights Reserved.
 * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php
 */

package sekati.core 
{
	public interface Runnable 
	{
		/**
		 * Starts the runnable object.
		 */
		
		function start():void;
		
		/**
		 * Stops the runnable object.
		 */
		
		function stop():void;
		
		/**
		 * Indicates whether the runnable object is currently running.
		 */
		
		function get running():Boolean;	}}