/** * sekati.events.FramePulse * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.events {	import flash.display.Sprite;	import flash.events.Event;	import flash.events.EventDispatcher;	/**	 * FramePulse proxies an <code>ENTER_FRAME</code> event to any non-	 * <code>DisplayObject</code> classes which need to execute code on each frame tick.	 * <pre><code>Usage:	 * FramePulse.$.addEventListener(FramePulse.FRAME_PULSE, _onEnterFrame);	 * protected function _onEnterFrame(e:Event):void {	 * 	trace( "pulse" );	 * }	 * </pre></code>	 * 	 * @see http://www.onflex.org/code/2006/09/as3-singleton-example-by-andrew-trice.html	 */	public class FramePulse extends EventDispatcher {		/**		 * @eventType onFramePulse fires each each frame.		 */		public static const FRAME_PULSE : String = "onFramePulse";		protected static var _instance : FramePulse;		protected var _pulse : Sprite;		/**		 * FramePulse Singleton Constructor		 * @param $ SingletonEnforcer internal to the AS file; this param prevents external instantiation without error.		 */		public function FramePulse($ : SingletonEnforcer = null) {			if (!$) {				throw new ArgumentError( "FramePulse is a Singleton and may only be accessed via its accessor methods: 'getInstance()' or '$'." );			}		}		/**		 * Singleton Accessor		 * @return FramePulse		 */				public static function getInstance() : FramePulse {			if(!_instance) _instance = new FramePulse( new SingletonEnforcer( ) );			return _instance;		}		/**		 * Shorthand singleton accessor getter		 * @return FramePulse		 */		public static function get $() : FramePulse {			return FramePulse.getInstance( );		}		public function addFrameListener(handler : Function) : void {			if (!_pulse) {				_pulse = new Sprite( );				}			_pulse.addEventListener( Event.ENTER_FRAME, handler );		}		public function removeFrameListener(handler : Function) : void {			if(_pulse != null) {				_pulse.removeEventListener( Event.ENTER_FRAME, handler );			}		}		/**		 * Destroy the frame pulse and singleton instance.		 */		public function destroy() : void {			_pulse.removeEventListener( Event.ENTER_FRAME, pulseDispatch );			_pulse = null;			_instance = null;		}		/**		 * Dispatches the framepulse event.		 */		protected function pulseDispatch(e : Event) : void {			dispatchEvent( new Event( FRAME_PULSE ) );		}					}}/** * Internal class is accessible only to this AS file * and is used as a constructor param to enforce * proper Singleton behavior. */internal class SingletonEnforcer {}