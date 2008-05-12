/** * sekati.text.FocusToggleField * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.text {	import flash.events.MouseEvent;	import flash.events.EventPhase;	import flash.events.TextEvent;	import flash.text.TextField;	import flash.text.TextFieldType;	import sekati.display.Canvas;			/**	 * FocusToggleField provides a togglable input field for forms.	 * @example <listing version="3.0">	 * 	var t : FocusToggleField = new FocusToggleField( );	 * 	t.text = "Hello World!";	 * 	t.x = 50;	 * 	t.y = 50;	 * 	t.width = 500;	 * 	t.height = 100;	 * 	t.background = true;	 * 	t.backgroundColor = 0xffffff;	 * 	t.border = true;	 * 	t.borderColor = 0x999999;	 * 	addChild( t );	 * </listing>	 * 	 * TODO - fix the last character slip.	 */	public class FocusToggleField extends TextField {		protected var _defaultValue : String;		protected var _focus : Boolean;		/**		 * FocusToggleField Constructor		 */		public function FocusToggleField() {			super.type = TextFieldType.INPUT;			addEventListener( MouseEvent.CLICK, onFocus, false, 0, true );			addEventListener( TextEvent.TEXT_INPUT, onInput, false, 0, true );			Canvas.stage.addEventListener( MouseEvent.CLICK, onLoseFocus, true, 1000, true );			//						//addEventListener( MouseEvent.CLICK, focusHandler, false, 0, true );			//addEventListener( TextEvent.TEXT_INPUT, inputHandler, false, 0, true );			// use the capture phase to catch this unfocus *after* we save the default value!			//Canvas.stage.addEventListener( MouseEvent.CLICK, focusHandler, false, 1, true );		}				protected function onFocus(e : MouseEvent) : void {			if(focus) {				trace( "field focused" );				_defaultValue = text;				super.text = '';				//Canvas.stage.addEventListener( MouseEvent.CLICK, onLoseFocus, true, 1000, true );			}		}		protected function onInput(e : TextEvent) : void {			trace( "inputtin text" );			_defaultValue = text;		}		protected function onLoseFocus(e : MouseEvent) : void {			trace( "losing focus: setting default |" + _defaultValue + "|" );			//if(text != _defaultValue) {			text = _defaultValue;				//}			//Canvas.stage.removeEventListener( MouseEvent.CLICK, onLoseFocus, true );		}		/**		 * Handle the input event: store the default value		 */		protected function inputHandler(e : TextEvent) : void {			_defaultValue = text;		}		/**		 * Handle the focus event.		 */		protected function focusHandler(e : MouseEvent) : void {			//if (e.eventPhase == EventPhase.BUBBLING_PHASE) {			trace( "val: " + this.text + " | defaultValue: " + _defaultValue + "(focus: " + focus + ")" );			if (focus && e.eventPhase == EventPhase.BUBBLING_PHASE) {				//_defaultValue = super.text;				super.text = '';			} else {				text = _defaultValue;			}			//}		}		/**		 * Set the default text on the TextField & store it as the last defaultValue.		 */		override public function set text(value : String) : void {			super.text = value;			//if (value != '') {			//trace( "storing text ..." );			_defaultValue = value;			//}		}		/**		 * Disallow any but TextFieldType.INPUT as type.		 */		override public function set type(value : String) : void {			throw new Error( "FocusToggleField must be TextFieldType.INPUT & cannot be user defined." );		}		/**		 * Boolean value which determines whether the TextField is focused or not.		 */		public function get focus() : Boolean {			return (this.stage.focus == this);			}	}}