/** * sekati.ui.FLVPlayer * @version 1.4.0 * @author jason m horwitz & steve baughman | sekati.com * Copyright (C) 2008-2009 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.ui {	import sekati.converters.BoolConverter;		import sekati.events.MediaEvent;	import sekati.media.FLV;	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.events.Event;	import flash.media.Video;		/**	 * FLVPlayer provides playback control interface logic to be used with sekati.media.FLV.	 * 	 * <p>To implement pass references to UI controller instances to the <code>FLVPlayer</code> 	 * constructor, instantiate the FLVPlayer instance & <code>addChild( myFLVPlayerInstance )</code> 	 * to attach the sprite-wrapped <code>Video</code>.</p>	 * 	 * @example <listing version="3.0">	 * var player : FLVPlayer = new FLVPlayer( player.playBtn, player.progressBar, player.bufferBar, player.gutterBar, player.volumeBtn );	 * player.x = player.y = 10;	 * addChild( player ); // adds a sprite-wrapped video instance.	 * player.init( 'path/to/my.flv' );	 * </listing>	 * 	 * @see sekati.media.FLV	 * @see sekati.events.MediaEvent	 */	public class FLVPlayer extends AbstractMediaPlayer {		protected var _video : Video;		protected var _currentCuePoint : Object;		protected var _width : uint;		protected var _height : uint;		protected var _smoothing : Boolean;		/**		 * FLVPlayer Constructor		 */		public function FLVPlayer(playBtn : MovieClip, progressBar : Sprite, bufferBar : Sprite, gutterBar : Sprite, volumeBtn : Sprite) {			super( playBtn, progressBar, bufferBar, gutterBar, volumeBtn );		}		// CORE CONTROLS				/**		 * Load video and initialize FLVPlayer UI and FLV core.		 * @param url 		of flv video.		 * @param buffer 	in seconds.		 * @param width 	of video.		 * @param height 	of video.		 * @param smoothing of video.		 */		override public function init(url : String, buffer : uint = 4, ...args) : void {			_width = (!isNaN( int( args[0] ) )) ? int( args[0] ) : 320;			_height = (!isNaN( int( args[1] ) )) ? int( args[1] ) : 240;			_smoothing = (args[2] == null) ? true : BoolConverter.toBoolean( args[2] );			super.init( url, buffer );		}		/**		 * @inheritDoc		 */		override protected function addMedia() : void {			_media = new FLV( _width, _height, _smoothing );			_video = _media['video'];			addChild( _video );		}		/**		 * @inheritDoc		 */		override protected function addMediaListeners() : void {			_media.addEventListener( MediaEvent.PROGRESS, movieProgressHandler, false, 0, true );			_media.addEventListener( MediaEvent.START, movieStatusHandler, false, 0, true );			_media.addEventListener( MediaEvent.STOP, movieStatusHandler, false, 0, true );			_media.addEventListener( MediaEvent.STREAM_NOT_FOUND, movieStatusHandler, false, 0, true );			_media.addEventListener( MediaEvent.REBUFFER, movieStatusHandler, false, 0, true );			_media.addEventListener( MediaEvent.REBUFFER_COMPLETE, movieStatusHandler, false, 0, true );			_media.addEventListener( MediaEvent.METADATA, movieStatusHandler, false, 0, true );			_media.addEventListener( MediaEvent.CUE_POINT, movieStatusHandler, false, 0, true );			_media.addEventListener( MediaEvent.REBUFFER, movieBufferPause, false, 0, true );			_media.addEventListener( MediaEvent.REBUFFER_COMPLETE, movieBufferResume, false, 0, true );			_media.addEventListener( MediaEvent.CUE_POINT, movieCuePointHandler, false, 0, true );		}		/**		 * @inheritDoc		 */		override protected function removeMediaListeners() : void {			_media.removeEventListener( MediaEvent.PROGRESS, movieProgressHandler );			_media.removeEventListener( MediaEvent.START, movieStatusHandler );			_media.removeEventListener( MediaEvent.STOP, movieStatusHandler );			_media.removeEventListener( MediaEvent.STREAM_NOT_FOUND, movieStatusHandler );			_media.removeEventListener( MediaEvent.REBUFFER, movieStatusHandler );			_media.removeEventListener( MediaEvent.REBUFFER_COMPLETE, movieStatusHandler );			_media.removeEventListener( MediaEvent.METADATA, movieStatusHandler );			_media.removeEventListener( MediaEvent.CUE_POINT, movieStatusHandler );			_media.removeEventListener( MediaEvent.REBUFFER, movieBufferPause );			_media.removeEventListener( MediaEvent.REBUFFER_COMPLETE, movieBufferResume );			_media.removeEventListener( MediaEvent.CUE_POINT, movieCuePointHandler );		}			// MOVIE HANDLERS					/**		 * Cuepoint Handler.		 */		protected function movieCuePointHandler(e : MediaEvent) : void {			_currentCuePoint = e.cuePointData;			// if seeking don't report cuepoint info			if(_isDrag || _isSeeking) return;			dispatchEvent( new MediaEvent( MediaEvent.CUE_POINT_DISPLAY, null, NaN, NaN, null, currentCuePoint ) );		}		/**		 * When playhead enters area that needs buffering, pause video if playing.		 */		protected function movieBufferPause(e : Event) : void {			if (_media.isPaused) {				isBufferPaused = false;			} else {				pause( );				isBufferPaused = true;			}		}		/**		 * When movie has finished buffering check to see if movie was paused to allow for buffering		 * if it was restart, if not, do nothing. This prevents the video from restarting if it was 		 * user paused, and then playhead dragged into buffering area.		 */		protected function movieBufferResume(e : Event) : void {			if (isBufferPaused) {				isBufferPaused = false;				resume( );			}		}		/**		 * Handle <code>FLV</code> movie progress events. 		 */		protected function movieProgressHandler(e : MediaEvent) : void {			//trace( "movie_onProgress - loaded:" + e.loaded + " played:" + e.played );			bufferBarPercent = e.loaded;			if (!_isSeeking) {				progressBarPercent = e.played;			} else {				_media.seekToPercent( progressBarPercent );			}					}		/**		 * Handle <code>FLV</code> movie status events.		 * 		 * <p>It is best to extend and override this class method to implement your own switch/case code.</p>		 */		protected function movieStatusHandler(e : MediaEvent) : void {			switch (e.code) {				case MediaEvent.BUFFER_EMPTY :					trace( "FLVPlayer-> movieEvent: bufferEmpty" );					break;				case MediaEvent.BUFFER_FULL :					trace( "FLVPlayer-> movieEvent: bufferFull" );					break;				case MediaEvent.BUFFER_FLUSH :					trace( "FLVPlayer-> movieEvent: bufferFlush" );					break;				case MediaEvent.START :					trace( "FLVPlayer-> movieEvent: start" );					break;				case MediaEvent.STOP :					trace( "FLVPlayer-> movieEvent: stop" );					//Logger.$.notice( this, "FLV Completed Playback." );					if(_media.isPlaying) playBtnClick( );					break;				case MediaEvent.STREAM_NOT_FOUND :					trace( "FLVPlayer-> movieEvent: play_streamNotFound" );					break;				case MediaEvent.SEEK_INVALID_TIME :					trace( "FLVPlayer-> movieEvent: seek_invalidTime" );					_media.rewind( );					break;				case MediaEvent.SEEK_NOTIFY:					trace( "FLVPlayer-> movieEvent: seek_notify" );					break;				case MediaEvent.REBUFFER:					trace( "FLVPlayer-> movieEvent: rebuffer" );					break;				case MediaEvent.REBUFFER_COMPLETE:					trace( "FLVPlayer-> movieEvent: rebufferComplete" );					break;					case MediaEvent.METADATA:					trace( "FLVPlayer-> movieEvent: metaData" );					break;				case MediaEvent.CUE_POINT:					trace( "FLVPlayer-> movieEvent: cuePoint" );					if(!_isDrag || !_isSeeking) {						dispatchEvent( new MediaEvent( MediaEvent.CUE_POINT_DISPLAY, null, NaN, NaN, null, e.cuePointData ) );					}					break;														default :					trace( "FLVPlayer-> movieEvent: unrecognized onStatus value: " + e.code + " :: " + e.type );			}					}		// EVENT HANDLERS		/**		 * Returns reference to current cue point data object.		 */		public function get currentCuePoint() : Object {			return _currentCuePoint;		}		/**		 * The <code>FLV</code> being played.		 */		public function get movie() : FLV {			return _media as FLV;		}		/**		 * The <code>Video</code> instance.		 */		public function get video() : Video {			return movie.video;		}	}}