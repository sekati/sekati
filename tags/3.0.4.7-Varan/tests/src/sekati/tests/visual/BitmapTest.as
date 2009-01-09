/** * sekati.tests.BitmapTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import flash.display.Sprite;	import flash.display.BitmapData;	import flash.display.Bitmap;	import flash.geom.*;	import flash.filters.*;	import flash.events.*;	/*	import flash.ui.ContextMenu;    import flash.ui.ContextMenuItem;    import flash.ui.ContextMenuBuiltInItems;    import flash.events.ContextMenuEvent;	*/		public class BitmapTest extends Sprite {				private var sprMain:Sprite;		private var bmpMain:BitmapData;		private var bmp:Bitmap;				private var blur:BlurFilter;		private var rate:Number = .90;//this will make our effect fade to black		private var colorMatrix:ColorMatrixFilter;				private var rectMain:Rectangle;		private var pntOrigin:Point;				private var currX:Number;		private var currY:Number;				private var range:Number = stage.stageWidth/4;		private var currAngle:Number = 180/Math.PI*2;				public function BitmapTest() {						//drawing sprite and bitmap object			sprMain = new Sprite();			bmpMain = new BitmapData(stage.stageWidth,stage.stageHeight,true,0);						//filters			blur = new BlurFilter(35,35,3);						/*			colorMatrix = new ColorMatrixFilter([			   rate,0,0,0,1,			   0,rate,0,0,1,			   0,0,rate,0,1,			   0,0,0,rate			]);			*/			colorMatrix = new ColorMatrixFilter([			   rate,1,0,1,1,			   0,rate,0,1,1,			   1,1,rate,0,0,			   0,0,0,rate			]);						//these are for the applyFilter method			rectMain = new Rectangle(0,0,stage.stageWidth,stage.stageHeight);			pntOrigin = new Point(0,0);						this.addEventListener(Event.ENTER_FRAME,goDraw);						currX = stage.stageWidth/2;			currY = stage.stageHeight/2;					}				private function goDraw(evt:Event):void {						sprMain.graphics.clear();						sprMain.graphics.beginFill(0xFFFFFF);						var newX:Number = Math.sin(currAngle)*range+currX;			var newY:Number = Math.cos(currAngle)*range+currY;						sprMain.graphics.drawCircle(newX,newY,10);						currAngle+=.05;						bmpMain.draw(sprMain);						//apply our filters			bmpMain.applyFilter(bmpMain,rectMain,pntOrigin,blur);			bmpMain.applyFilter(bmpMain,rectMain,pntOrigin,colorMatrix);						//this is what will be shown on the stage			bmp = new Bitmap(bmpMain);						//here I'm adding the drawing behind the previous effects so that we don't ever see the raw circle			stage.addChildAt(bmp,0);						if(stage.numChildren > 30) {				stage.removeChildAt(1);			}					}			}	}