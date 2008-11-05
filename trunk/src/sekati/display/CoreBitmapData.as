/** * sekati.display.CoreBitmapData * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.display {	import flash.display.BitmapData;	import flash.display.DisplayObject;	import flash.filters.BitmapFilter;	import flash.geom.Matrix;	import flash.geom.Point;	import flash.geom.Rectangle;	import sekati.validators.FlashValidator;			/**	 * <code>CoreBitmapData</code> provides a common interface for capturing, 	 * scaling & cropping <code>BitmapData</code> from a <code>DisplayObject</code>.	 */	public class CoreBitmapData extends BitmapData {		/**		 * Defines the maximum dimension of a BitmapData object in the Flash Player.<ul>		 */		public static const MAX_SIZE : int = 2880;		/**		 * @private		 * TODO - Investigate why 4096 fails on FP10.		 * Defines the maximum dimension of a BitmapData object in the Flash Player.<ul>		 * <li>>= FP9: 2880 pixel maximum.</li>		 * <li>>= FP10: 4096 pixel maximum (large bitmap support: max length: 8191 pixels per side).</li></ul>		 */		public static const PLAYER_BITMAP_PIXELS : int = (!FlashValidator.isMinVersion( 10 )) ? 2880 : 4096;		/**		 * CoreBitmapData Constructor		 * @param src 			of the DisplayObject to capture.		 * @param x 			optional crop start position.		 * @param y 			optional crop start position.		 * @param width 		optional crop width.		 * @param height 		optional crop height.		 * @param scale 		optional scale (effects actual width & height).		 * @param transparent 	Specifies whether the bitmap supports per-pixel transparency. 		 * 						If <code>true</code> set the <code>fillColor</code> to <code>0x00000000</code> for a full transparent bitmap.		 * 						If <code>false</code> a minor improvement in rendering performance will result.		 * @param fillColor 	32-bit ARGB value to fill the bitmap area with.		 */		public function CoreBitmapData(src : DisplayObject, x : Number = 0, y : Number = 0, width : Number = NaN, height : Number = NaN, scale : Number = 1, transparent : Boolean = false, fillColor : uint = 0xFFFFFFFF) {						var targetWidth : Number = (width > 0) ? (width * scale) : (src.width * scale);			var targetHeight : Number = (height > 0) ? (height * scale) : (src.height * scale);						// clamp to player limitations			targetWidth = (targetWidth > MAX_SIZE) ? MAX_SIZE : targetWidth;			targetHeight = (targetHeight > MAX_SIZE) ? MAX_SIZE : targetHeight;						super( targetWidth, targetHeight, transparent, fillColor );									//trace( targetWidth + "x" + targetHeight );									// We can improve performance thru locking: 			// @see http://flexcomps.wordpress.com/2008/10/10/improve-performance-with-bitmapdatalock/#more-133			lock( );						// Cropping has been requested so we must create an intermediary ...			if(width > 0 && height > 0) {								// constrain to player limitations				var srcWidth : Number = ((src.width * scale) > MAX_SIZE) ? MAX_SIZE : (src.width * scale); 				var srcHeight : Number = ((src.height * scale) > MAX_SIZE) ? MAX_SIZE : (src.height * scale); 								// generate a tmp bitmap to copy from after scaling is applied				var tmp : BitmapData = new BitmapData( srcWidth, srcHeight, transparent, fillColor );				tmp.lock( );				tmp.draw( src, new Matrix( scale, 0, 0, scale, 0, 0 ) );				copyPixels( tmp, new Rectangle( x, y, targetWidth, targetWidth ), new Point( 0, 0 ) );				tmp.unlock( );				tmp.dispose( );			} else {				// no cropping needed - a straight up draw will do ...				draw( src, new Matrix( scale, 0, 0, scale, 0, 0 ) );							}						unlock( );		}		/**		 * Apply a <code>BitmapFilter</code> to the <code>BitmapData</code>.		 * @see flash.filters.BitmapFilter		 */		public function addFilter(filter : BitmapFilter, cx : Number = NaN, cy : Number = NaN, width : Number = NaN, height : Number = NaN) : void {						var dest : Point = (isNaN( cx ) && isNaN( cy )) ? new Point( 0, 0 ) : new Point( cx, cy );			var rect : Rectangle = (isNaN( width ) && isNaN( height )) ? new Rectangle( 0, 0, this.width, this.height ) : new Rectangle( cx, cy, width, height );			lock( );			applyFilter( this, rect, dest, filter );			unlock( );		}	}}