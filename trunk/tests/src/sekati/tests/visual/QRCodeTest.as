/** * sekati.tests.visual.QRCodeTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import flash.text.TextFieldAutoSize;		import flash.events.MouseEvent;		import sekati.crypt.qrcode.QRCodeSprite;	import sekati.tests.visual.AbstractTestApplication;	import flash.display.Sprite;	import flash.text.TextField;	import flash.text.TextFieldType;			/**	 * QRCodeTest	 */	public class QRCodeTest extends AbstractTestApplication {		var qrcode : QRCodeSprite;		var str : String = "Encode ...";		var tf0 : TextField;		var tf1 : TextField;		var btn0 : Sprite;		var btn1 : Sprite;		private static const SIZE : int = 250;		public function QRCodeTest() {			super( );		}		override protected function initEntryPoint() : void {			super.initEntryPoint( );			qrcode = new QRCodeSprite( str, SIZE );			qrcode.x = 5;			qrcode.y = 50;			//			tf0 = new TextField( );			tf1 = new TextField( );			tf0.x = tf1.x = 10;			tf0.y = SIZE + 50;			tf1.y = SIZE + 75;			tf0.width = tf1.width = 225;			tf0.height = tf1.height = 20;			tf0.multiline = tf1.multiline = false;			tf0.border = tf1.border = true;			tf0.type = tf1.type = TextFieldType.INPUT;			tf0.text = str;			tf1.text = "Decode ...";			tf0.autoSize = tf1.autoSize = TextFieldAutoSize.LEFT;			//			btn0 = new Sprite( );			btn1 = new Sprite( );			btn0.graphics.beginFill( 0xff00ff, 1 );			btn1.graphics.beginFill( 0x00ff00, 1 );			btn0.graphics.drawRect( 0, 0, 20, 20 );			btn1.graphics.drawRect( 0, 0, 20, 20 );			btn0.graphics.endFill( );			btn1.graphics.endFill( );			btn0.x = 250;			btn1.x = 275;			btn0.y = btn1.y = SIZE+ 50;			btn0.buttonMode = btn1.buttonMode = true;			btn0.addEventListener( MouseEvent.CLICK, encode );			btn1.addEventListener( MouseEvent.CLICK, decode );			//			addChildren( qrcode, tf0, tf1, btn0, btn1 );		}		private function encode(e : MouseEvent) : void {			qrcode.text = tf0.text;			qrcode.drawData( SIZE, SIZE );		}		private function decode(e : MouseEvent) : void {			tf1.text = qrcode.decodeData();		}	}}