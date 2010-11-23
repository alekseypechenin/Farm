package Core
{
	import Utils.*;
	
	import flash.display.*;
	import flash.geom.*;
	
	import mx.core.*;
	
	public final class ResourceManager
	{
		// BackGround
		
		public static var BackGroundID1:String = "Media/Tiles/BG.jpg";
		public static var MousePointerID1:String = "Media/Tiles/MousePointer.png";
		
		// Potato			
		
		public static var PotatoID1:String = "Media/Entities/potato/1.png";
		public static var PotatoID2:String = "Media/Entities/potato/2.png";
		public static var PotatoID3:String = "Media/Entities/potato/3.png";
		public static var PotatoID4:String = "Media/Entities/potato/4.png";
		public static var PotatoID5:String = "Media/Entities/potato/5.png";
		
		// Clover
		
		public static var CloverID1:String = "Media/Entities/clover/1.png";
		public static var CloverID2:String = "Media/Entities/clover/2.png";
		public static var CloverID3:String = "Media/Entities/clover/3.png";
		public static var CloverID4:String = "Media/Entities/clover/4.png";
		public static var CloverID5:String = "Media/Entities/clover/5.png";
		
		// Sunflower
		
		public static var SunflowerID1:String = "Media/Entities/Sunflower/1.png";
		public static var SunflowerID2:String = "Media/Entities/Sunflower/2.png";
		public static var SunflowerID3:String = "Media/Entities/Sunflower/3.png";
		public static var SunflowerID4:String = "Media/Entities/Sunflower/4.png";
		public static var SunflowerID5:String = "Media/Entities/Sunflower/5.png";
	
		public static function getResourceFromPool(resType:String, resState: int):String
		{
			var resource:String = null;
			switch (resType)
			{
				case "potato":
					switch (resState)
					{
						case 1:
							resource = PotatoID1;
						break;
						case 2:
							resource = PotatoID2;							
						break;
						case 3:
							resource = PotatoID3;
						break;
						case 4:
							resource = PotatoID4;
						break;
						case 5:
							resource = PotatoID5;
						break;
					}
				break;
				case "clover":
					switch (resState)
					{
						case 1:
							resource = CloverID1;
						break;
						case 2:
							resource = CloverID2;							
						break;
						case 3:
							resource = CloverID3;
						break;
						case 4:
							resource = CloverID4;
						break;
						case 5:
							resource = CloverID5;
						break;
					}
				break;
				case "sunflower":				
					switch (resState)
					{
						case 1:
							resource = SunflowerID1;
						break;
						case 2:
							resource = SunflowerID2;							
						break;
						case 3:
							resource = SunflowerID3;
						break;
						case 4:
							resource = SunflowerID4;
						break;
						case 5:
							resource = SunflowerID5;
						break;
					}
				break;
			}
						
			return resource;
		}	
	}	
}