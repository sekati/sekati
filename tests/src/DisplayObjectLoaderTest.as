/** * DisplayObjectLoaderTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package {	import sekati.load.DisplayObjectLoader;			/**	 * DisplayObjectLoaderTest	 */	public class DisplayObjectLoaderTest extends AbstractTestApplication {		private var loader : DisplayObjectLoader;		private static const IMAGE_URL : String = 'http://localhost/sekati/deploy/assets/test0.jpg';		public function DisplayObjectLoaderTest() {			super( );		}		override protected function initEntryPoint() : void {			super.initEntryPoint( );			loader = new DisplayObjectLoader( );			//loader.load( IMAGE_URL );		}	}}