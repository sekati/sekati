/** * @version 1.0 * @author David Dahlstroem | hello@daviddahlstroem.com *  * Copyright (C) 2009 David Dahlstroem. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */ package sekati.core {	/**	 * The core interface in the Sekati API.	 */	public interface ICoreInterface {		/**		 * Clean and destroy object instance contents/self for garbage collection.		 * Always call destroy() before deleting last object pointer.		 * @return void		 */				function destroy() : void;		/**		 * Return the Fully Qualified Class Name string representation of		 * the instance object via <code>sekati.reflect.Stringifier</code>.		 * @return String		 */				function toString():String;			}}