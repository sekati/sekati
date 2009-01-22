/** * sekati.ui.AbstractMediaPlayer * @version 1.5.2 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.ui {	import sekati.display.LiquidSprite;	import sekati.events.MediaEvent;	import sekati.events.StageEvent;	import sekati.math.MathBase;	import sekati.media.IProgressiveMedia;	import sekati.utils.TypeEnforcer;	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.events.MouseEvent;		/**	 * AbstractMediaPlayer provides abstract player control logic for audio/video players and the likes.	 */	public class AbstractMediaPlayer extends LiquidSprite {		protected var _media : IProgressiveMedia;		protected var _isDrag : Boolean;		protected var _isSeeking : Boolean;		protected var _wasPlaying : Boolean;		protected var _playBtn : MovieClip;		protected var _progressBar : Sprite;		protected var _bufferBar : Sprite;		protected var _gutterBar : Sprite;		protected var _volumeBtn : Sprite;		protected var _isBufferPaused : Boolean;		/**		 * AbstractMediaPlayer Constructor		 * @param playBtn 		reference to play UI control.		 * @param progressBar	reference to progress UI to control.		 * @param bufferBar 	reference to buffer UI control.		 * @param gutterBar		reference to gutter UI to control.		 * @param volumeBtn 	reference to volume UI to control.		 */		public function AbstractMediaPlayer(playBtn : MovieClip, progressBar : Sprite, bufferBar : Sprite, gutterBar : Sprite, volumeBtn : Sprite) {			super( );						TypeEnforcer.enforceAbstract( this, AbstractMediaPlayer );						_playBtn = playBtn;			_progressBar = progressBar;			_bufferBar = bufferBar;			_gutterBar = gutterBar;			_volumeBtn = volumeBtn;			_isDrag = false;			_isSeeking = false;			_wasPlaying = false;						_progressBar.mouseEnabled = false;			_bufferBar.width = 0;			_progressBar.width = 0;			_playBtn.buttonMode = true;			_volumeBtn.buttonMode = true;			_bufferBar.buttonMode = true;							addUIListeners( );							}		// CORE CONTROLS				/**		 * Load and initialize the player UI and <code>IProgressiveMedia</code>.		 * @param url 		of <code>IProgressiveMedia</code> to be played.		 * @param buffer	in seconds.		 */		public function init(url : String, buffer : uint = 4) : void {			remove( );			setPauseIcon( );			createMedia( );			addMediaListeners( );			_media.load( url, buffer );			_media.play( );		}		/**		 * Remove the <code>IProgressiveMedia</code> from player.		 */		public function remove() : void {			if (_media) {				removeMediaListeners( );				_media.destroy( );				_media = null;				reset( );			}					}		/**		 * Reset the interface.		 */		public function reset() : void {			_bufferBar.width = 0;			_progressBar.width = 0;			setPlayIcon( );			}		/**		 * Pause playback		 */		public function pause() : void {			if (_media) {				setPlayIcon( );				_media.pause( );			}		}		/**		 * Resume playback		 */		public function resume() : void {			if (_media) {				setPlayIcon( );				_media.resume( );			}		}		/**		 * Core video volume driver.		 */		public function setVolume(percent : Number = NaN) : void {			var ov : Number = (!isNaN( percent )) ? percent : MathBase.clamp( ( _volumeBtn.mouseX / _volumeBtn.width ), 0, 1 );			var v : Number = MathBase.clamp( ov, 0, 1 );			_volumeBtn['vbar'].scaleX = v;			_media.volume = v;			//trace( "Volume: " + v );		}				/**		 * @inheritDoc		 */		override public function destroy() : void {			removeUIListeners( );			removeMediaListeners( );			_media.destroy( );			super.destroy( );		}			/**		 * @inheritDoc		 */		override protected function resize(e : StageEvent = null) : void {			super.resize( e );		}			// LISTENER & MEDIA STUBS				/**		 * Instantiate <code>IProgressiveMedia</code> (<i>stub</i>).		 */		protected function createMedia() : void {		}		/**		 * Add <code>MediaEvent.PROGRESS</code> & other <code>IProgressiveMedia</code> events.		 */		protected function addMediaListeners() : void {			_media.addEventListener( MediaEvent.PROGRESS, progressHandler, false, 0, true );			_media.addEventListener( MediaEvent.REBUFFER, bufferPause, false, 0, true );			_media.addEventListener( MediaEvent.REBUFFER_COMPLETE, bufferResume, false, 0, true );					}			/**		 * Remove <code>MediaEvent.PROGRESS</code> & other <code>IProgressiveMedia</code> events.		 */		protected function removeMediaListeners() : void {			_media.removeEventListener( MediaEvent.PROGRESS, progressHandler );			_media.removeEventListener( MediaEvent.REBUFFER, bufferPause );			_media.removeEventListener( MediaEvent.REBUFFER_COMPLETE, bufferResume );						}				/**		 * Add UI listers.		 */		protected function addUIListeners() : void {			_playBtn.addEventListener( MouseEvent.CLICK, playBtnClick, false, 0, true );			_volumeBtn.addEventListener( MouseEvent.MOUSE_DOWN, volumeBtnDown, false, 0, true );			_volumeBtn.addEventListener( MouseEvent.MOUSE_UP, volumeBtnUp, false, 0, true );			_volumeBtn.addEventListener( MouseEvent.MOUSE_MOVE, volumeBtnMove, false, 0, true );			_bufferBar.addEventListener( MouseEvent.MOUSE_DOWN, bufferBarDown, false, 0, true );			_bufferBar.addEventListener( MouseEvent.MOUSE_UP, bufferBarUp, false, 0, true );			_bufferBar.addEventListener( MouseEvent.MOUSE_MOVE, bufferBarMove, false, 0, true );		}		/**		 * Remove UI listers.		 */		protected function removeUIListeners() : void {			_playBtn.removeEventListener( MouseEvent.CLICK, playBtnClick );			_volumeBtn.removeEventListener( MouseEvent.MOUSE_DOWN, volumeBtnDown );			_volumeBtn.removeEventListener( MouseEvent.MOUSE_UP, volumeBtnUp );			_volumeBtn.removeEventListener( MouseEvent.MOUSE_MOVE, volumeBtnMove );			_bufferBar.removeEventListener( MouseEvent.MOUSE_DOWN, bufferBarDown );			_bufferBar.removeEventListener( MouseEvent.MOUSE_UP, bufferBarUp );			_bufferBar.removeEventListener( MouseEvent.MOUSE_MOVE, bufferBarMove );					}		// PLAYER DRIVERS				/**		 * Pause video in memory and track state.		 */		protected function pauseMemory() : void {			_wasPlaying = _media.isPaused;			_media.pause( );		}		/**		 * Resume video from member and release state.		 */		protected function resumeMemory() : void {			if (!_wasPlaying) {				_media.resume( );			}			_wasPlaying = false;		}		/**		 * Use guttBar to prevent seek offset inaccuracy while still buffering.		 */		protected function seekUI() : void {			if (_isSeeking) {				//var percent : Number = MathBase.clamp( ((_gutterBar.mouseX - 2) / (_gutterBar.width - 2)), .01, 1 );				var percent : Number = MathBase.clamp( (_gutterBar.mouseX / _gutterBar.width), 0, 0.99 );								// CC - works in liquid				//var percent : Number = MathBase.clamp( ((_gutterBar.stage.mouseX - _gutterBar.x) / _gutterBar.width), 0, 0.99 );								//var percent : Number = MathBase.clamp( ((Canvas.stage.mouseX - _gutterBar.x) / _gutterBar.width), 0, 0.99 );				//var percent : Number = MathBase.clamp( ((_gutterBar.stage.mouseX - _gutterBar.x) / _gutterBar.width), 0, 0.99 );				progressBarPercent = percent;				//trace( "@seekUI: " + percent + "% | bufferPercent: " + bufferBarPercent + "%" );			}		}			/**		 * Set the <code>_playBtn</code> icon "paused".		 */		protected function setPauseIcon() : void {			_playBtn.gotoAndStop( 'pause' );		}		/**		 * Set the <code>_playBtn</code> icon "played".		 */		protected function setPlayIcon() : void {			_playBtn.gotoAndStop( 'play' );		}				// MEDIA EVENT HANDLER STUBS		/**		 * When playhead enters area that needs buffering, pause the <code>IProgressiveMedia</code> if playing.		 */		protected function bufferPause(e : MediaEvent) : void {			if (_media.isPaused) {				_isBufferPaused = false;			} else {				pause( );				_isBufferPaused = true;			}		}		/**		 * When <code>IProgressiveMedia</code> has finished buffering check to see if media was paused to allow for buffering		 * if it was restart, if not, do nothing. This prevents the media from restarting if it was  user paused, and then 		 * playhead dragged into buffering area.		 */		protected function bufferResume(e : MediaEvent) : void {			if (_isBufferPaused) {				_isBufferPaused = false;				resume( );			}		}		/**		 * Handle <code>MediaEvent.PROGRESS</code> event: update the buffer and progress bars.		 */		protected function progressHandler(e : MediaEvent) : void {			//trace( "movieProgressHandler - loaded:" + e.loaded + " played:" + e.played );			bufferBarPercent = e.loaded;			if (!_isSeeking) {				progressBarPercent = e.played;			} else {				_media.seekToPercent( progressBarPercent );			}						}		/**		 * Handle & <b>re-dispatch</b> the <code>MediaEvent</code> status events (<i>since 		 * <code>AbstractMediaPlayer</code> subclasses have the option of being added to 		 * stage and bubbling these events unlike <code>IProgressiveMedia</code> classes</i>).		 * 		 * <p>It is best to implement your own switch/case subclass code for granular event responses.</p>		 */		protected function statusHandler(e : MediaEvent) : void {			dispatchEvent( e );		}		// UI EVENT HANDLERS				/**		 * Toggle the framed <code>_playBtn</code> icon and pause/resume playback.		 */		protected function playBtnClick(e : MouseEvent = null) : void {			if (_media) {				if (_playBtn.currentLabel == "play") {					setPauseIcon( );					_media.pause( );				} else {					setPlayIcon( );					_media.resume( );				}			}					}		/**		 * <code>_bufferBar</code> pressed: being seeking.		 */		protected function bufferBarDown(e : MouseEvent) : void {			_isSeeking = true;			seekUI( );			pauseMemory( );			_bufferBar.stage.addEventListener( MouseEvent.MOUSE_UP, bufferBarUp, false, 0, true );			}		/**		 * <code>_bufferBar</code> released: stop seeking.		 */		protected function bufferBarUp(e : MouseEvent) : void {			_isSeeking = false;			resumeMemory( );			_bufferBar.stage.removeEventListener( MouseEvent.MOUSE_UP, bufferBarUp );					}		/**		 * <code>_bufferBar</code> scrubbing: seek.		 */		protected function bufferBarMove(e : MouseEvent) : void {			seekUI( );		}		/**		 * <code>_volumeBtn</code> pressed: begin volume control.		 */		protected function volumeBtnDown(e : MouseEvent) : void {			_isDrag = true;			setVolume( );			_volumeBtn.stage.addEventListener( MouseEvent.MOUSE_UP, volumeBtnUp, false, 0, true );					}		/**		 * <code>_volumeBtn</code> released: end volume control.		 */		protected function volumeBtnUp(e : MouseEvent) : void {			_isDrag = false;			_volumeBtn.stage.removeEventListener( MouseEvent.MOUSE_UP, volumeBtnUp );				}		/**		 * <code>_volumeBtn</code> scrubbing: change volume.		 */		protected function volumeBtnMove(e : MouseEvent) : void {			if (_isDrag) {				setVolume( );			}					}		/**		 * Buffer bar scale percent (0-1).		 */		public function get bufferBarPercent() : Number {			return _bufferBar.width / _gutterBar.width;		}		/*** @private */		public function set bufferBarPercent(p : Number) : void {			_bufferBar.width = Math.round( _gutterBar.width * MathBase.clamp( p, 0, 1 ) );		}		/**		 * Progress bar scale percent (0-1).		 */		public function get progressBarPercent() : Number {			return _progressBar.width / _gutterBar.width;		}		/*** @private */		public function set progressBarPercent(p : Number) : void {			_progressBar.width = Math.round( _gutterBar.width * MathBase.clamp( p, 0, 1 ) );		}		/**		 * The <code>IProgressiveMedia</code> being played.		 */		public function get media() : IProgressiveMedia {			return (_media != null) ? _media : null;		}	}}