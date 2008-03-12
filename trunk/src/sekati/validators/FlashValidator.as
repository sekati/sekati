/** * sekati.validators.FlashValidator * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.validators {	import flash.system.Capabilities;	/**	 * FlashValidator provides introspective validation of playback type, version & mode.	 */	public class FlashValidator {		/**		 * Returns <code>true</code> if client flashplayer is >= the min version.		 */		public static function isMinVersion(minVersion : Number) : Boolean {			if (Number( Capabilities.version.split( " " )[1].split( "," )[0] ) >= minVersion) {				return true;			}			return false;		}		/**		 * Returns <code>true</code> if the client flashplayer supports fullscreen mode (>=9.0.28).		 */		public static function hasFullscreenMode() : Boolean {			var v : Array = Capabilities.version.split( " " )[1].split( "," );			var major : Number = Number( v[0] );			var minor : Number = Number( v[1] );			var sub : Number = Number( v[2] );			if (major > 9) { 				return true;			} else if (major < 9) {				return false;				}			if ((minor == 0 && sub >= 28) || minor > 0) {				return true;				} else {				return false;			}		}			/**		 * Returns <code>true</code> is the swf is being previewed externally.		 */		public static function isPreview() : Boolean {			return (Capabilities.playerType == "External") && Capabilities.isDebugger;		}					/**		 * Returns <code>true</code> is the swf is being previewed externally.		 */		public static function isExternal() : Boolean {			return (Capabilities.playerType == "External");		}			/**		 * Returns <code>true</code> is the swf is being previewed by the standalone player.		 */		public static function isStandAlone() : Boolean {			return (Capabilities.playerType == "StandAlone");		}		/**		 * Returns <code>true</code> is the swf is being previewed by the debug player.		 */		public static function isDebugger() : Boolean {			return Capabilities.isDebugger;		}		/**		 * FlashValidator Static Constructor		 */		public function FlashValidator() {			throw new Error( "FlashValidator is a static class and cannot be instantiated." );		}	}}