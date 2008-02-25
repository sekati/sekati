/** * sekati.utils.DisplayUtils * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.utils {	import flash.display.*;	import flash.geom.ColorTransform;	import flash.utils.*;	import sekati.utils.Assert;	/**	 * Static class wrapping various DisplayObject utilities.	 */	public class DisplayUtils {		/**		 * Re-scales elements on the timeline to 100% and then resizes		 * to fit the previously stretched dimensions.		 * @param o		The stretched movie.		 * @param child 	If there are children of the movie, they are also stretched.		 */				public static function sizeContent(o : DisplayObject, child : DisplayObject = null) : void {			var w : Number = o.width;			var h : Number = o.height;			o.scaleX = o.scaleY = 1;			if (child) {				child.width = w;				child.height = h;			}		}		/**		 * Turns button behavior of a sprite on.		 */				public static function makeButton(o : Sprite) : void {			o.buttonMode = true;			o.mouseChildren = false;		}		/**		 * Removes all display children from a container.		 */		public static function rmChildren(o : DisplayObjectContainer) : void {			var numChildren : int = o.numChildren;			for (var i : int = 0; i < numChildren ; i++) {				try {					//since removing 0 shifts everything down, keep removing 0.					o.removeChildAt( 0 );				} catch (error : Error) {					trace( "Error removing child during ElementUtility.removeAllChildren(): " + error.message );				}			}			Assert.assert( o.numChildren == 0 );		}		/**		 * Change the color of a display object, works when setting the color property of the colorTransform does not,		 * for "stubborn" elements.		 */		public static function color(mc : DisplayObject, color : uint) : void {			var MASK : uint = 0xff;			var b : uint = color & MASK;			color >>= 8;			var g : uint = color & MASK;			color >>= 8;			var r : uint = color & MASK;						var cx : ColorTransform = mc.transform.colorTransform;			cx.redMultiplier = cx.greenMultiplier = cx.blueMultiplier = 0;			cx.redOffset = r;			cx.greenOffset = g;			cx.blueOffset = b;						mc.blendMode = BlendMode.LAYER;			mc.transform.colorTransform = cx;		}		/**		 * Unparents all arguments passed into the method		 */		public static function unparentDisplayObjects(...args) : void {			for each (var obj:Object in args) {				if (obj is DisplayObject) {					var mc : DisplayObject = DisplayObject( obj );					if (mc.parent && mc.parent.contains( mc )) {						mc.parent.removeChild( mc );					}				}			}		}		/**		 * Useful for templated items, returns the Class object that a display object instance is an instance of.		 * You can pass another class to ensure that the class is a subclass or implementor of a certain class or interface.		 */		public static function getClassFromInstance(instance : DisplayObject, requiredSubclass : Class = null) : Class {			var clazz : Class = null;			try {				var className : String = getQualifiedClassName( instance );				clazz = Class( getDefinitionByName( className ) );				if (requiredSubclass) {					if (!(instance is requiredSubclass)) clazz = null;				}			} catch (error : ReferenceError) {				return null;			}			return clazz;		}				/**		 * DisplayUtils Static Constructor		 */		public function DisplayUtils() {			throw new Error( "DisplayUtils is a static class and cannot be instantiated." );		}	}}