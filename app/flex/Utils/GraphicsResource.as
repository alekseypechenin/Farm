package Utils
{
	// Namespaces	
	import flash.display.*;
	import flash.geom.*;
	
	import mx.controls.Image;
		
	// Determines graphis resource for DisplatObject
	public class GraphicsResource
	{
		// BitMap data of Loader
		public var bitmap:BitmapData = null;		
		// BitMap data of Loader with Alpha properpty
		public var bitmapAlpha:BitmapData = null;		
		// Bounds of Image
		public var draggingBitmapAlpha:BitmapData = null;		
		// Bounds of Image
		private var _drawRect:Rectangle = null;		
		// Get Rectangle of Graphics bounds
		public function get drawRect():Rectangle
		{
			return _drawRect;
		} 
		
		// Constructor
		public function GraphicsResource(loader:Loader, drawRect:Rectangle = null)
		{
			bitmap = createBitmapData(loader);
			bitmapAlpha = createAlphaBitmapData(loader);
			draggingBitmapAlpha = createDraggingAlphaBitmapData(loader);											
			if (drawRect == null)
				this._drawRect = bitmap.rect;
			else
				{
					this._drawRect = drawRect;
					
				}					
		}
		
		// Scales image
		protected function ScaleBitmap(bitmapData: BitmapData, newWidth:int, newHeight:int):BitmapData
		{
			var scaleImage:Image = new Image();
			scaleImage.load(new Bitmap(bitmapData, "auto", true));
						
			scaleImage.content.width = newWidth;
			scaleImage.content.height = newHeight;
			
			var bitmap:BitmapData = new BitmapData(newWidth, newHeight);
			bitmap.draw(scaleImage);
			return bitmap;
		}
		
		// Creates BitMapData using Loader
		protected function createBitmapData(image:Loader):BitmapData
		{					
			var bitmap:BitmapData = new BitmapData(image.width, image.height);
			bitmap.draw(image);
			return bitmap;
		}
		
		// Creates BitMapData with Alpha property using Loader
		protected function createAlphaBitmapData(image:Loader):BitmapData
		{
			var bitmap:BitmapData = new BitmapData(image.width, image.height);
			bitmap.draw(image, null, null, flash.display.BlendMode.ALPHA);
			return bitmap;
		}
		
		// Creates BitMapData with Alpha property using Loader
		protected function createDraggingAlphaBitmapData(image:Loader):BitmapData
		{
			var bitmap:BitmapData = new BitmapData(image.width, image.height,true,0x80ffffff);
			bitmap.draw(image, null, null, flash.display.BlendMode.ALPHA);
			return bitmap;
		}

	}
}