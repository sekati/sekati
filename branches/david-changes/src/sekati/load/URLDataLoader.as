/** * @version 1.0 * @author David Dahlstroem | hell@daviddahlstroem.com * Copyright (C) 2009 David Dahlstroem. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.load {	import sekati.core.Cancelable;	import sekati.load.ByteReference;	import sekati.load.ILoader;	import sekati.log.Logger;		import flash.events.Event;	import flash.events.IOErrorEvent;	import flash.events.ProgressEvent;	import flash.events.SecurityErrorEvent;	import flash.net.URLLoader;	import flash.net.URLRequest;		public class URLDataLoader extends AbstractLoader implements ILoader, Cancelable 	{				/** @private */		protected var _urlLoader:URLLoader;				public function URLDataLoader(request:URLRequest)		{				super(request);						reset();		}		public function cancel():void		{			try			{				_urlLoader.close();			}			catch(e:Error) {								Logger.$.warn(this, "URLDataLoader has no stream open.");			}		}				override public function load():void		{			_urlLoader.load(getURLRequest());						dispatchLoadStartEvent();		}				override public function clone():Object		{			var			loader:URLDataLoader = new URLDataLoader(getURLRequest());						loader.dataFormat = dataFormat;						return loader;		}				override public function reset():void		{			if(_urlLoader) destroy();						_urlLoader = new URLLoader();						_urlLoader.dataFormat = dataFormat;						_byteReference = new ByteReference(_urlLoader);						setEventListeners(true);		}			override public function destroy():void		{			cancel();						setEventListeners(false);						_byteReference.destroy();						_byteReference = null;						_urlLoader = null;		}		override public function get data():*		{			return _urlLoader.data;		}				public function get dataFormat():String		{			return _urlLoader.dataFormat;		}				public function set dataFormat(value:String):void		{			_urlLoader.dataFormat = value;		}				private function setEventListeners(add:Boolean):void		{			var method:String = (add) ? "addEventListener" : "removeEventListener";						_urlLoader[method](Event.COMPLETE, dispatchLoadCompleteEvent);						_urlLoader[method](ProgressEvent.PROGRESS, dispatchLoadProgressEvent);						_urlLoader[method](IOErrorEvent.IO_ERROR, dispatchIOErrorEvent);						_urlLoader[method](SecurityErrorEvent.SECURITY_ERROR, dispatchSecurityErrorEvent);		}	}}