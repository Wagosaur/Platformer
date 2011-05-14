package Objects 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
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
	public class Door extends Entity
	{
		
		
		public var sprite:Image = new Image(Assets.OBJECT_DOOR, new Rectangle(0, 0, 32, 64));
		public var sprite_hover:Image = new Image(Assets.OBJECT_DOOR, new Rectangle(32, 0, 32, 64));
		
		public function Door(x:int, y:int) 
		{
			super(x, y-32);
			
			graphic = sprite;
			setHitbox(32, 32, 0, -32);
		}
		
		override public function update():void
		{
			//set the graphic to the default one
			graphic = sprite;
			
			//if we collide with the player...
			if (collideWith(Global.player, x, y)) {
				//Note the use of collideWith (above). This is faster than using collde("type")
				
				//set the sprite to the hover one
				graphic = sprite_hover;
				
				//if down is pressed, finish level
				if (Input.pressed(Global.keyDown))
				{
					Global.finished = true;
				}
			}
		}
		
	}

}