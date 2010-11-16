package Core
{
	import flash.display.*;
	import flash.geom.*;
	import mx.core.*;
	import Utils.*;
	
	public final class ResourceManager
	{
		// Backgrounds
		
		[Embed(source="../Media/Tiles/BG.jpg")]
		private static var BackGroundID1:Class;
		public static var BackGroundGraphicID1:GraphicsResource = new GraphicsResource(new BackGroundID1());
		
		//[Embed(source="../Media/Pointer/Pointer.png")]
		//private static var BackPointerID1:Class;
		//public static var BackPointerGraphicID1:GraphicsResource = new GraphicsResource(new BackPointerID1());
		
		
		// Potato			
		
		[Embed(source="../Media/Entities/potato/1.png")]
		private static var PotatoID1:Class;
		public static var PotatoGraphicID1:GraphicsResource = new GraphicsResource(new PotatoID1());
		
		[Embed(source="../Media/Entities/potato/2.png")]
		private static var PotatoID2:Class;
		public static var PotatoGraphicID2:GraphicsResource = new GraphicsResource(new PotatoID2());
		
		[Embed(source="../Media/Entities/potato/3.png")]
		private static var PotatoID3:Class;
		public static var PotatoGraphicID3:GraphicsResource = new GraphicsResource(new PotatoID3());
		
		[Embed(source="../Media/Entities/potato/4.png")]
		private static var PotatoID4:Class;
		public static var PotatoGraphicID4:GraphicsResource = new GraphicsResource(new PotatoID4());
		
		[Embed(source="../Media/Entities/potato/5.png")]
		private static var PotatoID5:Class;
		public static var PotatoGraphicID5:GraphicsResource = new GraphicsResource(new PotatoID5());
		
		// Clover
		
		
		[Embed(source="../Media/Entities/clover/1.png")]
		private static var CloverID1:Class;
		public static var CloverGraphicID1:GraphicsResource = new GraphicsResource(new CloverID1());
		
		[Embed(source="../Media/Entities/clover/2.png")]
		private static var CloverID2:Class;
		public static var CloverGraphicID2:GraphicsResource = new GraphicsResource(new CloverID2());
		
		[Embed(source="../Media/Entities/clover/3.png")]
		private static var CloverID3:Class;
		public static var CloverGraphicID3:GraphicsResource = new GraphicsResource(new CloverID3());
		
		[Embed(source="../Media/Entities/clover/4.png")]
		private static var CloverID4:Class;
		public static var CloverGraphicID4:GraphicsResource = new GraphicsResource(new CloverID4());
		
		[Embed(source="../Media/Entities/clover/5.png")]
		private static var CloverID5:Class;
		public static var CloverGraphicID5:GraphicsResource = new GraphicsResource(new CloverID5());
		
		// Sunflower
		
		[Embed(source="../Media/Entities/Sunflower/1.png")]
		private static var SunflowerID1:Class;
		public static var SunflowerGraphicID1:GraphicsResource = new GraphicsResource(new SunflowerID1());
		
		[Embed(source="../Media/Entities/Sunflower/2.png")]
		private static var SunflowerID2:Class;
		public static var SunflowerGraphicID2:GraphicsResource = new GraphicsResource(new SunflowerID2());
		
		[Embed(source="../Media/Entities/Sunflower/3.png")]
		private static var SunflowerID3:Class;
		public static var SunflowerGraphicID3:GraphicsResource = new GraphicsResource(new SunflowerID3());
		
		[Embed(source="../Media/Entities/Sunflower/4.png")]
		private static var SunflowerID4:Class;
		public static var SunflowerGraphicID4:GraphicsResource = new GraphicsResource(new SunflowerID4());
		
		[Embed(source="../Media/Entities/Sunflower/5.png")]
		private static var SunflowerID5:Class;
		public static var SunflowerGraphicID5:GraphicsResource = new GraphicsResource(new SunflowerID5());
	}
}