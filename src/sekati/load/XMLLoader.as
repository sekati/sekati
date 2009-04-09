/** * @version 1.0 * @author David Dahlstroem | hello@daviddahlstroem.com *  * Copyright (C) 2009 David Dahlstroem. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.load{	import sekati.core.Cancelable;		import flash.net.URLLoaderDataFormat;	import flash.net.URLRequest;		/**	 * XMLLoader provides a standard API loader for <code>XML</code> content.	 */		public class XMLLoader extends URLDataLoader implements Loadable, Cancelable 	{				/**		 * XMLLoader Constructor		 */				public function XMLLoader(request:URLRequest, loaderName:String = null)		{			super(request, loaderName);						dataFormat = URLLoaderDataFormat.TEXT;		}				/**		 * Returns the loaded data as XML.		 */				public function get xml():XML		{			return new XML(data);		}	}}