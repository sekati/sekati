/** * sekati.collections.IStack * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.collections {	import sekati.collections.ICollection;	/**	 * IStack defines the stack data structure.  A stack is a special collection type in which	 * the last element added to it is the next one returned. You add elements via push & pop.	 */	public interface IStack extends ICollection {		/**		 * The object at the top of our stack, which would be return and removed on a 		 * subsequent call to <code>pop</code>.		 */		function get top() : Object;		/**		 * Add an element to the top of the stack.		 */		function push( o : Object ) : void;		/**		 * Remove and return the element at the top of the stack.		 */		function pop() : Object;			}}