/** * sekati.text.FocusToggleField * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.text {	import flash.events.MouseEvent;	import flash.events.TextEvent;	import flash.text.TextField;	import flash.text.TextFieldType;		import sekati.display.Canvas;			/**	 * FocusToggleField provides a togglable input field for forms.	 * 	 * TODO - fix the last character slip.	 */	public class FocusToggleField extends TextField {		protected var _defaultValue : String;		protected var _focus : Boolean;		/**		 * FocusToggleField Constructor		 */		public function FocusToggleField() {			super.type = TextFieldType.INPUT;			addEventListener( MouseEvent.CLICK, focusHandler, true, 0, true );			addEventListener( TextEvent.TEXT_INPUT, inputHandler, false, 0, true );			// use the capture phase to catch this unfocus *after* we save the default value!			Canvas.stage.addEventListener( MouseEvent.CLICK, focusHandler, true, 0, true );		}				/**		 * Handle the input event: store the default value		 */		protected function inputHandler(e : TextEvent) : void {			_defaultValue = text;		}				/**		 * Handle the focus event.		 */		protected function focusHandler(e : MouseEvent) : void {			trace( "val: " + this.text + " | defaultValue: " + _defaultValue + "(focus: " + focus + ")" );			if (focus) {				super.text = '';			} else {				text = _defaultValue;			}		}		/**		 * Set the default text on the TextField & store it as the last defaultValue.		 */		override public function set text(value : String) : void {			trace( "storing text ..." );			super.text = value;			if (value != '') {				_defaultValue = value;			}		}		/**		 * Disallow any but TextFieldType.INPUT as type.		 */		override public function set type(value : String) : void {			throw new Error( "FocusToggleField must be TextFieldType.INPUT & cannot be user defined." );		}		/**		 * Boolean value which determines whether the TextField is focused or not.		 */		public function get focus() : Boolean {			return (this.stage.focus == this);			}	}}