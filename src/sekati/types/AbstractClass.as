/** * sekati.types.AbstractClass * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.types {	import flash.utils.getDefinitionByName;	import flash.utils.getQualifiedClassName;		/**	 * AbstractClass	 */	public class AbstractClass {		/**		 * AbstractClass Constructor		 */		public function AbstractClass() {			if( Class( getDefinitionByName( getQualifiedClassName( this ) ) ) == AbstractClass ) throw new Error( 'AbstractClass must be extended' );		}	}}