package Utils
{
	// Namespaces	
	import flash.display.*;
	import flash.geom.*;
	
	import mx.controls.Image;
		
	// Determines graphis resource for DisplatObject
	public class GraphicsResource
	{
		// BitMap data of DisplayObject
		public var bitmap:BitmapData = null;		
		// BitMap data of DisplayObject with Alpha properpty
		public var bitmapAlpha:BitmapData = null;		
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
		
		// Creates BitMapData using DisplayObject
		protected function createBitmapData(image:Loader):BitmapData
		{					
			var bitmap:BitmapData = new BitmapData(image.width, image.height);
			bitmap.draw(image);
			return bitmap;
		}
		
		// Creates BitMapData with Alpha property using DisplayObject
		protected function createAlphaBitmapData(image:Loader):BitmapData
		{
			var bitmap:BitmapData = new BitmapData(image.width, image.height);
			bitmap.draw(image, null, null, flash.display.BlendMode.ALPHA);
			return bitmap;
		}

	}
}