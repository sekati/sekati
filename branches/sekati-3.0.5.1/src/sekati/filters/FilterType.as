/** * sekati.filters.FilterType * @version 1.0.1 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.filters {	import sekati.utils.TypeEnforcer;			/**	 * FilterType defines the rendering type of a Filter object.	 */	public class FilterType {		/**		 * Defines the filter type applied to the area of an object.		 */		public static const FULL : String = "full";			/**		 * Defines the filter type applied to the inner area of an object.		 */		public static const INNER : String = "inner";			/**		 * Defines the filter type applied to the outer area of an object.		 */		public static const OUTER : String = "outer";		/**		 * FilterType Static Constructor		 */		public function FilterType() {			TypeEnforcer.enforceStatic( FilterType );		}	}}