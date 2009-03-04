/** * @version 1.0 * @author David Dahlstroem | hello@daviddahlstroem.com * Copyright (C) 2009 David Dahlstroem. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.load {	import sekati.events.LoaderEvent;		import sekati.core.Cancelable;	import sekati.load.ByteReference;	import sekati.load.ILoader;	import sekati.log.Logger;	import sekati.reflect.ClassReflector;	import sekati.reflect.MethodReflector;		import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.events.ProgressEvent;	import flash.media.Sound;	import flash.media.SoundLoaderContext;	import flash.net.URLRequest;			/**	 * SoundLoader provides a standard API loader for loading sound.	 */		public class SoundLoader extends AbstractLoader implements ILoader, Cancelable	{				/**		 * Provides security checks for the SoundLoader class.		 * 		 * @see flash.media.SoundLoaderContext		 */				public var soundLoaderContext:SoundLoaderContext;				private var _sound:Sound;				/**		 * SoundLoader Constructor		 */				public function SoundLoader(request:URLRequest)		{			super(request);						reset();		}				/**		 * @inheritDoc		 */				override public function load():void		{			_sound.load(getURLRequest(), soundLoaderContext);		}				/**		 * Cancels the loading process.		 * The <code>reset()</code> method must be called before calling the <code>load()</code> method again.		 */				public function cancel():void		{			try			{				_sound.close();			}			catch(e:Error)			{				Logger.$.warn(this, "SoundLoader has no stream open");			}		}				/**		 * @inheritDoc		 */				override public function clone():Object		{			var			loader:SoundLoader = new SoundLoader(getURLRequest());						loader.soundLoaderContext = soundLoaderContext;						return loader as AbstractLoader;		}				/**		 * @inheritDoc		 */				override public function reset():void		{			if(_sound) destroy();						_sound = new Sound();						_byteReference = new ByteReference(_sound);						setEventListeners(true);		}				/**		 * @inheritDoc		 */				override public function destroy():void		{			cancel();						setEventListeners(false);						_byteReference.destroy();						_byteReference = null;									_sound = null;		}				/**		 * @inheritDoc		 */				override public function get data():*		{			return _sound;		}				/**		 * Indicates whether the SoundLoader ID3 data is available.		 */				public function hasID3():Boolean		{			/*			 * Use ClassReflector to iterate through Sound.id3 properties to determine whether ID3			 * info is available. If a property value returns not null the ID3 info is available.			 */						var id3Reflector:ClassReflector = new ClassReflector(_sound.id3);						var id3Properties:Array = id3Reflector.properties;						for(var i:int = 0; i < id3Properties.length; i++)			{				var propertyReflector:MethodReflector = id3Properties[i] as MethodReflector;								if(_sound.id3[propertyReflector.name] != null)				{					return true;										break;					}			}						return false;		}				private function setEventListeners(add:Boolean):void		{			var method:String = (add) ? "addEventListener" : "removeEventListener";						_sound[method](Event.OPEN, dispatchLoadStartEvent);						_sound[method](Event.COMPLETE, dispatchLoadCompleteEvent);						_sound[method](ProgressEvent.PROGRESS, dispatchLoadProgressEvent);						_sound[method](IOErrorEvent.IO_ERROR, dispatchIOErrorEvent);						_sound[method](Event.ID3, dispatchID3Event);		}				private function dispatchID3Event(e:Event):void		{			dispatchEvent(new LoaderEvent(LoaderEvent.ID3));		}	}}