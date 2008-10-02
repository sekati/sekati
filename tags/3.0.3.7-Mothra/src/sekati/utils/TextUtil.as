/** * sekati.utils.TextUtil * @version 1.1.1 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.utils {	import sekati.validators.StringValidator;		import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.text.TextFieldType;	import flash.text.TextFormat;			/**	 * Static class wrapping various Text utilities.	 */	public class TextUtil {		public static function create(name : String, x : Number, y : Number, w : Number, h : Number, selectable : Boolean = false, multiline : Boolean = false, border : Boolean = false, embedFonts : Boolean = false, autoSize : String = 'left') : TextField {			var tf : TextField = new TextField( );			tf.name = name;			tf.x = x;			tf.y = y;			tf.width = w;			tf.height = h;			tf.selectable = selectable;			tf.multiline = multiline;			tf.border = border;			tf.embedFonts = embedFonts;			tf.autoSize = autoSize;			return tf;		}		/**		 * Set the text of a <code>TextField</code> while preserving the formatting (leading, kerning, etc).		 * Note: htmlText and styles can break the formatting: no known fix as of yet.		 */		public static function setFormattedText(tf : TextField, str : String, autoSize : Boolean = true) : void {			var s : String = (StringValidator.isBlank( str )) ? " " : str;			if(autoSize) {				tf.autoSize = TextFieldAutoSize.LEFT;			}			var textFormat : TextFormat = tf.getTextFormat( );			if(tf.type == TextFieldType.INPUT) {				tf.text = s;				} else {				tf.htmlText = s;			}			tf.setTextFormat( textFormat );		}		/**		 * Set the <code>TextField</code> space width formatting.		 */		public static function setSpacesWidth( tf : TextField, space : Number = 1 ) : void {				var fmt : TextFormat = new TextFormat( );			fmt.letterSpacing = space;						var i : int = 0;			while (tf.text.indexOf( " ", i ) > -1) {				var index : int = tf.text.indexOf( " ", i );				tf.setTextFormat( fmt, index, index + 1 );				i = index + 1;			}		}		/**		 * Set the <code>TextField</code> leading formatting.		 */		public static function setLeading( tf : TextField, space : Number = 0  ) : void {			var fmt : TextFormat = tf.getTextFormat( );			fmt.leading = space;						tf.setTextFormat( fmt );		}		/**		 * Ellipse a single-line TextField to a specific width.		 */		public static function ellipseLine( tf : TextField , width : Number , param : String = "..." ) : void {			tf.autoSize = TextFieldAutoSize.LEFT;			var n : uint = param.length + 1;			while( tf.textWidth > width ) {				if (tf.textWidth > width * 2) {					tf.htmlText = tf.htmlText.substr( 0, tf.htmlText.length * 0.66 >> 0 ) + param;				}				tf.htmlText = tf.htmlText.substr( 0, tf.htmlText.length - n ) + param;			}		}		/**		 * empty a TextField.onSetFocus, restore to default if blank onKillFocus on input textfield		 * @param tf (TextField) target TextField		 * @return Void		 * 		 * {@code Usage:		 * tf.onSetFocus = tf.onKillFocus = function ():Void { TextUtils.focusToggle (tf); };		 * }		 */		public static function focusToggle(tf : TextField) : void {			/*			trace( "focus toggle called" );			if (tf['defval'].length) {				if (tf.text == tf['defval']) {					tf.text = "";				} else if (tf.text == "") {					tf.text = tf['defval'];				}			} else if (tf.text.length) {				tf['defval'] = tf.text;				tf.text = "";			}			 * 			 */		}		/**		 * TextUtil Static Constructor		 */		public function TextUtil() {			throw new Error( "TextUtil is a static class and cannot be instantiated." );		}	}}