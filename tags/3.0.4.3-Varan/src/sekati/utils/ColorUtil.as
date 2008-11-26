/** * sekati.utils.ColorUtil * @version 1.1.8 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php *  * Some methods adapted/ported from Nate Cook's AdvanceColor (AS2):  * http://natecook.com/downloads/color/AdvancedColor_2.as * @see http://www.libspark.org/browser/as3/Study/SoundStudy/sketchbook/colors/ColorUtil.as */package sekati.utils {	import sekati.display.CoreBitmapData;	import sekati.math.MathBase;	import sekati.math.Random;	import sekati.math.Range;		import flash.display.BitmapData;	import flash.display.DisplayObject;	import flash.geom.ColorTransform;			/**	 * Static class wrapping various Color utilities.	 * @see http://en.wikipedia.org/wiki/HSV_color_space	 */	public class ColorUtil {		public static const RGB_MAX : uint = 256;		public static const HUE_MAX : uint = 360;		public static const PCT_MAX : uint = 100;		// RGB(A) HEX GETTER (sampler) & SETTER		/**		 * Return the (A)RGB <i>hexadecimal</i> color value of a DisplayObject.		 * @param src 		of the display object.		 * @param x 		position to sample.		 * @param y 		position to sample.		 * @param getAlpha 	if true return is RGBA, else RGB.		 */		public static function getColor(src : DisplayObject, x : uint = 0, y : uint = 0, getAlpha : Boolean = false) : uint {			var w : Number =  MathBase.clamp( src.width, 1, CoreBitmapData.MAX_SIZE );			var h : Number = MathBase.clamp( src.height, 1, CoreBitmapData.MAX_SIZE );			var bmp : BitmapData = new BitmapData( w, h );			bmp.draw( src );			var color : uint = (!getAlpha) ? bmp.getPixel( int( x ), int( y ) ) : bmp.getPixel32( int( x ), int( y ) );			bmp.dispose( );			return color;		}		/**		 * Set the (A)RGB <i>hexadecimal</i> color value of a DisplayObject using ColorTransform.		 */		public static function setColor(src : DisplayObject, hex : uint) : void {			var ct : ColorTransform = src.transform.colorTransform;			ct.color = hex;			src.transform.colorTransform = ct;		}				// RANDOMIZABLES		/**		 * Generate a random hexidecimal color.		 * @see sekati.math.Random		 */		public static function randomColor() : uint {			return Random.hexColor( );		}		// COLOR TRANSFORM GETTERS, SETTERS & TRANSFORMATIONS		/**		 * Inverts the color of the DisplayObject.		 */		public static function invertColor(src : DisplayObject) : void {			var t : Object = ColorUtil.getTransform( src );			ColorUtil.setTransform( src, {					ra : -t['ra'], ga : -t['ga'], ba : -t['ba'], rb : 255 - t['rb'], gb : 255 - t['gb'], bb : 255 - t['bb'] 				} ) ;		}		/**		 * Reset the color of the DisplayObject to its original view (pre-ColorTransformed).		 */		public static function resetColor(src : DisplayObject) : void { 			ColorUtil.setTransform( src, {ra:100, ga:100, ba:100, rb:0, gb:0, bb:0} ) ;		}					/**		 * Returns the transform value set by the last setTransform() call.		 * @return An object containing the current offset and percentage values for the color.		 */		public static function getTransform(src : DisplayObject) : Object {			var ct : ColorTransform = src.transform.colorTransform;			return {ra: ct.redMultiplier * 100, rb: ct.redOffset, ga: ct.greenMultiplier * 100, gb: ct.greenOffset, ba: ct.blueMultiplier * 100, bb: ct.blueOffset, aa:ct.alphaMultiplier * 100, ab: ct.alphaOffset};		}		/**		 * Set ColorTransform information for a DisplayObject.		 * 		 * <p>The colorTransformObject parameter is a generic object that you create from the new Object constructor. It has parameters specifying the percentage and 		 * offset values for the red, green, blue, and alpha (transparency) components of a color, entered in the format 0xRRGGBBAA.</p>		 * 		 * @param transformObject An object created with the new Object constructor. This instance of the Object class must have the following properties 		 * that specify color transform values: ra, rb, ga, gb, ba, bb, aa, ab. These properties are explained in the above summary for the setTransform() method. 		 */		public static function setTransform( src : DisplayObject, transformObject : Object ) : void {			var t : Object = {ra:100, rb:0, ga:100, gb:0, ba:100, bb:0, aa:100, ab:0};			for (var p:String in transformObject) {				t[p] = transformObject[p];			}			var ct : ColorTransform = new ColorTransform( t['ra'] * 0.01, t['ga'] * 0.01, t['ba'] * 0.01, t['aa'] * 0.01, t['rb'], t['gb'], t['bb'], t['ab'] );			src.transform.colorTransform = ct;		}		// STRING CONVERSIONS, PARSERS & FORMATTERS			/**		 * Parse a String representation of a color (hex or html) to uint.		 */		public static function toColor(str : String) : uint {			if (str.substr( 0, 2 ) == '0x') {				str = str.substr( 2 );			} else if (str.substr( 0, 1 ) == '#') {				str = str.substr( 1 );			}			return parseInt( str, 16 );		}		/**		 * Convert a hexidecimal number to a string representation with ECMAScript notation: <code>0xrrggbb</code>.		 */		public static function toHexString(hex : uint) : String {			return "0x" + (hex.toString( 16 )).toUpperCase( ); 		}		/**		 * Convert a hexidecimal number to a string representation with HTML notation: <code>#rrggbb</code>.		 */		public static function toHTML(hex : uint) : String {			return "#" + (hex.toString( 16 )).toUpperCase( ); 		}		/**		 * Convert hue to RGB values using a linear transformation.		 * @param min 	of R,G,B.		 * @param max 	of R,G,B.		 * @param hue 	value angle hue.		 * @return 		Object with R,G,B properties on 0-1 scale.		 */ 		public static function HueToRGB(min : Number, max : Number, hue : Number) : Object {			var mu : Number, md : Number, F : Number, n : Number;			while (hue < 0) {				hue += HUE_MAX;			}			n = Math.floor( hue / 60 );			F = (hue - n * 60) / 60;			n %= 6;					mu = min + ((max - min) * F);			md = max - ((max - min) * F);					switch (n) {				case 0: 					return {r: max, g: mu, b: min};				case 1: 					return {r: md, g: max, b: min};				case 2: 					return {r: min, g: max, b: mu};				case 3: 					return {r: min, g: md, b: max};				case 4: 					return {r: mu, g: min, b: max};				case 5: 					return {r: max, g: min, b: md};			}			return null;		}		/**		 * Convert RGB values to a hue using a linear transformation.		 * @param red 		value on 0 to 1 scale.		 * @param green 	value on 0 to 1 scale.		 * @param blue 		value on 0 to 1 scale.		 * @return 			hue degree between 0 and 360.		 */ 		public static function RGBToHue(red : Number, green : Number, blue : Number) : uint {			var f : Number, min : Number, mid : Number, max : Number, n : Number;					max = Math.max( red, Math.max( green, blue ) );			min = Math.min( red, Math.min( green, blue ) );					// achromatic case			if (max - min == 0) {				return 0;			}					mid = Range.center( red, green, blue );				// using this loop to avoid super-ugly nested ifs			while (true) {				if (red == max) {					if (blue == min) n = 0; else n = 5;					break;				}								if (green == max) {					if (blue == min) n = 1; else n = 2;					break;				}								if (red == min) n = 3; else n = 4;				break;			}					if ((n % 2) == 0) {				f = mid - min;			} else {				f = max - mid;			}			f = f / (max - min);					return 60 * (n + f);		}		// HSL				/**		 * Convert an RGB Hexidecimal value to HSL values		 * @param red 		0 - 1 scale.		 * @param green 	0 - 1 scale.		 * @param blue 		0 - 1 scale.		 * @return Object with h (hue), l (lightness), s (saturation) values:<ul>		 * <li><code>h</code> on 0 - 360 scale.</li>		 * <li><code>l</code> on 0 - 255 scale.</li>		 * <li><code>s</code> on 0 - 1 scale.</li></ul>		 */		public static function RGBtoHSL(red : Number, green : Number, blue : Number) : Object {			var min : Number, max : Number, delta : Number, l : Number, s : Number, h : Number = 0;							max = Math.max( red, Math.max( green, blue ) );			min = Math.min( red, Math.min( green, blue ) );						//l = (min + max) / 2;			l = (min + max) * 0.5;					// L			if (l == 0) {				return {h:h, l:0, s:1};			}					//delta = (max - min) / 2;			delta = (max - min) * 0.5;					if (l < 0.5) {													// S				s = delta / l;			} else {				s = delta / (1 - l);			}			// H			h = RGBToHue( red, green, blue );					return {h:h, l:l, s:s};									}		/**		 * Convert HSL values to RGB values.		 * @param hue 			0 to 360.		 * @param luminance 	0 to 1.		 * @param saturation 	0 to 1.		 * @return 				Object with R,G,B values on 0 to 1 scale.		 */ 		public static function HSLtoRGB(hue : Number, luminance : Number, saturation : Number) : Object {			var delta : Number;			if (luminance < 0.5) {				delta = saturation * luminance;			} else {				delta = saturation * (1 - luminance);			}			return HueToRGB( luminance - delta, luminance + delta, hue );		}		// HSV				/**		 * Convert RGB values to HSV values.		 * @param red 		0 to 1 scale.		 * @param green 	0 to 1 scale.		 * @param blue 		0 to 1 scale.		 * @return 			Object with H,S,V values:<ul>		 * 						<li>h - on 0 to 360 scale</li>		 * 						<li>s - on 0 to 1 scale</li>		 * 						<li>v - on 0 to 1 scale</li></ul>		 */ 		public static function RGBtoHSV(red : Number, green : Number, blue : Number) : Object {			var min : Number, max : Number, s : Number, v : Number, h : Number = 0;					max = Math.max( red, Math.max( green, blue ) );			min = Math.min( red, Math.min( green, blue ) );					if (max == 0) {				return {h:0, s:0, v:0};			}					v = max;			s = (max - min) / max;				h = RGBToHue( red, green, blue );					return {h:h, s:s, v:v};		}		/**		 * Convert HSV values to RGB values.		 * @param hue 			on 0 to 360 scale.		 * @param saturation 	on 0 to 1 scale.		 * @param value 		on 0 to 1 scale.		 * @return 				Object with R,G,B values on 0 to 1 scale.		 */ 		public static function HSVtoRGB(hue : Number, saturation : Number, value : Number) : Object {			var min : Number = (1 - saturation) * value;					return HueToRGB( min, value, hue );		}		/**		 * Convert HSV to HLS using RGB conversions: color preservation may be dubious.		 */		public static function HSVtoHSL(hue : Number, saturation : Number, value : Number) : Object {			var rgbVal : Object = HSVtoRGB( hue, saturation, value );			return RGBtoHSL( rgbVal.r, rgbVal.g, rgbVal.b );		}		/**		 * Convert HSL to HSV using RGB conversions: color preservation may be dubious.		 */		public static function HSLtoHSV(hue : Number, luminance : Number, saturation : Number) : Object {			var rgbVal : Object = HSLtoRGB( hue, luminance, saturation );			return RGBtoHSV( rgbVal.r, rgbVal.g, rgbVal.b );		}		// RGB COMPONENT GETTER/SETTER.				/**		 * Set the color of a DisplayObject from RGB components.		 */		public static function setRGBComponent(src : DisplayObject, r : Number, g : Number, b : Number) : void {			r = MathBase.limit( r, 0, RGB_MAX, false );			g = MathBase.limit( g, 0, RGB_MAX, false );			b = MathBase.limit( b, 0, RGB_MAX, false );				setColor( src, hexFromComponents( r, g, b ) );		}		/**		 * Get the RGB components from a DisplayObject.		 * @param src 	to sample color from.		 * @param x 	location to sample.		 * @param y 	location to sample.		 * @return 		component object.		 */		public static function getRGBComponent(src : DisplayObject, x : uint = 0, y : uint = 0) : Object {			var tmpVal : Object = componentsFromHex( getColor( src, x, y ) );			return {r:tmpVal.r, g:tmpVal.g, b:tmpVal.b};		}		// HSL COMPONENT GETTER/SETTER.				/**		 * Set the color of a DisplayObject from HSL components.		 */		public static function setHSLComponent(src : DisplayObject, h : Number, l : Number, s : Number) : void {			h = MathBase.limit( h, 0, HUE_MAX, true );			l = MathBase.limit( l, 0, PCT_MAX, false ) / PCT_MAX;			s = MathBase.limit( s, 0, PCT_MAX, false ) / PCT_MAX;				var rgbVal : Object = HSLtoRGB( h, l, s );			setColor( src, hexFromPercentages( rgbVal ) );		}		/**		 * Get the HSL components from a DisplayObject.		 * @param src 	to sample color from.		 * @param x 	location to sample.		 * @param y 	location to sample.		 * @return 		component object.		 */		public static function getHSLComponent(src : DisplayObject, x : uint = 0, y : uint = 0) : Object {			var rgbVal : Object = componentsFromHex( getColor( src, x, y ) );			rgbVal.r /= 256;			rgbVal.g /= 256;			rgbVal.b /= 256;					var hslVal : Object = RGBtoHSL( rgbVal.r, rgbVal.g, rgbVal.b );					hslVal.h = Math.round( hslVal.h );			hslVal.l = Math.round( hslVal.l * PCT_MAX );			hslVal.s = Math.round( hslVal.s * PCT_MAX );					return hslVal;		}		// HSV COMPONENT GETTER/SETTER				/**		 * Set the color of a DisplayObject from HSV components.		 */		public static function setHSVComponent(src : DisplayObject, h : Number, s : Number, v : Number) : void {			h = MathBase.limit( h, 0, HUE_MAX, true );			s = MathBase.limit( s, 0, PCT_MAX, false ) / PCT_MAX;			v = MathBase.limit( v, 0, PCT_MAX, false ) / PCT_MAX;				var rgbVal : Object = HSVtoRGB( h, s, v );			setColor( src, hexFromPercentages( rgbVal ) );		}		/**		 * Get the HSV components from a DisplayObject.		 * @param src 	to sample color from.		 * @param x 	location to sample.		 * @param y 	location to sample.		 * @return 		component object.		 */		public static function getHSVComponent(src : DisplayObject, x : uint = 0, y : uint = 0) : Object {			var rgbVal : Object = componentsFromHex( getColor( src, x, y ) );			rgbVal.r /= 256;			rgbVal.g /= 256;			rgbVal.b /= 256;				var hsvVal : Object = RGBtoHSV( rgbVal.r, rgbVal.g, rgbVal.b );				hsvVal.h = Math.round( hsvVal.h );			hsvVal.s = Math.round( hsvVal.s * PCT_MAX );			hsvVal.v = Math.round( hsvVal.v * PCT_MAX );					return hsvVal;		}				// RGB COMPONENT CONVERSIONS				/**		 * Convert an RGB hexidecimal value to an object containing its R,G,B components.		 * TODO - refactor to getRGB or toRGBComponents		 */		public static function componentsFromHex(hex : uint) : Object {			/*			var tmp : Object = new Object( );			tmp.r = Math.floor( hex / (RGB_MAX * RGB_MAX) );			tmp.g = Math.floor( (hex / RGB_MAX) % RGB_MAX );			tmp.b = Math.floor( hex % RGB_MAX );			 */			var r : Number = hex >> 16 & 0xff;			var g : Number = hex >> 8 & 0xff;			var b : Number = hex & 0xff;			return {r:r, g:g, b:b};					}			/**		 * Convert an RGB Object to a hexidecimal color value.		 */		public static function hexFromPercentages(rgbObj : Object) : uint {			return hexFromComponents( rgbObj.r * RGB_MAX, rgbObj.g * RGB_MAX, rgbObj.b * RGB_MAX );		}		/**		 * Convert individual R,G,B values to a hexidecimal value.		 */		public static function hexFromComponents(r : uint, g : uint, b : uint) : uint {			var hex : uint = 0;			hex += (r << 16);			hex += (g << 8);			hex += (b);			return hex;	 		}		//---------------------------------------------------------------------------------		// TODO - Methods below are being integrated into the utility (some overlap with 		// 		  existing methods may exist.				/**		 * @private		 */		public static function getARGB(rgb : uint) : Object {			var a : Number = rgb >> 24 & 0xff;			var r : Number = rgb >> 16 & 0xff;			var g : Number = rgb >> 8 & 0xff;			var b : Number = rgb & 0xff;			return {a:a, r:r, g:g, b:b};		}		/**		 * @private		 */		public static function setARGB(a : Number,r : Number,g : Number,b : Number) : uint {			var argb : uint = 0;			argb += (a << 24);			argb += (r << 16);			argb += (g << 8);			argb += (b);			return argb;		}		/**		 * @private		 */		public static function toGrayscale(hex : uint) : uint {			var color : Object = getARGB( hex );			var c : Number = 0;			c += color.r * .3;			c += color.g * .59;			c += color.b * .11;			color.r = color.g = color.b = c;			return setARGB( color.a, color.r, color.g, color.b );		}				/**		 * Change the contrast of a hexidecimal Number by a certain increment		 * @param hex 		color value to shift contrast on		 * @param inc 		increment value to shift		 * @return new hex color value		 */		public static function changeContrast(hex : Number, inc : Number) : Number {			var o : Object = componentsFromHex( hex );			o.r = MathBase.clamp( o.r + inc, 0, 255 );			o.g = MathBase.clamp( o.g + inc, 0, 255 );			o.b = MathBase.clamp( o.b + inc, 0, 255 );			return hexFromComponents( o.r, o.g, o.b );		}			/**		 * ColorUtils Static Constructor		 */		public function ColorUtil() {			throw new Error( "ColorUtils is a static class and cannot be instantiated." );		}	}}