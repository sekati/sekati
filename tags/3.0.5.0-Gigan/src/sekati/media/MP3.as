/** * sekati.media.MP3 * @version 1.5.2 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.media {	import sekati.events.FramePulse;	import sekati.events.MediaEvent;	import sekati.log.Logger;	import sekati.validators.FileTypeValidator;	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.events.IOErrorEvent;	import flash.media.Sound;	import flash.media.SoundChannel;	import flash.media.SoundLoaderContext;	import flash.media.SoundTransform;	import flash.net.URLRequest;		/**	 * MP3 provides a common media control object for playing <i>progressive</i> audio content. 	 * Acceptable file types are defined in <code>FileTypeValidator.IS_AUDIO</code>.	 * @example <listing version="3.0">	 * 		var mp3 : MP3 = new MP3( );	 * 		mp3.load( "path/to/song.mp3" );	 * 		mp3.play( );	 * </listing>	 * @see sekati.ui.MP3Player	 * @see sekati.events.MediaEvent	 */	public class MP3 extends EventDispatcher implements IProgressiveMedia {		/*** @private */		protected var _sound : Sound;		/*** @private */		protected var _channel : SoundChannel;		/*** @private */		protected var _transform : SoundTransform;		/*** @private */		protected var _context : SoundLoaderContext;		/*** @private */		protected var _lastSeekableTime : Number;		/*** @private */		protected var _isPaused : Boolean;		/*** @private */		protected var _isStarted : Boolean;		/*** @private */		protected var _isBufferPause : Boolean;			/*** @private */		protected var _bufferTime : Number;					/*** @private */		protected var _url : String;		/**		 * MP3 Constructor		 */		public function MP3() {			super( );			_sound = new Sound( );			_transform = new SoundTransform( );			_lastSeekableTime = 0;			_isPaused = false;			_isStarted = false;		}		/**		 * Load the audio and begin playback.		 * @param url 		of the audio file.		 * @param buffer 	in seconds		 * @throws 			ArgumentError if <code>url</code> is not audio type.		 */		public function load(url : String, buffer : uint = 4) : void {			if(!FileTypeValidator.isAudio( url )) {				throw new ArgumentError( "MP3.load() Argument Error: '" + url + "' is not a valid audio file type according to FileTypeValidator.IS_AUDIO." );			}			_url = url;			_bufferTime = buffer;			_context = new SoundLoaderContext( (buffer * 1000), false );			_sound.addEventListener( Event.COMPLETE, loadCompleteHandler, false, 0, true );			_sound.addEventListener( Event.ID3, id3Handler, false, 0, true );			_sound.addEventListener( IOErrorEvent.IO_ERROR, errorHandler, false, 0, true );			_sound.load( new URLRequest( _url ), _context );			play( );			stop( );						FramePulse.$.addFrameListener( progressHandler );			_isStarted = true;		}		// BASIC CONTROLS				/**		 * Start playback.		 */				public function play() : void {			_isStarted = true;			_channel = _sound.play( 0, 0, _transform );			_channel.addEventListener( Event.SOUND_COMPLETE, playCompleteHandler, false, 0, true );			_channel.soundTransform = _transform;			dispatchEvent( new MediaEvent( MediaEvent.START, "start" ) );		}		/**		 * Stop playback.		 */		public function stop() : void {			_channel.stop( );			_channel.removeEventListener( Event.SOUND_COMPLETE, playCompleteHandler );			_isStarted = false;			_isPaused = false;				}		/**		 * Pause playback.		 */		public function pause() : void {			if (!_isPaused && _isStarted) {				_isPaused = true;				_lastSeekableTime = position;				_channel.stop( );				_channel.removeEventListener( Event.SOUND_COMPLETE, playCompleteHandler );			}					}		/**		 * Resume playback.		 */		public function resume() : void {			if (_isPaused && _isStarted) {				_isPaused = false;				_channel.stop( );				_channel = sound.play( _lastSeekableTime, 0, _transform );				_channel.addEventListener( Event.SOUND_COMPLETE, playCompleteHandler, false, 0, true );			}				}		/**		 * Pause/Resume playback toggle.		 */		public function togglePause() : void {			_isPaused ? resume( ) : pause( );		}		/**		 * Seek to a playback time.		 * @param time 		in playback to seek to.		 */		public function seek(time : Number) : void {			if((time / duration) < percentLoaded) {				_lastSeekableTime = position;				_channel.stop( );				_channel.removeEventListener( Event.SOUND_COMPLETE, playCompleteHandler );				_channel = _sound.play( time, 0, _transform );				_channel.addEventListener( Event.SOUND_COMPLETE, playCompleteHandler, false, 0, true );			}		}		/**		 * Seek to a playback percent (0 - 1).		 * @param percent 	of playback to seek to.		 */		public function seekToPercent(percent : Number) : void {			seek( duration * percent );		}		/**		 * Fast-Forward playback.		 * @param seconds 		to step forward.		 */		public function fastForward(seconds : Number = 2) : void {			seek( position + seconds );		}		/**		 * Rewind playback.		 * @param seconds 		to step back.		 */		public function rewind(seconds : Number = 2) : void {			seek( position - seconds );		}		/**		 * Stop playback and cleanup.		 */		public function destroy() : void {			stop( );			FramePulse.$.removeFrameListener( progressHandler );			_channel.removeEventListener( Event.SOUND_COMPLETE, playCompleteHandler );					_sound.removeEventListener( Event.COMPLETE, loadCompleteHandler );			_sound.removeEventListener( Event.ID3, id3Handler );			_sound.removeEventListener( IOErrorEvent.IO_ERROR, errorHandler );		}		// HELPERS				/**		 * Handle buffer externally to <code>ns.bufferTime</code> so we can achieve proper cuePoint timing.		 */		protected function checkBuffer() : void {			// we're outta buffer ...			if(percentLoaded <= percentPlayed) {				// video has finished loading				if(percentLoaded >= 1) return; 				// pause playback				if(!_isBufferPause) {					dispatchEvent( new MediaEvent( MediaEvent.REBUFFER ) );					_isBufferPause = true;				}			} else if(percentLoaded >= percentPlayedWithBuffer) {				// resume playback				if(_isBufferPause) {					_isBufferPause = false;					dispatchEvent( new MediaEvent( MediaEvent.REBUFFER_COMPLETE ) );				}			}		}				// HANDLERS		/**		 * Playback progress handler.		 */		protected function progressHandler(e : Event) : void {			//Logger.$.trace( this, "Progress: played: " + percentPlayed + "% / loaded: " + percentLoaded + "%" );			dispatchEvent( new MediaEvent( MediaEvent.PROGRESS, null, percentLoaded, percentPlayed ) );			checkBuffer( );		}		/**		 * playback complete handler.		 */		protected function playCompleteHandler(e : Event) : void {			dispatchEvent( new MediaEvent( MediaEvent.COMPLETE, "complete" ) );		}		/**		 * ID3 tag handler.		 */		protected function id3Handler(e : Event) : void {			dispatchEvent( new MediaEvent( MediaEvent.ID3, null, NaN, NaN, null, null, sound.id3 ) );			Logger.$.object( sound.id3 );			Logger.$.info( this, "ID3 tag:" );		}		/**		 * Load complete handler		 */		protected function loadCompleteHandler(e : Event) : void {			dispatchEvent( new MediaEvent( MediaEvent.BUFFER_FLUSH ) );		}		/**		 * Error handler.		 */		protected function errorHandler(e : IOErrorEvent) : void {			Logger.$.error( this, "IOError (STREAM_NOT_FOUND): " + e.text );			dispatchEvent( new MediaEvent( MediaEvent.STREAM_NOT_FOUND, "play_streamNotFound" ) );		}		// GETTERS & SETTERS		/**		 * Paused status.		 */		public function get isPaused() : Boolean {			return _isPaused;		}		/**		 * Buffering status.		 */		public function get isBuffering() : Boolean {			//return _sound.isBuffering;			return (_sound.isBuffering || _isBufferPause) ? true : false;		}		/**		 * Playing status.		 */		public function get isPlaying() : Boolean {			return _isStarted;		}		/**		 * Stopped status.		 */		public function get isStopped() : Boolean {			return !_isStarted;		}		/**		 * The position of the playhead, in seconds.		 */		public function get position() : Number {			return _channel.position;		}				/**		 * The total playback duration, in seconds.		 */		public function get duration() : Number {			return _sound.length;		}		/**		 * Amount of play-ahead buffer, in seconds.		 */		public function get bufferLength() : Number {			var percentBuffered : Number = (percentLoaded - percentPlayed);			return (duration * percentBuffered);		}		/**		 * Return the percent played (1 based %). 		 */		public function get percentPlayed() : Number {			return (_channel.position / _sound.length);		}		/**		 * The percent of the movie that <i>should be</i> currently buffered.		 * @see #checkBuffer()		 */		public function get percentPlayedWithBuffer() : Number {			//trace("position: " + position +" ,bufferTime: " + _bufferTime + ", duration: " + _duration);			return ((position + _bufferTime) / duration);		}				/**		 * Return the percent loaded (1 based %).		 */		public function get percentLoaded() : Number {			return ( _sound.bytesLoaded / _sound.bytesTotal );		}		// AUDIO GETTER & SETTERS				/**		 * The <code>Sound</code>.		 */		public function get sound() : Sound {			return _sound;		}		/**		 * The <code>SoundChannel</code>.		 */				public function get channel() : SoundChannel {			return _channel;		}		/**		 * The <code>SoundTransform</code>.		 */		public function get transform() : SoundTransform {			return _transform;		}			/***		 * The <code>Sound</code> url.		 */		public function get url() : String {			return _url;		}		/**		 * The <code>Sound</code> volume (0 - 1).		 */		public function get volume() : Number {			return _channel.soundTransform.volume;		}		/*** @private */		public function set volume(volume : Number) : void {			_transform.volume = volume;			_channel.soundTransform = _transform;			}		/**		 * The <code>Sound</code> pan. (0 = balanced, -1 = left, 1 = right).		 */		public function get pan() : Number {			return _transform.pan;		}		/*** @private */		public function set pan(pan : Number) : void {			_transform.pan = pan;			_channel.soundTransform = _transform;			}	}}