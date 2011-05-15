package Objects 
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
	import net.flashpunk.Sfx;
	import Object;
	import Objects.Pickups.Doublejump;
	import Objects.Pickups.Shoot;
	import Objects.Pickups.Walljump;
	
	/**
	 * ...
	 * @author Wago
	 * Based on Noel Barry's Advanced Platform Engine
	 * 
	 */
	public class Player extends Physics
	{
		
		//sounds
		public static var snd_death:Sfx = new Sfx(Assets.SND_DEATH);
		public static var snd_jump:Sfx = new Sfx(Assets.SND_JUMP);
		public static var snd_jump2:Sfx = new Sfx(Assets.SND_JUMP2);
		public static var snd_shoot:Sfx = new Sfx(Assets.SND_SHOOT);
		public static var snd_powerup:Sfx = new Sfx(Assets.SND_POWERUP);
		
		public var sprite:Spritemap = new Spritemap(Assets.PLAYER, 32, 32, animEnd);
		
		//how fast we accelerate
		public var movement:Number = 1;
		public var jump:Number = 8;
		
		//current player direction (true = right, false = left)
		public var direction:Boolean = true;
		
		//are we on the ground?
		public var onground:Boolean = false;
		
		//are we walljumping? (0 = no, 1 = left, 2 = right)
		public var walljumping:int = 0;
		//can we double jump? (false = no, true = yes)
		public var doublejump:Boolean = false;
		
		public var dead:Boolean = false;
		public var start:Point;
		
		//timer for shoot
		private var rate_of_fire:Number = 0.5;
		private var rof_timer:Number = 0;
			
		public function Player(x:int, y:int) 
		{
			//set position
			super(x, y);
			start = new Point(x, y);
			
			//set different speeds and such
			mGravity = 0.4;
			mMaxspeed = new Point(4, 8);
			mFriction = new Point(0.5, 0.5);
			
			//set up animations
			sprite.add("standLeft", [0], 0, false);
			sprite.add("standRight", [8], 0, false);
			sprite.add("walkLeft", [0, 1, 2, 3, 4, 5, 6, 7], 0.2, true);
			sprite.add("walkRight", [8, 9, 10, 11, 12, 13, 14, 15], 0.2, true);
			
			sprite.add("jumpLeft", [2], 0, false);
			sprite.add("jumpRight", [10], 0, false);
			
			sprite.add("slideRight", [16], 0, false);
			sprite.add("slideLeft", [17], 0, false);
			
			sprite.play("standRight");
			
			//set hitbox & graphic
			setHitbox(12, 24, -10, -8);
			graphic = sprite;
			type = "Player";
		}
		
		override public function update():void 
		{
			//did we... die?
			if (dead) 
			{ 
				sprite.alpha -= 0.1; 
				return; 
			} 
			else if ( sprite.alpha < 1 ) 
			{ 
				sprite.alpha += 0.1 
			}
			//Did we get a powerup?
			var j:Doublejump = collide("pickup", x, y) as Doublejump;
			var s:Shoot = collide("pickup", x, y) as Shoot;
			var w:Walljump = collide("pickup", x, y) as Walljump

			if (j){ j.destroy();
				Global.DoublejumpGot = true;
				snd_powerup.play();
			}
			
			if (s){ s.destroy();
				Global.ShootGot = true;
				snd_powerup.play();
			}
			
			if (w){ w.destroy();
				Global.WalljumpGot = true;
				snd_powerup.play();
			}

			
			if (collide("enemy", x, y))
			{
				killme();
			}
			
			//are we on the ground?
			onground = false;
			if (collide(solid, x, y + 1)) 
			{ 
				onground = true;
				walljumping = 0;
				doublejump = true;
			}
			
			//set acceleration to nothing
			acceleration.x = 0;
			
			//increase acceeration, if we're not going too fast
			if (Input.check(Global.keyLeft) && speed.x > -mMaxspeed.x) { acceleration.x = - movement; direction = false; }
			if (Input.check(Global.keyRight) && speed.x < mMaxspeed.x) { acceleration.x = movement; direction = true; }
			
			//friction (apply if we're not moving, or if our speed.x is larger than maxspeed)
			if ( (! Input.check(Global.keyLeft) && ! Input.check(Global.keyRight)) || Math.abs(speed.x) > mMaxspeed.x ) { friction(true, false); }
			
			//jump
			if ( Input.pressed(Global.keyA) ) 
			{
				var jumped:Boolean = false;
				
				if (!onground)
				{
					if (doublejump && Global.DoublejumpGot)
					{
						snd_jump2.play();
					}
				}
				if (onground)
				{
					snd_jump.play();
				}
				//normal jump
				if (onground) { 
					speed.y = -jump; 
					jumped = true; 
				}
				
				//wall jump
				if (Global.WalljumpGot)
				{
					if (collide(solid, x - 1, y) && !jumped && walljumping != 3) 
					{ 
						speed.y = -jump;			//jump up
						speed.x = mMaxspeed.x * 2;	//move right fast
						walljumping = 2;			//and set wall jump direction
						jumped = true;				//so we don't "use up" or double jump
						snd_jump2.play();
					}
					//same as above
					if (collide(solid, x + 1, y) && !jumped && walljumping != 3) 
					{ 
						speed.y = -jump; 
						speed.x = - mMaxspeed.x * 2;
						walljumping = 1;
						jumped = true;
						snd_jump2.play();
					}
				}
				
				//set double jump to false
				if (Global.DoublejumpGot)
				{
				if (!onground && !jumped && doublejump) 
					{
							speed.y = -jump;
							doublejump = false;
							//set walljumping to 0 so we can move back in any direction again
							//incase we were wall jumping prior to this double jump.
							//if you don't want to allow walljumping after a double jump, set this to 3.
							walljumping = 0;
					} 
				}
			}
			//shoot
			// Added a timer on shoots
			rof_timer -= FP.elapsed;
			
			if (Global.ShootGot)
			{
				
				if (Input.pressed(Global.keyB))
				{
					if (rof_timer < 0)
					{
						snd_shoot.play();
						rof_timer = rate_of_fire;
						var bullet:Bullet = new Bullet(x, y+15);
						if (speed.x > 0 || direction)
						{
							bullet.x += 36;
						}
						if (speed.x < 0 || !direction)
						{
							bullet.x -= 8;
							bullet.movement = -8;
						}
						FP.world.add(bullet);
					}
				}
			
			}
			
			//REMOVED AS OF V0.90 - Felt bad with this in here
			//if we ARE walljumping, make sure we can't go back
			/*if (walljumping > 0)
			{
				if (walljumping == 2 && speed.x < 0) { speed.x = 0; }
				if (walljumping == 1 && speed.x > 0) { speed.x = 0; }
			}*/
			
			//set the gravity
			gravity();
			
			//make sure we're not going too fast vertically
			//the reason we don't stop the player from moving too fast left/right is because
			//that would (partially) destroy the walljumping. Instead, we just make sure the player,
			//using the arrow keys, can't go faster than the max speed, and if we are going faster
			//than the max speed, descrease it with friction slowly.
			maxspeed(false, true);
			
			//variable jumping (tripple gravity)
			if (speed.y < 0 && !Input.check(Global.keyA)) { gravity(); gravity(); }
			
			
			//set the sprites according to if we're on the ground, and if we are moving or not
			if (onground)
			{
				if (speed.x < 0) { sprite.play("walkLeft"); }
				if (speed.x > 0) { sprite.play("walkRight"); }
				
				if (speed.x == 0) 
				{
					if (direction) { sprite.play("standRight"); } else { sprite.play("standLeft"); }
				}
			} 
			else
			{
				if (direction) { sprite.play("jumpRight"); } else { sprite.play("jumpLeft"); }
				
				//are we sliding on a wall?
				if (collide(solid, x - 1, y)) { sprite.play("slideRight"); }
				if (collide(solid, x + 1, y)) { sprite.play("slideLeft"); }
			}
			
			
			//set the motion. We set this later so it stops all movement if we should be stopped
			motion();
			
			//did we just get.. KILLED? D:
			if (collide("Spikes", x, y))
			{
				snd_death.play();
				//killme!
				killme();
			}
			
		}
		
		public function killme():void
		{
			dead = true;
			Global.restart = true;
		}
		
		public function animEnd():void 
		{ 
			
		}
		
	}

}