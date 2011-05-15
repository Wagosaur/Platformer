package Objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import Assets;
	/**
	 * ...
	 * @author Wago
	 * Based on Noel Barry's Advanced Platform Engine
	 * 
	 */
	public class Elevator extends Physics
	{
		public var sprite:Image = new Image(Assets.OBJECT_MOVING);
		
		public var direction:Boolean = FP.choose(true, false);
		public var movement:Number = 2;
		public var carry:Array = new Array("Solid", "Player");
		
		public function Elevator(x:int, y:int) 
		{
			//our x/y position
			super(x, y);
			
			//graphic & hitbox
			graphic = sprite;
			setHitbox(64, 32);
		}
		
		override public function update():void {
			
			//move in the correct direction
			speed.y = direction ? movement : - movement;
			
			//move stuff that's on top of us, for each type of entity we can carry
			for each(var i:String in carry) {
				elevate(i,speed.y);
			}
			
			//move
			motion();
			
			//if we've stopped moving, switch directions!
			if ( speed.y == 0 ) { direction = !direction; }
		}
		
	}

}