/** * CoreBitmapTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import flash.display.Bitmap;	import flash.events.Event;	import flash.filters.BlurFilter;		import sekati.display.CoreBitmapData;	import sekati.ui.Image;			/**	 * CoreBitmapTest	 */	public class CoreBitmapTest extends AbstractTestApplication {		public static const IMG_URL : String = 'http://consume.sekati.com/_lib/img/dearmom.gif';		public var img : Image;		public function CoreBitmapTest() {			super( );		}		override protected function initEntryPoint() : void {			super.initEntryPoint( );			img = new Image( IMG_URL );			img.addEventListener( Event.INIT, loadHandler );					}		/**		 * Handle load event		 */		private function loadHandler(e : Event) : void {			trace( "img loaded: smoothed bitmap available via img.bmp!" );			img.removeEventListener( Event.INIT, loadHandler );			addChild( img );									var data : CoreBitmapData = new CoreBitmapData( img );			data.addFilter( new BlurFilter( 4, 4, 3 ), 30, 30, 60, 60 );			//var data : CoreBitmapData = new CoreBitmapData( img, 0, 0, 0, 0, 21 );			//var data : CoreBitmapData = new CoreBitmapData( img, 0, 0, 0, 0, 0.5 );			//var data : CoreBitmapData = new CoreBitmapData( img, 0, 0, 50, 50, 1 );			//var data : CoreBitmapData = new CoreBitmapData( img, 0, 0, 50, 50, 2 );						var bmp : Bitmap = new Bitmap( data );			bmp.y = 150;			addChild( bmp );		}			}}