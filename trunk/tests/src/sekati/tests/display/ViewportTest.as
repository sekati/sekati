/** * ViewportTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.display {	import sekati.ui.Viewport;		/**	 * ViewportTest	 */	public class ViewportTest extends AbstractTestApplication {		public function ViewportTest() {			super( );		}		override protected function initEntryPoint() : void {			super.initEntryPoint( );			Viewport.$.init( this, 25 );			Viewport.$.render( );			}	}}