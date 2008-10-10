/** * sekati.display.Canvas * @version 1.1.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.display {	import flash.display.DisplayObject;	import flash.display.LoaderInfo;	import flash.display.Sprite;	import flash.display.Stage;		/**	 * The API <code>Canvas</code> (<code>sekati.display.Document</code>'s superclass): exposes top-level, <i>"global"</i>	 * access to the <code>stage</code>, <code>root</code>, <code>loaderInfo</code> & <code>flashVar</code> for 	 * all classes (including non-DisplayObject classes).	 * 	 * <p>Developers implementing the API may find it handy to reference these objects via their static references:<ul>	 * <li><code>Canvas.stage</code></li>	 * <li><code>Canvas.root</code></li>	 * <li><code>Canvas.loaderInfo</code></li>	 * <li><code>Canvas.flashVars</code></li></ul></p>	 * 	 * <p><b>Note:</b> <code>Canvas</code> checks if the API implemented application has been loaded in to another	 * SWF application or is running <i>"standalone"</i>. If loaded then <code>Canvas</code> remaps its own 	 * <code>stage</code>, <code>root</code>, <code>loaderInfo</code> & <code>flashVar</code> properties to	 * that of the parent SWF, otherwise it uses its own <code>DisplayList</code> property references.</p>	 * 	 * @see sekati.display.Document	 */	public class Canvas extends Sprite {		public static var stage : Stage;		public static var root : DisplayObject;		public static var loaderInfo : LoaderInfo;		public static var flashVars : Object;		/**		 * Canvas Constructor		 */		public function Canvas() {			setReferences( );		}				/**		 * Initialize or update the core <code>DisplayList</code> reference properties.		 * 		 * <p>This is externalized from the constructor so we may update the references		 * when being loaded as an API application</p>		 */		protected function setReferences() : void {			Canvas.stage = this.stage;			Canvas.root = this;			Canvas.loaderInfo = this.loaderInfo;			Canvas.flashVars = this.loaderInfo.parameters;		}	}}