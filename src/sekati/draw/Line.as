/** * sekati.draw.Line * @version 1.0.1 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.draw {	import flash.display.Shape;	import flash.geom.Point;	import sekati.draw.IDrawable;		/**	 * Line provides a basic line Shape.	 */	public class Line extends Shape implements IDrawable {		protected var _startX : Number;		protected var _startY : Number;		protected var _endX : Number;		protected var _endY : Number;		protected var _thickness : Number;		protected var _color : uint;		protected var _alpha : Number;		protected var _pixelHinting : Boolean;		protected var _scaleMode : String;			protected var _caps : String;		protected var _joints : String;		protected var _miterLimit : Number;		/**		 * Line Constructor		 */		public function Line(startPt : Point, endPt : Point,  thickness : Number = 1, color : uint = 0x000000,  alpha : Number = 1, pixelHinting : Boolean = false, scaleMode : String = "normal", caps : String = null, joints : String = null, miterLimit : Number = 3) {			draw( startPt, endPt, thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit );		}		/**		 * @inheritDoc		 */		public function draw(startPt : Point, endPt : Point,  thickness : Number = 1, color : uint = 0x000000,  alpha : Number = 1, pixelHinting : Boolean = false, scaleMode : String = "normal", caps : String = null, joints : String = null, miterLimit : Number = 3) : void {			this.graphics.lineStyle( thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit );			this.graphics.moveTo( startPt.x, startPt.y );			this.graphics.lineTo( endPt.x, endPt.y );							}				/**		 * @inheritDoc		 */		public function clear() : void {			this.graphics.clear( );			}	}}