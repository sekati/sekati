/** * sekati.tests.StageDisplayTest * @version 1.0.4 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import sekati.display.Canvas;	import sekati.log.Logger;	import sekati.managers.StageManager;		import flash.display.Sprite;	import flash.events.MouseEvent;			[SWF(width="1024", height="768", frameRate="31", backgroundColor="#000000")]	/**	 * StageDisplayTest	 */	public class StageManagerTest extends AbstractTestApplication {		/**		 * Test Constructor		 */		public function StageManagerTest() {			super( );		}		override protected function initEntryPoint() : void {			super.initEntryPoint( );			Logger.$.trace( this, "Initializing StageDisplayTest stage: " + Canvas.stage.stageWidth + "x" + Canvas.stage.stageHeight );			initUI( );			Logger.$.trace( this, "Initializing StageDisplayTest content: " + StageManager.$.contentWidth + "x" + StageManager.$.contentHeight );					}		/**		 * build a box		 */		private function initUI() : void {			var s : Sprite = new Sprite( );			s.x = 50;			s.y = 50;			s.graphics.beginFill( 0xff00ff );			s.graphics.drawRoundRect( 0, 0, 50, 50, 10, 10 );			s.graphics.endFill( );			addChild( s );			s.addEventListener( MouseEvent.CLICK, clickHandler );		}		private function clickHandler(e : MouseEvent) : void {			//trace( "click" );			StageManager.$.toggleFullscreen( );		}	}}