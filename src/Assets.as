package  
{
	import Objects.Shoot;
	/**
	 * ...
	 * @author Wago
	 * Based on Noel Barry's Advanced Platform Engine
	 */
	public class Assets 
	{
		
		//Embed the levels
		[Embed(source = '../assets/levels/Level1.oel', mimeType = 'application/octet-stream')] public static const LEVEL1:Class;
		[Embed(source = '../assets/levels/Level2.oel', mimeType = 'application/octet-stream')] public static const LEVEL2:Class;
		
		public static const LEVELS:Array = new Array(LEVEL1,
													 LEVEL2);
													 
		//tilesets      
		[Embed(source = '../assets/graphics/tileset.png')]public static const TILESET:Class;
		
		//sounds
		[Embed(source = '../assets/Sounds/Death.mp3')] public static const SND_DEATH:Class;
		[Embed(source = '../assets/Sounds/Jump.mp3')] public static const SND_JUMP:Class;
		[Embed(source = '../assets/Sounds/Jump2.mp3')] public static const SND_JUMP2:Class;
		[Embed(source = '../assets/Sounds/Shoot.mp3')] public static const SND_SHOOT:Class;
		[Embed(source = '../assets/Sounds/Powerup.mp3')] public static const SND_POWERUP:Class;
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
		[Embed(source = '../assets/graphics/doublejump.png')] public static const OBJECT_DOUBLEJUMP:Class;
		[Embed(source = '../assets/graphics/door.png')] public static const OBJECT_DOOR:Class;
		[Embed(source = '../assets/graphics/electricity.png')] public static const OBJECT_ELECTRICITY:Class;
		[Embed(source = '../assets/graphics/moving.png')] public static const OBJECT_MOVING:Class;
		[Embed(source = '../assets/graphics/spikes.png')] public static const OBJECT_SPIKE:Class;
		[Embed(source = '../assets/graphics/Sign.png')] public static const OBJECT_SIGN:Class;
		[Embed(source = '../assets/graphics/shoot.png')] public static const OBJECT_SHOOT:Class;
		[Embed(source = '../assets/graphics/bullet.png')] public static const OBJECT_BULLET:Class;
		[Embed(source = '../assets/graphics/Walljump.png')] public static const OBJECT_WALLJUMP:Class;
		[Embed(source = '../assets/graphics/Bow.png')] public static const OBJECT_BOW:Class;
		
		//enemys
		[Embed(source = '../assets/graphics/Enemy.png')] public static const OBJECT_SKULL:Class;
		
		
		//player
		[Embed(source = '../assets/graphics/player.png')] public static const PLAYER:Class;
	}

}