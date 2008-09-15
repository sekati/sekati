/** * sekati.display.CoreSprite * @version 1.2.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.display {	import flash.display.Sprite;	import flash.events.Event;		import sekati.core.CoreInterface;	import sekati.reflect.Stringifier;		/**	 * CoreSprite is a foundational DO class and should be thought 	 * of as one of the main visual building block of the API.	 * 	 * <p>Use CoreSprite in all but frame-based assets; else 	 * CoreClip is most appropriate.</p>	 * 	 * @see sekati.display.CoreClip	 */	public class CoreSprite extends Sprite implements CoreInterface {		protected var _this : Sprite;		/**		 * CoreSprite Constructor		 */		public function CoreSprite() {			_this = this;			addEventListener( Event.ADDED_TO_STAGE, onStage, false, 0, true );			addEventListener( Event.REMOVED_FROM_STAGE, offStage, false, 0, true );		}		/**		 * Stub: Sprite has been added to stage.		 */		protected function onStage(e : Event = null) : void {			trace( _this + " added to stage" );			}		/**		 * Stub: Sprite has been removed from stage.		 */		protected function offStage(e : Event = null) : void {			trace( _this + " removed from stage" );			}		/**		 * Clean up after thy self.		 */		public function destroy() : void {			removeEventListener( Event.ADDED_TO_STAGE, onStage );			removeEventListener( Event.REMOVED_FROM_STAGE, offStage );		}		/**		 * Return reflective output		 * @return String		 */		override public function toString() : String {			return Stringifier.stringify( _this );		}	}}