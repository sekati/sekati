/** * sekati.core.App * @version 1.0.1 * @author jason m horwitz | sekati.com | tendercreative.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.core {	import flash.text.StyleSheet;	import sekati.display.Canvas;	import sekati.log.Logger;	import sekati.net.NetBase;	/**	 * App provides a common static storage area for API and application	 * instances, debuggers, data objects, vars & constants.	 * @see sekati.core.Bootstrap	 * @see sekati.display.Document	 */	dynamic public class App {				/**		 * Derived application path.		 */		public static var PATH : String = NetBase.getPath();				/**		 * Location of the <code>config.xml</code> file.		 */		public static var CONF_URI : String = ( !Canvas.flashVars['conf_uri'] ) ? App.PATH + "xml/config.xml" : Canvas.flashVars['conf_uri'];						/**		 * Application name as defined in <code>config.xml</code>.		 */		public static var APP_NAME : String;		/**		 * Application versions as defined in <code>config.xml</code>.		 */		public static var APP_VERSION : String;				/**		 * Crossdomain location as defined in <code>config.xml</code>.		 */		public static var CROSSDOMAIN_URI : String;				/**		 * External data XML location as defined in <code>config.xml</code>.		 */		public static var DATA_URI : String;				/**		 * External application CSS location as defined in <code>config.xml</code>.		 */		public static var CSS_URI : String;				/**		 * Determines whether advanced <code>Logger</code> output is generated. Defined in <code>config.xml</code>.		 */		public static var LOG_ENABLE : Boolean;		/**		 * The amount of system memory flash may utilize before an alarm <code>Logger</code> event fires. Defined in MegaBytes in <code>config.xml</code>.		 */		public static var MEMORY_ALARM : uint;				/**		 * Determines whether Google Analytics is utilized via <code>sekati.external.Urchin</code>. Defined in <code>config.xml</code>.		 */		public static var TRACK_ENABLE : Boolean;				/**		 * Determines whether the application supports Fullscreen mode via <code>sekati.display.StageDisplay</code>. Defined in <code>config.xml</code>.		 */		public static var FULLSCREEN_ENABLE : Boolean;				/**		 * Determines whether keyboard management is enabled. Defined in <code>config.xml</code>.		 */		public static var KEY_ENABLE : Boolean;							/**		 * Determines whether address-bar deeplinking is enabled. Defined in <code>config.xml</code>.		 */		public static var DEEPLINK_ENABLE : Boolean;				/**		 * Stores a "shortcut" reference to the </code>Logger</code>.		 */		public static var log : Logger;				/**		 * Generic object which <code>Bootstrap</code> loads external data 		 * in for runtime storage and application data centralization.		 */		public static var db : Object = new Object( );				/**		 * The parsed application stylesheet.		 */		public static var css : StyleSheet = new StyleSheet( );				/**		 * App Static Constructor		 */		public function App() {			throw new Error( "App is a static class and cannot be instantiated." );		}		}}