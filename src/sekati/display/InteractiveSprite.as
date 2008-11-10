/** * sekati.display.InteractiveSprite * @version 1.2.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.display {	import flash.events.Event;	import flash.events.MouseEvent;		import sekati.display.CoreSprite;	import sekati.events.StageEvent;		/**	 * InteractiveSprite provides a common API construct for interactive sprite objects.	 */	public class InteractiveSprite extends CoreSprite {		/*** @private */		protected var isEnabled : Boolean;		/**		 * InteractiveSprite Constructor		 */		public function InteractiveSprite() {			super( );			isEnabled = true;			interactiveMode = true;		}		/**		 * Add listeners when added to stage.		 */		override protected function onStage(e : Event = null) : void {			_this.addEventListener( MouseEvent.MOUSE_OVER, over, false, 0, true );			_this.addEventListener( MouseEvent.MOUSE_OUT, out, false, 0, true );			_this.addEventListener( MouseEvent.CLICK, click, false, 0, true );			_this.addEventListener( MouseEvent.MOUSE_DOWN, press, false, 0, true );			_this.addEventListener( MouseEvent.MOUSE_UP, release, false, 0, true );		}		/**		 * Remove the listeners when removed from the stage.		 */		override protected function offStage(e : Event = null) : void {			_this.removeEventListener( MouseEvent.MOUSE_OVER, over );			_this.removeEventListener( MouseEvent.MOUSE_OUT, out );			_this.removeEventListener( MouseEvent.CLICK, click );			_this.removeEventListener( MouseEvent.MOUSE_DOWN, press );			_this.removeEventListener( MouseEvent.MOUSE_UP, release );				Canvas.stage.removeEventListener( MouseEvent.MOUSE_UP, releaseOutside );			StageDisplay.$.removeEventListener( StageEvent.LEAVE, releaseOutside );									}		/**		 * Stub: mouse over event handler.		 */		protected function over(e : MouseEvent = null) : void {		}				/**		 * Stub: mouse out event handler.		 */		protected function out(e : MouseEvent = null) : void {		}		/**		 * Stub: click event handler.		 */		protected function click(e : MouseEvent = null) : void {		}			/**		 * Stub: press event handler. Starts release-outside simulation via 		 * <code>stage.MOUSE_UP</code> & <code>StageEvent.LEAVE</code>.		 */		protected function press(e : MouseEvent = null) : void {			Canvas.stage.addEventListener( MouseEvent.MOUSE_UP, releaseOutside, false, 0, true );			StageDisplay.$.addEventListener( StageEvent.LEAVE, releaseOutside, false, 0, true );					}				/**		 * Stub: release event handler.		 */		protected function release(e : MouseEvent = null) : void {			Canvas.stage.removeEventListener( MouseEvent.MOUSE_UP, releaseOutside );			StageDisplay.$.removeEventListener( StageEvent.LEAVE, releaseOutside );						}		/**		 * Stub: release outside event handler.		 */		protected function releaseOutside(e : Event = null) : void {			Canvas.stage.removeEventListener( MouseEvent.MOUSE_UP, releaseOutside );			StageDisplay.$.removeEventListener( StageEvent.LEAVE, releaseOutside );			}		/*** @private */		public function set enabled(b : Boolean) : void {			isEnabled = interactiveMode = b;			if(isEnabled) {				onStage( );			} else {				offStage( );			}		}		/**		 * Enabled property defines whether interactive eventing is available or not.		 */		public function get enabled() : Boolean {			return isEnabled;		}									}}