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
		public var _graphics:GraphicsResource = null;
		
		// World tile layer.
	    private var tiledBackground:TiledBackground = null;
	  
		
		public function GameObject(tiledBackground:TiledBackground,position:Point, zOrder:int = 0)
		{
			super(zOrder);
			inuse = false;
			this.tiledBackground = tiledBackground;	
			this.position = position.clone();									
		}
	
		// Removes object
		override public function shutdown():void
		{
			if (inuse)
			{				
				super.shutdown();
				_graphics = null;							
			}
		}
		
		public function set graphics(value:GraphicsResource):void
		{
			if (value != null)
			{
				inuse = true;
				this._graphics = value;
				InitializeComplited();
			}
		}
		
		public function get graphics():GraphicsResource
		{
			return this._graphics;
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
		
		public function InitializeComplited():void { }				
			
	}
}