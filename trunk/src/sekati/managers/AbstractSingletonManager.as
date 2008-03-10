/** * sekati.managers.AbstractSingletonManager * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.managers {	import flash.events.EventDispatcher;	/**	 * AbstractSingletonManager	 */	public class AbstractSingletonManager extends EventDispatcher {		protected static var _instance : AbstractSingletonManager;		/**		 * AbstractSingletonManager Singleton Constructor		 * @param $ SingletonEnforcer - internal to the AS file; the param prevents external instantiation without error.		 */		public function AbstractSingletonManager( $ : SingletonEnforcer = null) {			if (!$) {				throw new ArgumentError( "AbstractSingletonManager is a Singleton and may only be accessed via its accessor methods: 'getInstance()' or '$'." );				}		}		/**		 * Singleton Accessor		 * @return AbstractSingletonManager		 */		public static function getInstance() : AbstractSingletonManager {			if( _instance == null ) _instance = new AbstractSingletonManager( new SingletonEnforcer( ) );			return _instance;		}		/**		 * Shorthand singleton accessor getter		 * @return AbstractSingletonManager		 */		public static function get $() : AbstractSingletonManager {			return AbstractSingletonManager.getInstance( );			}	}}/** * Internal class is accessible only to this AS file * and is used as a constructor param to enforce * proper Singleton behavior. */internal class SingletonEnforcer {}		