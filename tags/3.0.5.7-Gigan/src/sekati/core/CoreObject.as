/** * sekati.core.CoreObject * @version 1.0.2 * @author jason m horwitz | sekati.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.core {	import sekati.core.ICoreInterface;	import sekati.core.KeyFactory;	import sekati.reflect.Stringifier;	/**	 * The core object in the Sekati API.	 */	dynamic public class CoreObject extends Object implements ICoreInterface {		/**		 * CoreObject Constructor calls superclass, links _this and injects a 		 * <code>sekati.crypt.RUID</code> via <code>sekati.core.KeyFactory</code>.		 */				public function CoreObject() {			super( );			KeyFactory.getKey( this );			}		/**		 * @inheritDoc		 */				public function destroy() : void {			for(var i:String in this) delete this[i];				delete this;		}		/**		 * @inheritDoc		 */		public function toString() : String {			return Stringifier.stringify( this );			}	}}