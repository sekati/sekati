/** * sekati.collisions.GroupCollisionDetector * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php *  * Based on the CDK work of coreyoneil. */package sekati.collisions {	import sekati.collections.TypedArray;	import sekati.collisions.AbstractCollisionDetector;	/**	 * GroupCollisionDetector provides collision detection to <i>all registered display object</i> 	 * against all other registered display objects (<b>many to many</b>).	 * 	 * @example <listing version="3.0">	 * var detector : GroupCollisionDetector = new GroupCollisionDetector( A, B, C, D );	 * </listing>	 * Would detect:<ul>	 * <li><code>A</code> colliding with <code>B</code></li>	 * <li><code>A</code> colliding with <code>C</code></li>	 * <li><code>A</code> colliding with <code>D</code></li>	 * <li><code>B</code> colliding with <code>C</code></li>	 * <li><code>B</code> colliding with <code>D</code></li>	 * <li><code>C</code> colliding with <code>D</code></li>	 * </ul>	 * 	 * <p>You may apply an <code>alphaThreshold</code> to prevent collisions on perimeter alphas, prevent certain colors	 * from registering collisions with <code>excludeColor()</code> or aquire the angle of the collision by setting the 	 * <code>returnAngleType</code> to one of the provided <code>CollisionAngle</code>'s.</p>	 * 	 * @example <listing version="3.0">	 * detector.alphaThreshold = 0.5; 						// areas with an alpha >= 0.5 will create a collision.	 * detector.excludeColor( 0xffff0000 ); 				// The 32-bit color to exclude from collisions.	 * detector.returnAngleType = CollisionAngle.RADIAN; 	// would return the collision angle as radian in the Collision instance	 * </listing>	 * 	 * <p>You may choose to use the built-in frame-based monitoring function to check & respond to <code>Collision</code>'s:</p>	 * 	 * @example <listing version="3.0">	 * private function collisionHandler( e : CollisionEvent ) : void {	 * 		var list = e.collisions; // a TypedArray containing one or more Collision instances.	 * 		for ( var i : int = 0; i < list.length; i++) {	 * 			var collision : Collision = list[i] as Collision;	 * 			trace("Collision detected: " + collision.object1 + " & " + collision.object2 + " (angle: " + collision.angle + ", overlap: " + collision.overlap + ")");	 * 		}	 * }	 * detector.addEventListener( CollisionEvent.COLLISION, collisionHandler );	 * detector.startMonitor();	 * </listing>	 * 	 * @see sekati.collisions.Collision	 * @see sekati.collisions.CollisionAngle	 * @see sekati.collisions.AbstractCollisionDetector	 * @see sekati.collisions.CollisionDetector	 * @see sekati.collisions.GroupCollisionDetector	 * @see sekati.events.CollisionEvent	 */	public class GroupCollisionDetector extends AbstractCollisionDetector {		/**		 * GroupCollisionDetector Constructor		 * @param objs 	whoms collisions will be detected with each other.		 */		public function GroupCollisionDetector(... objs : Array) {			super( );			for(var i : uint = 0; i < objs.length ; i++) {				addItem( objs[i] );			}		}		/**		 * Check for collisions between the <code>DisplayObjects</code>, if an object collided with another it is recorded 		 * and returned by <code>checkCollisions()</code> as an TypedArray of <code>Collision</code> objects.		 */		override public function checkCollisions() : TypedArray {			clearArrays( );						var len : uint = objectArray.length;						if(len < 2) {				//Logger.$.warn( this, "There must be at least two objects added for collision detection." );				return objectCollisionArray;							}						for(var i : uint = 0; i < len - 1 ; i++) {				var item1 : * = objectArray[i];								for(var j : uint = i + 1; j < len ; j++) {					var item2 : * = objectArray[j];										if(item1.hitTestObject( item2 )) {						objectCheckArray.push( [ item1,item2 ] );					}				}			}			if(objectCheckArray.length) {				len = objectCheckArray.length;				for(i = 0; i < len ; i++) {					findCollisions( objectCheckArray[i][0], objectCheckArray[i][1] );				}			}					return objectCollisionArray;		}			}}