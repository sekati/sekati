/** * sekati.tests.KeyManagerTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import sekati.managers.KeyManager;	import sekati.utils.ArrayUtil;	import sekati.log.Logger;	/**	 * KeyManagerTest	 */	public class KeyManagerTest extends AbstractTestApplication {		/**		 * KeyManagerTest Constructor		 */		public function KeyManagerTest() {			super( );		}		/**		 * @inheritDoc		 */		override protected function initEntryPoint() : void {			super.initEntryPoint( );			KeyManager.$.addKeyListener( test0, true, KeyManager.$['A'] );			KeyManager.$.addKeyListener( test1, false, KeyManager.$['UP'], KeyManager.$['M'] );			KeyManager.$.addKeyListener( test2, false, KeyManager.$['DOWN'], KeyManager.$['P'] );			KeyManager.$.addKeyListener( test0, false, KeyManager.$['UP'] );			//			///*			var a : Array = [ 5,4,3,2,1,'C','B','A' ];			var b : Array = [ 'A','B','C',1,2,3,4,5 ];			Logger.$.trace( this, "arrays compare: " + ArrayUtil.compare( a, b ) );			Logger.$.trace( this, "arrays compare: " + ArrayUtil.compare( a, b, true ) );			 //*/		}		public function test0() : void {			//trace( "###### test0 works." );			Logger.$.warn( this, "###### test0 works." );		}		public function test1() : void {			//trace( "@@@@@@ test1 works." );			Logger.$.warn( this, "@@@@@@ test1 works." );		}		public function test2() : void {			//trace( "@@@@@@ test2 works@@@@" );			Logger.$.warn( this, "%%%%%% test2 works." );		}			}}