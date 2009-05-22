/** * sekati.math.PRNG * @version 1.0.2 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php *  * Parts of this class were adapted from Grant Skinner's Rndm. */package sekati.math {	/**	 * PRNG provides a Seeded Pseudo-Random Number Generating System based on the Park Miller 	 * "minimal standard" linear congruential pseudo-random number generator.	 * 	 * @see http://www.firstpr.com.au/dsp/rand31/	 */	public class PRNG {		protected static var _instance : PRNG;		protected var _seed : uint = 0;		protected var _currentSeed : uint = 0;		/**		 * PRNG Singleton Constructor		 * @param $ SingletonEnforcer - internal to the AS file; the param prevents external instantiation without error.		 */		public function PRNG( $ : SingletonEnforcer = null, seed : uint = 1) {			if (!$) {				throw new ArgumentError( "sekati.math.PRNG is a Singleton and may only be accessed via its accessor methods: 'getInstance()' or '$'." );				}			_seed = _currentSeed = seed;		}		/**		 * Singleton Accessor		 * @return PRNG		 */		public static function getInstance() : PRNG {			if( _instance == null ) _instance = new PRNG( new SingletonEnforcer( ) );			return _instance;		}		/**		 * Shorthand singleton accessor getter		 * @return PRNG		 */		public static function get $() : PRNG {			return PRNG.getInstance( );			}		/**		 * The random seed value.		 * @example <listing version="3.0">		 * PRNG.$.seed = Math.random()*0xFFFFFF; // sets a random seed		 * PRNG.$.seed = 50; // sets a static seed		 * </listing>		 */		public function get seed() : uint {			return _seed;		}		/**		 * @private		 */		public function set seed(val : uint) : void {			_seed = _currentSeed = val;		}		/**		 * Return the current seed.		 */		public function get currentSeed() : uint {			return _currentSeed;		}				/**		 * Returns a random number between 0 - 1 exclusive.		 */		public function random() : Number {			return (_currentSeed = (_currentSeed * 16807) % 2147483647) / 0x7FFFFFFF + 0.000000000233;		}		/**		 * Seeded random float.		 * @example <listing version="3.0">		 * PRNG.$.float( 50 ); // returns a number between 0-50 exclusive		 * PRNG.$.float( 20, 50 ); // returns a number between 20-50 exclusive		 * </listing>		 */				public function float(min : Number, max : Number = NaN) : Number {			if (isNaN( max )) { 				max = min; 				min = 0; 			}			return random( ) * (max - min) + min;		}		/**		 * Seeded random boolean.		 * @example <listing version="3.0">		 * PRNG.$.boolean( ); // returns true or false (50% chance of true)		 * PRNG.$.float( 0.8 ); // returns true or false (80% chance of true)		 * </listing>		 */					public function boolean(chance : Number = 0.5) : Boolean {			return (random( ) < chance);		}		/**		 * Seeded random sign.		 * @example <listing version="3.0">		 * PRNG.$.sign(); // returns 1 or -1 (50% chance of 1)		 * PRNG.$.sign(0.8); // returns 1 or -1 (80% chance of 1)		 * </listing>		 */					public function sign(chance : Number = 0.5) : int {			return (random( ) < chance) ? 1 : -1;		}		/**		 * Seeded random bit.		 * @example <listing version="3.0">		 * PRNG.$.bit(); // returns 1 or 0 (50% chance of 1)		 * PRNG.$.bit(0.8); // returns 1 or 0 (80% chance of 1)		 * </listing>		 */					public function bit(chance : Number = 0.5) : int {			return (random( ) < chance) ? 1 : 0;		}		/**		 * Seeded random integer.		 * @example <listing version="3.0">		 * PRNG.$.integer(50); // returns an integer between 0-49 inclusive		 * PRNG.$.integer(20,50); // returns an integer between 20-49 inclusive		 * </listing>		 */					public function integer(min : Number, max : Number = NaN) : int {			if (isNaN( max )) { 				max = min; 				min = 0; 			}			// Need to use floor instead of bit shift to work properly with negative values:			return Math.floor( float( min, max ) );		}		/**		 * Reset the number series while retaining the seed.		 */		public function reset() : void {			_seed = _currentSeed;		}			}}/** * Internal class is accessible only to this AS file and is used  * as a constructor param to enforce proper Singleton behavior. */internal class SingletonEnforcer {}	