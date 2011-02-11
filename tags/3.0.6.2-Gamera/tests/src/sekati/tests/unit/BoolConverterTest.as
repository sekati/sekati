/** * sekati.tests.unit.BoolConverterTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.unit {	import sekati.converters.BoolConverter;		import sekati.tests.unit.APITestCase;	/**	 * BoolConverterTest	 */	public class BoolConverterTest extends APITestCase {		public function BoolConverterTest(methodName : String = null) {			super( methodName );		}		public function testBoolConverter() : void {			assertFalse( "Boolean string false", BoolConverter.toBoolean( ) );			assertFalse( "Boolean string false", BoolConverter.toBoolean( null ) );			assertFalse( "Boolean string false", BoolConverter.toBoolean( "false" ) );			assertFalse( "Boolean string false", BoolConverter.toBoolean( "0" ) );			assertFalse( "Boolean number false", BoolConverter.toBoolean( 0 ) );			assertFalse( "Boolean string false", BoolConverter.toBoolean( "null" ) );			assertFalse( "Boolean string false", BoolConverter.toBoolean( "no" ) );			assertTrue( "Boolean string true", BoolConverter.toBoolean( "true" ) );			assertTrue( "Boolean string true", BoolConverter.toBoolean( true ) );			assertTrue( "Boolean string true", BoolConverter.toBoolean( "1" ) );			assertTrue( "Boolean string true", BoolConverter.toBoolean( "yes" ) );			assertTrue( "Boolean number true", BoolConverter.toBoolean( 1 ) );		}	}}