package Entities
{
	import Utils.*;
	
	import flash.geom.Point;
	
	// Represents object that determines Field(Gives) game object (potato, clover and e.t.c)
	public class FieldObject extends GameObject
	{
		public static const maxState:int = 5;
		
		// Uniq number
	    public var id:Number;
	    
	    // Gives type
	    public var type:String;
	    
	    // Gives state 
	    public var state:Number;
	     
	    // Constructor
	    public function FieldObject(tiledBackground:TiledBackground,
	    						    graphics:GraphicsResource,
	    						    position:Point,	    					
	    						    zOrder:int,
	    						    type:String,
	    						    state:int)
		{
			super(tiledBackground,graphics,position,zOrder);	
			this.state = state;											
			this.type = type;
		}		  
	}
}