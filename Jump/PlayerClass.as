package 
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Fabian Verkuijlen
	 */
	public class PlayerClass extends MovieClip
	{
	
	private var art:MovieClip
	public function PlayerClass() 
	{
		art = new Player();
		addChild(art);
	}
	//Oude Jump en fall functie.
	//public function jump():void
		//{
			//y -= 60; 
		//}
	//public function fall():void
		//{
			//y += 60;
		//}
	//}
	
	}
	}