package Objects.Pickups 
{
	import flash.geom.Rectangle;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import Assets;
	import Control.Game;
	import Global;
	/**
	 * ...
	 * @author Wago
	 * Based on Noel Barry's Advanced Platform Engine
	 * 
	 */
	public class Walljump extends Entity
	{
		public var sprite:Image = new Image(Assets.OBJECT_WALLJUMP);
		
		public function Walljump(x:int, y:int) 
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
			
			//if we collide with the player...
		}
		
		public function destroy():void
		{
			// Here we could place specific destroy-behavior for the Bullet.
			FP.world.remove(this);
			Global.WalljumpGot = true;
		}
	}
}