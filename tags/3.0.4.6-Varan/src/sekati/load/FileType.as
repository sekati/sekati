/** * sekati.load.FileType * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.load {	import sekati.log.Logger;	import sekati.validators.FileTypeValidator;			/**	 * FileType provides <code>Class</code> references to the appropriate <code>ILoader</code> for various file types.	 */	public class FileType {		public static const IMAGE_LOADER : Class = ImageLoader;		public static const XML_LOADER : Class = XMLLoader;		public static const CSS_LOADER : Class = StyleSheetLoader;		public static const SWF_LOADER : Class = SWFLoader;		public static const TEXT_LOADER : Class = TextLoader;		public static const VARIABLE_LOADER : Class = VariableLoader;		public static const AUDIO_LOADER : Class = SoundLoader;		public static const BINARY_LOADER : Class = ByteArrayLoader;		/**		 * Detect the appropriate <code>AbstractLoader</code> for the passed in <code>path</code> 		 * file type. If no appropriate file type <code>ILoader</code> can be located the default 		 * <code>BINARY_LOADER</code> will be used.		 * @param path 		of the file to be queued.		 * @return Class reference to the appropriate <code>AbstractLoader</code> sub-class.		 * @see sekati.validators.FileTypeValidator		 */		public static function getLoaderClass(path : String) : Class {			if(FileTypeValidator.isImage( path )) {				return IMAGE_LOADER;			} else if (FileTypeValidator.isXML( path )) {				return XML_LOADER;			} else if(FileTypeValidator.isCSS( path )) {				return CSS_LOADER;			} else if (FileTypeValidator.isSWF( path )) {				return SWF_LOADER;			} else if (FileTypeValidator.isText( path )) {				return TEXT_LOADER;			} else if (FileTypeValidator.isVariables( path )) {				return VARIABLE_LOADER;			} else if (FileTypeValidator.isAudio( path )) {				return AUDIO_LOADER;			} else {				Logger.$.warn( FileType, "getLoaderClass() could not locate an ILoader implementation for '" + path + "': defaulting to: " + BINARY_LOADER );				return BINARY_LOADER;			}		}		/**		 * FileType Static Constructor		 */		public function FileType() {			throw new Error( "FileType is a static class and cannot be instantiated." );		}	}}