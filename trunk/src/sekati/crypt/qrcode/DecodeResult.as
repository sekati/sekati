/** * sekati.crypt.qrcode.DecodeResult * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.crypt.qrcode {	import flash.display.BitmapData;	import flash.geom.Point;			/**	 * DecodeResult	 */	public class DecodeResult {		public var version : uint;		public var errorCorrectionLevel : uint;		public var text : String;		public var debug : BitmapData;		public var acrossLines : Object;		public var pos : Object = { leftTop:Point, rightTop:Point, leftBottom:Point, rightBottom:Point };			}}