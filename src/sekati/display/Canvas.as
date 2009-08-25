/** * sekati.display.Canvas * @version 1.3.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008-2009 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.display {	import sekati.core.ApplicationPreloader;	import sekati.display.CoreSprite;	import flash.display.DisplayObject;	import flash.display.LoaderInfo;	import flash.display.Stage;		/**	 * The API <code>Canvas</code> (<code>sekati.display.Application</code>'s superclass): exposes top-level, <i>"global"</i>	 * access to the <code>stage</code>, <code>root</code>, <code>loaderInfo</code> & <code>flashVar</code> for 	 * all classes (including non-DisplayObject classes).	 * 	 * <p>Developers implementing the API may find it handy to reference these objects via their static references:<ul>	 * <li><code>Canvas.stage</code></li>	 * <li><code>Canvas.root</code></li>	 * <li><code>Canvas.loaderInfo</code></li>	 * <li><code>Canvas.flashVars</code></li></ul></p>	 * 	 * <p><b>Note:</b> <code>Canvas</code> supports the loading of API implemented application in to other	 * SWF application or running <i>"standalone"</i>. This is accomplished by calling <code>setReferences()</code>	 * in both the <code>Canvas</code> constructor & in the <code>ADDED_TO_STAGE</code> event handler of the subclassed 	 * <code>Document</code> Class. This prevents failure when being loaded in to another SWF's <code>DisplayList</code>.</p>	 * 	 * @see sekati.display.Application	 */	public class Canvas extends CoreSprite {		/**		 * Reference to the Application <code>stage</code> instance which represents the main drawing area.		 */		public static var stage : Stage;		/**		 * Reference to the Application <code>root</code> which represents the top-most display object, if this is the first 		 * SWF file loaded (<i>e.g. has not been loaded by another SWF</i>), the <code>root</code> property is the display 		 * object itself. The root property of the <code>Stage</code> object is the <code>Stage</code> object itself. 		 */		public static var root : DisplayObject;				/**		 * Reference to the <code>LoaderInfo</code> object associated with the SWF file containing 		 * information about loading the file to which this display object belongs.		 */		public static var loaderInfo : LoaderInfo;				/**		 * Reference to the object that contains name-value pairs that represent the parameters 		 * provided to the loaded SWF file through the <code>Object Embed Flashvars</code> tags.		 */		public static var flashVars : Object;				/**		 * Reference property which defines whether the <code>Canvas</code> has a parent (<i>and has thus been loaded by another 		 * SWF</i>): <code>true</code> or not (<i>is executing under its own FlashPlayer instance</i>): <code>false</code>.		 */		public static var hasParent : Boolean;		/**		 * Canvas Constructor		 */		public function Canvas() {			setReferences( );		}		/**		 * Initialize or update the core <code>DisplayList</code> reference properties.		 * 		 * <p>This is externalized from the constructor so we may update the references		 * when being loaded as an API application.</p>		 * 		 * <p>A check is made to see if the parent is an <code>APILoader</code> instance: 		 * if <code>true</code> then the main API application is being loaded by a preloader		 * and the references are remapped to secure the top-level <code>stage, root, 		 * loaderInfo, flashVars</code>.</p>		 */		protected function setReferences() : void {			if(this.parent is ApplicationPreloader) {				Canvas.stage = this.parent.stage;				Canvas.root = this.parent;				Canvas.loaderInfo = this.parent.loaderInfo;				Canvas.flashVars = this.parent.loaderInfo.parameters;				Canvas.hasParent = true;			} else {				Canvas.stage = this.stage;				Canvas.root = this;				Canvas.loaderInfo = this.loaderInfo;				Canvas.flashVars = this.loaderInfo.parameters;				Canvas.hasParent = false;			}		}	}}