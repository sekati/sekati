/** * @version 1.0 * @author David Dahlstroem | hello@daviddahlstroem.com *  * Copyright (C) 2009 David Dahlstroem. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.load{	import sekati.core.Cancelable;		import flash.net.URLLoaderDataFormat;	import flash.text.StyleSheet;		/**	 * StyleSheetLoader provides a standard API loader for loading StyleSheets.	 */		public class StyleSheetLoader extends URLDataLoader implements Loadable, Cancelable 	{				/**		 * StyleSheetLoader Constructor		 * 		 * @param sourceURL URL pointing at the file to be loaded.		 * @param loaderName Optional name for the loader		 */				public function StyleSheetLoader(sourceURL:String, loaderName:String = null)		{			super(sourceURL, loaderName);						dataFormat = URLLoaderDataFormat.TEXT;		}				/**		 * @inheritDoc		 */		override public function get data():*		{			var			styleSheet:StyleSheet = new StyleSheet();			styleSheet.parseCSS(super.data as String);						return styleSheet;		}				/**		 * Parses the loaded data as StyleSheet and returns a StyleSheet instance.		 * 		 * @return New StyleSheet instance with the loaded StyleSheet parsed into it.		 */				public function get styleSheet():StyleSheet		{			return data as StyleSheet;		}	}}