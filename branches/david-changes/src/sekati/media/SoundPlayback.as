/** * @version 1.0 * @author David Dahlstroem | hello@daviddahlstroem.com * Copyright (C) 2009 David Dahlstroem. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.media{	import sekati.core.Cloneable;	import sekati.core.ICoreInterface;	import sekati.events.SoundPlaybackEvent;	import sekati.events.WeakEventDispatcher;	import sekati.reflect.ClassReflector;	import sekati.reflect.MethodReflector;	import sekati.reflect.Stringifier;		import flash.events.Event;	import flash.media.ID3Info;	import flash.media.Sound;	import flash.media.SoundChannel;	import flash.media.SoundTransform;	import flash.utils.setTimeout;		/**	 * SoundPlayback class provides a base API for playing and controlling sound playback.	 */		public class SoundPlayback extends WeakEventDispatcher implements ICoreInterface, MediaPlayback, Cloneable	{				/** @private */		protected var _sound:Sound;				private var _soundChannelReference:SoundChannel;				private var _position:Number;				private var _playing:Boolean;				private var _pan:Number = 0;				private var _volume:Number = 1;				private var _loopRuns:uint = 0;				public var loops:uint;				/**		 * Creates a new SoundPlayback instance.		 * 		 * @param sound Reference to a sound object.		 */				public function SoundPlayback(sound:Sound)		{			super(this);						_playing = false;						setSound(sound);		}				/**		 * Starts or resumes sound playback.		 */				public function play():void		{			if(playing) return;						_soundChannel = _sound.play(_position, 0, new SoundTransform(_volume, _pan));						_playing = true;		}				/**		 * Starts sound playback at a defined position.		 * 		 * @param position Playback starting position.		 */				public function playAt(position:Number):void		{			if(playing) _soundChannel.stop();						_position = position;						_soundChannel = _sound.play(_position, 0, new SoundTransform(_volume, _pan));						_playing = true;		}				/**		 * Pauses sound playback.		 */				public function pause():void		{			_position = _soundChannel.position;						_soundChannel.stop();						_playing = false;		}				/**		 * Stops sound playback.		 * The position is set to zero.		 */				public function stop():void		{			seek(0);						_loopRuns = 0;						_soundChannel.stop();						_playing = false;		}				/**		 * Sets the position of the sound playback.		 */				public function seek(position:Number):void		{			if(playing) _soundChannel.stop();						_position = position;						_soundChannel = _sound.play(_position, 0, new SoundTransform(_volume, _pan));						if(!playing) pause(); 		}				/**		 * Sets the volume of the sound playback.		 */				public function get volume():Number		{			return _soundChannel.soundTransform.volume;		}		public function set volume(value:Number):void		{			_soundChannel.soundTransform = new SoundTransform(value, _soundChannel.soundTransform.pan);						_volume = _soundChannel.soundTransform.volume;		}				/**		 * Indicates the number of loops left.		 */				public function get remainingLoops():uint		{			return Math.max(loops - _loopRuns, 0);		}				/**		 * Changes the sound of the SoundPlayback. If the Soundplayback is currently playing, the new sound will begin playing automatically.		 * Use <code>SoundPlayback.stop()</code> <code>SoundPlayback.pause()</code> before calling this method if you wish to ensure that the new sound is not playing.		 * 		 * @param sound Reference to new Sound.		 * @param resetPosition If <code>true</code> the new sound will begin playing from start.		 * If set to <code>false</code> the new sound will attempt to play at the same position as the old sound.		 * 		 */				public function setSound(sound:Sound, resetPosition:Boolean = true):void		{						var soundPos:Number = (resetPosition) ? 0 : position;						if(_soundChannel) _soundChannel.stop();						_sound = sound;						seek(Math.min(soundPos, length));		}				/**		 * Returns the length of the sound in milliseconds.		 * If the sound is not completely loaded the sound length will be estimated.		 */				public function get length():Number		{			if(_sound.bytesLoaded == _sound.bytesTotal) return _sound.length;						return (_sound.bytesTotal / (_sound.bytesLoaded / _sound.length));		}				/**		 * Returns retrieved sound ID3 data.		 * 		 * @see sekati.events.SoundPlaybackEvent#ID3		 */				public function get id3():ID3Info		{			return _sound.id3;		}				/**		 * Sets the pan of the sound playback.		 * Negative values set pan to left channel, while positive values sets pan to right channel.		 */				public function get pan():Number		{			return _soundChannel.soundTransform.pan;		}				public function set pan(value:Number):void		{						if(value < -1) value = -1;						if(value > 1) value = 1;						_soundChannel.soundTransform = new SoundTransform(_soundChannel.soundTransform.volume, value);						_pan = _soundChannel.soundTransform.pan;		}				/**		 * Returns the position of the sound playback.		 */				public function get position():Number		{			if(!_soundChannel) return 0;						return _soundChannel.position;		}				/**		 * Indicates whether the sound is currently playing.		 */				public function get playing():Boolean		{			return _playing;		}				/**		 * @inheritDoc		 */				override public function toString():String		{			return Stringifier.stringify(this);		}				/**		 * @inheritDoc		 */				public function destroy():void		{			_sound = null;						if(_soundChannelReference) _soundChannelReference.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);		}				/**		 * @inheritDoc		 */				public function clone():Object		{			var			clone:SoundPlayback = new SoundPlayback(_sound);						clone.loops = loops;						clone.seek(position);						if(playing) clone.play();						return clone;					}						/**		 * @private		 */		protected function get _soundChannel():SoundChannel		{			return _soundChannelReference;		}				protected function set _soundChannel(value:SoundChannel):void		{			if(_soundChannelReference) _soundChannelReference.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);						_soundChannelReference = value;						_soundChannelReference.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);		}				private function onSoundComplete(e:Event):void		{			var numLoopsLeft:uint = Math.max(loops - _loopRuns, 0);						if(numLoopsLeft > 0 && playing)			{				playAt(0);								dispatchEvent(new SoundPlaybackEvent(SoundPlaybackEvent.PLAYBACK_LOOP));								_loopRuns = Math.min(_loopRuns + 1, loops);				}			else			{				stop();								dispatchEvent(new SoundPlaybackEvent(SoundPlaybackEvent.PLAYBACK_COMPLETE));				}					}				}}