/** * sekati.tests.visual.AllocatorTest * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.tests.visual {	import sekati.log.Logger;		import sekati.display.CoreSprite;		import sekati.collections.Allocator;	import sekati.tests.visual.AbstractTestApplication;	import flash.system.System;			/**	 * AllocatorTest	 */	public class AllocatorTest extends AbstractTestApplication {		public function AllocatorTest() {			super( );		}		override protected function initEntryPoint() : void {			//super.initEntryPoint( );			var allocator : Allocator = new Allocator( CoreSprite );			var test : CoreSprite;			Logger.$.trace( this, "Memory Initialized: " + System.totalMemory );			for (var i : int = 0; i < 1000 ; i++) {				test = allocator.getObject( );			}			Logger.$.trace( this, "Memory Loop #1: " + System.totalMemory );			allocator.reset( );			Logger.$.trace( this, "Memory: " + System.totalMemory );			for (var j : int = 0; j < 1000 ; j++) {				test = allocator.getObject( );			}			Logger.$.trace( this, "Memory Loop #2: " + System.totalMemory );			allocator.release( );			Logger.$.trace( this, "Memory Finalized: " + System.totalMemory );					}	}}