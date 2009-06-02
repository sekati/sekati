/** * sekati.transitions.EquationTypes * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.transitions {	import sekati.utils.TypeEnforcer;			/**	 * EquationTypes provides a set of <code>Tweener</code> supported easing equations as constants.	 * 	 * @see http://hosted.zeh.com.br/tweener/docs/en-us/misc/transitions.html	 */	public class EquationType {		// linear		public static const LINEAR : String = 'linear';		// sine		public static const EASE_IN_SINE : String = 'easeInSine';		public static const EASE_OUT_SINE : String = 'easeOutSine';		public static const EASE_IN_OUT_SINE : String = 'easeInOutSine';		public static const EASE_OUT_IN_SINE : String = 'easeOutInSine';		// quint		public static const EASE_IN_QUINT : String = 'easeInQuint';		public static const EASE_OUT_QUINT : String = 'easeOutQuint';		public static const EASE_IN_OUT_QUINT : String = 'easeInOutQuint';		public static const EASE_OUT_IN_QUINT : String = 'easeOutInQuint';		// quad		public static const EASE_IN_QUAD : String = 'easeInQuad';		public static const EASE_OUT_QUAD : String = 'easeOutQuad';		public static const EASE_IN_OUT_QUAD : String = 'easeInOutQuad';		public static const EASE_OUT_IN_QUAD : String = 'easeOutInQuad';		// quart		public static const EASE_IN_QUART : String = 'easeInQuart';		public static const EASE_OUT_QUART : String = 'easeOutQuart';		public static const EASE_IN_OUT_QUART : String = 'easeInOutQuart';			public static const EASE_OUT_IN_QUART : String = 'easeOutInQuart';						// expo		public static const EASE_IN_EXPO : String = 'easeInExpo';		public static const EASE_OUT_EXPO : String = 'easeOutExpo';		public static const EASE_IN_OUT_EXPO : String = 'easeInOutExpo';					public static const EASE_OUT_IN_EXPO : String = 'easeOutInExpo';					// cubic		public static const EASE_IN_CUBIC : String = 'easeInCubic';		public static const EASE_OUT_CUBIC : String = 'easeOutCubic';		public static const EASE_IN_OUT_CUBIC : String = 'easeInOutCubic';				public static const EASE_OUT_IN_CUBIC : String = 'easeOutInCubic';				// circ		public static const EASE_IN_CIRC : String = 'easeInCirc';		public static const EASE_OUT_CIRC : String = 'easeOutCirc';		public static const EASE_IN_OUT_CIRC : String = 'easeInOutCirc';				public static const EASE_OUT_IN_CIRC : String = 'easeOutInCirc';			// back		public static const EASE_IN_BACK : String = 'easeInBack';		public static const EASE_OUT_BACK : String = 'easeOutBack';		public static const EASE_IN_OUT_BACK : String = 'easeInOutBack';				public static const EASE_OUT_IN_BACK : String = 'easeOutInBack';					// elastic		public static const EASE_IN_ELASTIC : String = 'easeInElastic';		public static const EASE_OUT_ELASTIC : String = 'easeOutElastic';		public static const EASE_IN_OUT_ELASTIC : String = 'easeInOutElastic';				public static const EASE_OUT_IN_ELASTIC : String = 'easeOutInElastic';			// bounce		public static const EASE_IN_BOUNCE : String = 'easeInBounce';		public static const EASE_OUT_BOUNCE : String = 'easeOutBounce';		public static const EASE_IN_OUT_BOUNCE : String = 'easeInOutBounce';				public static const EASE_OUT_IN_BOUNCE : String = 'easeOutInBounce';		/**		 * EquationTypes Static Constructor		 */		public function EquationType() {			TypeEnforcer.enforceStatic( this );		}														}}