/** * sekati.tests.TestDocument * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import sekati.display.Canvas;	import sekati.display.StageDisplay;	/**	 * TestDocument provides base initialization of the API Canvas.	 */	public class TestDocument extends Canvas {		/**		 * TestDocument Constructor		 */		public function TestDocument() {			super( );			StageDisplay.$.init( );		}	}}