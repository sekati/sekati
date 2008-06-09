/** * sekati.ui.TextLabel * @version 1.0.2 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.ui {	import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.text.TextFormat;	import flash.text.AntiAliasType;	/**	 * Generic Text Label	 */	public class TextLabel extends TextField {		/**		 * TextLabel Constructor		 */		public function TextLabel(str : String, fontFace : String = "Arial", fontSize : uint = 22, fontColor : Number = 0x000000, hasBorder : Boolean = true, bgColor : Number = 0xFFFFCC, borderColor : Number = 0xCCCCCC) {			var labelFormat : TextFormat = new TextFormat( fontFace, fontSize, fontColor );			this.autoSize = TextFieldAutoSize.LEFT;			this.background = true;			this.backgroundColor = bgColor;			this.border = hasBorder;			this.borderColor = borderColor;			this.htmlText = str;			this.selectable = false;			this.embedFonts = false;			this.textColor = fontColor;			this.defaultTextFormat = labelFormat;			this.antiAliasType = AntiAliasType.ADVANCED;		}	}}