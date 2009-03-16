/* * com.air.dragAndDrop.DragAndDropSprite * @version 1.0.0 * @author Steven J Baughman | Tender * Copyright (C) 2009  Steven J Baughman, Tender. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.air.display {	import sekati.formats.PNGEncoder;		import sekati.display.CoreBitmapData;	import sekati.display.InteractiveSprite;	import sekati.formats.JPGEncoder;	import sekati.ui.Image;	import flash.desktop.Clipboard;	import flash.desktop.ClipboardFormats;	import flash.desktop.NativeDragManager;	import flash.desktop.NativeDragOptions;	import flash.display.DisplayObject;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.filesystem.File;	import flash.filesystem.FileMode;	import flash.filesystem.FileStream;			/**	 * DragAndDropSprite	 * 	 * For Adobe AIR applications.	 * 	 * An image that is enabled for drag-and-drop functionality. 	 * Drag to other desktops, applications, or other AIR Applications	 * 	 * use:	 * var dragAndDropImage : DragAndDropImage = new DragAndDropImage("assets/testPicture.png");	 * addChild(dragAndDropImage);	 */	public class DragAndDropImage extends InteractiveSprite {		private var options : NativeDragOptions;		private var clipboard : Clipboard;		private var image : Image;		private var fileArray : Array;		private var imagePath : String;		public function DragAndDropImage(imagePath : String) {			super( );			this.imagePath = imagePath;			loadImage( );		}		private function loadImage( ) : void {			image = new Image( imagePath );			image.addEventListener( Event.INIT, imageLoaded );			image.load( );		}		private function imageLoaded(event : Event) : void {			image.removeEventListener( Event.INIT, imageLoaded );			addChild( image );			setupCopyPasteOptions( );		}		/*		 * Setup basic drag-and-drop restrictions and prep image		 */		private function setupCopyPasteOptions() : void {			// Only allow our image to be copied.			// Links and move won't do us much good because we're creating the file dynamically.			options = new NativeDragOptions( );			options.allowCopy = true;			options.allowLink = false;			options.allowMove = false;						// create native copy of our image			fileArray = [ createFileFromImage( ) ];			}		/*		 * Creates a tmp image from the BitmapData of a display object		 * so that we can copy this to where the user drags		 */				private function createFileFromImage() : File {						// get native file name			var tmpArray: Array = imagePath.split("/");			var fileName: String = tmpArray[tmpArray.length - 1];						// create tmp file in native format			var file : File = File( File.createTempDirectory( ) ).resolvePath( fileName );			var fileStream : FileStream = new FileStream( );			fileStream.open( file, FileMode.WRITE );						// JPG or PNG?			tmpArray = imagePath.split(".");			var fileExtension: String = tmpArray[tmpArray.length - 1];			trace("fileExtension=="+fileExtension);			// If this is a PNG file, use PNG Encoding			if(fileExtension.toUpperCase()=="PNG") {				trace("USE PNG!");				fileStream.writeBytes( PNGEncoder.encode( new CoreBitmapData( image.bmp, 0, 0, image.bmp.width, image.bmp.height, 1, true, 0x00000000 ) ) );			} else {				// OTHERWISE, use JPG encoding				fileStream.writeBytes( new JPGEncoder( 100 ).encode( new CoreBitmapData( image.bmp ) ) );			}									fileStream.close( );			return file;		}		/*		 * On Press, initiate drag-and-drop		 */		override protected function press(e : MouseEvent = null) : void {			super.press( e );			// create new clipboard object			clipboard = new Clipboard( );						// coming soon // create flash native version			clipboard.setData( ClipboardFormats.BITMAP_FORMAT, new CoreBitmapData( image ) ); // create bitmap version			clipboard.setData( ClipboardFormats.FILE_LIST_FORMAT, fileArray ); // create file version						// start dragging			NativeDragManager.doDrag( image, clipboard, new CoreBitmapData( image ), null, options );		}	}}