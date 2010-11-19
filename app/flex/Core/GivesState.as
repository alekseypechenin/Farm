package Core
{
	public final class GivesState
	{	
		//
		public static const None:int=0;
		//	
		public static const Potato:int=1;
		//
		public static const Clover:int=2;
		//
		public static const Sunflower:int=3;
		//
		private static var _state:int = CommandState.None;
		
		//
		public static function set State(value:int):void
		{
			switch (value)
			{
				case None:
					_state = None;
				break;
				case Potato: 
					_state = Potato;
				break;
				case Clover:
					_state = Clover;
				break;
				case Sunflower:
					_state = Sunflower;
				break;				
				default:
					throw new Error( "Argument out of range." );
			}
		}
		
		//
		public static function get State():int
		{
			return _state;
		}
		
		//
		public static function stateToString():String
		{
			switch (_state)
			{
				case Potato:
					return "potato";
				break;
				case Clover:
					return "clover";
				break;
				case Sunflower:
					return "sunflower";
				break;
				default:
					throw new Error( "Argument is out of range or no determine ." );
			} 	
		}		
	}
}