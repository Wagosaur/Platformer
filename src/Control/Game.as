package Control
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.system.Capabilities;
	import Assets;
	import Global;
	import net.flashpunk.Sfx;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.utils.Input;
	
	import org.flashdevelop.utils.FlashViewer;
	import flash.events.*;
	
	import Objects.*;
	import Solids.*;
	
	import neoart.flod.*;
	
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Game extends World
	{
		[Embed(source = '../../assets/Sounds/180_degrees_dsx_trsi.mod', mimeType = 'application/octet-stream')] private var SONG1:Class;
		[Embed(source = '../../assets/Sounds/banja_dsx_trsi.mod', mimeType = 'application/octet-stream')] private var SONG2:Class;
		private var stream:ByteArray;
		private var processor:ModProcessor;
		
		public var tileset:Tilemap;
		
		//timer so that reset level doesn't happen right away...
		public var reset:int = 60;
		
		override public function begin():void
		{
			/*music = new Sfx(MUSIC)
			music.volume = 0.5;
			music.loop();
			if (Input.check(Global.keyP))
			{
			}
			*/
			playSong();
			
			//enable the console
			FP.console.enable();
			
			//set the level to 0
			Global.level = 0;
			
			//load next level
			nextlevel();
			
		}
		
		override public function update():void 
		{

			//only update if the game is not paused
			if (!Global.paused) { super.update(); }
			
			//if we should restart
			if (Global.restart) { 
				
				//make a timer so it isn't instant
				reset -= 1;
				if (reset == 0) {
					//restart level
					restartlevel();
					//set restart to false
					Global.restart = false;
					//reset our timer
					reset = 60;
					Global.DoublejumpGot = false;
					Global.ShootGot = false;
					Global.WalljumpGot = false;
				}
			}
			
			
			//load next level on level completion
			if (Global.finished) {
				nextlevel();
			}
		}
		
		public function loadlevel():void 
		{	
			//get the XML
			var file:ByteArray = new Assets.LEVELS[Global.level-1];
			var str:String = file.readUTFBytes( file.length );
			var xml:XML = new XML(str);
			
			//define some variables that we will use later on
			var e:Entity;
			var o:XML;
			var n:XML;
			
			//set the level size
			FP.width = xml.width;
			FP.height = xml.height;
			
			//add the tileset to the world
			add(new Entity(0, 0, tileset = new Tilemap(Assets.TILESET, FP.width, FP.height, Global.grid, Global.grid)));
			
			//add the view, and the player
			add(Global.player = new Player(xml.objects[0].player.@x, xml.objects[0].player.@y));
			
			//set the view to follow the player, within no restraints, and let it "stray" from the player a bit.
			//for example, if the last parameter was 1, the view would be static with the player. If it was 10, then
			//it would trail behind the player a bit. Higher the number, slower it follows.
			add(Global.view = new View(Global.player as Entity, new Rectangle(0,0,FP.width,FP.height), 1));
			
			//add tiles
			for each (o in xml.tilesAbove[0].tile) {
				//place the tiles in the correct position
				//NOTE that you should replace the "5" with the amount of columns in your tileset!
				tileset.setTile(o.@x / Global.grid, o.@y / Global.grid, (9 * (o.@ty/Global.grid)) + (o.@tx/Global.grid));
			}
			
			//place the solids
			for each (o in xml.floors[0].rect) {
				//place flat solids, setting their position & width/height
				add(new Solid(o.@x, o.@y, o.@w, o.@h));
			}
			if(str.search("<slopes>") > 0) {
				for each (o in xml.slopes[0].slope) {
					//place a slope
					add(new Slope(o.@x, o.@y, o.@type));
				}
			}
			
			//place a crate
			for each (o in xml.objects[0].crate) { add(new Crate(o.@x, o.@y)); }
			
			//place a moving platform
			for each (o in xml.objects[0].moving) { add(new Moving(o.@x, o.@y)); }
			
			//place a moving platform
			for each (o in xml.objects[0].spikes) { add(new Spikes(o.@x, o.@y)); }
			
			//place a sign
			for each (o in xml.objects[0].sign) { add(new Sign(o.@x, o.@y)); }
			
			//pickups
			for each (o in xml.objects[0].doublejump) { add(new Doublejump(o.@x, o.@y)); }
			for each (o in xml.objects[0].shoot) { add(new Shoot(o.@x, o.@y)); }
			for each (o in xml.objects[0].walljump) { add(new Walljump(o.@x, o.@y)); }
			
			//place electricity
			for each (o in xml.objects[0].electricity) {
				var p:Point;
				//get the end point of the electricity (via nodes)
				for each (n in o.node)
				{
					p = new Point(n.@x, n.@y);
				}
				
				//add electricity to the world
				add(new Electricity(o.@x, o.@y, p.x, p.y));
			}
						
			//add the door!
			for each (o in xml.objects[0].door) { add(new Door(o.@x, o.@y)); }
		}
		
		
		/**
		 * Loads up the next level (removes all entities of the current world, increases Global.level, calls loadlevel)
		 * @return	void
		 */
				
		public function nextlevel():void
		{
			removeAll();
			
			if(Global.level < Assets.LEVELS.length) { Global.level ++; }
			Global.finished = false;
			
			loadlevel();
		}
		
		
		/**
		 * Reloads the current level
		 * @return	void
		 */
		public function restartlevel():void
		{
			removeAll();
			loadlevel();
			
			//increase deaths
			Global.deaths ++;
		}
		
		private function playSong():void
		{
			//	1) First we get the module into a ByteArray
			
			stream = new SONG1() as ByteArray;
			
			//	2) Create the ModProcessor which will play the song
			
			processor = new ModProcessor();
			
			//	3) Load the song (now converted into a ByteArray) into the ModProcessor
			//	This returns true on success, meaing the module was parsed successfully
			
			if (processor.load(stream))
			{
				//	Will the song loop at the end? (boolean)
				processor.loopSong = true;
				
				//	4) Play it!
				processor.play();
			}
		}
		/*private function keyPress(event:KeyboardEvent):void
		{
			switch (event.keyCode)
			{
				//	1 - Play module 1
				case 49:
					processor.stop();
				
					stream = new SONG1() as ByteArray;
					
					if (processor.load(stream))
					{
						processor.loopSong = true;
						processor.play(sound);
					}
					break;
					
				//	2 - Play module 2
				case 50:
					processor.stop();
					
					stream = new SONG2() as ByteArray;
					
					if (processor.load(stream))
					{
						processor.loopSong = true;
						processor.play(sound);
					}
					break;
				
				//	M - Pause or Resume the playback
				case 77:
					if (processor.isPlaying)
					{
						processor.pause();
					}
					else
					{
						processor.play(sound);
					}
					break;
				
				//	Stereo Separation
				
				//	Left - Adjust the stereo separation
				case 37:
					if (processor.stereo > 0)
					{
						processor.stereo -= 0.10;
					}
					break;
					
				//	Right
				case 39:
					if (processor.stereo < 1)
					{
						processor.stereo += 0.10;
					}
					break;
			}
		}*/
		
	}

}