/** * sekati.geom.TrigBase * @version 1.0.1 * @author jason m horwitz | sekati.com * Copyright (C) 2008 jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.geom {	import sekati.geom.Point;	import sekati.geom.Point3D;	import sekati.math.MathBase;	import sekati.utils.TypeEnforcer;			/**	 * TrigBase provides common trigonometry utilities.	 */	public class TrigBase {		/**		 * Convert angle to radian		 */		public static function angle2radian(a : Number) : Number {			return resolveAngle( a ) * Math.PI / 180;		}		/**		 * Convert radian to angle		 */		public static function radian2angle(r : Number) : Number {			return resolveAngle( r * 180 / Math.PI );		}		/**		 * will always give back a positive angle between 0 and 360		 */		public static function resolveAngle(a : Number) : Number {			var mod : Number = a % 360;			return (mod < 0) ? 360 + mod : mod;		}		/**		 * Get angle from two points		 */		public static function getAngle(p1 : Point, p2 : Point) : Number {			var r : Number = Math.atan2( p2.y - p1.y, p2.x - p1.x );			return radian2angle( r );		}		/**		 * Get radian from two points		 */		public static function getRadian(p1 : Point, p2 : Point) : Number {			return angle2radian( TrigBase.getAngle( p1, p2 ) );		}		/**		 * Get distance between two points		 */		public static function getDistance(p1 : Point, p2 : Point) : Number {			var xd : Number = p1.x - p2.x;			var yd : Number = p1.y - p2.y;			return Math.sqrt( xd * xd + yd * yd );		}		public static function getZDistance(p1 : Point3D, p2 : Point3D) : Number {			return  p1.z - p2.z;		}		/**		 * Get new point based on distance and angle from a given point		 * 		 * Note: Rounding to 3 decimals because got results like this: 6.12303176911189e-15		 * just as a precaution not to screw up movieclips positions & infinite tween loops		 */		public static function getPointFromDistanceAndAngle(centerPoint : Point, dist : Number, angle : Number) : Point {			var rad : Number = angle2radian( angle );			return new Point( MathBase.round( centerPoint.x + Math.cos( rad ) * dist, 3 ), MathBase.round( centerPoint.y + Math.sin( rad ) * dist, 3 ) );		}				/**		 * TrigBase Static Constructor		 */		public function TrigBase() {			TypeEnforcer.enforceStatic( TrigBase );		}	}}