package src 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.media.SoundTransform;


	/**
	 * ...
	 * @author Erwin Henraat
	 */
	public class Main extends Sprite 
	{
		private var player:Player;
		private var horKey:int;
		private var verKey:int;
		private var enemies:Array;
	
		
			
		public function Main() 
		{
			player = new Player();
			addChild(player);
			
			enemies = new Array();
			//enemies = []; korte notatie
			
			
			for (var i:int = 0; i < 5; i++ )
			{
				enemies.push(new Enemy());
				addChild(enemies[i]);
				enemies[i].x = stage.stageWidth/2 + Math.random() * (stage.stageWidth/2);
				enemies[i].y = Math.random() * stage.stageHeight;
			}
			
			//later moet je ze stuk voor stuk plaatsen
			
			
			
			
			
			
			trace(enemies);
			
			trace("hoi hoi!!");
			addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyReleased);
		
			
		}		
		

		private function loop(e:Event)
		{
			
			for (var i:int = 0; i < enemies.length; i++ )
			{
				enemies[i].turnTo(new Point(player.x, player.y));
				//enemies[i].move(30);
			}
			
			player.turnTo(new Point(mouseX , mouseY));
			
			//nieuwe besturing
			//player.move(-verKey * 16);
			
			//oude besturing
			player.x += 5 * horKey;
			player.y += 5 * verKey;
			
			//player.x += (keyH1 - keyH2) *5;
			//player.y += (keyV1 - keyV2) *5;
			
			
		}
		private function onKeyReleased(e:KeyboardEvent)
		{
			if (e.keyCode == 65)// A key is logelaten
			{
				//keyH1 = 0;
				horKey = 0;
			}
			if (e.keyCode == 68)// D key is logelaten 
			{
				horKey = 0;
				//keyH2 = 0;
			}
			if (e.keyCode == 87)
			{
				verKey = 0;
				//keyV1 = 0;
			}
			if (e.keyCode == 83)
			{
				verKey = 0;
				//keyV2 = 0;
			}					
		}
		private function onKeyPressed(e:KeyboardEvent)
		{
			//trace(e.keyCode);
			//65 A
			//87 W
			//83 S
			//68 D
			if (e.keyCode == 65)
			{
				//keyH1 = 1;
				horKey = -1;
			}
			if (e.keyCode == 68)
			{
				//keyH2 = 1;
				horKey = 1;
			}
			if (e.keyCode == 87)
			{
				//keyV1 = 1;
				verKey = -1;
			}
			if (e.keyCode == 83)
			{
				//keyV2 = 1;
				verKey = 1;
			}
			
		}
		
	}

}