package Entities
{
	// Namespaces
	import Utils.*;	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;	
	import mx.collections.*;
	import mx.core.*;
	
	// Crates main landshaft
	public class TiledBackground extends BaseObject
	{
		// the bitmap data to display	
		private var graphics:GraphicsResource = null;
		
		// Offsets		
		private var xOffset:Number = 0;
		private var yOffset:Number = 0;
		
		// MaxOffsets
		private var xMaxOffset:Number = 0;
		private var yMaxOffset:Number = 0;

		// The background moving feature variables 
		private var mouseDownKey:Boolean = false;
		private var prevMousePoint: Point = null;		
			
		// Constructor	
		public function TiledBackground(graphics:GraphicsResource)
		{
			super(ZOrders.BACKGROUNDZORDER);
			this.graphics = graphics;	
			xMaxOffset = this.graphics.drawRect.width - Application.application.width;
			yMaxOffset = this.graphics.drawRect.height - Application.application.height;					
			xOffset = xMaxOffset / 2;
			yOffset = yMaxOffset / 2;
		}
		
		// Removes object
		override public function shutdown():void
		{
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
			mouseDownKey = true;
			prevMousePoint = new Point(event.localX, event.localY);
		}
		
		override public function mouseUp(event:MouseEvent):void
		{
			mouseDownKey = false;
		}
		
		override public function mouseMove(event:MouseEvent):void
		{
			if (mouseDownKey)
			{ 
				var newXOffset: Number = event.localX - prevMousePoint.x;
				var newYOffset: Number = event.localY - prevMousePoint.y;
				
				xOffset += -newXOffset;
				yOffset += -newYOffset;
				
				prevMousePoint = new Point(event.localX, event.localY);
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