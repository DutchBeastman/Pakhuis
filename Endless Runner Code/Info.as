package src 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Kevin Breurken
	 */
	public class Info extends MovieClip
	{
		private var InfoScherm:Infoscherm;
		private var backbutton:BackButton;
		public function Info() 
		{
			InfoScherm = new Infoscherm();
			addChild(InfoScherm);
			backbutton = new BackButton();
			addChild(backbutton);
			backbutton.x = 1400;
			backbutton.y = 10;
			backbutton.addEventListener(MouseEvent.CLICK, backtomenu)
		}
		private function backtomenu(e:MouseEvent):void {
			removeChild(backbutton);
			removeChild(InfoScherm);
		}
	}

}