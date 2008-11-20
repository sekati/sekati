/** * StrandTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.display {	import flash.geom.Point;	//import sekati.draw.Strand;	import sekati.math.*;		/**	 * StrandTest	 */	public class StrandTest extends AbstractTestApplication {		//public var strand : Strand;		/**		 * Constructor		 */		public function StrandTest() {			super( );			/*			var s : Point = new Point( 10, 10 );			var cp : Array = new Array( );			var e : Point = new Point( rWidth, rHeight );			*/			//strand = new Strand( s, cp, e );			//addChild( strand );						/*var curve:Curve = new Curve(0, 0, 50,300, 100, 100, 1, 0xff0000);addChild(curve);Tweener.addTween(curve, {sx:200,sy:300,tx:100,ty:0,ex:900,ey:500, color:0xff00ff, transition:"easeOutQuint", time:5, onUpdate:renderCurve});function renderCurve():void {	curve.draw();}			 */		}		/**		 * Render a new strand.		 */		protected function render() : void {			//strand.draw( );		}		/**		 * Take the start and end point and generate a random curve.		 */		protected function rCurve(s : Point, e : Point, amount : uint) : Array {			var cp : Array = new Array( );			for (var i : int = 0; i < amount ; i++) {				var x : Number = MathBase.random( s.x, e.x );				var y : Number = MathBase.random( s.y, e.y );				cp.push( new Point( x, y ) );			}			return cp;		}		/**		 * Return a random stage width.		 */		protected function get rWidth() : Number {			return MathBase.random( 0, stage.width );			}		/**		 * Return a random stage height.		 */		protected function get rHeight() : Number {			return MathBase.random( 0, stage.height );			}			}}