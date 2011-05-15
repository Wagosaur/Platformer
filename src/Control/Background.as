package Control 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	
	/**
	 * @author Wago
	 */
	public class Background extends Entity
	{
		public function Background() 
		{
			// set the background graphic and parallax rates.
			graphic = new Backdrop(Assets.BACKGROUND);
			graphic.scrollX = .5;
			//graphic.scrollY = .5;
			
			// put it on layer 100, so it appears behind other entities.
			layer = 100;
		}
		
		/**  
		 * Updates the background, makes it scroll.
		 */
		override public function update():void 
		{
			x -= FP.elapsed * 20;
			//y -= FP.elapsed * 10;
		}
	}
}