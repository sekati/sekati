/** * BrowserAddressTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import sekati.display.InteractiveSprite;	import sekati.draw.Rect;	import sekati.external.BrowserAddress;	import sekati.log.Logger;		import flash.events.MouseEvent;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.utils.setInterval;			/**	 * BrowserAddressTest	 */	public class BrowserAddressTest extends AbstractTestApplication {		public var btn0 : InteractiveSprite;		public var btn1 : InteractiveSprite;		public var tf : TextField;		//		public var testInterval : uint;		public var hashValue : String;		public function BrowserAddressTest() {			super( );		}		/**		 * @inheritDoc		 */		override protected function initEntryPoint() : void {			super.initEntryPoint( );			configUI( );		}		/**		 * Configure UI elements.		 */		private function configUI() : void {			tf = new TextField( );			tf.autoSize = TextFieldAutoSize.LEFT;			tf.multiline = true;			tf.text = "BrowserAddress Test Initializing ...";			tf.y = 100;						btn0 = new InteractiveSprite( );			var rect0 : Rect = new Rect( 100, 100, 0, 0, 0, 0xff00ff );			btn0.addChild( rect0 );			btn0.y = 200;			btn0.addEventListener( MouseEvent.CLICK, fooClickHandler );						btn1 = new InteractiveSprite( );			var rect1 : Rect = new Rect( 100, 100, 0, 0, 0, 0x00ff00 );			btn1.addChild( rect1 );					btn1.x = 150;			btn1.y = 200;						btn1.addEventListener( MouseEvent.CLICK, barClickHandler );						addChildren( btn0, btn1, tf );			//setTimeout( fooClickHandler, 500 );			testInterval = setInterval( hasComparator, 1000 );						//addChild( new TextButton( "Suck It!", new Rect( 200, 100, 0, 0, 0, 0xcccccc )) );		}		/**		 * Compare the current hash with the previous known hash.		 */		private function hasComparator() : void {			var previousHash : String = hashValue;			hashValue = BrowserAddress.anchor;						if(previousHash != hashValue) {				Logger.$.notice( this, "OMG: the URL has changed dude!" );				tf.appendText( "\nANCHOR CHANGE AUTO-DETECTED: (was: " + previousHash + ", now: " + hashValue + ")" );			}		}		/**		 * haha		 */		private function fooClickHandler(e : MouseEvent = null) : void {			var oldAnchor : String = BrowserAddress.anchor;			BrowserAddress.anchor = "FOO";			tf.text = "Rewriting anchor tag: " + BrowserAddress.anchor + " from: " + oldAnchor;		}		private function barClickHandler(e : MouseEvent = null) : void {			var oldAnchor : String = BrowserAddress.anchor;			BrowserAddress.anchor = "BAR";			tf.text = "Rewriting anchor tag: " + BrowserAddress.anchor + " from: " + oldAnchor;				}	}}