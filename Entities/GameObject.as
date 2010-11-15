package Entities
{
	// Namespaces
	import flash.display.*;
	import flash.geom.*;
	import Utils;
	
	/*
		The base class for all objects in the game.
	*/
	public class GameObject extends BaseObject
	{
		// object position
		public var position:Point = new Point(0, 0);
		// the bitmap data to display	
		public var graphics:GraphicsResource = null;
		
		public function GameObject(graphics:GraphicsResource, position:Point, zOrder:int = 0)
		{
			super(zOrder);				
			this.graphics = graphics;
			this.position = position.clone();									
		}
	
		// Removes object
		override public function shutdown():void
		{
			if (inuse)
			{				
				super.shutdown();
				graphics = null;							
			}
		}
		
		// Draws object
		override public function copyToBackBuffer(db:BitmapData):void
		{
			db.copyPixels(graphics.bitmap, graphics.bitmap.rect, position, graphics.bitmapAlpha, new Point(0, 0), true);
		}				
			
	}
}