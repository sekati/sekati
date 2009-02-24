/** * RotationPlane * @version 1.0.0 * @author pj ahlberg * Copyright (C) 2009  pj ahlberg. All Rights Reserved. */package {	import sekati.utils.BitmapTransformer;	import sekati.display.CoreBitmapData;	import sekati.display.CoreSprite;	import sekati.log.Logger;		import flash.display.BitmapData;	import flash.display.DisplayObject;	import flash.display.Sprite;	import flash.geom.Point;			/**	 * CoreSprite is a foundational <code>DisplayObject</code> class 	 * and can be thought of as one of the main building block of 	 * API-based applications.	 */	public class RotationPlane extends CoreSprite {		public static const X_AXIS : String = "xaxis";		public static const Y_AXIS : String = "yaxis";				protected var _rotType : String;		protected var _renderReady : Boolean;		protected var _bd0 : BitmapData;		protected var _bd1 : BitmapData;		protected var _frontBitmapTransform : BitmapTransformer;		protected var _backBitmapTransform : BitmapTransformer;		protected var _vertsArray : Array;		protected var _facesArray : Array;		protected var _btArray : Array;		protected var _numVertices : uint;		protected var _numFaces : uint;		protected var _spCube : Sprite;		protected var _rotationX : Number;		protected var _rotationY : Number;		protected var _wSegments : int;		protected var _hSegments : int;		protected var _smooth : Boolean;		protected var _side0 : Sprite;		protected var _side1 : Sprite;		protected var _material0 : DisplayObject;		protected var _material1 : DisplayObject;		protected var _reversePlaneAlwaysOn:Number;		protected var _focalLength : Number;				/**		 * RotationPlane Constructor		 * @param front 	the front facing display object		 * @example <listing version="3.0">		 * 		 * </listing>		 * @see sekati.display.CoreBitmap		 */		public function RotationPlane(mat0 : DisplayObject, mat1 : DisplayObject, wsegments : int = 5, hsegments : int = 5, smooth : Boolean = false) {						_renderReady = false;			reversePlaneAlwaysOn = false;			rotationType = Y_AXIS;						_wSegments = wsegments;			_hSegments = hsegments;						_smooth = smooth;						this.material0 = mat0;			this.material1 = mat1;						_focalLength = 1500;						_spCube = new Sprite( );			addChild( _spCube );			_spCube.x = _material0.width / 2;			_spCube.y = _material0.width / 2;						_side0 = new Sprite( );			_spCube.addChild( _side0 );			_side1 = new Sprite( );			_spCube.addChild( _side1 );						_rotationX = 0;			_rotationY = 0;						init3D( );		}		protected function init3D() : void {						_vertsArray = new Array( );			_facesArray = new Array( );			_btArray = new Array( );			_numVertices = 8;			_numFaces = 2;			setFrontPlane( );			setBackPlane( );						_renderReady = true;			renderView( _rotationY, _rotationX );		}		protected function setFrontPlane() : void {						_frontBitmapTransform = new BitmapTransformer( _material0.width, _material0.height, _wSegments, _hSegments, _smooth );						_vertsArray[0] = [ 0,-_material0.width / 2, _material0.height / 2 ];			_vertsArray[1] = [ 0,_material0.width / 2, _material0.height / 2 ];			_vertsArray[2] = [ 0,_material0.width / 2,-_material0.height / 2 ];			_vertsArray[3] = [ 0,-_material0.width / 2, -_material0.height / 2 ];						_facesArray[0] = [ 0,1,2,3,_bd0,_frontBitmapTransform ];					}		protected function setBackPlane() : void {						_backBitmapTransform = new BitmapTransformer( _material1.width, _material1.height, _wSegments, _hSegments, _smooth );						if(_rotType == Y_AXIS) {				_vertsArray[4] = [ -1,_material1.width / 2, _material1.height / 2 ];				_vertsArray[5] = [ -1,-_material1.width / 2, _material1.height / 2 ];				_vertsArray[6] = [ -1,-_material1.width / 2, -_material1.height / 2 ];				_vertsArray[7] = [ -1,_material1.width / 2, -_material1.height / 2 ];							_facesArray[1] = [ 4,5,6,7,_bd1, _backBitmapTransform ];			} else {				_vertsArray[4] = [ -1,-_material1.width / 2, _material1.height / 2 ];				_vertsArray[5] = [ -1,_material1.width / 2, _material1.height / 2 ];				_vertsArray[6] = [ -1,_material1.width / 2, -_material1.height / 2 ];				_vertsArray[7] = [ -1,-_material1.width / 2, -_material1.height / 2 ];							_facesArray[1] = [ 7,6,5,4,_bd1, _backBitmapTransform ];			}								}		protected function renderView(t : Number,p : Number) : void {						if(!_renderReady) {				return;			}				var i : int;			var distArray : Array = [];			var dispArray : Array = [];			var vertsNewArray : Array = [];			var midPoint : Array = [];			var curv0 : Array = [];			var curv1 : Array = [];			var curv2 : Array = [];			var curv3 : Array = [];			var curImg : BitmapData;			var dist : Number;			var curFace : uint;						t = t * Math.PI / 180;			p = (p + 90) * Math.PI / 180;				_side0.graphics.clear( );			_side1.graphics.clear( );							for(i = 0; i < _numVertices ;i++) {						vertsNewArray[i] = pointNewView( _vertsArray[i], t, p ); 			}					for(i = 0; i < _numFaces ;i++) {						midPoint[0] = (vertsNewArray[_facesArray[i][0]][0] + vertsNewArray[_facesArray[i][1]][0] + vertsNewArray[_facesArray[i][2]][0] + vertsNewArray[_facesArray[i][3]][0]) / 4;				midPoint[1] = (vertsNewArray[_facesArray[i][0]][1] + vertsNewArray[_facesArray[i][1]][1] + vertsNewArray[_facesArray[i][2]][1] + vertsNewArray[_facesArray[i][3]][1]) / 4;				midPoint[2] = (vertsNewArray[_facesArray[i][0]][2] + vertsNewArray[_facesArray[i][1]][2] + vertsNewArray[_facesArray[i][2]][2] + vertsNewArray[_facesArray[i][3]][2]) / 4;						dist = Math.sqrt( Math.pow( _focalLength - midPoint[0], 2 ) + Math.pow( midPoint[1], 2 ) + Math.pow( midPoint[2], 2 ) );						distArray[i] = [ dist,i ];			}				distArray.sort( byDist );				for(i = 0; i < _numVertices ;i++) {							dispArray[i] = [ _focalLength / (_focalLength - vertsNewArray[i][0]) * vertsNewArray[i][1],-_focalLength / (_focalLength - vertsNewArray[i][0]) * vertsNewArray[i][2] ];			}				for(i = _reversePlaneAlwaysOn; i < _numFaces ;i++) {						curFace = distArray[i][1];						curv0 = [ dispArray[_facesArray[curFace][0]][0],dispArray[_facesArray[curFace][0]][1] ];				curv1 = [ dispArray[_facesArray[curFace][1]][0],dispArray[_facesArray[curFace][1]][1] ];				curv2 = [ dispArray[_facesArray[curFace][2]][0],dispArray[_facesArray[curFace][2]][1] ];				curv3 = [ dispArray[_facesArray[curFace][3]][0],dispArray[_facesArray[curFace][3]][1] ];						curImg = _facesArray[curFace][4];						_spCube.setChildIndex( this["_side" + String( curFace )], _spCube.numChildren - 1 );						_facesArray[curFace][5].mapBitmapData( curImg, new Point( curv0[0], curv0[1] ), new Point( curv1[0], curv1[1] ), new Point( curv2[0], curv2[1] ), new Point( curv3[0], curv3[1] ), this["_side" + String( curFace )] );			}		}		protected function byDist(v : Array,w : Array) : Number {				if (v[0] > w[0]) {				return -1;			} else if (v[0] < w[0]) {				return 1;			} else {				return 0;			}		}		protected function pointNewView(v : Array,theta : Number,phi : Number) : Array {				var newCoords : Array = [];						newCoords[0] = v[0] * Math.cos( theta ) * Math.sin( phi ) + v[1] * Math.sin( theta ) * Math.sin( phi ) + v[2] * Math.cos( phi );			newCoords[1] = -v[0] * Math.sin( theta ) + v[1] * Math.cos( theta );			newCoords[2] = -v[0] * Math.cos( theta ) * Math.cos( phi ) - v[1] * Math.sin( theta ) * Math.cos( phi ) + v[2] * Math.sin( phi );						return newCoords;		}				public function get material0() : DisplayObject {			return _material0;		}		public function set material0(value : DisplayObject) : void {			_material0 = value;			_bd0 = new CoreBitmapData( _material0, 0, 0, NaN, NaN, 1, true );			if(!_renderReady) {				return;			}			setFrontPlane();			renderView( _rotationY, _rotationX );		}		public function get material1() : DisplayObject {			return _material1;		}		public function set material1(value : DisplayObject) : void {			_material1 = value;			_bd1 = new CoreBitmapData( _material1, 0, 0, NaN, NaN, 1, true );			if(!_renderReady) {				return;			}			setBackPlane();			renderView( _rotationY, _rotationX );		}		public function get rotationX() : Number {			return _rotationX;		}		public function set rotationX(value : Number) : void {			_rotationX = value;			renderView( _rotationY, _rotationX );		}		public function get rotationY() : Number {			return _rotationY;		}		public function set rotationY(value : Number) : void {			_rotationY = value;			renderView( _rotationY, _rotationX );		}		public function get smooth() : Boolean {			return _smooth;		}		public function set smooth(value : Boolean) : void {			_smooth = value;			for (var i : int = 0; i < _btArray.length ; i++) {				_btArray[i]._smooth = _smooth;			}			renderView( _rotationY, _rotationX );		}		public function get rotationType() : String {			return _rotType;		}		public function set rotationType(value : String) : void {			if(_rotType == value) {				return;			}else if (value != X_AXIS && value != Y_AXIS) {				Logger.$.error( this, String( value ) + " is not a valid rotation type. The rotationType will not be changed." );				return;			}						_rotType = value;						setBackPlane();		}				public function get reversePlaneAlwaysOn() : Boolean {						if(_reversePlaneAlwaysOn == 0){				return true;			}else{				return false;			}					}		public function set reversePlaneAlwaysOn(value : Boolean) : void {			if(value == true){				_reversePlaneAlwaysOn = 0;			}else if(value == false){				_reversePlaneAlwaysOn = 1;			}		}				public function get focalLength() : Number {			return _focalLength;		}				public function set focalLength(focalLength : Number) : void {			_focalLength = focalLength;		}					}}