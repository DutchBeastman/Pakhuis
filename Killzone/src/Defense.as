package src 
{
	import flash.display.MovieClip;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	/**
	 * ...
	 * @author Fabian Verkuijlen
	 */
	public class Defense extends MovieClip
	{
		
		private var art:MovieClip;
		public var life:int;
		public function Defense() 
		
		{
			art = new DefenseArt();
			addChild(art);
			life = 10;
		}
		private var Defensive:DisplayObjectContainer;
		private var _minX:int;
		private var _minY:int;
		private var _maxX:int;
		private var _maxY:int;
		public function setBoundries(Defensive:DisplayObjectContainer):void
		{
			_minX = 0;
			_minY = 0;
			_maxX = Defensive.width;
			_maxY = Defensive.height;
		}
		
	}

}