/** * sekati.collections.DisplayListIterator * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.collections {	import sekati.collections.IIterator;	import sekati.collections.ArrayQueue;	import flash.display.DisplayObjectContainer;		/**	 * DisplayList based Iterator	 */	public class DisplayListIterator implements IIterator {		private var _queue : ArrayQueue;		/**		 * DisplayListIterator Constructor		 * @param container	DisplayObjectContainer used in iteration.		 */		public function DisplayListIterator(container : DisplayObjectContainer) {			_queue = new ArrayQueue( );			var index : int = 0;			while ( index < container.numChildren ) _queue.enqueue( container.getChildAt( index++ ) );					}		/**		 * @inheritDoc		 */		public function hasNext() : Boolean {			return !_queue.isEmpty;		}		/**		 * @inheritDoc		 */		public function next() : Object {			return _queue.dequeue( );		}		/**		 * @inheritDoc		 */		public function peek() : Object {			return _queue.head;		}	}}