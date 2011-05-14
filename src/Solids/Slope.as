package Solids 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.masks.Pixelmask;
	import Assets;
	/**
	 * ...
	 * @author Wago
	 * Based on Noel Barry's Advanced Platform Engine
	 * 
	 */
	public class Slope extends Solid
	{
		
		public var slopeMask:Pixelmask
		
		public function Slope(x:int, y:int, type:int) 
		{
			super(x, y, 0, 0);
			
			var slope:Class;
			switch(type) {
				case 0: slope = Assets.SLOPE1; break;
				case 1: slope = Assets.SLOPE2; break;
				case 2: slope = Assets.SLOPE3; break;
				case 3: slope = Assets.SLOPE4; break;
			}
			
			slopeMask = new Pixelmask(slope, 0, 0);
			mask = slopeMask;
			
			//hide us - we don't need to ever be updated
			active = false;
			visible = false;
		}
		
	}

}