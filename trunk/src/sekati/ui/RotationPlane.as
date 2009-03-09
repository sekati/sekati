/**
 * sekati.ui.RotationPlane
 * @version 1.1.0
 * @author pj ahlberg, jason m horwitz | sekati.com
 * Copyright (C) 2009  jason m horwitz, Sekat LLC. All Rights Reserved.
 * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php
 */
package sekati.ui {
	import sekati.display.CoreBitmapData;
	import sekati.display.CoreSprite;
	import sekati.utils.BitmapTransform;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;	

	/**
	 * RotationPlane provides a two dimensional plane containing two <i>"material"</i> <code>DisplayObject</code>'s 
	 * which can be manipulated via <code>rotateX, rotateY</code>.
	 */
	public class RotationPlane extends CoreSprite {
		/**
		 * Orient the materials on the X-axis.
		 * @see #orientation
		 */
		public static const X_ORIENTED : String = "x";
		/**
		 * Orient the materials on the Y-axis.
		 * @see #orientation
		 */
		public static const Y_ORIENTED : String = "y";
		protected var _orientation : String;
		protected var _renderReady : Boolean;
		protected var _bmpd0 : CoreBitmapData;
		protected var _bmpd1 : CoreBitmapData;
		protected var _frontBitmapTransform : BitmapTransform;
		protected var _backBitmapTransform : BitmapTransform;
		protected var _vertsArray : Array;
		protected var _facesArray : Array;
		protected var _btArray : Array;
		protected var _numVertices : uint;
		protected var _numFaces : uint;
		protected var _spCube : Sprite;
		protected var _rotationX : Number;
		protected var _rotationY : Number;
		protected var _wSegments : int;
		protected var _hSegments : int;
		protected var _smooth : Boolean;
		protected var _side0 : Sprite;
		protected var _side1 : Sprite;
		protected var _material0 : DisplayObject;
		protected var _material1 : DisplayObject;
		protected var _reversePlaneAlwaysOn : Number;
		protected var _focalLength : Number;
		protected var _masterWidth : Number;
		protected var _masterHeight : Number;
		/**
		 * RotationPlane Constructor
		 * @param material0 	the first (front) <code>DisplayObject</code>.
		 * @param material1 	the second (reverse) <code>DisplayObject</code>.
		 * @param orientation 	the orientation of the second material to the first. Must be <code>X_ORIENTED</code> or <code>Y_ORIENTED</code>.
		 * @param focalLength 	the amount of focal distortion: the higher the value the less distortion. (Recommended value: <code>1000-2000</code>). 
		 * @param wsegments 	the number of horizontal segments (divisons) to slice the materials (effects distortion).
		 * @param wsegments 	the number of vertical segments (divisons) to slice the materials (effects distortion).
		 * @param smooth 		determines whether the rotational transformation <code>BitmapData</code> is smoothed or not (effects performance).
		 * @example <listing version="3.0">
		 * var plane : RotationPlane = new RotationPlane( loader0.content, loader1.content, RotationPlane.X_ORIENTED );
		 * plane.addEventListener( MouseEvent.MOUSE_OVER, rotationBack );
		 * plane.addEventListener( MouseEvent.MOUSE_OUT, rotationFront );
		 * addChild( plane );
		 * 	
		 * private function rotationBack(e : MouseEvent) : void {
		 * 		Tweener.addTween( plane, { rotateX:180, time:0.7 } );
		 * }
		 * 		
		 * private function rotationFront(e : MouseEvent) : void {
		 * 		Tweener.addTween( plane, { rotateY:0, time:0.7 } );
		 * }
		 * </listing>
		 * @see sekati.utils.BitmapTransform
		 */
		public function RotationPlane(material0 : DisplayObject, material1 : DisplayObject, orientation : String = Y_ORIENTED, focalLength : uint = 1500, wsegments : int = 5, hsegments : int = 5, smooth : Boolean = false) {
			_renderReady = false;
			reversePlaneAlwaysOn = false;
			this.orientation = orientation;
			mouseEnabled = false;
			mouseChildren = false;
			_wSegments = wsegments;
			_hSegments = hsegments;
			interactiveMode = false;
			
			_material0 = null;			_material1 = null;
			
			_smooth = smooth;
			
			this.material0 = material0;
			this.material1 = material1;
			
			
			this.material0.visible = false;
			this.material1.visible = false;
			
			_focalLength = focalLength;
			
			_spCube = new Sprite( );
			addChild( _spCube );
			
			_side0 = new Sprite( );
			_spCube.addChild( _side0 );
			_side1 = new Sprite( );
			_spCube.addChild( _side1 );
			
			determineMasterDimensions( );
			
			_rotationX = 0;
			_rotationY = 0;
			
			init3D( );
		}
		/**
		 * Determine <code>width : height</code> relationships.
		 */
		protected function determineMasterDimensions() : void {
			_masterWidth = (_material0.width >= _material1.width) ? _material0.width : _material1.width;
			_masterHeight = (_material0.height >= _material1.height) ? _material0.height : _material1.height;
			alignDisplayObjects( );
		}
		/**
		 * Align the materials.
		 */
		protected function alignDisplayObjects() : void {
			material0.x = (_masterWidth * 0.5) - (material0.width * 0.5);
			material1.x = (_masterWidth * 0.5) - (material1.width * 0.5);
			material0.y = (_masterHeight * 0.5) - (material0.height * 0.5);
			material1.y = (_masterHeight * 0.5) - (material1.height * 0.5);
			_spCube.x = _masterWidth * 0.5;
			_spCube.y = _masterHeight * 0.5;
		}
		/**
		 * Initialize 3D logic.
		 */
		protected function init3D() : void {
			_vertsArray = new Array( );
			_facesArray = new Array( );
			_btArray = new Array( );

			_numVertices = 8;
			_numFaces = 2;

			setFrontPlane( );
			setBackPlane( );
			
			_renderReady = true;
			renderView( _rotationY, _rotationX );
		}
		/**
		 * Configure the front plane (<code>material0</code>).
		 */
		protected function setFrontPlane() : void {
			_frontBitmapTransform = new BitmapTransform( _material0.width, _material0.height, _wSegments, _hSegments, _smooth );
			
			_vertsArray[0] = [ 0,-_material0.width * 0.5, _material0.height * 0.5 ];
			_vertsArray[1] = [ 0,_material0.width * 0.5, _material0.height * 0.5 ];
			_vertsArray[2] = [ 0,_material0.width * 0.5,-_material0.height * 0.5 ];
			_vertsArray[3] = [ 0,-_material0.width * 0.5, -_material0.height * 0.5 ];
			
			_facesArray[0] = [ 0, 1, 2, 3, _bmpd0, _frontBitmapTransform ];
		}
		/**
		 * Configure the back plane (<code>material1</code>).
		 */
		protected function setBackPlane() : void {
			_backBitmapTransform = new BitmapTransform( _material1.width, _material1.height, _wSegments, _hSegments, _smooth );
			
			if(_orientation == Y_ORIENTED) {
				_vertsArray[4] = [ -1,_material1.width * 0.5, _material1.height * 0.5 ];
				_vertsArray[5] = [ -1,-_material1.width * 0.5, _material1.height * 0.5 ];
				_vertsArray[6] = [ -1,-_material1.width * 0.5, -_material1.height * 0.5 ];
				_vertsArray[7] = [ -1,_material1.width * 0.5, -_material1.height * 0.5 ];
			
				_facesArray[1] = [ 4, 5, 6, 7, _bmpd1, _backBitmapTransform ];
			} else {
				_vertsArray[4] = [ -1,-_material1.width * 0.5, _material1.height * 0.5 ];
				_vertsArray[5] = [ -1,_material1.width * 0.5, _material1.height * 0.5 ];
				_vertsArray[6] = [ -1,_material1.width * 0.5, -_material1.height * 0.5 ];
				_vertsArray[7] = [ -1,-_material1.width * 0.5, -_material1.height * 0.5 ];
			
				_facesArray[1] = [ 7, 6, 5, 4, _bmpd1, _backBitmapTransform ];
			}
			
			_material1.visible = false;			_side1.visible = false;
			renderView( _rotationX, _rotationY );
		}
		/**
		 * Render the view.
		 */
		protected function renderView(t : Number, p : Number) : void {
			if(!_renderReady) {
				return;
			}
			var i : int;
			var distArray : Array = [];
			var dispArray : Array = [];
			var vertsNewArray : Array = [];
			var midPoint : Array = [];
			var curv0 : Array = [];
			var curv1 : Array = [];
			var curv2 : Array = [];
			var curv3 : Array = [];
			var curImg : BitmapData;
			var dist : Number;
			var curFace : uint;
			
			t = t * Math.PI / 180;
			p = (p + 90) * Math.PI / 180;
	
			_side0.graphics.clear( );
			_side1.graphics.clear( );
	
			for(i = 0; i < _numVertices ;i++) {
				vertsNewArray[i] = pointNewView( _vertsArray[i], t, p ); 
			}
	
			for(i = 0; i < _numFaces ;i++) {
				midPoint[0] = (vertsNewArray[_facesArray[i][0]][0] + vertsNewArray[_facesArray[i][1]][0] + vertsNewArray[_facesArray[i][2]][0] + vertsNewArray[_facesArray[i][3]][0]) * 0.25;
				midPoint[1] = (vertsNewArray[_facesArray[i][0]][1] + vertsNewArray[_facesArray[i][1]][1] + vertsNewArray[_facesArray[i][2]][1] + vertsNewArray[_facesArray[i][3]][1]) * 0.25;
				midPoint[2] = (vertsNewArray[_facesArray[i][0]][2] + vertsNewArray[_facesArray[i][1]][2] + vertsNewArray[_facesArray[i][2]][2] + vertsNewArray[_facesArray[i][3]][2]) * 0.25;
				dist = Math.sqrt( Math.pow( _focalLength - midPoint[0], 2 ) + Math.pow( midPoint[1], 2 ) + Math.pow( midPoint[2], 2 ) );
				distArray[i] = [ dist,i ];
			}
			
			var byDist : Function = function(v : Array, w : Array):Number {
				if (v[0] > w[0]) {
					return -1;
				} else if (v[0] < w[0]) {
					return 1;
				} else {
					return 0;
				}				
			};
			
			distArray.sort( byDist );
			
			for(i = 0; i < _numVertices ;i++) {
				dispArray[i] = [ _focalLength / (_focalLength - vertsNewArray[i][0]) * vertsNewArray[i][1],-_focalLength / (_focalLength - vertsNewArray[i][0]) * vertsNewArray[i][2] ];
			}
			for(i = _reversePlaneAlwaysOn; i < _numFaces ;i++) {
				curFace = distArray[i][1];
				curv0 = [ dispArray[_facesArray[curFace][0]][0],dispArray[_facesArray[curFace][0]][1] ];
				curv1 = [ dispArray[_facesArray[curFace][1]][0],dispArray[_facesArray[curFace][1]][1] ];
				curv2 = [ dispArray[_facesArray[curFace][2]][0],dispArray[_facesArray[curFace][2]][1] ];
				curv3 = [ dispArray[_facesArray[curFace][3]][0],dispArray[_facesArray[curFace][3]][1] ];
				curImg = _facesArray[curFace][4];
				_spCube.setChildIndex( this["_side" + String( curFace )], _spCube.numChildren - 1 );
				_facesArray[curFace][5].mapBitmapData( curImg, new Point( curv0[0], curv0[1] ), new Point( curv1[0], curv1[1] ), new Point( curv2[0], curv2[1] ), new Point( curv3[0], curv3[1] ), this["_side" + String( curFace )] );
			}
			swapDisplayObjects( );
			/*_side0.visible = true;
			_side1.visible = true;
			material0.visible = false;			material1.visible = false;*/
		}
		/**
		 * Swap display objects.
		 */
		protected function swapDisplayObjects() : void {
			
			var frontXFacing : Boolean = false;
			var frontYFacing : Boolean = false;
			var backXFacing : Boolean = false;
			var backYFacing : Boolean = false;
			
			
			if(_rotationX % 180 == 0 && _rotationY % 180 == 0) {
				if(_rotationX % 360 == 0) {
					frontXFacing = true;
				} else {
					backXFacing = true;
				}
				
				if(_rotationY % 360 == 0) {
					frontYFacing = true;
				} else {
					backYFacing = true;
				}
				
				
				_side0.visible = false;
				_side1.visible = false;
				material0.visible = true;
				if(reversePlaneAlwaysOn) material1.visible = true;
				
				
				/*trace( "frontXFacing = " + frontXFacing );
				trace( "frontYFacing = " + frontYFacing );
				trace( "backXFacing = " + backXFacing );
				trace( "backYFacing = " + backYFacing );
				trace( "------------------------------------------------" );*/
			} else {
				_side0.visible = true;
				_side1.visible = true;
				material0.visible = false;
				material1.visible = false;
			}

			
			//front facing Y rotation
			if(frontXFacing == true && frontYFacing == true && backXFacing == false && backYFacing == false) {
				_side0.visible = false;
				_side1.visible = false;
				material0.visible = true;
				material1.visible = false;
			}
			
			//front facing X rotation
			if(frontXFacing == false && frontYFacing == false && backXFacing == true && backYFacing == true) {
				_side0.visible = false;
				_side1.visible = false;
				material0.visible = false;
				material1.visible = true;
			}
			
			//back facing Y rotation
			if(frontXFacing == true && frontYFacing == false && backXFacing == false && backYFacing == true) {
				_side0.visible = false;
				_side1.visible = false;
				material0.visible = false;
				material1.visible = true;
			}
			
			//back facing X rotation
			if(frontXFacing == false && frontYFacing == true && backXFacing == true && backYFacing == false) {
				_side0.visible = false;
				_side1.visible = false;
				material0.visible = false;
				material1.visible = true;
			}
		}
		/**
		 * Aquire the new view coordinates.
		 */
		protected function pointNewView(v : Array, theta : Number, phi : Number) : Array {
			var newCoords : Array = [];
			newCoords[0] = v[0] * Math.cos( theta ) * Math.sin( phi ) + v[1] * Math.sin( theta ) * Math.sin( phi ) + v[2] * Math.cos( phi );
			newCoords[1] = -v[0] * Math.sin( theta ) + v[1] * Math.cos( theta );
			newCoords[2] = -v[0] * Math.cos( theta ) * Math.cos( phi ) - v[1] * Math.sin( theta ) * Math.cos( phi ) + v[2] * Math.sin( phi );
			return newCoords;
		}
		/**
		 * The <code>DisplayObject</code> <i>"material"</i> used on the first (front) side of the plane.
		 */
		public function get material0() : DisplayObject {
			return _material0;
		}
		/*** @private */
		public function set material0(value : DisplayObject) : void {
			if(_material0 != null) {
				removeChild( _material0 );
				_material0 = null;
			}
			_material0 = value;
			addChild( _material0 );
			_bmpd0 = new CoreBitmapData( _material0, 0, 0, NaN, NaN, 1, true );
			if(!_renderReady) {
				return;
			}
			setFrontPlane( );
			renderView( _rotationY, _rotationX );
		}
		/**
		 * The <code>DisplayObject</code> <i>"material"</i> used on the second (reverse) side of the plane.
		 */
		public function get material1() : DisplayObject {
			return _material1;
		}
		/*** @private */
		public function set material1(value : DisplayObject) : void {
			if(_material1 != null) {
				removeChild( _material1 );
				_material1 = null;
			}
			_material1 = value;
			addChild( _material1 );
			_bmpd1 = new CoreBitmapData( _material1, 0, 0, NaN, NaN, 1, true );
			if(!_renderReady) {
				return;
			}
			setBackPlane( );
			renderView( _rotationY, _rotationX );
		}
		/**
		 * Rotation of the plane <b>on</b> the X-axis (vertical movement).
		 * 
		 * <p><b>Note</b>: <code>rotateX</code> is used instead of <code>rotationX</code> for compatability 
		 * purposes between <i>FP9</i> and <i>FP10</i>'s inherited <code>rotationX</code></p>
		 */
		public function get rotateX() : Number {
			return _rotationX;
		}
		/*** @private */
		public function set rotateX(value : Number) : void {
			_rotationX = value;
			renderView( _rotationY, _rotationX );
		}
		/**
		 * Rotation of the plane <b>on</b> the Y-axis (horizontal movement).
		 * 
		 * <p><b>Note</b>: <code>rotateY</code> is used instead of <code>rotationY</code> for compatability 
		 * purposes between <i>FP9</i> and <i>FP10</i>'s inherited <code>rotationY</code></p>
		 */
		public function get rotateY() : Number {
			return _rotationY;
		}
		/*** @private */
		public function set rotateY(value : Number) : void {
			_rotationY = value;
			renderView( _rotationY, _rotationX );
		}
		/**
		 * Determines whether the <code>BitmapData</code> smoothing is applied to the plane rotations or not.
		 */
		public function get smooth() : Boolean {
			return _smooth;
		}
		/*** @private */
		public function set smooth(value : Boolean) : void {
			_smooth = value;
			for (var i : int = 0; i < _btArray.length ; i++) {
				_btArray[i]._smooth = _smooth;
			}
			renderView( _rotationY, _rotationX );
		}
		/**
		 * Determines the orientation of the reverse material (<code>material1</code>) to the front material (<code>material0</code>) 
		 * based on your choosen axis of rotation; this can be set manually.
		 * 
		 * <p><b>Note</b>: At this time it is assumed that this will be set once during initialization; though switching in-line may
		 * be supported in future versions.</p>
		 */
		public function get orientation() : String {
			return _orientation;
		}
		/*** @private */
		public function set orientation(value : String) : void {
			if(_orientation == value) {
				return;
			} else if (value != X_ORIENTED && value != Y_ORIENTED) {
				//Logger.$.error( this, String( value ) + " is not a valid orientation type. The orientation will not be changed." );
				return;
			}
			
			_orientation = value;
			
			if(!_renderReady) {
				return;
			}
			setBackPlane( );
		}
		/**
		 * Determines whether the reverse plane material will always be visible (<code>true</code>) or not (<code>false</code>).
		 */
		public function get reversePlaneAlwaysOn() : Boolean {
			if(_reversePlaneAlwaysOn == 0) {
				return true;
			} else {
				return false;
			}
		}
		/*** @private */
		public function set reversePlaneAlwaysOn(value : Boolean) : void {
			if(value == true) {
				_reversePlaneAlwaysOn = 0;
			}else if(value == false) {
				_reversePlaneAlwaysOn = 1;
			}
		}
		/**
		 * Determines the amount of focal distortion: the higher the value the less distortion. (Recommended value: <code>1000-2000</code>). 
		 */
		public function get focalLength() : Number {
			return _focalLength;
		}
		/*** @private */
		public function set focalLength(focalLength : Number) : void {
			_focalLength = focalLength;
		}
	}
}
