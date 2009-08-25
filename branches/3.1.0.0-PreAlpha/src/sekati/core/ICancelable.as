/** * sekati.core.ICancelable * @version 1.0.1 * @author David Dahlstroem | hello@daviddahlstroem.com & jason m horwitz | sekati.com * Copyright (C) 2009 David Dahlstroem, jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.core {	/**	 * ICancelable implementors may be canceled.	 */
	public interface ICancelable {
		/**		 * Classes implementing this interface are cancelable.		 */		function cancel() : void;	}}