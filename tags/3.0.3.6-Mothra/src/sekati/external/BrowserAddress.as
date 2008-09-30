/** * sekati.external.BrowserAddress * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.external {	import flash.external.ExternalInterface;				/**	 * BrowserAddress provides basic deeplinking through URL anchor getters and setters.	 * 	 * <p>While not as powerful or full-featured as <code>SWFAddress</code> it is far easier	 * to implement and support as there is no need to write back/forward code-jumps from all points in the	 * site but only during initialization. The model:<ol>	 * <li>Check for anchor links during App initialization & respond with jump code when appropriate.</li>	 * <li>Set links as the user drills down to key points in the site or application experience</li>	 * </ol></p> 	 */	public class BrowserAddress {		protected static var baseURL : String = ExternalInterface.call( "function( ) { document.location.href.split('#')[0]; }" );		protected static var baseTitle : String = ExternalInterface.call( "function( ) { document.title; }" );		/**		 * Returns value of the _anchor		 */		public function get anchor() : String {			return ExternalInterface.call( "function( ) { return document.location.href.split( '#' )[1]; }" );		}		/**		 * @private		 */		public function set anchor(val : String) : void {			ExternalInterface.call( "function( ) { document.location.href = " + baseURL + " + '#' + " + val + " };" );		}		/**		 * Returns value of property		 */		public function get title() : String {			return ExternalInterface.call( "function( ) { return document.title; }" );		}		/**		 * @private		 */		public function set title(val : String) : void {			ExternalInterface.call( "function( ) { document.title = " + val + " };" );		}		/**		 * Return the full Browser URL		 */		public function get href() : String {			return ExternalInterface.call( "function( ) { return document.location.href;" );		}		/**		 * BrowserAddress Static Constructor		 */		public function BrowserAddress() {			throw new Error( "BrowserAddress is a static class and cannot be instantiated." );		}	}}