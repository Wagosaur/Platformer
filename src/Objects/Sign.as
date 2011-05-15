package Objects 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import Assets;
	import Control.Game;
	import Global;
	import net.flashpunk.FP
	/**
	 * ...
	 * @author Wago
	 * Based on Noel Barry's Advanced Platform Engine
	 * 
	 */
	public class Sign extends Entity
	{
		
		//public var text:Text = new Text("PICK UP THE SHOE FOR DOUBLEJUMP ABILITY!", -150, -100, 0, 0 );
		public var sprite:Image = new Image(Assets.OBJECT_SIGN, new Rectangle(0, 0, 32, 64));
		public var sprite_hover:Image = new Image(Assets.OBJECT_SIGN, new Rectangle(0, 0, 32, 64));
		
		public function Sign(x:int, y:int, text:String) 
		{
			super(x, y);	
			graphic = sprite;
			setHitbox(32, 32, 0, 0);
			text = text;
		}
		
		override public function update():void
		{
			//set the graphic to the default one
			graphic = sprite;
			
			//if we collide with the player...
			if (collideWith(Global.player, x, y)) {
				//Note the use of collideWith (above). This is faster than using collde("type")
				
				//set the sprite to the hover one
				
				//graphic = text;
				
			}
		}
	}
}