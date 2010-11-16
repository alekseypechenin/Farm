package Entities
{
	// Namespaces
	import Core.*;
	
	import Utils.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	import mx.collections.*;
	import mx.core.*;
	
	// Crates main landshaft
	public class TiledBackground extends BaseObject
	{
		public const maxObjectWidth:int = 100;
		public const maxObjectHeight:int = 54;
		private const objectsGlobalOffsetX:int = -5;
		private const objectsGlobalOffsetY:int = 22; 
		private const maxMatrixX:int = 15;
		private const maxMatrixY:int = 27
		
		// Matrix coordinates that is determined by Mouse Pointer. Default = undefined
		private var globalMatrixPosition: Point = new Point(-1,-1);		
		
		// the bitmap data to display	
		private var graphics:GraphicsResource = null;
		
		// Background Offsets		
		public var xOffset:Number = 0;
		public var yOffset:Number = 0;
		
		// MaxOffsets
		public var xMaxOffset:Number = 0;
		public var yMaxOffset:Number = 0;

		// The background moving feature variables 	
		private var prevMousePoint: Point = null;
		private var wasMoving:Boolean = false;
		
		private var Pointer: GameObject = null;		
			
		// Constructor	
		public function TiledBackground(graphics:GraphicsResource)
		{
			super(ZOrders.BACKGROUNDZORDER);
			this.graphics = graphics;	
			xMaxOffset = this.graphics.drawRect.width - Application.application.width;
			yMaxOffset = this.graphics.drawRect.height - Application.application.height;					
			xOffset = xMaxOffset / 2;
			yOffset = yMaxOffset / 2;
			
			Pointer = new GameObject(this,ResourceManager.SunflowerGraphicID1,new Point(0,0),1);							
		}
		
		// Removes object
		override public function shutdown():void
		{
			Pointer.shutdown();
			super.shutdown();
		}
		
		// Frame ping
		override public function enterFrame(dt:Number):void
		{
			if (xOffset <= 0) 		   { xOffset = 0; }
			if (yOffset <= 0) 		   { yOffset = 0; }
			if (xOffset >= xMaxOffset) { xOffset = xMaxOffset; }			 
			if (yOffset >= yMaxOffset) { yOffset = yMaxOffset; }						
		}
		
		override public function mouseDown(event:MouseEvent):void
		{			
			prevMousePoint = new Point(event.localX, event.localY);
			wasMoving = false;
		}
		
		override public function mouseUp(event:MouseEvent):void
		{
			if (!wasMoving)
			{
				switch (GivesState.ID)
				{
					case 1:	new GameObject(this, ResourceManager.PotatoGraphicID5,Pointer.position,globalMatrixPosition.x+globalMatrixPosition.y);
					break;
					case 2: new GameObject(this, ResourceManager.CloverGraphicID5,Pointer.position,globalMatrixPosition.x+globalMatrixPosition.y);
					break;
					case 3: new GameObject(this, ResourceManager.SunflowerGraphicID5,Pointer.position,globalMatrixPosition.x+globalMatrixPosition.y);
					break;
				}
			} 
		}
		
		override public function mouseMove(event:MouseEvent):void
		{		
			if (event.buttonDown)
			{
				wasMoving =true; 
				var newXOffset: Number = event.localX - prevMousePoint.x;
				var newYOffset: Number = event.localY - prevMousePoint.y;
				
				xOffset += -newXOffset;
				yOffset += -newYOffset;
				
				prevMousePoint = new Point(event.localX, event.localY);
			}
			
			globalMatrixPosition = GetMatrixPosition(
										new Point(event.localX + xOffset,
										event.localY + yOffset))
			if (globalMatrixPosition.x != -1 && globalMatrixPosition.y != -1)
			{			
				Pointer.position = 	objectPositionFromMatrix(globalMatrixPosition);
			}											
		}
						
		// Draws Tiled background
		override public function copyToBackBuffer(db:BitmapData):void
		{		
			// Create visual bounds	
			var recVisBounds:Rectangle = new Rectangle(
					0+xOffset,
					0+yOffset,
					0+xOffset+Application.application.width,
					0+xOffset+Application.application.height);
								
			db.copyPixels(graphics.bitmap, recVisBounds, new Point(0,0), graphics.bitmapAlpha, new Point(0, 0), true);		
		}
		
		public function objectPositionFromMatrix(matrixPosition:Point): Point
		{
			var objectPosition: Point;
			if (matrixPosition.y % 2 == 0)
			{
				 objectPosition = new Point
							(matrixPosition.x * maxObjectWidth + objectsGlobalOffsetX,
							matrixPosition.y * maxObjectHeight/2 + objectsGlobalOffsetY);	
			}
			else
			{
				objectPosition = new Point
							(matrixPosition.x * maxObjectWidth + maxObjectWidth/2 + objectsGlobalOffsetX,
							matrixPosition.y *maxObjectHeight/2 + objectsGlobalOffsetY);				
			} 
			return objectPosition;
		}
		
		public function GetMatrixPosition(globalCoordinates: Point):Point
		{
			// As default = Undefined
			var _globalMatrixPosition:Point = new Point(-1,-1);
			
			// Min side of object
			var squareMinSide:Number = Math.min(maxObjectWidth,maxObjectHeight);
						
			// Min length of Mouse pointer and objects position
			var minLength: Number = Number.MAX_VALUE;
						
			for (var i:int = 0; i < 15; ++i){			
			for (var j:int = 0; j < 27; ++j){															
					var objectPosition:Point = objectPositionFromMatrix(new Point(i,j));
					var objectCenter:Point = new Point
							(objectPosition.x + maxObjectWidth / 2,
							objectPosition.y + maxObjectHeight / 2);
							
					var diffX:Number = objectCenter.x - globalCoordinates.x
					var diffY:Number = objectCenter.y - globalCoordinates.y
					
					var lengthMouseFromObjectCenter: Number = 
					Math.sqrt(diffX*diffX + diffY*diffY);
					
					minLength = Math.min(lengthMouseFromObjectCenter,minLength);
					
					if (lengthMouseFromObjectCenter <= squareMinSide/2)
					{														
						_globalMatrixPosition = new Point(i,j);
						return _globalMatrixPosition;
					}				
				}										
			}	
			return _globalMatrixPosition;
		}
	
	}
}