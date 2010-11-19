package Entities
{
	// Namespaces
	import Utils.*;
	
	import flash.display.*;
	import flash.geom.*;
	/*
		The base class for all objects in the game.
	*/
	public class GameObject extends BaseObject
	{
		// object position
		public var position:Point = new Point(0, 0);
		// the bitmap data to display	
		public var graphics:GraphicsResource = null;
		
		private var tiledBackground:TiledBackground = null;
		
		public function GameObject(tiledBackground:TiledBackground, graphics:GraphicsResource, position:Point, zOrder:int = 0)
		{
			super(zOrder);	
			this.tiledBackground = tiledBackground;			
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
			var screenPos:Point = tiledBackground.getObjectScreenPosition(new Point(position.x,position.y));			
			var screenPosInAccordanceWithHeigh: Point = new Point(
				 screenPos.x ,
				 screenPos.y - (this.graphics.drawRect.height - tiledBackground.maxObjectHeight));
			
			db.copyPixels(graphics.bitmap, graphics.bitmap.rect, screenPosInAccordanceWithHeigh, graphics.bitmapAlpha, new Point(0, 0), true);
		}				
			
	}
}