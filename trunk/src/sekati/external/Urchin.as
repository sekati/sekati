/** * sekati.external.Urchin * @version 1.0.0 * @author jason m horwitz | sekati.com | tendercreative.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.external {	import flash.external.ExternalInterface;		import sekati.core.App;		/**	 * Google Analytics (Urchin) tracking of Flash events.	 *  	 * Add google analytics javascript to your swf's html document:	 * <code><script src="http://www.google-analytics.com/urchin.js" type="text/javascript"></script>	 * <script type="text/javascript">	 * _uacct = "UA-000000-0"; <!-- Insert your GA site account number -->	 * urchinTracker();	 * </script><code>	 * 	 * Enable swLiveConnect:	 * <code>flash.system.fscommand( "swLiveConnect", "true" );</code>	 * 	 * Make your initial tracking call:	 * <code>Urchin.track( "home" );</code>	 * 	 * @see http://www.google.com/support/analytics/bin/answer.py?answer=27243&hl=en	 */	public class Urchin {		private static var _base : String = '/flash/';		/**		 * Indicates the flash sites Urchin tracking base.		 * @default "flash"		 * <code>Urchin.base = "homepage"; // set optional webroot</code>		 */		public static function get base() : String {			return _base;		}		/**		 * @private		 */		public static function set base(base : String) : void {			_base = (base) ? '/' + base + '/' : _base;		}		/**		 * track a page event		 * @return Void		 * {@code Usage		 * 	Urchin.track("projects"); // register '/homepage/projects'		 * 	Urchin.track("projects/page1");	// register '/homepage/projects/page1'		 * }		 */		public static function track(pg : String) : void {			if( !App.TRACK_ENABLE ) return;			var pv : String = _base + pg;			//App.log.info( "Urchin", "* Urchin.track ('" + pv + "')" );			ExternalInterface.call( "urchinTracker", pv );		}				/**		 * Urchin Static Constructor		 */		public function Urchin() {			throw new Error( "Urchin is a static class and cannot be instantiated." );		}	}}