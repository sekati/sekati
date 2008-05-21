/** * sekati.tests.BoxTest * @version 1.0.0 * @author jason m horwitz | sekati.com | tendercreative.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package  {	import flash.display.MovieClip;	import flash.events.Event;		import caurina.transitions.Tweener;		import sekati.math.MathBase;			/**	 * BoxTest	 */	public class BoxTest extends MovieClip {		/**		 * Constructor		 */		public function BoxTest() {			for (var i : Number = 0; i < 100 ; i++) {				createBox( i );			}			this.addEventListener( "onBtnDoubleClick", _btnDblClik );			}		/**		 * Create a TestBox		 * @param i		 * @return void		 */		private function createBox(i : int) : void {			var t : Box = new Box( );			t.name = "testBox_" + String( i );			t.alpha = 0;			Tweener.addTween( t, {alpha:.10, rotation:360, width:50, height:50, x:MathBase.random( 0, this.stage.stageWidth ), y:MathBase.random( 0, this.stage.stageHeight ), time:.5, delay:MathBase.constrain( .1 * i, 0, 10 ), transition:"easeinoutexpo"} );			addChild( t );						var m : MovieClip = new MovieClip( );			addChild( m );			removeChildAt( 1 );		}				/**		 * double click event		 */		private function _btnDblClik(e : Event) : void {			trace( "recvd double clicked BTN!" );		}			}}