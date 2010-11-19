package Core
{
	//
	public final class CommandState
	{	
		//	
		public static const None:int=0;
		//	
		public static const Take:int=1;
		//
		public static const Give:int=2;
		//
		public static const Grow:int=3;
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
				case Take: 
					_state = Take;
				break;
				case Give:
					_state = Give;
				break;
				case Grow:
					_state = Grow;
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
	}
}