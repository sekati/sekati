/** * sekati.transitions.Motion * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.transitions {	import flash.display.DisplayObject;	import caurina.transitions.Tweener;	/**	 * Motion provides some common <a href="">Tweener</a> shortcuts.	 * @example <listing version="3.0">	 * 	Tweener.addTween( mySprite, base:Motion.base, x:100 ); // a base transition	 * 	Tweener.addTween( mySprite, base:Motion.base, transition:Motion.o.expo, y:100 ); // a customized base transition 	 * </listing>	 */	public class Motion {		/* Easing Equation Shortcuts */		/**		 * EaseIn Shortcuts		 */		public static const i : Object = { quint:"easeInQuint", quad:"easeInQuad", quart:"easeInQuart", expo:"easeInExpo", cubic:"easeInCubic" };		/**		 * EaseOut Shortcuts		 */		public static const o : Object = { quint:"easeOutQuint", quad:"easeOutQuad", quart:"easeOutQuart", expo:"easeOutExpo", cubic:"easeOutCubic" };		/**		 * EaseInOut Shortcuts		 */		public static const io : Object = { quint:"easeInOutQuint", quad:"easeInOutQuad", quart:"easeInOutQuart", expo:"easeInOutExpo", cubic:"easeOutCubic" };		/**		 * Time Shortcuts		 */		public static const time : Object = { short:0.3, medium:0.5, long:0.7, xlong:1 };		/* Base Transitions */		public static function get base() : Object {			return {time:0.5, transition:o['quad'] };		}		public static function get baseShort() : Object {			return {time:0.3, transition:o['quad'] };		}		public static function get baseMedium() : Object {			return {time:0.7, transition:o['quad'] };		}		public static function get baseLong() : Object {			return {time:1, transition:io['quad'] };		}		public static function get baseXLong() : Object {			return {time:1.3, transition:io['quad'] };		}		/* Fade Transitions */		public static function fadeTo(a : Number) : Object {			return { alpha:a, time:0.3, transition:io['expo'] };			}							public static function get fadeIn() : Object {			return Motion.fadeTo( 1 );			}		public static function get fadeOut() : Object {			return Motion.fadeTo( 0 );			}		/**		 * Return a base tween object glow transition		 * @param a 	alpha [0-1]		 * @param b 	blur [0-255]		 * @param c 	color [hex]		 * @param s 	strength [0-255]		 * @return Object		 */		public static function glow(a : Number, b : Number, c : Number, s : Number) : Object {			return {_Glow_alpha:a, _Glow_color:c, _Glow_quality:3, _Glow_strength:s, _Glow_blurX:b, _Glow_blurY:b};			}		/**		 * Create a small "burst" transition		 */			public static function burst(o : DisplayObject, c : Number, cb : Function) : void {			Tweener.addTween( o, {_scale:10, time:0.3, transition:Motion.o['quint']} );			Tweener.addTween( o, {_Glow_alpha:100, _Glow_color:c, _Glow_quality:3, _Glow_strength:10, _Glow_blurX:25, _Glow_blurY:25, _scale:150, time:0.3, transition:io['quad'], delay:0.3} );			Tweener.addTween( o, {_alpha:0, _scale:50, time:0.5, transition:Motion.o['quint'], delay:0.6, onComplete:cb} );		}		/**		 * Normalize a clip		 */		public static function normalize(o : DisplayObject) : void {			o.filters = [];			o.scaleX = 100;			o.scaleY = 100;			Tweener.addTween( o, {_color:undefined, time:0} );			}		/**		 * Return a base tween object color transition		 */		public static function colorTo(c : Number) : Object {			return { _color:c, time:0.3, transition:Motion.io['quint'] };			}		/**		 * Motion Static Constructor		 */		public function Motion() {			throw new Error( "Motion is a static class and cannot be instantiated." );		}		}}