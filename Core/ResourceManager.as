package Core
{
	import flash.display.*;
	import flash.geom.*;
	import mx.core.*;
	import Utils.*;
	
	public final class ResourceManager
	{
		[Embed(source="../Media/Tiles/BG.jpg")]
		public static var BackGroundID1:Class;
		public static var BackGroundGraphicID1:GraphicsResource = new GraphicsResource(new BackGroundID1());			
	}
}