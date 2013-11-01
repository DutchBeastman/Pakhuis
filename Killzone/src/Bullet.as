package src 
{
	import flash.display.MovieClip;
	/**
	 * ...
	 * @author Fabian Verkuijlen
	 */
	public class Bullet extends MovableGameObject
	{
		private var art:MovieClip;
		public function Bullet($style:int) 
		{
			if ($style == 1)
			{
				art = new BulletArt();
				addChild(art);
			}
			if ( $style == 2)
			{
				art = new Bullet2Art();
				addChild(art);
			}
		}
		
	}

}