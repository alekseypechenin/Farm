package Entities
{
	// Namespaces
	import flash.events.*;
	import flash.display.*;	
	import Core.*;
	
	// Base object of all objects in the game
	public class BaseObject
	{
		// Determines if object was deleted 
		public var inuse:Boolean = false;		
		// Object Z Order
		public var zOrder:int = 0;
				
		// Constructor
		public function BaseObject(zOrder:int)
		{
			this.inuse = true;
			this.zOrder = zOrder;
			GameObjectManager.Instance.addBaseObject(this);			
		}
		
		// Removes object	
		public function shutdown():void
		{
			if (this.inuse)
			{
				this.inuse = false;
				GameObjectManager.Instance.removeBaseObject(this);
			}
		}
		
		// Ovveride this methods if yuo want implement functionality fo them
		
		public function enterFrame(dt:Number):void {}		
		public function click(event:MouseEvent):void { }	
		public function mouseDown(event:MouseEvent):void { }		
		public function mouseUp(event:MouseEvent):void { }		
		public function mouseMove(event:MouseEvent):void { }
		public function collision(other:BaseObject):void { }
		public function copyToBackBuffer(db:BitmapData):void { }
	}
}