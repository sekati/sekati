/** * APITestSuite * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.unit {	import flexunit.framework.Test;	import flexunit.framework.TestSuite;			/**	 * APITestSuite provides an index of all APITestCases.	 */	public class APITestSuite extends TestSuite implements Test {		/**		 * APITestSuite Constructor		 */		public function APITestSuite(param : Object = null) {			super( param );			addCases( );		}		/**		 * Add the APITestCases.		 */			private function addCases() : void {			addTestSuite( StringUtilTest );			addTestSuite( StringValidatorTest );		}	}}