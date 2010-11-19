package Entities
{
	// Namespaces
	import Core.*;
	
	import Utils.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	import mx.collections.*;
	import mx.controls.Alert;
	import mx.core.*;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
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
		
		// Request manager. Allows to call HTTP request
		private var requestManager:RequestManager = null;
		
		// Background Offsets		
		public var xOffset:Number = 0;
		public var yOffset:Number = 0;
		
		// MaxOffsets
		public var xMaxOffset:Number = 0;
		public var yMaxOffset:Number = 0;
		
		// Resource pool of Fields object
		public var fieldsObjects:ArrayCollection = new ArrayCollection();
		
		// The background moving feature variables 	
		private var prevMousePoint: Point = null;
		private var wasMoving:Boolean = false;
		
		// Mouse Pointer 
		private var mousePointer: GameObject = null;
						
		// Constructor	
		public function TiledBackground(graphics:GraphicsResource)
		{
			super(ZOrders.BACKGROUNDZORDER);
			this.graphics = graphics;	
			xMaxOffset = this.graphics.drawRect.width - Application.application.width;
			yMaxOffset = this.graphics.drawRect.height - Application.application.height;					
			xOffset = xMaxOffset / 2;
			yOffset = yMaxOffset / 2;
			
			mousePointer = new GameObject(this,ResourceManager.SunflowerGraphicID1,new Point(0,0),1);
			mousePointer.hidden = true;	
						
			requestManager = new RequestManager(resultHandler,faultHandler);		
			requestManager.requestQuery(RequestManager.RETURNSALLGIVES);		
			requestManager.requestSend();		
		}
		
		// RequestManager Fault event handler 
		private function faultHandler(event:FaultEvent):void
		{
			Alert.show(event.fault.faultString, event.fault.faultCode);
		}	
		
		// RequestManager Result event handler 				
		private function resultHandler(event:ResultEvent):void
		{
			var fieldsAsXML:XML = event.result as XML;
								
			var fields:XMLList = fieldsAsXML..field;
			
			if (fields.length() == 0) 
			{
				updateFieldObjects(new XMLList(fieldsAsXML));
			}
			else
			{
				updateFieldObjects(fields);
			}
		}
		
		// Update fields in accordance with new XML data
		public function updateFieldObjects(fieldsData: XMLList):void
		{		
			var field:FieldObject;
			var fieldData:XML;
			
			for each (fieldData in fieldsData) 
			{
				var fieldPosition:Point = new Point(Number(fieldData.x),Number(fieldData.y))
				
				// Debug information
				trace(fieldData.x,fieldData.y,fieldData.ftype,fieldData.fstate);
				
				field = getFieldObjects(new Point(fieldData.x,fieldData.y));
				var resource:GraphicsResource = null;
				
				if ((field == null) || (field != null && field.state != fieldData.fstate))
				{
					resource = ResourceManager.getResourceFromPool
							(String(fieldData.ftype),Number(fieldData.fstate));
				}
						
				if (resource != null) 
				{
					if (field == null)
					{
						field = new FieldObject(
								this,
								resource,
								fieldPosition,
								getZOrder(fieldPosition),
								fieldData.ftype,
								fieldData.fstate)
						fieldsObjects.addItem(field)
					}
					else
					{
						field.state = fieldData.fstate;
						field.graphics = resource;
					}
				}
			}
		}
		
		// Get field object in accordance with matrixPosition
		public function getFieldObjects(matrixPosition: Point): FieldObject
		{
			var fieldObject:FieldObject;
			for each (fieldObject in fieldsObjects)
			{
				if (fieldObject.position.x == matrixPosition.x
					&& fieldObject.position.y == matrixPosition.y)
				{
					return fieldObject;
				}
			} 
			return null;
		}
		
		// Add field
		public function addFieldObject():void
		{
			if (getFieldObjects(mousePointer.position) == null)
			{
				var givesType:String = GivesState.stateToString();
					
				requestManager.requestQuery(
						RequestManager.ADDGIVE,
						{ftype: givesType, x: mousePointer.position.x,y: mousePointer.position.y});		
				requestManager.requestSend();
			}
			else
			{
				Alert.show("Вы не можете сажать на этом участке поля.");
			}
		}
		
		// Grows fields
		public function growFieldObject():void
		{
			var needGrow:Boolean = false
			var fieldObject:FieldObject;
			for each (fieldObject in fieldsObjects)
			{
				if (fieldObject.state < FieldObject.maxState)
				{
					needGrow = true;
					break;
				}
			} 
			if (needGrow)
			{
				requestManager.requestQuery(RequestManager.GROWGIVES);			
				requestManager.requestSend();
			}
			else
			{
				Alert.show("Нечему расти..");
			}
		}
		
		// Get field object screen position
		public function getObjectScreenPosition(matrixPosition: Point): Point
		{
			var worldPosition:Point = getObjectWolrdPosition(matrixPosition)
			
			return new Point( 
				worldPosition.x - xOffset,
				worldPosition.y - yOffset)
		}
		
		// Get game object world position in accordance with matrix position
		public function getObjectWolrdPosition(matrixPosition:Point): Point
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
			return new Point(objectPosition.x ,objectPosition.y);
		}
		
		// Get matrix position of mouse pointer in accordance with world mouse pointer
		public function getMatrixPosition(worldPosition: Point):Point
		{
			// As default = Undefined
			var _globalMatrixPosition:Point = new Point(-1,-1);
			
			// Min side of object
			var squareMinSide:Number = Math.min(maxObjectWidth,maxObjectHeight);
						
			// Min length of Mouse pointer and objects position
			var minLength: Number = Number.MAX_VALUE;
						
			for (var i:int = 0; i < 15; ++i){			
			for (var j:int = 0; j < 27; ++j){															
					var objectPosition:Point = getObjectWolrdPosition(new Point(i,j));
					var objectCenter:Point = new Point
							(objectPosition.x + maxObjectWidth / 2,
							objectPosition.y + maxObjectHeight / 2);
							
					var diffX:Number = objectCenter.x - worldPosition.x
					var diffY:Number = objectCenter.y - worldPosition.y
					
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
		
		// Get object Z order 
		public function getZOrder(matrixPosition:Point):int
		{
			return matrixPosition.x + matrixPosition.y * maxMatrixX;
		}
		
		// Removes object
		override public function shutdown():void
		{
			mousePointer.shutdown();
			super.shutdown();
		}
		
		// Frame ping
		override public function enterFrame(dt:Number):void
		{
			if (xOffset <= 0) 		   { xOffset = 0; }
			if (yOffset <= 0) 		   { yOffset = 0; }
			if (xOffset >= xMaxOffset) { xOffset = xMaxOffset; }			 
			if (yOffset >= yMaxOffset) { yOffset = yMaxOffset; }
			
			switch (CommandState.State)
			{				
				case CommandState.None:
					mousePointer.hidden = false;
					break;
				case CommandState.Give:
					mousePointer.hidden = true;
					
					break;			
				case CommandState.Grow:
					growFieldObject();		
					CommandState.State = CommandState.None;
					break;
				case CommandState.Take:		
					CommandState.State = CommandState.None;
					break;
			}
			
		}
		
		// MouseDown event handler 
		override public function mouseDown(event:MouseEvent):void
		{			
			prevMousePoint = new Point(event.localX, event.localY);
			wasMoving = false;
		}
		
		// MouseUp event handler 
		override public function mouseUp(event:MouseEvent):void
		{
			if (!wasMoving)
			{
				if (GivesState.State != GivesState.None && !mousePointer.hidden)
				{
					addFieldObject();
				}
			} 
		}
		
		// MouseMove event handler
		override public function mouseMove(event:MouseEvent):void
		{		
			if (!mousePointer.hidden)
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
				
				globalMatrixPosition = getMatrixPosition(
											new Point(event.localX + xOffset,
											event.localY + yOffset))
											
				if (globalMatrixPosition.x != -1 && globalMatrixPosition.y != -1)
				{			
					mousePointer.position = 	globalMatrixPosition;
					mousePointer.hidden = false;
				}
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

	}
}