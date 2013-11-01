package src 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Fabian Verkuijlen
	 */
	public class Player extends Unit 
	{
		private var art:MovieClip;
		public function Player() 
		{
			art = new PlayerArt();
			addChild(art);
			life = 4;
		}
		
	}

}

/*
Draaien:
var xdiff:Number = (_target.x - x);
var ydiff:Number = (_target.y - y);
var radians:Number = Math.atan2(ydiff, xdiff);
var degrees:Number = radians * 180 / Math.PI; 
rotation = degrees;
*/