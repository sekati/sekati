/** * sekati.tests.visual.SoundLoaderTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import sekati.load.SoundLoader;	import sekati.log.Logger;		import flash.events.Event;			/**	 * SoundLoaderTest	 */	public class SoundLoaderTest extends AbstractTestApplication {		private static const URL : String = 'http://localhost/sekati/deploy/assets/beep.mp3';		private var loader : SoundLoader;		public function SoundLoaderTest() {			super( );		}		override protected function initEntryPoint() : void {			super.initEntryPoint( );			Logger.$.info( this, "Test starting ..." );			loader = new SoundLoader( URL );			loader.addEventListener( Event.INIT, initContent );			loader.load( );		}		/**		 * Respond to the load event!		 */		private function initContent(e : Event) : void {			Logger.$.notice( this, "w00t: it loaded" );			loader.removeEventListener( Event.INIT, initContent );			loader.content.play( );			Logger.$.info( this, "Sound Buffering: " + loader.content.isBuffering + " \n ID3 info: " );			Logger.$.object( loader.content.id3 );		}	}}