/** * sekati.tests.FramePulseTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package  {	import flash.events.Event;	import sekati.events.FramePulse;		/**	 * FramePulseTest	 */	public class FramePulseTest {		/**		 * FramePulseTest Constructor		 */		public function FramePulseTest() {			FramePulse.$.addEventListener( FramePulse.FRAME_PULSE, _onEnterFrame );		}		protected function _onEnterFrame(e : Event) : void {			trace( "frame pulse" );		}	}}