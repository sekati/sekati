/** * sekati.ui.TextButton * @version 1.0.1 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.ui {	import sekati.display.InteractiveSprite;	import sekati.draw.Rect;	import sekati.utils.AlignUtil;	import sekati.utils.ColorUtil;	import flash.events.MouseEvent;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.text.TextFormat;			/**	 * TextButton provides a very simple UI button with a text label and roll over states implementing <code>InteractiveSprite</code>.	 */	public class TextButton extends InteractiveSprite {		public var bg : Rect;		public var tf : TextField;		protected var _caption : String;		protected var _font : String;		protected var _size : uint;		/**		 * TextButton Constructor		 * @param caption 	of the button text.		 * @param bgRect 	shape to use as background.		 * @param font 		of the button text.		 * @param size 		pf the button text.		 */		public function TextButton(caption : String, bgRect : Rect, font : String = "Verdana", size : uint = 9) {			super( );			bg = bgRect;			_caption = caption;			_font = font;			_size = size;			configUI( );		}		/**		 * @inheritDoc		 */		protected function configUI() : void {			var fmt : TextFormat = new TextFormat( );			fmt.font = _font;			fmt.size = _size;			tf = new TextField( );			tf.autoSize = TextFieldAutoSize.LEFT;			tf.multiline = true;			tf.htmlText = _caption;			tf.setTextFormat( fmt );			tf.textColor = (ColorUtil.averageLightness( bg ) > 200) ? 0 : 0xffffff;			AlignUtil.alignCenter( tf, bg );			addChildren( bg, tf );		}		/**		 * @inheritDoc		 */		override protected function over(e : MouseEvent = null) : void {			super.over( e );			ColorUtil.invertColor( this );		}		/**		 * @inheritDoc		 */		override protected function out(e : MouseEvent = null) : void {			super.out( e );			ColorUtil.resetColor( this );		}	}}