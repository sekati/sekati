/** * @version 1.0 * @author David Dahlström | hell@daviddahlstroem.com * Copyright (C) 2009 David Dahlström. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */ package sekati.load {	import sekati.core.ICoreInterface;		import sekati.core.Cloneable;	import sekati.core.Resetable;	import sekati.load.BytesTotalPrefetcher;	import flash.net.URLRequest;		public interface ILoader extends ICoreInterface, Cloneable, Resetable	{		/**		 * Initiates the loading process of the loader. A new URLRequest cannot be defined through this method. 		 */		function load():void;		/**		 * Returns a value between zero and one indicating the current loading progress of the loader.		 */		function get progress():Number;		/**		 * Returns the loaded data of the loader.		 * 		 * @return May return <code>null</code> until the loader has finished loading.		 * @see #loaded		 * @see #loading 		 */		function get data():*;		/**		 * Instructs the loader to prefech the total file size of target file without having to start the actual loading progress.		 * 		 * @see sekati.events.LoaderEvent#BYTESTOTAL_PREFETCHED		 */		function prefetchBytesTotal():void;		/**		 * Returns the bytesTotal prefetcher instance.		 */		function get bytesTotalPrefetcher():BytesTotalPrefetcher;		/**		 * Returns the <code>URLRequest</code> of the loader. The <code>URLRequest</code> cannot be changed.		 */		function getURLRequest():URLRequest;		/**		 * Indicates whether the loader is cancelable. Cancelable loaders may be interrupted while loading.		 * Cancelable loader instances implements the <code>cancel()</code> method. Note that if you wish to		 * cancel a loading process to resume it later you need to use the reset method before starting calling		 * the load() method again.		 * 		 * @see sekati.core.Cancelable;		 */		function get cancelable():Boolean;		/**		 * Indicates the number of total bytes of the loaders target file.		 * @return Total bytes from started loading process or prefetched file size via <code>prefetchBytesTotal()</code>, otherwise zero.		 */		function get bytesTotal():int;		/**		 * Indicates the number of loaded bytes from the loaders target file.		 * @return Zero if loading process has not begun.		 */		function get bytesLoaded():uint;		/**		 * Indicates, in milliseconds, the time elapsed from loading start to loading completion.		 */		function get loadTime():uint;		/**		 * Indicates whether the loading process has finished.		 */		function get loaded():Boolean;		/**		 * Indicates whether the loading process is running.		 */		function get loading():Boolean;	}}