/** * sekati.core.App * @version 1.0.7 * @author jason m horwitz | sekati.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.core {	import flash.text.StyleSheet;	import sekati.display.Canvas;	import sekati.net.NetBase;	/**	 * App provides a common static dynamic storage area for API and application 	 * instances, loggers, data objects, properties & constants.	 * 	 * <p><b>API Version Schema</b>: Sekati API implements a <i>major.minor[.build[.revision]]</i> 	 * versioning schema along with an easily recognizable <i>Code Name</i> to assist in identifying 	 * compatible releases.</p>	 * 	 * <p>While it may be tempting to remove; please leave the <i>API metadata Constants</i> 	 * intact as the API does undergo regular development, & while new additions will	 * generally be backwards compatible to avoid breaking the API, from time to time	 * major API changes are necessary. This being the case the <i>API constants</i> can be 	 * very important in assisting the developer as to which SWC or SVN Revision is most	 * appropriate or compatible with an existing project.</p>	 * 	 * @see sekati.display.Document	 * @see sekati.core.Bootstrap	 */	dynamic public class App {		/**		 * Enables API name to be retrieved at runtime or when reverse engineering.		 * 		 * <p><i>Please leave intact:</i> this metadata may be displayed in the <code>ContextMenu</code>		 * if enabled and <code>API_CREDIT</code> is <code>true</code> in <code>config.xml</code></p>.		 */		public static const API_NAME : String = 'Sekati API';				/**		 * Enables API url to be retrieved at runtime or when reverse engineering.		 * 		 * <p><i>Please leave intact:</i> this metadata may be displayed in the <code>ContextMenu</code>		 * if enabled and <code>API_CREDIT</code> is <code>true</code> in <code>config.xml</code></p>.		 */		public static const API_URL : String = 'http://sekati.googlecode.com/';				/**		 * Enables API copyright information to be retrieved at runtime or when reverse engineering.		 * 		 * <p><i>Please leave intact:</i> this metadata may be displayed in the <code>ContextMenu</code>		 * if enabled and <code>API_CREDIT</code> is <code>true</code> in <code>config.xml</code></p>.		 */		public static const API_AUTHOR : String = 'Copyright (c) 2008 jason m horwitz | sekati.com | Sekati LLC. All Rights Reserved.';						/**		 * Enables API version, release state & code name to be retrieved at runtime or when reverse engineering.		 * 		 * <p><i>Please leave intact:</i> this metadata may be displayed in the <code>ContextMenu</code>		 * if enabled and <code>API_CREDIT</code> is <code>true</code> in <code>config.xml</code></p>.		 */		public static const API_VERSION : String = 'Public Alpha 3.0.3.5 - "Mothra"';				/**		 * Enables API version date to be retrieved at runtime or when reverse engineering.		 * 		 * <p><i>Please leave intact:</i> this metadata may be displayed in the <code>ContextMenu</code>		 * if enabled and <code>API_CREDIT</code> is <code>true</code> in <code>config.xml</code></p>.		 */		public static const API_DATE : String = '09.17.08';					/**		 * Determines whether to display the API version, player & platform information via the <code>ContextMenuManager</code> 		 * when "menu" value & "verbose" attribute are set <code>true</code> in <code>config.xml</code>.		 * @see MANAGED_MENU		 */		public static var API_INFO : Boolean;									/**		 * Derived application path.		 */		public static var PATH : String = NetBase.getPath();				/**		 * Location of the <code>config.xml</code> file.		 */		public static var CONF_URI : String = ( !Canvas.flashVars['conf_uri'] ) ? App.PATH + "xml/config.xml" : Canvas.flashVars['conf_uri'];				/**		 * Application name as defined in <code>config.xml</code>.		 */		public static var APP_NAME : String;		/**		 * Application versions as defined in <code>config.xml</code>.		 */		public static var APP_VERSION : String;				/**		 * Crossdomain location as defined in <code>config.xml</code>.		 */		public static var CROSSDOMAIN_URI : String;				/**		 * Indicates whether the Crossdomain Policy File should be loaded during <code>Bootstrap</code>. Defined in <code>config.xml</code>.		 */		public static var CROSSDOMAIN_BOOTLOAD : Boolean;						/**		 * External data XML location as defined in <code>config.xml</code>.		 */		public static var DATA_URI : String;		/**		 * Indicates whether the data XML should be loaded during <code>Bootstrap</code>. Defined in <code>config.xml</code>.		 */		public static var DATA_BOOTLOAD : Boolean;				/**		 * External application CSS location as defined in <code>config.xml</code>.		 */		public static var CSS_URI : String;				/**		 * Indicates whether the CSS stylesheet should be loaded during <code>Bootstrap</code>. Defined in <code>config.xml</code>.		 */		public static var CSS_BOOTLOAD : Boolean;						/**		 * Determines whether the <code>ContextMenuManager</code> is instantiated during <code>Bootstrap</code>. Defined in <code>config.xml</code>.		 * @see sekati.managers.ContextMenuManager		 */		public static var MANAGED_MENU : Boolean;						/**		 * Determines whether the application supports Fullscreen mode via <code>sekati.display.StageDisplay</code> If <code>MANAGED_MENU</code>		 * is <code>true</code> a <code>ContextMenu</code> <i>'fullscreen'</i> item will be automatically added. Defined in <code>config.xml</code>.		 * @see sekati.display.StageDisplay		 */		public static var FULLSCREEN_ENABLE : Boolean;								/**		 * Determines whether Google Analytics is utilized via <code>sekati.external.Urchin</code>. Defined in <code>config.xml</code>.		 * @see sekati.external.Urchin		 */		public static var TRACK_ENABLE : Boolean;				/**		 * Determines whether keyboard management is enabled. Defined in <code>config.xml</code>.		 * @see sekati.managers.KeyManager		 */		public static var KEY_ENABLE : Boolean;				/**		 * Determines whether advanced <code>Logger</code> output is generated. Defined in <code>config.xml</code>.		 * @see sekati.log.Logger		 */		public static var LOG_ENABLE : Boolean;		/**		 * Determines <code>Logger</code> output is generated. Defined in <code>config.xml</code>.		 * @see sekati.log.LogTarget		 */		public static var LOG_TARGET : String;				/**		 * Determines whether address-bar deeplinking is enabled. Defined in <code>config.xml</code>.		 */		public static var DEEPLINK_ENABLE : Boolean;						/**		 * Determines whether to display the <code>Performance</code> UI feedback graph. Defined in <code>config.xml</code>.		 * @see sekati.profiler.PerformanceMonitor		 */		public static var PERFORMANCE_MONITOR_ENABLE : Boolean;						/**		 * Generic object which <code>Bootstrap</code> loads external data 		 * in for runtime storage and application data centralization.		 */		public static var db : Object = new Object( );				/**		 * The parsed application stylesheet.		 */		public static var css : StyleSheet = new StyleSheet( );				/**		 * App Static Constructor		 */		public function App() {			throw new Error( "App is a static class and cannot be instantiated." );		}		}}