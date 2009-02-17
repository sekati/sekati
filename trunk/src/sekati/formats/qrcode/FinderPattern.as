/** * sekati.formats.qrcode.FinderPattern * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.formats.qrcode {	import flash.display.BitmapData;		import flash.display.Shape;		import flash.geom.Point;			/**	 * FinderPattern	 */	public class FinderPattern {		private static const HORIZONTAL : int = 0;		private static const VERTICAL : int = 1;		public static function findPattern(pixels : BitmapData, debug : BitmapData = null) : Object {			var linesAcrossHorizontally : Array = findLinesAcross( pixels, HORIZONTAL );			var linesAcrossVertically : Array = findLinesAcross( pixels, VERTICAL );			var line : Object;			var i : int;			if (debug != null) {				for each(line in linesAcrossHorizontally) {					for (i = 0; i < line.offset ; i++) {						debug.setPixel( line.endPoint.x - i, line.endPoint.y, 0x00ff00 );					}				}				for each(line in linesAcrossVertically) {					for (i = 0; i < line.offset ; i++) {						debug.setPixel( line.endPoint.x, line.endPoint.y - i, 0x00ff00 );					}				}			}			var horizontal3Centers : Array = findTop3ClusterCenters( linesAcrossHorizontally );			var vertical3Centers : Array = findTop3ClusterCenters( linesAcrossVertically );			if (debug != null) {				for each(line in horizontal3Centers) {					for (i = 0; i < line.offset ; i++) {						debug.setPixel( line.endPoint.x - i, line.endPoint.y, 0xff0000 );					}				}				for each(line in vertical3Centers) {					for (i = 0; i < line.offset ; i++) {						debug.setPixel( line.endPoint.x, line.endPoint.y - i, 0xff0000 );					}				}			}			var centers : Array = findCenters( horizontal3Centers, vertical3Centers );			if (debug != null && centers.length == 3) {				var triangle : Shape = new Shape( );				triangle.graphics.beginFill( 0x0000ff );				triangle.graphics.moveTo( centers[0].x, centers[0].y );				triangle.graphics.lineTo( centers[1].x, centers[1].y );				triangle.graphics.lineTo( centers[2].x, centers[2].y );				triangle.graphics.lineTo( centers[0].x, centers[0].y );				debug.draw( triangle );			}			centers = orderCenters( centers ); 			trace( centers );			return {leftTop: centers[0], rightTop: centers[1], leftBottom: centers[2]      };		}		private static function findLinesAcross(pixels : BitmapData,         direction : int) : Array {			var MAX_SIDE_PRIMARY:int;			var MAX_SIDE_SECONDARY:int;			if (direction==HORIZONTAL) {        MAX_SIDE_PRIMARY=pixels.width; MAX_SIDE_SECONDARY=pixels.height;      } else if (direction==VERTICAL) {        MAX_SIDE_PRIMARY=pixels.height; MAX_SIDE_SECONDARY=pixels.width;      }			var reference:Array = new Array(1, 1, 3, 1, 1);			var referenceSum:int = 7; //1+1+3+1+1			var recent:Array = new Array();      var linesAcross:Array = new Array();       for (var b:int=0; b<MAX_SIDE_SECONDARY; b++) {        var last:int = 0;         var current:int = 0;        var length:int = 0;        for (var a:int=0; a<MAX_SIDE_PRIMARY; a++) {          current = direction==HORIZONTAL ? pixels.getPixel(a,b) :             pixels.getPixel(b,a);          if (current==last) {            length++;          } else {            if (recent.push(length) > reference.length) {              recent.shift();            }            if (current==0) { //white->black transision            } else { //black->white transition              if (recent.length==reference.length) {                var recentAverage:int = 0;                var recentSum:int = 0;                var i:int;                for (i=0; i<recent.length; i++) {                  recentSum+=recent[i];                }                recentAverage = recentSum/referenceSum;                for (i=0; i<recent.length; i++) {                  var t:int = reference[i]*recentAverage;                  if ((recent[i]<t*0.5) || (recent[i]>t*2)) {                    break;                  }                }                if (i==recent.length) {                  var endPoint:Point = direction==HORIZONTAL ?                     new Point(a-1,b) :                     new Point(b,a-1);                  linesAcross.push({endPoint:endPoint, offset:recentSum});                }              }            }            length = 1;            last = current;          }        }        recent = new Array();        length = 0;      }      return linesAcross;		}    private static function findTop3ClusterCenters(linesAcross:Array): Array {      var clusters:Array = new Array();      var i:int;      for each (var target:Object in linesAcross) {        for (i=0; i < clusters.length; i++) {          var lastElement:Object = clusters[i][clusters[i].length-1];          if (Point.distance(lastElement.endPoint, target.endPoint) < 3) {            clusters[i].push(target);          }        }        if (i == clusters.length) {          clusters.push(new Array(target));        }      }        clusters.sortOn("length", Array.DESCENDING | Array.NUMERIC);      var clusterCenters:Array = new Array();      if (clusters.length>=3) {        for (i=0; i<clusters.length && clusterCenters.length<3; i++) {          var candidate:Object = clusters[i][int(clusters[i].length/2)];          var j:int=0;          for (j=0; j<clusterCenters.length; j++) {            // avoid too near points            if (Point.distance(candidate.endPoint, clusterCenters[j].endPoint) < 3) {              break;            }          }          if (j==clusterCenters.length) {            clusterCenters.push(candidate);          }        }      }      return clusterCenters;    }    private static function findCenters(horizontal3Centers:Array,        vertical3Centers:Array):Array {      var centers:Array = new Array();      for each(var h:Object in horizontal3Centers) {        for each(var v:Object in vertical3Centers) {          if (Point.distance(h.endPoint, v.endPoint) < h.offset) {            centers.push(new Point(h.endPoint.x-h.offset/2,                  v.endPoint.y-v.offset/2));            break;          }        }      }      return centers;    }    private static function orderCenters(centers:Array): Array {      return centers;    }			}}