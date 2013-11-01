package src 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author Fabian Verkuijlen
	 */
	public class Enemy extends Unit 
	{
		private var art:MovieClip;
		
		private var shootTimer:Timer
		public function Enemy() 
		{
			life = 1;
			art = new EnemyArt();
			addChild(art);
			
			
			shootTimer = new Timer(1200 + Math.random() * 500, 0)
			shootTimer.start();
			shootTimer.addEventListener(TimerEvent.TIMER, shoot);
			
		}
		private function shoot(e:TimerEvent)
		{
			dispatchEvent( new Event("geschoten"));
		}
		public function destroy()
		{
			shootTimer.stop();
			shootTimer.removeEventListener(TimerEvent.TIMER, shoot);
			shootTimer = null;
		}
	}

}