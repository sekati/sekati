/** * sekati.utils.GarbageCollector * @version 1.0.1 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.utils {	import sekati.utils.TypeEnforcer;	import flash.net.LocalConnection;			/**	 * GarbageCollector provides hacks to control the GC. Implement this class sparingly: most methods	 * are unsupported, unofficial and resource/cpu hogs: best used for testing during development.	 */	public class GarbageCollector {		/**		 * Force the Garbage Collector to run a full Mark-Sweep: avoid using in production.		 * @see http://www.gskinner.com/blog/archives/2006/08/as3_resource_ma_2.html		 */		public static function run() : void {			try {				new LocalConnection( ).connect( 'foo' );				new LocalConnection( ).connect( 'foo' );			} catch (e : *) {				trace( "sekati.utils.GarbageCollector.run() => Forcing Garbage Collector to run a full Mark, Sweep." );			}		}				/**		 * GarbageCollector Static Constructor		 */		public function GarbageCollector() {			TypeEnforcer.enforceStatic( GarbageCollector );		}	}}