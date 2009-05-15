/** * sekati.draw.Bezier * @version 1.0.5 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.draw {	import flash.display.Shape;	import sekati.draw.ITweenableDrawing;		/**	 * Bezier provides a Tweenable curve which, unlike <code>Curve</code> requires a Control Point.	 * @see sekati.draw.Curve	 */	public class Bezier extends Shape implements ITweenableDrawing {				/**		 * I know this is BS but compiler bug in mxmlc prevents proper compilation.		 * @see http://bugs.adobe.com/jira/browse/ASC-2231		 */		public static const THICKNESS : Number = 1;		public static const COLOR : uint = 0x000000;		public static const ALPHA : Number = 1;		public static const HINTING : Boolean = true;		public static const SCALE_MODE : String = "none";		public static const CAPS : String = "square";		public static const JOINTS : String = "miter";		public static const MITER_LIMIT : Number = 3;				protected var _sx : Number;		protected var _sy : Number;		protected var _cx : Number;		protected var _cy : Number;		protected var _ax : Number;		protected var _ay : Number;		protected var _thickness : Number;		protected var _color : uint;		protected var _alpha : Number;		protected var _pixelHinting : Boolean;		protected var _scaleMode : String;		protected var _caps : String;		protected var _joints : String;		protected var _miterLimit : Number;		/**		 * Bezier Constructor		 * @example <listing version="3.0">		 * var benzier:Bezier = new Bezier(300, 300, 200,200, 500, 500, 1, 0x00ffff);		 * addChild(benzier);		 * Tweener.addTween(benzier, {sx:20,sy:500,cx:0,cy:100,ax:700,ay:300, color:0x33ffff, thickness:2.75, transition:"easeOutQuint", time:5, onUpdate:renderBenzier});		 * function renderBenzier():void {		 * 	benzier.draw();		 * }		 * </listing>		 */		public function Bezier(startX : Number, startY : Number, controlX : Number, controlY : Number, anchorX : Number, anchorY : Number, thickness : Number = THICKNESS, color : uint = COLOR,  alpha : Number = ALPHA, pixelHinting : Boolean = HINTING, scaleMode : String = SCALE_MODE, caps : String = CAPS, joints : String = JOINTS, miterLimit : Number = MITER_LIMIT) {			_sx = startX;			_sy = startY;			_cx = controlX;			_cy = controlY;			_ax = anchorX;			_ay = anchorY;			_thickness = thickness;			_color = color;			_alpha = alpha;			_pixelHinting = pixelHinting;			_scaleMode = scaleMode;			_caps = caps;			_joints = joints;			_miterLimit = miterLimit;			draw( );		}		/**		 * @inheritDoc		 */		public function draw() : void {			this.graphics.lineStyle( _thickness, _color, _alpha, _pixelHinting, _scaleMode, _caps, _joints, _miterLimit );			this.graphics.moveTo( _sx, _sy );			this.graphics.curveTo( _cx, _cy, _ax, _ay );								}					/**		 * @inheritDoc		 */				public function redraw() : void {			clear( );			draw( );		}		/**		 * @inheritDoc		 */		public function clear() : void {			this.graphics.clear( );			}		/**		 * Return the start x pos.		 */		public function get sx() : Number {			return _sx;		}				/**		 * @private		 */		public function set sx(n : Number) : void {			_sx = n;		}				/**		 * Return the start y pos.		 */		public function get sy() : Number {			return _sy;		}		/**		 * @private		 */		public function set sy(n : Number) : void {			_sy = n;		}			/**		 * Return the control x pos.		 */		public function get cx() : Number {			return _cx;		}				/**		 * @private		 */		public function set cx(n : Number) : void {			_cx = n;		}				/**		 * Return the control y pos.		 */		public function get cy() : Number {			return _cy;		}		/**		 * @private		 */		public function set cy(n : Number) : void {			_cy = n;		}			/**		 * Return the anchor x pos.		 */		public function get ax() : Number {			return _ax;		}				/**		 * @private		 */		public function set ax(n : Number) : void {			_ax = n;		}		/**		 * Return the anchor y pos.		 */		public function get ay() : Number {			return _ay;		}		/**		 * @private		 */		public function set ay(n : Number) : void {			_ay = n;		}		/**		 * Return the color.		 */		public function get color() : uint {			return _color;		}		/**		 * @private		 */		public function set color(n : uint) : void {			_color = n;		}			/**		 * Return the thickness.		 */		public function get thickness() : uint {			return _thickness;		}		/**		 * @private		 */		public function set thickness(n : uint) : void {			_thickness = n;		}								}}