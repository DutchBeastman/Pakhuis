package src 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Fabian Verkuijlen
	 */
	public class Map extends MovieClip 
	{
		private var art:MovieClip;
		public function Map() 
		{
			art = new MapArt();
			addChild(art);
		}
		
	}

}