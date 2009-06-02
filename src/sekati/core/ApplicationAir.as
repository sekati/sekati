/** * sekati.display.ApplicationAir * @version 1.0.1 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.core {	import sekati.core.Application;	import sekati.log.Logger;	import sekati.managers.StageManager;		import flash.system.fscommand;			/**	 * ApplicationAir provides an AIR compatible API <code>Document</code> 	 * implementation for use in building API driven AIR applications.	 * 	 * <p><b>Note</b>: Your core library should build for FP10 with AIR.</p>	 * 	 * @see sekati.display.Application	 */	public class ApplicationAir extends Application {				/**		 * ApplicationAir Constructor		 */		public function ApplicationAir() {			super( );		}				/**		 * @inheritDoc		 */		override protected function initMovieProperties() : void {			Logger.$.info( this, "*** - Initializing Movie Properties ..." );			fscommand( "swLiveConnect", "true" );			fscommand( "allowscale", "false" );			fscommand( "showmenu", "false" );			fscommand( "fullscreen", "false" );			StageManager.$.init( );		}	}}