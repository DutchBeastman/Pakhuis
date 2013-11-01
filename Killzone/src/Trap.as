package src 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Fabian Verkuijlen
	 */
	public class Trap extends MovieClip 
	{
		private var art:MovieClip;
		public function Trap() 
		{
			art = new TrapArt();
			addChild(art);
		}
		
	}

}