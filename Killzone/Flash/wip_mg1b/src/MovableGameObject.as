package src 
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Erwin Henraat
	 */
	public class MovableGameObject extends MovieClip 
	{
		
		public function MovableGameObject() 
		{
			
		}
		public function move($speed:Number)
		{
			var snelheid:Point = new Point();
			snelheid.x = Math.cos(this.rotation / 180 * Math.PI) * $speed;
			snelheid.y = Math.sin(this.rotation / 180 * Math.PI) * $speed;
			
			this.x += snelheid.x;
			this.y += snelheid.y;
		}
		
	}

}