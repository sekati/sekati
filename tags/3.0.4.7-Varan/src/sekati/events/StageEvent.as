/** * sekati.events.StageEvent * @version 1.2.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */ package sekati.events {	import flash.events.Event;		/**	 * StageEvent provides advanced Stage event notification.	 */	public class StageEvent extends Event {		/**		 * @eventType stageFullscreen fires when the stages fullscreen state changes.		 */				public static const FULLSCREEN : String = "stageFullscreen";		/**		 * @eventType stageResize fires when the stage resizes.		 */		public static const RESIZE : String = "stageResize";				/**		 * @eventType stageResizeComplete fires when the stage is finished resizing.		 */				public static const RESIZE_COMPLETE : String = "stageResizeComplete";						/**		 * @eventType stageLeave fires when the mouse leaves the stage.		 */		public static const LEAVE : String = "stageLeave";		/**		 * @eventType stageLeaveComplete fires when the mouse leaves the stage and remains out.		 */		public static const LEAVE_COMPLETE : String = "stageLeaveComplete";		/**		 * @eventType stageActivate fires when the application player gains system focus.		 */		public static const ACTIVATE : String = "stageActivate";				/**		 * @eventType stageDeactivate fires when the application player loses system focus.		 */		public static const DEACTIVATE : String = "stageDeactivate";		/**		 * @eventType stageMouseIdle fires when the users mouse remains idle for the <code>StageDisplay</code> defined period of time.		 */		public static const MOUSE_IDLE : String = "stageMouseIdle";				/**		 * @eventType stageMouseResume fires when the users mouse resumes activity.		 */		public static const MOUSE_RESUME : String = "stageMouseResume";			/**		 * StageEvent Constructor		 */		public function StageEvent(type : String, bubbles : Boolean = true, cancelable : Boolean = false) {			super( type, bubbles, cancelable );		}		/**		 * @inheritDoc		 */		override public function clone() : Event {			return new StageEvent( type, bubbles, cancelable );		}						}}