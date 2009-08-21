/** * sekati.text.FocusToggle * @version 1.0.5 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.text {	import flash.events.Event;	import flash.events.EventDispatcher;	import flash.events.MouseEvent;	import flash.events.TextEvent;	import flash.text.TextField;	import sekati.utils.TextUtil;	import sekati.validators.StringValidator;			/**	 * FocusToggle provides a togglable action to the passed-in input TextField.	 * 	 * <p><b>Warning</b>: Your TextField or DisplayObject containing the TextField must	 * be added to stage before the FocusToggle is instantiated for proper functionality.</p>	 * 	 * @example <listing version="3.0">	 * 	// inside a Sprite-based class with a textfield instance	 * 	tf.text = "Your E-Mail Address";	 * 	var toggle : FocusToggle = new FocusToggle( tf );	 * </listing>	 * 	 * @see sekati.text.FocusToggleField	 */	public class FocusToggle extends EventDispatcher {		protected var _tf : TextField;		protected var _currentValue : String;		protected var _initialValue : String;			/**		 * FocusToggle Constructor		 */		public function FocusToggle(tf : TextField) {			_tf = tf;			_initialValue = _currentValue = _tf.text;			_tf.addEventListener( TextEvent.TEXT_INPUT, inputHandler );			_tf.addEventListener( MouseEvent.CLICK, focusHandler );			_tf.stage.addEventListener( MouseEvent.CLICK, focusHandler );						}		/**		 * Handle the input event: store the default value including 		 * the latest character contained in the event.		 */		protected function inputHandler(e : TextEvent) : void {			_currentValue = String( _tf.text + e.text );		}		/**		 * Handle the focus event.		 */		protected function focusHandler(e : Event) : void {			if(_currentValue != _tf.text) {				_currentValue = _tf.text;			}			if(StringValidator.isBlank( _tf.text )) {				_currentValue = _initialValue;			}			TextUtil.setFormattedText( _tf, ((focus && isInitialValue) ? '' : _currentValue), false );		}		/**		 * Destroy the FocusToggle action for the field.		 */		public function destroy() : void {			_tf.removeEventListener( TextEvent.TEXT_INPUT, inputHandler );			_tf.removeEventListener( MouseEvent.CLICK, focusHandler );			_tf.stage.removeEventListener( MouseEvent.CLICK, focusHandler );			_currentValue = null;			_tf = null;		}		/**		 * Boolean value which determines whether the TextField is focused or not.		 */		public function get focus() : Boolean {			var b : Boolean;			try { 				b = (_tf.stage.focus == _tf);			} catch (e : Error) {				b = false;				}			return b;		}		/**		 * Denotes whether the text is set to the initial value.		 */		public function get isInitialValue() : Boolean {			return (_currentValue == _initialValue);		}	}}