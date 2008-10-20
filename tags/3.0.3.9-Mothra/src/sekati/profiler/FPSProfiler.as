/** * sekati.profiler.FPSProfiler * @version 1.0.2 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.profiler {	import sekati.events.FramePulse;	import flash.utils.getTimer;	import flash.events.Event;		/**	 * FPSProfiler provides FPS trending.	 */	public class FPSProfiler {		/**		 * Value of Upward FPS Trending.		 */		public const UPTREND : int = 1;		/**		 * Value of Downward FPS Trending.		 */		public const DOWNTREND : int = 0;		protected var _updateEveryFrame : uint;			protected var _frame : int;		protected var _currentFps : int;		protected var _currentTrend : int;		protected var _averageFps : int;		protected var _averageTrend : int;		protected var _now : int;		/**		 * FPSProfiler Constructor		 */		public function FPSProfiler(updateEveryFrame : uint = 1, autostart : Boolean = true) {			_frame = 1;			_updateEveryFrame = updateEveryFrame;			if (autostart) {				start( );				}		}		/**		 * Start FPS profiling.		 */		public function start() : void {			_now = getTimer( );			FramePulse.$.addFrameListener( _enterFrame );		}		/**		 * Stop FPS profiling.		 */		public function stop() : void {			FramePulse.$.removeFrameListener( _enterFrame );			}		/**		 * @private		 */		private function _enterFrame(e : Event) : void {			if(_frame % _updateEveryFrame == 0) {				var current : Number = Math.round( 1000 / (getTimer( ) - _now) );				_currentTrend = (current >= _currentFps) ? UPTREND : DOWNTREND;				_currentFps = current;				_now = getTimer( );				var average : Number = Math.round( (_frame / (_now / 1000)) );				_averageTrend = (average >= _averageFps) ? UPTREND : DOWNTREND;					_averageFps = average;								var ctrend : String = (_currentTrend == UPTREND) ? "+" : "-";				var atrend : String = (_averageTrend == UPTREND) ? "+" : "-";				trace( "FPSProfiler > current: " + _currentFps + " (" + ctrend + ")" + " ::: average: " + _averageFps + "(" + atrend + ")" );			}			_frame++;		}				/**		 * Return a snapshot of the application's current/average FPS with trending information.		 */				public function snapshot() : String {			var ctrend : String = (_currentTrend == UPTREND) ? "+" : "-";			var atrend : String = (_averageTrend == UPTREND) ? "+" : "-";						return ( "FPSProfiler > current: " + _currentFps + " (" + ctrend + ")" + " ::: average: " + _averageFps + "(" + atrend + ")" );		}		/**		 * Return the current FPS.		 */		public function get currentFPS() : int {			return _currentFps;			}		/**		 * Return the average FPS.		 */		public function get averageFPS() : int {			return _currentFps;			}		/**		 * Return the current FPS Trend.		 */		public function get currentTrend() : int {			return _currentTrend;			}		/**		 * Return the average FPS Trend.		 */		public function get averageTrend() : int {			return _currentTrend;			}			}}