/** * sekati.tests.KeyManagerTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests {	import sekati.tests.AbstractTestApplication;	import sekati.managers.KeyManager;	import flash.ui.Keyboard;	/**	 * KeyManagerTest	 */	public class KeyManagerTest extends AbstractTestApplication {		/**		 * KeyManagerTest Constructor		 */		public function KeyManagerTest() {			super( );		}		/**		 * @inheritDoc		 */		override protected function initEntryPoint() : void {			super.initEntryPoint( );			KeyManager.getInstance( );			//KeyManager.$.addKeyListener( test, [ Keyboard.DOWN, Keyboard.CONTROL ] );		}		public function test() : void {			trace( "the test function has fired." );		}	}}