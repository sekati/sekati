/** * sekati.load.SWFLoader * @version 1.0.2 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.load {	import sekati.load.AbstractLoader;	import sekati.load.ILoader;		import flash.display.Loader;	import flash.display.Sprite;			/**	 * SWFLoader provides a standard API loader for SWF asset content.	 * 	 * @example <listing version="3.0">	 * var loader : SWFLoader = new SWFLoader( "http://localhost/path/to/movie.swf" );	 * loader.addEventListener( Event.INIT, addSWF );	 * loader.load( );	 * 	 * private function addSWF(e : Event) : void {	 * 		loader.removeEventListener( Event.INIT, addSWF );	 * 		addChild( loader.content );	 * }	 * </listing>	 */	public class SWFLoader extends AbstractLoader implements ILoader {		/**		 * SWFLoader Constructor		 * @param url 	of the SWF file.		 */		public function SWFLoader(url : String) {			super( Loader, url );		}				/**		 * The <i>strictly-typed</i> <code>MovieClip</code> loader content.		 */		public function get content() : Sprite {			return rawContent as Sprite;		}	}}