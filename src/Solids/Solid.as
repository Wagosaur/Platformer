package Solids 
{
	import net.flashpunk.Entity;
	/**
	 * ...
	 * @author Noel Berry
	 */
	public class Solid extends Entity
	{
		
		public function Solid(x:int,y:int,w:int = 32,h:int = 32) 
		{
			type = "Solid";
			setHitbox(w, h);
			
			this.x = x;
			this.y = y;
			
			
			//hide us - we don't need to ever be updated or rendered
			active = false;
			visible = false;
		}
		
	}

}