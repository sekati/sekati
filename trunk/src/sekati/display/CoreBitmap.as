/** * sekati.display.CoreBitmap * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.display {	import flash.display.Bitmap;	import flash.display.BitmapData;			/**	 * CoreBitmap	 */	public class CoreBitmap extends Bitmap {		public function CoreBitmap(bitmapData : BitmapData = null, pixelSnapping : String = "auto", smoothing : Boolean = true) {			super( bitmapData, pixelSnapping, smoothing );		}	}}