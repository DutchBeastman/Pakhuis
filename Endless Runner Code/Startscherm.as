package src
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Fabian Verkuijlen
	 */
	public class Startscherm extends MovieClip
	{
		
		
		
		public function Startscherm()
		{
			
			Start.addEventListener(MouseEvent.CLICK, startgame)
			Info.addEventListener(MouseEvent.CLICK, DisplayInfo)
		
		}
		
		private function DisplayInfo(e:MouseEvent):void
		{
			Main._main.infoscherm();
		}
		private function startgame(e:MouseEvent):void
		{
			Main._main.init();
			//FIXME: start scherm wordt niet weggehaald.
		}	
	
	}

}