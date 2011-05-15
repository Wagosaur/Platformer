package Objects.Enemies 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	import net.flashpunk.FP
	import Assets;
	import Object;
	import Objects.Physics;
	/**
	 * ...
	 * @author Wago
	 * Based on Noel Barry's Advanced Platform Engine
	 * 
	 */
	public class Steve extends Physics
	{
		public var sprite:Image = new Image(Assets.OBJECT_STEVE);
		
		public var direction:Boolean = FP.choose(true, false);
		public var movement:Number = 2;
		
		public function Steve(x:int, y:int) 
		{
			//set position      
			super(x, y);
			
			//set graphic and mask
			graphic = sprite;
			mask = new Pixelmask(Assets.OBJECT_STEVE);
			
			//set type
			type = "enemy";
		}
		override public function update():void {
			
			//move in the correct direction
			speed.x = direction ? movement : - movement;
			
			//move ourselves
			motion();
			
			gravity();
			
			//if we've stopped moving, switch directions!
			if ( speed.x == 0 ) { direction = !direction; }
			
			if (collide("Bullet", x, y)) 
			{
				FP.world.remove(this);
			}
		}

		//public function destroy():void
		//{
			// Here we could place specific destroy-behavior for the Bullet.
			//FP.world.remove(this);
		//}
		
	}

}