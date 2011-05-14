package Objects 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP
	/**
	 * ...
	 * @author Wago
	 */
	public class Shoot extends Entity
	{
		
		public var sprite:Image = new Image(Assets.OBJECT_SHOOT);
		
		public function Shoot(x:int, y:int) 
		{
			super(x, y);
			
			graphic = sprite;
			setHitbox(32, 32, 0, 0);
		}
		
		override public function update():void
		{
			//set the graphic to the default one
			graphic = sprite;
			
			//set type
			type = "pickup";
			
		}
		
		public function destroy():void
		{
			// Here we could place specific destroy-behavior for the Bullet.
			FP.world.remove(this);
			Global.ShootGot = true;
		}
		
	}

}