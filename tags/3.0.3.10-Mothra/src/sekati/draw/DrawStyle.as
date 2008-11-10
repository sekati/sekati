/** * sekati.draw.DrawStyle * @version 1.0.1 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.draw {	import flash.geom.Matrix;		/**	 * DrawStyle provides a base preference set for API Drawn Shapes.	 * @see flash.display.CapsStyle	 * @see flash.display.GradientType	 * @see flash.display.InterpolationMethod	 * @see flash.display.JointStyle	 * @see flash.display.LineScaleMode	 * @see flash.display.SpreadMethod	 * @see flash.geom.Matrix	 */	public class DrawStyle {		public static var THICKNESS : Number = 1;		public static var COLOR : uint = 0x000000;		public static var ALPHA : Number = 1;		public static var HINTING : Boolean = true;		public static var SCALE_MODE : String = "none";		public static var CAPS : String = "square";		public static var JOINTS : String = "miter";		public static var MITER_LIMIT : Number = 3;		public static var GRADIENT_TYPE : String = "linear";		public static var GRADIENT_COLORS : Array = [ 0x000000, 0xFFFFFF ];		public static var GRADIENT_ALPHAS : Array = [ 0,100 ];		public static var GRADIENT_RATIOS : Array = [ 0,255 ];		public static var GRADIENT_MATRIX : Matrix = null;		public static var GRADIENT_SPREAD : String = "pad";		public static var GRADIENT_INTERPOLATE : String = "rgb";		public static var FOCALPOINT_RATIO : Number = 0;		/**		 * DrawStyle Static Constructor		 */		public function DrawStyle() {			throw new Error( "DrawStyle is a static class and cannot be instantiated." );		}	}}