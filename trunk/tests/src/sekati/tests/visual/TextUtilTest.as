/** * sekati.tests.visual.TextUtilTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import sekati.utils.TextUtil;		import sekati.tests.visual.AbstractTestApplication;	import flash.text.TextField;		/**	 * TextUtilTest	 */	public class TextUtilTest extends AbstractTestApplication {		private var tf0 : TextField;		/**		 * TextUtilTest Constructor		 */		public function TextUtilTest() {			super( );		}		override protected function initEntryPoint() : void {			super.initEntryPoint( );					tf0 = TextUtil.create( "Hello World! This is a visual test of the TextUtil class.", 10, 100 );			addChild( tf0 );						TextUtil.ellipseLine( tf0, 150 );						// give some status			//Logger.$.info( this, "Device Info ::  name: " + mic.deviceName + ", index: " + mic.deviceIndex + ", device list: " + mic.devices );		}	}}