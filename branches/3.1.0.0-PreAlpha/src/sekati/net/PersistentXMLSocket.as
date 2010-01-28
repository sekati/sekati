/** * sekati.net.PersistentXMLSocket * @version 1.0.6 * @author jason m horwitz | sekati.com * Copyright (C) 2010  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.net {	import sekati.log.Logger;	import flash.events.DataEvent;	import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.events.SecurityErrorEvent;	import flash.net.XMLSocket;	import flash.utils.clearInterval;	import flash.utils.setInterval;		/**	 * PersistentXMLSocket provides an advanced <code>XMLSocket</code>.	 * @see http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/net/XMLSocket.html	 */	public class PersistentXMLSocket extends XMLSocket {		public static const SOCKET_NULL_CHAR : String = "\0";		public static var RECONNECT_DELAY : int = 30000;		protected var _host : String;		protected var _port : int;		protected var _autoReconnect : Boolean;		protected var _reconnectInterval : int;		/**		 * PersistentXMLSocket Constructor		 * @param host			the hostname to connect the socket to.		 * @param port 			the socket port on the host.		 * @param autoConnect 	whether to automatically connect (<code>true</code>), or not (<code>false</code>).		 * @param autoReconnect	whether to automatically attempt reconnections once the connection is lost (<code>true</code>), or not (<code>false</code>).		 */		public function PersistentXMLSocket(host : String, port : int, autoConnect : Boolean = true, autoReconnect : Boolean = true) {			super( );			_host = host;			_port = port;			_autoReconnect = autoReconnect;			configureListeners( );			if(autoConnect) {				connect( _host, _port );			}		}		/**		 * Configure Socket listeners		 */		protected function configureListeners() : void {			addEventListener( Event.CONNECT, connectHandler, false, 0, true );						addEventListener( Event.CLOSE, closeHandler, false, 0, true );			addEventListener( DataEvent.DATA, dataHandler, false, 0, true );			addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true );			addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true );			}		/**		 * Attempt to reconnect to the socket which closed the connection.		 */		protected function reconnect() : void {			clearReconnectInterval( );			if(!connected) {				Logger.$.notice( this, " ... Reconnect attempt @ " + url + " ... retry in " + ( RECONNECT_DELAY / 1000 ) + "s ..." ); 				connect( _host, _port );				_reconnectInterval = setInterval( reconnect, RECONNECT_DELAY );			}		}		/**		 * Clear any reconnect attempts.		 */		protected function clearReconnectInterval() : void {			clearInterval( _reconnectInterval );			_reconnectInterval = NaN;		}		/**		 * Connect Handler.		 */		protected function connectHandler(e : Event) : void {			Logger.$.status( this, "Connected @ " + url );		}		/**		 * Close Handler.		 */		protected function closeHandler(e : Event) : void {			Logger.$.warn( this, "Disconnected @ " + url );			if(_autoReconnect) {				reconnect( );			}		}		/**		 * Data Handler.		 */		protected function dataHandler(e : DataEvent) : void {			Logger.$.info( this, "RX Data @ " + url );		}				/**		 * Security Error Handler.		 */		protected function securityErrorHandler(e : SecurityErrorEvent) : void {			Logger.$.error( this, url + " Security Error @ " + url + ": " + e );		}		/**		 * IO Error Handler.		 */		protected function ioErrorHandler(e : IOErrorEvent) : void {			Logger.$.error( this, url + " IO Error @ " + url + ": " + e );		}			/**		 * XMLSocket host.		 */		public function get host() : String {			return _host;		}		/**		 * XMLSocket port.		 */		public function get port() : int {			return _port;		}		/**		 * The XMLSocket URL.		 */		public function get url() : String {			return "xmlsocket://" + _host + ":" + _port;		}		/**		 * Whether the socket will attempt to auto-reconnect on disconnect.		 * @return Boolean		 */		public function get autoReconnect() : Boolean {			return _autoReconnect;		}		/*** @private */				public function set autoReconnect(autoReconnect : Boolean) : void {			_autoReconnect = autoReconnect;			// false: make sure we arent already trying a reconnect			if(!autoReconnect) {				clearReconnectInterval( );			}			// true: try to reconnect if we arent already			if(autoReconnect && !connected && !_reconnectInterval) {				reconnect( );							}		}	}}