/** * sekati.profiler.PerformanceMonitor * @version 1.3.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.profiler {	import sekati.display.Canvas;	import sekati.events.FramePulse;	import sekati.log.Logger;		import flash.events.Event;	import flash.system.System;	import flash.utils.getTimer;			/**	 * PerformanceMonitor provides a visual graph to application FPS and RAM usage.	 */	final public class PerformanceMonitor {		private static var _instance : PerformanceMonitor;		private var itvTime : int;		private var initTime : int;		private var currentTime : int;		private var frameCount : int;		private var totalCount : int;		//		public var minFps : Number;		public var maxFps : Number;		public var minMem : Number;		public var maxMem : Number;		public var history : int = 60;		public var fpsList : Array = [];		public var memList : Array = [];		//		private var _isDisplaying : Boolean = false;		private var _isRunning : Boolean = false;		private var ui : PerformanceMonitorGraph;				/**		 * PerformanceMonitor Singleton Constructor		 * @param $ SingletonEnforcer - internal to the AS file; the param prevents external instantiation without error.		 * @example <listing version="3.0">		 * PerformanceMonitor.$.show(); // display the graphical UI.		 * </listing>		 */		public function PerformanceMonitor( $ : SingletonEnforcer = null) {			if (!$) {				throw new ArgumentError( "sekati.profiler.PerformanceMonitor is a Singleton and may only be accessed via its accessor methods: 'getInstance()' or '$'." );				}			init( );		}		/**		 * Singleton Accessor		 * @return PerformanceMonitor		 */		public static function getInstance() : PerformanceMonitor {			if( _instance == null ) _instance = new PerformanceMonitor( new SingletonEnforcer( ) );			return _instance;		}		/**		 * Shorthand singleton accessor getter		 * @return PerformanceMonitor		 */		public static function get $() : PerformanceMonitor {			return PerformanceMonitor.getInstance( );			}		/**		 * Initialize the monitor.		 */		private function init() : void {			ui = new PerformanceMonitorGraph( );			minFps = Number.MAX_VALUE;			maxFps = Number.MIN_VALUE;			minMem = Number.MAX_VALUE;			maxMem = Number.MIN_VALUE;				start( );		}		/**		 * Start monitoring.		 */		public function start() : void {			if(running) return;			_isRunning = true;			initTime = itvTime = getTimer( );			totalCount = frameCount = 0;			FramePulse.$.addFrameListener( draw );				}		/**		 * Stop monitoring.		 */		public function stop() : void {			if(!running) return;			_isRunning = false;			FramePulse.$.removeFrameListener( draw );					}		/**		 * Attempt to run the player garbage collector.		public function gc() : void {		GarbageCollector.run( );		}		 */		/**		 * The current FPS.		 */		public function get currentFps() : Number {			return frameCount / intervalTime;		}		/**		 * The current global flashplayer memory usage.		 */		public function get currentMem() : Number {			return (System.totalMemory / 1024) / 1000;		}		/**		 * The average FPS.		 */		public function get averageFps() : Number {			return totalCount / runningTime;		}		/**		 * The average RAM.		 */		public function get averageMem() : Number {			return (minMem + maxMem) / 2;		}				/**		 * The amount of time the monitor has been running.		 */				public function get runningTime() : Number {			return (currentTime - initTime) / 1000;		}		/**		 * The interval at which the monitor is running.		 */		public function get intervalTime() : Number {			return (currentTime - itvTime) / 1000;		}		/**		 * Show the graph UI.		 */ 		public function show() : void {			Logger.$.info( this, "Displaying Monitor Graph UI." );			_isDisplaying = true;			Canvas.stage.addChild( ui );			updateDisplay( );		}		/**		 * Hide the graph UI.		 */		public function hide() : void {			Logger.$.info( this, "Hiding Monitor Graph UI." );			_isDisplaying = false;			Canvas.stage.removeChild( ui );		}		/**		 * Toggle the graph UI visibility.		 */		public function toggleDisplay() : void {			if(displaying) {				hide( );			} else {				show( );			}		}		/**		 * Draw in to the graph.		 */		private function draw(e : Event) : void {			currentTime = getTimer( );						//trace( "currentTime: " + currentTime + " / totalTime: " + initTime );			frameCount++;			totalCount++;			if(intervalTime >= 1) {				if(_isDisplaying) {					updateDisplay( );				} else {					updateMinMax( );				}								fpsList.unshift( currentFps );				memList.unshift( currentMem );								if(fpsList.length > history) fpsList.pop( );				if(memList.length > history) memList.pop( );								itvTime = currentTime;				frameCount = 0;			}		}		/**		 * Update the display & monitoring values.		 */		public function updateDisplay() : void {			updateMinMax( );			ui.update( );		}		/**		 * Update the monitoring values only.		 */		public function updateMinMax() : void {			minFps = Math.min( currentFps, minFps );			maxFps = Math.max( currentFps, maxFps );							minMem = Math.min( currentMem, minMem );			maxMem = Math.max( currentMem, maxMem );		}		/**		 * Determines whether the monitor is being displayed.		 */		public function get displaying() : Boolean {			return _isDisplaying;		}		/**		 * Determines whether the monitor is running or not.		 */		public function get running() : Boolean {			return _isRunning;		}			}}/** * Internal class is accessible only to this AS file and is used  * as a constructor param to enforce proper Singleton behavior. */internal class SingletonEnforcer {}		