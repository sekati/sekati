/** * sekati.tests.TestApplication * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests {	import sekati.display.Document;	/**	 * TestApplication provides a baseline implementation of the API.	 */	public class TestApplication extends Document {		/**		 * TestApplication Constructor		 */		public function TestApplication() {			super( );		}				/**		 * <code>initAPI</code> is overriden to skip the <code>Bootstrap</code> 		 * sequence in this test application to run the API "dumb".		 */		override protected function initAPI(hasBootstrap : Boolean = false) : void {			super.initAPI( hasBootstrap );		}	}}