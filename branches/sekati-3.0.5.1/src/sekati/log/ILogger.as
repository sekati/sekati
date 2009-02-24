/** * sekati.log.ILogger * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2008  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.log {	/**	 * ILogger provides the definitions for the Logger API.	 */	public interface ILogger {		function trace(origin : Object, message : String) : void;		function info(origin : Object, message : String) : void;		function status(origin : Object, message : String) : void;		function notice(origin : Object, message : String) : void;		function debug(origin : Object, message : String) : void;		function warn(origin : Object, message : String) : void;		function error(origin : Object, message : String) : void;		function fatal(origin : Object, message : String) : void;		function object(origin : Object) : void;		function set enabled(b : Boolean) : void;		function get enabled() : Boolean;		function set outputMode(mode : uint) : void		function get outputMode() : uint;		function reset() : void;	}}