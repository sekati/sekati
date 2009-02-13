/** * sekati.tests.TextTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import flash.text.TextField;		import sekati.text.FocusToggleField;		import sekati.text.FocusToggle;	import sekati.utils.TextUtil;	/**	 * TextTest	 */	public class TextTest extends AbstractTestApplication {		public var tf : TextField;		/**		 * Constructor		 */		public function TextTest() {			super( );		}		/**		 * Test Code...		 */		override protected function initEntryPoint() : void {						// existing field			new FocusToggle( tf );			//removeChild(tf);						// create the field			var t : FocusToggleField = new FocusToggleField( );			t.text = "Hello World!";			t.x = 10;			t.y = 50;			t.width = 250;			t.height = 50;			t.background = true;			t.backgroundColor = 0xffffff;			t.border = true;			t.borderColor = 0x999999;			addChild( t );						// create via util			var testTf : TextField = TextUtil.create( "herrrooooo" );			testTf.text = "HELLOOOOOOO?";			addChild( testTf );		}	}}