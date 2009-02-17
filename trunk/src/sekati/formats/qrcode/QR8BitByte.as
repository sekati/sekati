/** * sekati.formats.qrcode.QR8BitByte * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.formats.qrcode {	import flash.utils.ByteArray;		import sekati.formats.qrcode.QRData;	/**	 * QR8BitByte	 */	internal class QR8BitByte extends QRData {		/**		 * QR8BitByte Constructor		 */		public function QR8BitByte(data : String) {			super( Mode.MODE_8BIT_BYTE, data );		}		public override function write(buffer : BitBuffer) : void {			var data : ByteArray = QRUtil.getBytes( getData( ), QRUtil.getJISEncoding( ) );			for (var i : int = 0; i < data.length ; i++) {				buffer.put( data[i], 8 );			}		}		public override function getLength() : int {			return QRUtil.getBytes( getData( ), QRUtil.getJISEncoding( ) ).length;		}			}}