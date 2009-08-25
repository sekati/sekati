/** * sekati.geom.CorePoint * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php */package sekati.geom {	import flash.geom.Point;	/**	 * CorePoint provides an advanced <code>Point</code> object for API geometry.	 */	public class CorePoint extends Point {		/**		 * CorePoint Constructor		 */		public function CorePoint(x : Number = 0, y : Number = 0) {			super( x, y );		}		/**		 * check if two points match		 * @param p (Point)		 * @return Boolean		 */		public function isEqual(p : Point) : Boolean {			return (p.x == x && p.y == y);		}		/**		 * get distance between two points		 * @param p (Point)		 * @return Number		 */		public function getDistance(p : Point) : Number {			return TrigBase.getDistance( this, p );		}		/**		 * Algo to give the grid based distance when only vertical & horizontal moves are allowed		 * @param p (Point)		 * @return Number		 */		public function getAbsoluteGridDistance(p : Point) : Number {			return Math.abs( x - p.x ) + Math.abs( y - p.y );		}		/**		 * Algo to give the grid based distance when diagonal moves are allowed		 * by finding math.min of the differences, we're figuring out how many moves can be diagonal ones.		 * Then we can just substract that number from the normal .getAbsoluteGridDistance() method since diagonals take		 * 1 move instead of the usual 2		 * @param p (Point)		 * @return Number		 */		public function getAbsoluteGridDistanceAllowDiagonals(p : Point) : Number {			var offset : Number = Math.min( Math.abs( x - p.x ), Math.abs( y - p.y ) );			return getAbsoluteGridDistance( p ) - offset;		}		/**		 * Get the angle degree between this point and a second point.		 * @param p (Point)		 * @return Number		 */		public function getAngle(p : Point) : Number {			return Math.atan( (this.y - p.y) / (this.x - p.x) ) / (Math.PI / 180);		}		/**		 * Returns a new point based on this point with x and y offset values		 * @param nX (Number)		 * @param nY (Number)		 * @return Point		 */		public function displace(nX : Number, nY : Number) : Point {			return new Point( x + nX, y + nY );		}		/**		 * Rotate this Point around another Point by the specified angle.		 * @param p (Point)		 * @param angle (Number)		 * @return Void		 */		public function rotate(p : Point, angle : Number) : void {			var radians : Number = TrigBase.angle2radian( angle );				var baseX : Number = this.x - p.x;			var baseY : Number = this.y - p.y;			this.x = (Math.cos( radians ) * baseX) - (Math.sin( radians ) * baseY) + p.x;			this.y = (Math.sin( radians ) * baseX) + (Math.cos( radians ) * baseY) + p.y;			}			/**		 * Clone this Point.		 * @return Point		 */		override public function clone() : Point {			return new CorePoint( x, y );		}						}}