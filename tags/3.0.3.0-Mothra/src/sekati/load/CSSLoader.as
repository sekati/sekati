/** * sekati.load.CSSLoader * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.load {	import flash.events.Event;	import flash.net.URLLoader;	import flash.net.URLRequest;	import flash.text.StyleSheet;    		/**	 * CSSLoader	 */	public class CSSLoader extends URLLoader {				/**		 * @private		 */		protected var _styleSheet : StyleSheet ;			/**		 * CSSLoader Constructor		 */		public function CSSLoader(request : URLRequest = null, styleSheet : StyleSheet = null) {			super( request );			addEventListener( Event.COMPLETE, completeHandler );			this.styleSheet = styleSheet;			}		/**		 * The StyleSheet reference of this loader.		 */		public function get styleSheet() : StyleSheet {			return _styleSheet;		}		/**		 * @private		 */		public function set styleSheet( styleSheet : StyleSheet ) : void {			_styleSheet = ( styleSheet != null ) ? styleSheet : new StyleSheet( );		}		/**		 * Invoked when the loader process is complete to parse the datas.		 */		protected function completeHandler(e : Event) : void {			styleSheet.parseCSS( data );		}			}}