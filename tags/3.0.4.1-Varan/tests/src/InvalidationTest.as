/** * InvalidationTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package {	import sekati.display.Canvas;	import sekati.collections.TypedArray;	import sekati.draw.Rect;	import sekati.log.Logger;	import sekati.math.MathBase;	import sekati.utils.ColorUtil;			/**	 * InvalidationTest	 */	public class InvalidationTest extends AbstractTestApplication {		public function InvalidationTest() {			super( );		}		/**		 * @inheritDoc		 */		override protected function initEntryPoint() : void {			super.initEntryPoint( );			Logger.$.notice( this, "starting test ..." );						/*6 	INFO 	InvalidationTest 	init() called with deffered rendering: false 	(3 ms)7 	INFO 	InvalidationTest 	init() complete; please check benchmark for time passed since last log:  	(46 ms) 			*/			//init( false );			init( true );		}		private function init(isDeferredRender : Boolean = false) : void {			Logger.$.info( this, "init() called with deffered rendering: " + isDeferredRender );			// typed storage array for the rects			var rectangles : TypedArray = new TypedArray( Rect );			var r : Rect; 						// create a bunch of rectangles			for (var i : int = 0; i < 1000 ; i++) {				r = new Rect( 10, 10 );				rectangles.push( r );				addChild( r ); 														// draw			}						// manipulate their properties to make for the pretty!			for (var j : int = 0; j < rectangles.length ; j++) {				r = rectangles[j] as Rect;				r.width = MathBase.random( r.width, r.width * 5 ); 					// draw				r.height = MathBase.random( r.height, r.height * 5 );				// draw				r.x = MathBase.random( 0, Canvas.stage.stageWidth - r.width ); 		// draw				r.y = MathBase.random( 0, Canvas.stage.stageHeight - r.height );	// draw				ColorUtil.setColor( r, ColorUtil.randomColor( ) ); 					// draw			}			if(isDeferredRender) {				stage.invalidate( );			}			Logger.$.info( this, "init() complete; please check benchmark for time passed since last log: " );		}	}}