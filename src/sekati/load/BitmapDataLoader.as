/** * @version 1.0 * @author David Dahlstroem | hell@daviddahlstroem.com * Copyright (C) 2009 David Dahlstroem. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.load {	import sekati.core.Cancelable;	import sekati.load.ByteReference;	import sekati.load.ILoader;	import sekati.log.Logger;		import flash.display.BitmapData;	import flash.display.Loader;	import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.events.ProgressEvent;	import flash.events.SecurityErrorEvent;	import flash.net.URLRequest;	import flash.system.LoaderContext;		public class BitmapDataLoader extends AbstractLoader implements ILoader, Cancelable	{				public var allowTransparency:Boolean = true;				public var bitmapDataFillColor:uint = 0xFFFFFF;				public var loaderContext:LoaderContext;				private var _loader:Loader;				private var _bitmapData:BitmapData;				public function BitmapDataLoader(request:URLRequest)		{			super(request);						reset();		}				public function cancel():void		{			try			{				_loader.close();			}			catch(e:Error)			{				Logger.$.warn(this, "BitmapDataLoader has no stream open.");			}		}				override public function load():void		{			_loader.load(getURLRequest(), loaderContext);		}				override public function clone():Object		{			var			loader:BitmapDataLoader = new BitmapDataLoader(getURLRequest());						loader.allowTransparency = allowTransparency;						loader.bitmapDataFillColor = bitmapDataFillColor;						loader.loaderContext = loaderContext;						return loader;		}				override public function reset():void		{						if(_loader) destroy();						_loader = new Loader();						_byteReference = new ByteReference(_loader.contentLoaderInfo);						setEventListeners(true);		}				override public function destroy():void		{						cancel();						if(_bitmapData) _bitmapData.dispose();						setEventListeners(false);						_byteReference.destroy();						_byteReference = null;						_loader = null;		}			override public function get data():*		{						if(_loader)			{				if(!_loader.content) return null;			}			else			{				return null;			}						if(_bitmapData) _bitmapData.dispose();						_bitmapData = new BitmapData(_loader.content.width, _loader.content.height, allowTransparency, bitmapDataFillColor);						_bitmapData.draw(_loader.content);						_loader.unload();						return _bitmapData;		}				private function setEventListeners(add:Boolean):void		{						if(!_loader) return;						var method:String = (add) ? "addEventListener" : "removeEventListener";						_loader.contentLoaderInfo[method](Event.OPEN, dispatchLoadStartEvent);						_loader.contentLoaderInfo[method](Event.COMPLETE, dispatchLoadCompleteEvent);						_loader.contentLoaderInfo[method](ProgressEvent.PROGRESS, dispatchLoadProgressEvent);						_loader.contentLoaderInfo[method](IOErrorEvent.IO_ERROR, dispatchIOErrorEvent);						_loader.contentLoaderInfo[method](SecurityErrorEvent.SECURITY_ERROR, dispatchSecurityErrorEvent);		}		}}