/** * sekati.view.Viewport * @version 1.0.2 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.view {	import flash.display.DisplayObjectContainer;	import flash.display.Shape;	import flash.events.EventDispatcher;	import sekati.display.StageDisplay;	import sekati.events.StageEvent;	import sekati.events.ViewportEvent;		/**	 * Viewport provides a faux application viewport via a set of letterboxing DisplayObject's to confine content.	 * By default these are set at a 16:9 proportion and maintain the proportion to <code>Canvas.stage</code>. A	 * <code>ViewportEvent.RENDER</code> is dispatched when the Viewport is updated. This condenses <code>StageDisplay</code>	 * events and assists in liquid layouts which require a proportional relationship within a Viewport.	 * @example <listing version="3.0">	 * // Note: Document class extends sekati.display.Canvas	 * // initialize the StageDisplay	 * StageDisplay.$.init( );	 * // initialize a viewport with a 25 pixel minimum footer.	 * Viewport.$.init( this, 25 );	 * Viewport.$.render( );	 * </listing>	 * @see sekati.events.ViewportEvent	 * @see sekati.display.StageDisplay	 */	public class Viewport extends EventDispatcher {		protected static var _instance : Viewport;		protected var BOTTOM_CONSTRAINT : uint;		protected var PROPORTION_WIDTH : uint;		protected var PROPORTION_HEIGHT : uint;		protected var RATIO : Number;		protected var _target : DisplayObjectContainer;		protected var _vp : Shape;		protected var _tb : Shape;		protected var _bb : Shape;		/**		 * Viewport Singleton Constructor		 * @param $ SingletonEnforcer - internal to the AS file; the param prevents external instantiation without error.		 */		public function Viewport( $ : SingletonEnforcer = null) {			if (!$) {				throw new ArgumentError( "Viewport is a Singleton and may only be accessed via its accessor methods: 'getInstance()' or '$'." );				}		}		/**		 * Singleton Accessor		 * @return Viewport		 */		public static function getInstance() : Viewport {			if( _instance == null ) _instance = new Viewport( new SingletonEnforcer( ) );			return _instance;		}		/**		 * Shorthand singleton accessor getter		 * @return Viewport		 */		public static function get $() : Viewport {			return Viewport.getInstance( );			}		/**		 * Parameterized Viewport initialization.		 * @param target 			target viewport container object.		 * @param bottomConstraint 	defines the minimum bottom letter-box height.		 * @param proportionWidth 	proportional width of the viewport.		 * @param proportionHeight 	proportional height of the viewport.		 * @param lbColor 			letter-box color.		 * @param vpColor 			viewport color.		 * @param lbVisible 		display the letterbox DisplayObjects.		 * @param vpVisible 		display the viewport DisplayObject.		 */		public function init(target : DisplayObjectContainer, bottomConstraint : uint = 0, proportionWidth : uint = 16, proportionHeight : uint = 9, lbColor : int = 0x000000, vpColor : uint = 0xFFFFFF, lbVisible : Boolean = true, vpVisible : Boolean = false) : void {			PROPORTION_WIDTH = proportionWidth;			PROPORTION_HEIGHT = proportionHeight;			RATIO = (PROPORTION_HEIGHT / PROPORTION_WIDTH);			BOTTOM_CONSTRAINT = bottomConstraint;			_target = target;						// viewport			_vp = new Shape( );			_vp.graphics.beginFill( vpColor, 1 );			_vp.graphics.drawRect( 0, 0, PROPORTION_WIDTH, PROPORTION_HEIGHT );			_vp.graphics.endFill( );			_vp.visible = vpVisible;						// top letterbox			_tb = new Shape( );			_tb.graphics.beginFill( lbColor, 1 );			_tb.graphics.drawRect( 0, 0, PROPORTION_WIDTH, PROPORTION_HEIGHT );			_tb.graphics.endFill( );			_tb.visible = lbVisible;						// bottom letterbox			_bb = new Shape( );			_bb.graphics.beginFill( lbColor, 1 );			_bb.graphics.drawRect( 0, 0, PROPORTION_WIDTH, PROPORTION_HEIGHT );			_bb.graphics.endFill( );			_bb.visible = lbVisible;						_target.addChild( _vp );			_target.addChild( _tb );			_target.addChild( _bb );						StageDisplay.$.addEventListener( StageEvent.RESIZE, render, false, 0, true );			StageDisplay.$.addEventListener( StageEvent.RESIZE_COMPLETE, render, false, 0, true );			StageDisplay.$.addEventListener( StageEvent.FULLSCREEN, render, false, 0, true );						render( );		}		/**		 * Destroy the Viewport		 */		public function destroy() : void {			StageDisplay.$.removeEventListener( StageEvent.RESIZE, render );			StageDisplay.$.removeEventListener( StageEvent.RESIZE_COMPLETE, render );			StageDisplay.$.removeEventListener( StageEvent.FULLSCREEN, render );			_target.removeChild( _vp );			_target.removeChild( _tb );			_target.removeChild( _bb );			_vp = null;			_tb = null;			_bb = null;									_instance = null;		}		/**		 * Update the Viewport confines.		 */		public function render(e : StageEvent = null) : void {			var w : int = StageDisplay.$.width;			var h : int = int( w * RATIO );			var y : int = int( StageDisplay.$.height / 2 - h / 2 );			var bh : Number = (int( StageDisplay.$.height - h - y ) < BOTTOM_CONSTRAINT && BOTTOM_CONSTRAINT > 0) ? BOTTOM_CONSTRAINT : int( StageDisplay.$.height - h - y );			var by : int = int( StageDisplay.$.height - _bb.height );									_vp.width = _tb.width = _bb.width = w;			_vp.height = h;			_vp.y = y;			_tb.height = y;			_bb.height = bh;			_bb.y = by;						dispatchEvent( new ViewportEvent( ViewportEvent.RENDER ) );		}		/**		 * Return viewport ratio.		 */		public function get ratio() : Number {			return RATIO;		}		/**		 * Return ratio proportional width.		 */		public function get proportionWidth() : uint {			return PROPORTION_WIDTH;		}		/**		 * Return ratio proportional height.		 */		public function get proportionHeight() : uint {			return PROPORTION_HEIGHT;		}				/**		 * Return viewport width.		 */		public function get width() : int {			return _vp.width;		}		/**		 * Return viewport height.		 */		public function get height() : int {			return _vp.height;		}		/**		 * Return viewport x position.		 */		public function get x() : int {			return _vp.x;		}		/**		 * Return viewport y position.		 */		public function get y() : int {			return _vp.y;		}		/**		 * Return viewport center x position.		 */		public function get centerx() : int {			return (width / 2);		}		/**		 * Return viewport center y position.		 */		public function get centery() : int {			return (height / 2);		}		/**		 * Return top of the visible viewport.		 */		public function get top() : int {			return (_tb.height + _tb.y);		}		/**		 * Return bottom of the visible viewport.		 */		public function get bottom() : int {			return _bb.y;		}		/**		 * Return the viewport shape.		 */		public function get viewport() : Shape {			return _vp;			}		/**		 * Return the top letter box shape.		 */		public function get topBox() : Shape {			return _tb;			}		/**		 * Return the bottom letterbox shape.		 */		public function get bottomBox() : Shape {			return _bb;		}				}}/** * Internal class is accessible only to this AS file and is used  * as a constructor param to enforce proper Singleton behavior. */internal class SingletonEnforcer {}	