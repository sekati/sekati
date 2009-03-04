/** * sekati.text.AbstractTextField * @version 1.0.1 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.text {	import flash.events.Event;	import flash.text.TextField;	import sekati.core.ICoreInterface;	import sekati.utils.TypeEnforcer;		/**	 * AbstractTextField	 */	public class AbstractTextField extends TextField implements ICoreInterface {		protected var _this : TextField;		/**		 * AbstractTextField is a foundational TextField class and should be thought 		 * of as one of the main textual building block of the API.		 */		public function AbstractTextField() {			TypeEnforcer.enforceAbstract( this, AbstractTextField );			_this = this;			addEventListener( Event.ADDED_TO_STAGE, onStage, false, 0, true );			addEventListener( Event.REMOVED_FROM_STAGE, offStage, false, 0, true );					}		/**		 * Stub: Sprite has been added to stage.		 */		protected function onStage(e : Event) : void {			trace( _this + " added to stage" );			}		/**		 * Stub: Sprite has been removed from stage.		 */		protected function offStage(e : Event) : void {			trace( _this + " removed from stage" );			}		/**		 * Clean up after thy self.		 */		public function destroy() : void {			removeEventListener( Event.ADDED_TO_STAGE, onStage );			removeEventListener( Event.REMOVED_FROM_STAGE, offStage );		}					}}