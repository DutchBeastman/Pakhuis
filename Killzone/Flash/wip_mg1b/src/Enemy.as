package src 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Erwin Henraat
	 */
	public class Enemy extends Unit 
	{
		private var art:MovieClip;
		public function Enemy() 
		{
			art = new EnemyArt();
			addChild(art);
		}
		
	}

}