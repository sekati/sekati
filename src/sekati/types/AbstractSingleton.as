/** * sekati.types.AbstractSingleton * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.types {	/**	 * AbstractSingleton provides a common Singleton design pattern; pseudo-privatizing 	 * the constructor via an internal class used in the constructor argument thus throwing	 * an error if any external object attempts instantiation.	 * 	 * <p>Further, a <code>getInstance</code> shortcut (<code>$</code>) is standardized here	 * to allow shorter syntax, simpler identification of Singleton references & making class	 * exposure through <code>ApplicationDomain</code> less error prone.</p> 	 */	public class AbstractSingleton {		private static var _instance : AbstractSingleton;		/**		 * AbstractSingleton Singleton Constructor		 * @param $ SingletonEnforcer - internal to the AS file; the param prevents external instantiation without error.		 */		public function AbstractSingleton( $ : SingletonEnforcer = null) {			if (!$) {				throw new ArgumentError( "sekati.types.AbstractSingleton is a Singleton and may only be accessed via its accessor methods: 'getInstance()' or '$'." );				}		}		/**		 * Singleton Accessor		 * @return AbstractSingleton		 */		public static function getInstance() : AbstractSingleton {			if( _instance == null ) _instance = new AbstractSingleton( new SingletonEnforcer( ) );			return _instance;		}		/**		 * Shorthand singleton accessor getter		 * @return AbstractSingleton		 */		public static function get $() : AbstractSingleton {			return AbstractSingleton.getInstance( );			}		}}/** * Internal class is accessible only to this AS file and is used  * as a constructor param to enforce proper Singleton behavior. */internal class SingletonEnforcer {}	