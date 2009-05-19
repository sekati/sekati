/** * sekati.external.BrowserAddress * @version 1.0.3 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.external {	import sekati.log.Logger;	import sekati.utils.StringUtil;	import sekati.utils.TypeEnforcer;	import flash.external.ExternalInterface;			/**	 * BrowserAddress provides <i>basic</i> deeplinking through URL anchor getters and setters.	 * 	 * <p>While not as powerful or full-featured as <code>BrowserManager</code> or <code>SWFAddress</code> it is far easier	 * to implement and support as there is no need to write back/forward code-jumps from all points in the site but only 	 * during initialization. The model:<ol>	 * <li>Check for anchor links during App initialization & respond with jump code when appropriate.</li>	 * <li>Set links as the user drills down to key points in the site or application experience</li>	 * </ol></p> 	 * 	 * @see sekati.managers.BrowserManager	 */	public class BrowserAddress {		protected static var baseURL : String = ExternalInterface.call( "function( ) { document.location.href.split('#/')[0]; }" );		protected static var baseTitle : String = ExternalInterface.call( "function( ) { document.title; }" );		/**		 * Returns value of the _anchor		 */		public static function get anchor() : String {			var js : String = "function( ) { return document.location.href.split( '#/' )[1]; }";			return ExternalInterface.call( js );		}		/*** @private */		public static function set anchor(val : String) : void {			val = (!StringUtil.beginsWith( val, '/' )) ? val : val.substr( 1, val.length - 1 );			var js : String = "function( ) { document.location.href = document.location.href.split('#/')[0] + '#/" + val + "'; }";			ExternalInterface.call( js );			Logger.$.info( BrowserAddress, "* BrowserAddress.anchor => '" + val + "'" );		}		/**		 * Returns value of property		 */		public static function get title() : String {			var js : String = "function( ) { return document.title; }";			return ExternalInterface.call( js );		}		/*** @private */		public static function set title(val : String) : void {			var js : String = "function( ) { document.title = '" + val + "'; }";			ExternalInterface.call( js );			Logger.$.info( BrowserAddress, "* BrowserAddress.title => '" + val + "'" );		}		/**		 * Return the full Browser URL		 */		public static function get href() : String {			var js : String = "function( ) { return document.location.href; }";			return ExternalInterface.call( js );		}				/**		 * Move forward in the browser history.		 */		public static function forward() : void {			var js : String = "function( ) { return window.history.forward(); }";			ExternalInterface.call( js );					}				/**		 * Move back in the browser history.		 */		public static function back() : void {			var js : String = "function( ) { return window.history.back(); }";			ExternalInterface.call( js );					}				/**		 * Jump to an index in the browser history.		 */		public static function go(delta : int = 1) : void {			var js : String = "function( ) { return window.history.go(" + delta + "); }";			ExternalInterface.call( js );		}				/**		 * BrowserAddress Static Constructor		 */		public function BrowserAddress() {			TypeEnforcer.enforceStatic( BrowserAddress );		}	}}