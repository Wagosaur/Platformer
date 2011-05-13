package  
{
	/**
	 * ...
	 * @author Wago
	 * Based on Noel Barry's Advanced Platform Engine
	 */
	public class Assets 
	{
		
		//Embed the levels
		[Embed(source = '../assets/levels/Level1.oel', mimeType = 'application/octet-stream')]public static const LEVEL1:Class;
		[Embed(source = '../assets/levels/Level2.oel', mimeType = 'application/octet-stream')]public static const LEVEL2:Class;
		[Embed(source = '../assets/levels/Level3.oel', mimeType = 'application/octet-stream')]public static const LEVEL3:Class;
		[Embed(source = '../assets/levels/NewLevel.oel', mimeType = 'application/octet-stream')] public static const TESTLEVEL:Class;
		[Embed(source = '../assets/levels/Tutorial level.oel', mimeType = 'application/octet-stream')]public static const TUTLEVEL:Class;
		
		public static const LEVELS:Array = new Array(TUTLEVEL);
		
		[Embed(source = '../assets/graphics/paused.png')] public static const PAUSED:Class;
													 
		//tilesets      
		[Embed(source = '../assets/graphics/tileset.png')]public static const TILESET:Class;
		
		//menu
		[Embed(source = '../assets/graphics/banner.png')]public static const MENU_BANNER:Class;
		[Embed(source = '../assets/graphics/menu.png')]public static const MENU:Class;
		
		//slopes
		[Embed(source = '../assets/graphics/slope1.png')] public static const SLOPE1:Class;
		[Embed(source = '../assets/graphics/slope2.png')] public static const SLOPE2:Class;
		[Embed(source = '../assets/graphics/slope3.png')] public static const SLOPE3:Class;
		[Embed(source = '../assets/graphics/slope4.png')] public static const SLOPE4:Class;
		
		//objects
		[Embed(source = '../assets/graphics/crate.png')] public static const OBJECT_CRATE:Class;
		[Embed(source = '../assets/graphics/door.png')] public static const OBJECT_DOOR:Class;
		[Embed(source = '../assets/graphics/electricity.png')] public static const OBJECT_ELECTRICITY:Class;
		[Embed(source = '../assets/graphics/moving.png')] public static const OBJECT_MOVING:Class;
		[Embed(source = '../assets/graphics/spikes.png')] public static const OBJECT_SPIKE:Class;
		[Embed(source = '../assets/graphics/Sign.png')] public static const OBJECT_SIGN:Class;
		
		//player
		[Embed(source = '../assets/graphics/player.png')] public static const PLAYER:Class;
	}

}