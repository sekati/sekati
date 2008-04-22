/** * sekati.display.CoreClip * @version 1.1.1 * @author jason m horwitz | sekati.com | tendercreative.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.display {	import flash.display.MovieClip;	import flash.events.Event;		import sekati.core.CoreInterface;	import sekati.reflect.Stringifier;		/**	 * CoreClip is a foundational DO class and should be thought 	 * of as one of the main visual building block of the API.	 * 	 * <p>Use CoreClip for frame-based assets; else 	 * CoreSprite is most appropriate.</p>	 * 	 * @see sekati.display.CoreSprite	 */	public class CoreClip extends MovieClip implements CoreInterface {		protected var _this : MovieClip;		/**		 * CoreClip Constructor		 */		public function CoreClip() {			_this = this;			addEventListener( Event.ADDED_TO_STAGE, onStage, false, 0, true );			addEventListener( Event.REMOVED_FROM_STAGE, offStage, false, 0, true );		}		/**		 * Stub: Clip has been added to stage.		 */		protected function onStage(e : Event) : void {			trace( _this + " added to stage" );			}		/**		 * Stub: Clip has been removed from stage.		 */		protected function offStage(e : Event) : void {			trace( _this + " removed from stage" );			}		/**		 * Clean up after thy self.		 */		public function destroy() : void {			removeEventListener( Event.ADDED_TO_STAGE, onStage );			removeEventListener( Event.REMOVED_FROM_STAGE, offStage );		}		/**		 * Return reflective output		 * @return String		 */		override public function toString() : String {			return Stringifier.stringify( _this );		}	}}