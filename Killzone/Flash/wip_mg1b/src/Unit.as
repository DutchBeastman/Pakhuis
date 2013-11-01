package src 
{
	import flash.display.MovieClip;
	import flash.geom.Point;

	
	/**
	 * ...
	 * @author Erwin Henraat
	 */
	public class Unit extends MovableGameObject 
	{
		
		public function Unit() 
		{
			trace("hallo ik ben een unit");
		}
		public function turnTo($target:Point)
		{
			var diffX:Number = $target.x - this.x;
			var diffY:Number = $target.y - this.y;
			var radians:Number = Math.atan2(diffY, diffX);
			var degrees:Number = radians * 180 / Math.PI; 
		
			this.rotation = degrees;
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

bewegen:
xas Math.cos(this.rotation / 180 * Math.PI);
yas Math.sin(this.rotation / 180 * Math.PI);
*/