/** * sekati.tests.visual.RotationPlaneTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import caurina.transitions.Tweener;	import sekati.display.Canvas;	import sekati.load.ImageLoader;	import sekati.tests.visual.AbstractTestApplication;	import sekati.ui.RotationPlane;	import flash.events.Event;	import flash.events.MouseEvent;		/**	 * RotationPlaneTest	 */	public class RotationPlaneTest extends AbstractTestApplication {		private static const TWEEN : Object = { time:0.6, transition:"easeOutQuad" };		private static const URL0 : String = 'http://localhost/sekati/deploy/assets/test0.jpg';		private static const URL1 : String = 'http://localhost/sekati/deploy/assets/test1.jpg';		private var loader0 : ImageLoader;		private var loader1 : ImageLoader;		private var plane : RotationPlane;		private var _istweening : Boolean = false;		private var counter : int;		public function RotationPlaneTest() {			super( );		}		override protected function initEntryPoint() : void {			super.initEntryPoint( );						counter = 2;						loadMaterial0( );			graphics.beginFill( 0x333333 );			graphics.drawRect( 0, 0, Canvas.stage.stageWidth, Canvas.stage.stageHeight );			graphics.endFill( );		}		private function loadMaterial0() : void {			loader0 = new ImageLoader( URL0 );			loader0.addEventListener( Event.INIT, loadMaterial1 );			loader0.load( );		}		private function loadMaterial1(e : Event) : void {			loader0.removeEventListener( Event.INIT, loadMaterial1 );			loader1 = new ImageLoader( URL1 );			loader1.addEventListener( Event.INIT, initRotationPlane );			loader1.load( );					}		private function initRotationPlane(e : Event) : void {			loader1.removeEventListener( Event.INIT, initRotationPlane );						plane = new RotationPlane( loader0.content, loader1.content, RotationPlane.X_ORIENTED, 2000, 10, 10 );			plane.x = plane.y = 100;						Canvas.stage.addEventListener( MouseEvent.MOUSE_DOWN, hit );			plane.addEventListener( MouseEvent.MOUSE_OVER, onOver );			plane.addEventListener( MouseEvent.MOUSE_OUT, onOut );			addChild( plane );		}		private function hit(e : MouseEvent) : void {							rotationBack( );						counter++;		}		private function rotationBack() : void {			_istweening = true;			Tweener.addTween( plane, { base:TWEEN, rotationX:180*counter, rotationY:180*counter, onComplete:function():void {				_istweening = false;			}} );		}		protected function rotationFront() : void {			_istweening = true;			Tweener.addTween( plane, { base:TWEEN, rotationX:0, onComplete:function():void {				_istweening = false;			}} );		}		private function onOver(e : MouseEvent) : void {			if(!_istweening) {				Tweener.addTween( plane, { base:TWEEN, rotationY:30} );			}		}		private function onOut(e : MouseEvent) : void {			if(!_istweening) {				Tweener.addTween( plane, { base:TWEEN, rotationY:0} );			}		}	}}