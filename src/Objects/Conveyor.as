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
	public class Conveyor extends Physics
	{
		public var sprite:Image = new Image(Assets.PLATFORM_CONVEYOR);
		
		private var cSpeed:Number
		
		public var direction:Boolean = FP.choose(true, false);
		public var movement:Number = 2;
		public var carry:Array = new Array("Solid", "Player");
		
		public function Conveyor(x:int, y:int, cSpeed:Number) 
		{
			//our x/y position
			super(x, y);
			graphic = sprite;
			setHitbox(64, 32);
			this.cSpeed = new Number(cSpeed);
			
		}
		public function conveyor(type:String,speed:Number):void
		{
			var e:Entity = collide(type, x, y - 1) as Entity;
			if (e) {
				motionx(e, cSpeed);
				
				var p:Physics = e as Physics;
				if(p != null) { p.moveontop("Player", speed); }
			}
		}
		
		override public function update():void {
			
			//move in the correct direction
			speed.y = direction ? movement : - movement;
			
			for each (var i:String in carry) {
				conveyor(i, speed.y);
			}
			
			if ( speed.y == 0 ) { direction = !direction; }
		}
		
	}

}