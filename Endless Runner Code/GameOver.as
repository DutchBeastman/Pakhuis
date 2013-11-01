package src 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Fabian Verkuijlen
	 */
	public class GameOver extends MovieClip
	{
		
		public function GameOver() 
		{
			Restart.addEventListener(MouseEvent.CLICK, reloaded)
			Menu.addEventListener(MouseEvent.CLICK, mainmenu)
		}
		
		private function mainmenu(e:MouseEvent):void 
		{
			Main._main.reload();
		}
		
		private function reloaded(e:MouseEvent):void 
		{
			Main._main.init();
		}
		
	}

}