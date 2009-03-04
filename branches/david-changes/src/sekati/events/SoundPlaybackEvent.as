/** * @version 1.0 * @author David Dahlstroem | hello@daviddahlstroem.com * Copyright (C) 2009 David Dahlstroem. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */ package sekati.events{	import flash.events.Event;		public class SoundPlaybackEvent extends Event 	{				public static const ID3:String = "audioPlaybackID3";				public static const PLAYBACK_COMPLETE:String = "audioPlaybackComplete";				public static const PLAYBACK_LOOP:String = "audioPlaybackLoop";				public function SoundPlaybackEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)		{			super(type, bubbles, cancelable);		}				override public function clone():Event		{			return new SoundPlaybackEvent(type, bubbles, cancelable);		}	}}