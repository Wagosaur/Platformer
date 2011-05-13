package  
{
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Key;
	import Objects.Player;
	import Control.View;
	import net.flashpunk.Sfx
	
	/**
	 * ...
	 * @author Wago
	 * Based on Noel Barry's Advanced Platform Engine
	 * 
	 * This class contains a numver of global variables to be used throughout the game
	 */
	
	public class Global 
	{
		public static var
			time:int = 0,
			deaths:int = 0,
			gems:int = 0,
			level:int = 0,
			
			newgame:Boolean = false,
			loadgame:Boolean = false,
			
			musicon:Boolean = true,
			soundon:Boolean = true,
			
			keyUp:int = Key.UP,
			keyDown:int = Key.DOWN,
			keyLeft:int = Key.LEFT,
			keyRight:int = Key.RIGHT,
			keyA:int = Key.X,
			keyB:int = Key.Z,
			keyP:int = Key.P,
			
			player:Player,
			view:View,
			
			paused:Boolean = false,
			restart:Boolean = false,
			finished:Boolean = false;
			
			
			
		public static const grid:int = 32;
	}

}