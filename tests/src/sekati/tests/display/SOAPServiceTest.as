/** * SOAPServiceTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.display {	import flash.events.Event;	import sekati.events.ServiceEvent;	import sekati.rpc.SOAPService;			/**	 * SOAPServiceTest	 */	public class SOAPServiceTest extends AbstractTestApplication {		public var ws : SOAPService;		public function SOAPServiceTest() {			super( );		}		/**		 * @inheritDoc		 */		override protected function initEntryPoint() : void {			super.initEntryPoint( );			ws = new SOAPService( 'http://archive.sekati.com/swsdk/soap_server.php?wsdl', 'SekatiWebServiceKit' );			ws.addEventListener( ServiceEvent.LOAD, loadHandler );			ws.addEventListener( ServiceEvent.FAULT, faultHandler );			ws.addEventListener( ServiceEvent.RESULT, resultHandler );		}		/**		 * Once the service is loaded: make some calls to the remote method ...		 */		protected function loadHandler(e : ServiceEvent) : void {			trace( "LOAD HANDLER:###:::::%%%%->" + e.type );			ws.service.serviceTest( );			ws.service.helloWorld( 'jason' );			ws.service.doPercent( 15, 500 );			ws.service.fakeMethodWillFail( );		}				/**		 * Handle SOAPService results.		 */		protected function resultHandler(e : ServiceEvent) : void {			trace( "RESULT.HANDLER:###:::::%%%%=> [" + e.result + "]" );		}			/**		 * Handle SOAPService faults.		 */		protected function faultHandler(e : ServiceEvent) : void {			trace( "FAULT.HANDLER:###:::::%%%%=> [" + e.fault + "]" );		}				}}