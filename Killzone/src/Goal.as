package src 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Fabian Verkuijlen
	 */
	public class Goal extends MovieClip 
	{
		private var art:MovieClip;
		public function Goal() 
		{
			art = new GoalArt();
			addChild(art);
		}
		
	}

}