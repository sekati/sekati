/** * @version 1.0 * @author David Dahlstroem | hello@daviddahlstroem.com * Copyright (C) 2009 David Dahlstroem. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.events {	import flash.events.Event;		/**	 * LoaderEvent provides a base Event for loaders.	 */	public class LoaderEvent extends Event 	{				public static const START:String = "loadStart";			public static const COMPLETE:String = "loadComplete";				public static const PROGRESS:String = "loadProgress";				public static const IO_ERROR:String = "loadIOError";				public static const SECURITY_ERROR:String = "loadSecurityError";				public static const BYTESTOTAL_PREFETCHED:String = "loadBytesTotalPrefetch";				public function LoaderEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)		{			super(type, bubbles, cancelable);		}				/**		 * @inheritDoc		 */		override public function clone():Event		{			return new LoaderEvent(type, bubbles, cancelable);		}	}}