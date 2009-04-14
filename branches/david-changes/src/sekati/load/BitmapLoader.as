/** * @version 1.0 * @author David Dahlstroem | hello@daviddahlstroem.com *  * Copyright (C) 2009 David Dahlstroem. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.load{	import sekati.core.Cancelable;		import flash.display.Bitmap;	import flash.display.BitmapData;		public class BitmapLoader extends BitmapDataLoader implements Loadable, Cancelable	{				public var smoothing:Boolean;				public function BitmapLoader(sourceURL:String, loaderName:String = null)		{			super(sourceURL, loaderName);		}				/**		 * @inheritDoc		 */				override public function get data():*		{			return new Bitmap(super.data as BitmapData, "auto", smoothing);		}				/**		 * @inheritDoc		 */				override public function reset():void		{			smoothing = false;						super.reset();		}				/**		 * @inheritDoc		 */				override public function clone():Object		{			var			loader:BitmapLoader = new BitmapLoader(getURL(), name);						loader.allowTransparency = allowTransparency;						loader.fillColor = fillColor;						loader.smoothing = smoothing;						return loader;		}	}}