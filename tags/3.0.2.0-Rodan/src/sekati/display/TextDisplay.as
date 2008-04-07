/** * sekati.display.TextDisplay * @version 1.0.1 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.display {	import flash.display.DisplayObject;	import flash.text.TextField;		import sekati.core.App;		/**	 * TextDisplay provides an interface to uniformly style, set & clear <code>TextField</code> text.	 */	public class TextDisplay {		/**		 * Clear all textfields in the object.		 */			public static function clear(o : DisplayObject) : void {			for(var i : String in o) { 				if (o[i] is TextField) {					o[i].text = "";					o[i].htmlText = ""; 				}			}					}		/**		 * Apply the application stylesheet to all <code>TextField</code>'s in the object.		 * @see sekati.core.App#css		 */		public static function style(o : DisplayObject) : void {			for(var i : String in o) { 				if (o[i] is TextField && !o[i].styleSheet) {					o[i].styleSheet = App.css;				} 			}				}		/**		 * Apply the application stylesheet to <code>TextField</code> & set string.		 * @see sekati.core.App#css		 */		public static function show(tf : TextField, str : String) : void {			if (!tf.styleSheet) tf.styleSheet = App.css;			tf.htmlText = str;		}		/**		 * Hide a textfield (visible false, alpha 0)		 * @see TextDisplay.reveal()		 */		public static function hide( ...args ) : void {			for(var i : int = 0; i < args.length ; i++) { 				if (args[i] is TextField) {					args[i].alpha = 0;					args[i].visible = false;				}			}			}		/**		 * Reveal a textfield (visible true, alpha 100)		 * @see TextDisplay.hide()		 */		public static function reveal(...args) : void {			for(var i : int = 0; i < args.length ; i++) { 				if (args[i] is TextField) {					args[i].alpha = 1;					args[i].visible = true;				}			}			}		/**		 * TextDisplay Static Constructor		 */		public function TextDisplay() {			throw new Error( "TextDisplay is a static class and cannot be instantiated." );		}	}}