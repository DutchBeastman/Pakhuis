package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author Fabian Verkuijlen
	 */
	public class PlatformClass extends MovieClip
	{
		private var platform:Array;
		//art van platform zelf
		private var art:Platform;
		public function PlatformClass()
		{
			x = 0;
			y = 0;

			art = new Platform();
			addChild(art);
		}
		public function move():void 
		{
			//x -= 10;
		}
		
		
		
	}
		
		
	
	

}