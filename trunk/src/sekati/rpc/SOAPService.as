/** * sekati.rpc.SOAPService * @version 1.0.2 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.rpc {	import flash.events.EventDispatcher;	import flash.system.ApplicationDomain;	import mx.core.Singleton;	import mx.rpc.events.FaultEvent;	import mx.rpc.events.ResultEvent;	import mx.rpc.soap.LoadEvent;	import mx.rpc.soap.WebService;	import sekati.events.ServiceEvent;	import sekati.log.Logger;		/**	 * SOAPService provides a SOAP WebService client interface.	 * 	 * <p><b>WARNING</b>: SOAPService cannot be compiled with the flash IDE as of Flash CS3 due to its dependency	 * on the Flex3 SDK core which is required to be initialized to access <code>mx.rpc.WebService</code>. This 	 * means that compilation must take place either within a Flex Project or (thanks to the <code>initFlexCore</code>	 * work-around in a pure actionscript project with mxmlc (e.g. FlexBuilder or FDT).</p>	 * 	 * @example <listing version="3.0">	 * 	ws = new SOAPService( 'http://archive.sekati.com/swsdk/soap_server.php?wsdl', 'SekatiWebServiceKit' );	 * 		 * 	ws.addEventListener( ServiceEvent.LOAD, loadHandler );	 * 	ws.addEventListener( ServiceEvent.FAULT, faultHandler );	 * 	ws.addEventListener( ServiceEvent.RESULT, resultHandler );	 * 		 * 	protected function loadHandler(e : ServiceEvent) : void {	 * 		trace( "LOAD HANDLER:###:::::%%%%->" + e.type );	 * 		ws.service.serviceTest( );	 * 		ws.service.helloWorld( 'jason' );	 * 		ws.service.doPercent( 15, 500 );	 * 		ws.service.fakeMethodWillFail( );	 * 	}			 * 		 * 	protected function resultHandler(e : ServiceEvent) : void {	 * 		trace( "RESULT.HANDLER:###:::::%%%%=> [" + e.result + "]" );	 * 	}		 * 		 * 	protected function faultHandler(e : ServiceEvent) : void {	 * 		trace( "FAULT.HANDLER:###:::::%%%%=> [" + e.fault + "]" );	 * 	}				 * </listing>	 * 	 * @see sekati.events.ServiceEvent	 */	public class SOAPService extends EventDispatcher {		protected var ws : WebService;		protected var isServiceLoaded : Boolean = false;		/**		 * SOAPService Constructor		 * @param wsdl 		webservice url		 * @param service 	webservice name		 * @param port 		webservice port		 */		public function SOAPService(wsdl : String, service : String = null, port : String = null) {						initFlexCore( );						ws = new WebService( );			ws.wsdl = wsdl;			ws.service = service;			ws.port = port;						ws.addEventListener( LoadEvent.LOAD, serviceLoad, false, 0, true );			ws.addEventListener( FaultEvent.FAULT, serviceFault, false, 0, true );			ws.addEventListener( ResultEvent.RESULT, serviceResult, false, 0, true );						ws.loadWSDL( );		}			/**		 * <code>mx.rpc.soap.WebService</code> dies when built in a pure ActionScript projects as it requires the Flex core be initialized		 * (as it is in a flex project), therefore we must fake it to use flex bound classes: really lame.		 */		protected function initFlexCore() : void {			var resourceManagerImpl : Object = ApplicationDomain.currentDomain.getDefinition( "mx.resources::ResourceManagerImpl" ); 			Singleton.registerClass( "mx.resources::IResourceManager", Class( resourceManagerImpl ) );			}		/**		 * Mark the WebService WSDL as loaded and accessible for RPC calls.		 */		protected function serviceLoad(e : LoadEvent) : void {			Logger.$.status( this, "WebService LOAD => " + ws.wsdl );			isServiceLoaded = true;			dispatchEvent( new ServiceEvent( ServiceEvent.LOAD ) );		}		/**		 * Dispatch information about failures.		 */		protected function serviceFault(e : FaultEvent) : void {			Logger.$.error( this, "WebService FAULT => " + e.fault );						dispatchEvent( new ServiceEvent( ServiceEvent.FAULT, null, e.fault ) );		}		/**		 * Dispatch the results of a webservice method call.		 */		protected function serviceResult(e : ResultEvent) : void {			Logger.$.info( this, "WebService RESULT => " + e.result );			dispatchEvent( new ServiceEvent( ServiceEvent.RESULT, e.result ) );		}		/**		 * Return the WebService reference for direct RPC calls.		 */		public function get service() : WebService {			return ws;		}		/**		 * Return the WebService availability status.		 */		public function get available() : Boolean {			return isServiceLoaded;		}	}}