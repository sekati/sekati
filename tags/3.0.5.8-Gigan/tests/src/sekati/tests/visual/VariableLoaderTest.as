/** * sekati.tests.visual.VariableLoaderTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import sekati.load.VariableLoader;	import sekati.log.Logger;	import flash.events.Event;			/**	 * VariableLoaderTest	 */	public class VariableLoaderTest extends AbstractTestApplication {		private static const URL : String = 'http://localhost/sekati/deploy/assets/variables.txt';		private var loader : VariableLoader;		public function VariableLoaderTest() {			super( );		}		override protected function initEntryPoint() : void {			super.initEntryPoint( );			Logger.$.info( this, "Test starting ..." );			loader = new VariableLoader( URL );			loader.addEventListener( Event.INIT, initContent );			loader.load( );		}		/**		 * Respond to the load event!		 */		private function initContent(e : Event) : void {			Logger.$.notice( this, "Variables loaded ..." );			loader.removeEventListener( Event.INIT, initContent );			Logger.$.object( loader.content );			Logger.$.info( this, "URLVariables.toString: " + loader.content.toString( ) );		}	}}