/** * sekati.utils.TextUtil * @version 1.2.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.utils {	import flash.text.StyleSheet;		import sekati.core.App;		import flash.display.DisplayObject;		import sekati.validators.StringValidator;		import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.text.TextFieldType;	import flash.text.TextFormat;			/**	 * Static class wrapping various Text utilities.	 */	public class TextUtil {		/**		 * Clear a <code>TextField</code>'s contents.		 * @param tf 			<code>TextField</code> instance.		 */		public static function clear(tf : TextField) : void {			tf.text = tf.htmlText = '';		}		/**		 * Style a <code>TextField</code>'s contents.		 * @param tf 			<code>TextField</code> instance.		 * @param stylesheet 	to apply to the <code>TextField</code> (Default: <code>App.css</code>).		 */		public static function style(tf : TextField, stylesheet : StyleSheet = null) : void {			tf.styleSheet = (stylesheet) ? stylesheet : App.css;		}		/**		 * Clear all <code>TextField</code>'s in the display object.		 * @param o 		<code>DisplayObject</code> containing the <code>TextField</code>'s.		 */			public static function clearFields(o : DisplayObject) : void {			for(var i : String in o) { 				if (o[i] is TextField) {					clear( o[i] );				}			}					}		/**		 * Apply the application stylesheet to all <code>TextField</code>'s in the object.		 * @param o 			<code>DisplayObject</code> containing the <code>TextField</code>'s.		 * @param stylesheet 	to apply to the <code>TextField</code>'s (Default: <code>App.css</code>).		 * @see sekati.core.App#css		 */		public static function styleFields(o : DisplayObject, stylesheet : StyleSheet = null) : void {			for(var i : String in o) { 				if (o[i] is TextField && !o[i].styleSheet) {					style( o[i], stylesheet );				} 			}				}		/**		 * Apply a <code>StyleSheet</code> to a <code>TextField</code> & set its contents.		 * @param tf 			<code>TextField</code> to display.		 * @param str 			of text.		 * @param stylesheet 	to apply to the <code>TextField</code>'s (Default: <code>App.css</code>).		 * @see sekati.core.App#css		 */		public static function show(tf : TextField, str : String, stylesheet : StyleSheet = null) : void {			if (!tf.styleSheet) tf.styleSheet = (stylesheet) ? stylesheet : App.css;			tf.htmlText = str;		}		/**		 * Hide a <code>TextField</code> from display (visible false, alpha 0).		 * @see #reveal		 */		public static function hide( ...args ) : void {			for(var i : int = 0; i < args.length ; i++) { 				if (args[i] is TextField) {					args[i].alpha = 0;					args[i].visible = false;				}			}			}		/**		 * Reveal a textfield (visible true, alpha 1)		 * @see #hide		 */		public static function reveal(...args) : void {			for(var i : int = 0; i < args.length ; i++) { 				if (args[i] is TextField) {					args[i].alpha = 1;					args[i].visible = true;				}			}			}				/**		 * Create a <code>TextField</code> instance and return it.		 */		public static function create(str : String, x : Number = 0, y : Number = 0, width : Number = 200, height : Number = 20, multiline : Boolean = false, font : String = "Verdana", size : Number = 9, color : uint = 0, autoSize : String = 'left', embedFonts : Boolean = false, selectable : Boolean = false, css : StyleSheet = null) : TextField {			var tf : TextField = new TextField( );			var fmt : TextFormat = new TextFormat( font, size, color );			tf.x = x;			tf.y = y;			tf.width = width;			tf.height = height;			tf.autoSize = autoSize;			tf.embedFonts = embedFonts;			tf.selectable = selectable;			tf.multiline = multiline;			tf.textColor = color;			tf.defaultTextFormat = fmt;			tf.htmlText = str;			tf.styleSheet = css;			return tf;		}		/**		 * Set the text of a <code>TextField</code> while preserving the formatting (leading, kerning, etc).		 * XXX - Warning: htmlText and styles can break the formatting: no known fix as of yet.		 */		public static function setFormattedText(tf : TextField, str : String, autoSize : Boolean = true) : void {			var s : String = (StringValidator.isBlank( str )) ? " " : str;			if(autoSize) {				tf.autoSize = TextFieldAutoSize.LEFT;			}			var textFormat : TextFormat = tf.getTextFormat( );			if(tf.type == TextFieldType.INPUT) {				tf.text = s;				} else {				tf.htmlText = s;			}			tf.setTextFormat( textFormat );		}		/**		 * Set the <code>TextField</code> space width formatting.		 */		public static function setSpacesWidth( tf : TextField, space : Number = 1 ) : void {				var fmt : TextFormat = new TextFormat( );			fmt.letterSpacing = space;						var i : int = 0;			while (tf.text.indexOf( " ", i ) > -1) {				var index : int = tf.text.indexOf( " ", i );				tf.setTextFormat( fmt, index, index + 1 );				i = index + 1;			}		}		/**		 * Set the <code>TextField</code> leading formatting.		 */		public static function setLeading( tf : TextField, space : Number = 0  ) : void {			var fmt : TextFormat = tf.getTextFormat( );			fmt.leading = space;						tf.setTextFormat( fmt );		}		/**		 * Ellipse a single-line TextField to a specific width.		 */		public static function ellipseLine( tf : TextField , width : Number , param : String = "..." ) : void {			tf.autoSize = TextFieldAutoSize.LEFT;			var n : uint = param.length + 1;			while( tf.textWidth > width ) {				if (tf.textWidth > width * 2) {					tf.htmlText = tf.htmlText.substr( 0, tf.htmlText.length * 0.66 >> 0 ) + param;				}				tf.htmlText = tf.htmlText.substr( 0, tf.htmlText.length - n ) + param;			}		}		/**		 * TextUtil Static Constructor		 */		public function TextUtil() {			throw new Error( "TextUtil is a static class and cannot be instantiated." );		}	}}