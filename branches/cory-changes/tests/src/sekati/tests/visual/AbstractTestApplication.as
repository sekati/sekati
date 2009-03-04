/** * sekati.tests.AbstractTestApplication * @version 1.1.1 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import sekati.display.Canvas;	import sekati.display.Document;	import sekati.log.Logger;	import sekati.profiler.PerformanceMonitor;	import sekati.utils.TypeEnforcer;			/**	 * AbstractTestApplication provides a baseline implementation of the API for tests	 * which require basic API bootstrapped support (such as Canvas).	 */	public class AbstractTestApplication extends Document {		/**		 * AbstractTestApplication Constructor		 */		public function AbstractTestApplication() {			super( );			TypeEnforcer.enforceAbstract( this, AbstractTestApplication );		}		/**		 * <code>initAPI</code> is overriden to skip the <code>Bootstrap</code> 		 * sequence in this test application to run the API "dumb".		 */		override protected function initAPI(hasBootstrap : Boolean = false) : void {			super.initAPI( hasBootstrap );		}		override protected function initTweenEngine() : void {		}		/**		 * @inheritDoc		 */		override protected function initEntryPoint() : void {			Logger.$.trace( this, "initEntryPoint: Test Code Executes ..." );			new PerformanceMonitor( Canvas.stage );		}	}}