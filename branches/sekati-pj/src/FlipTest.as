/** * FlipTest * @version 1.0.0 * @author pj ahlberg * Copyright (C) 2009  pj ahlberg. All Rights Reserved. */package {	import flash.display.Bitmap;	import sekati.display.Document;	[SWF(width="1075", height="500", frameRate="31", backgroundColor="#000000")]	/**	 * FlipTest	 */	public class FlipTest extends Document {		protected var _rotationPlane : RotationPlane;		[Embed(source="../lib/assets/ch.jpg")]		protected var _imageSource : Class;		public function FlipTest() {			super( );		}		override protected function initEntryPoint() : void {			super.initEntryPoint( );			attachPlane( );		}		protected function attachPlane() : void {			var bitmapfront : Bitmap = Bitmap( new _imageSource( ) );			var bitmapback : Bitmap = Bitmap( new _imageSource( ) );						_rotationPlane = new RotationPlane( bitmapfront, bitmapback );						_rotationPlane.x = _rotationPlane.y = 200;						addChild( _rotationPlane );		}	}}