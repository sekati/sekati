/** * sekati.core.IStringifiable * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.core {

	/**	 * IStringifiable implementors may be stringified.	 */	public interface IStringifiable {
		/**		 * Return the Fully Qualified Class Name string representation of		 * the instance object via <code>sekati.reflect.Stringifier</code>.		 * @return String		 */				function toString() : String;		}}