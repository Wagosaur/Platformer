package Objects.Enemies 
{
	import flash.geom.Point
	import net.flashpunk.Entity
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import Assets;
	import Global;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import Object;
	import Objects.Physics;
	
	/**
	 * ...
	 * @author Wago
	 * Based on Noel Barry's Advanced Platform Engine
	 * 
	 */
	public class Bob extends Physics
	{
		public var sprite:Spritemap = new Spritemap(Assets.OBJECT_BOB, 32, 32, animEnd);
		
		public var direction:Boolean = FP.choose(true, false);
		public var movement:Number = 4;
		
		
		public function Bob(x:int, y:int) 
		{
			//set position      
			super(x, y);
			
			//set graphic and mask
			graphic = sprite;
			setHitbox(32, 32, 0, 0);
			
			//set animation
			//set up animations
			sprite.add("standLeft", [0], 0, false);
			sprite.add("standRight", [8], 0, false);
			sprite.add("walkLeft", [0, 1, 2, 3, 4, 5, 6, 7], 0.2, true);
			sprite.add("walkRight", [8, 9, 10, 11, 12, 13, 14, 15], 0.2, true);
			sprite.play("standRight");
			
			//set type
			type = "enemy";
		}
		override public function update():void {
			
			//move in the correct direction
			speed.x = direction ? movement : - movement;
			
			//set up animations
			if (speed.x < 0) { sprite.play("walkLeft"); }
			if (speed.x > 0) { sprite.play("walkRight"); }
			
			if (speed.x == 0) 
			{
				if (direction) { sprite.play("standRight"); } else { sprite.play("standLeft"); }
			}
			
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
		
		public function animEnd():void 
		{ 
			
		}

		//public function destroy():void
		//{
			// Here we could place specific destroy-behavior for the Bullet.
			//FP.world.remove(this);
		//}
		
	}

}