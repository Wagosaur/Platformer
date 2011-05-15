package
{
	import flash.events.ContextMenuEvent;
	import net.flashpunk.Engine
	import net.flashpunk.FP
	import Control.Menu
	
	[SWF(width = "640", height = "480")]
	
	/**
	 * ...
	 * @author Wago
	 * Based on Noel Barry's Advanced Platform Engine
	 * 
	 */
	
	public class Main extends Engine
	{
		public function Main():void
		{
			//init the game
			super(640, 480, 60, true);	
			//FP.screen.scale = 2;
		}
		
		override public function init():void 
		{
			FP.world = new Menu;
		}
	}
}