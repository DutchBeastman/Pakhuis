package src 
{
	import flash.automation.KeyboardAutomationAction;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.media.SoundTransform;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * ...
	 * @author Fabian Verkuijlen
	 */
	public class Main extends Sprite 
	{
		private var map:Map;
		private var player:Player;
		private var horKey:int;
		private var verKey:int;
		private var enemies:Array;
		private var bullets:Array;
		private var enemyBullets:Array;
		private var defensive:Array;
		private var Quit:SimpleButton;
		private var restartKnop:SimpleButton;
		private var Startknop:SimpleButton;
		private var traps:Array;
		private var goal:Goal;
		private var win:TextField;
		private var lost:TextField;
		private var start:StartArt;
		private var Lose:LoseArt;
		private var Win:WinArt;
		public function Main() 
		{
		start = new StartArt();
		addChild(start);
		Startknop = new StartknopArt();
		addChild(Startknop);
		Startknop.x = stage.stageWidth * 0.35;
		Startknop.y = stage.stageWidth * 0.05;
		Startknop.addEventListener(MouseEvent.CLICK, startGame);
		}
		private function startGame(e:MouseEvent)
		{
			
			
			Startknop.removeEventListener(MouseEvent.CLICK, startGame);
			removeChild(Startknop);
			start.removeEventListener(MouseEvent.CLICK, startGame);
			removeChild(start);
			
			
			init();
			//spel moet Beginnen.
		}
		
		private function init()
		{
			map = new Map();
			addChild(map);
			map.x = 0;
			map.y = 0;
			player = new Player();
			player.x = 50;
			player.y = 670;
			enemies = new Array();
			//enemies = []; korte notatie
			bullets = new Array();
			enemyBullets  = new Array();
			defensive = new Array();
			traps = [];//andere notatie voor het aanmaken van een lege array
			goal = new Goal();
			addChild(goal);
			goal.x = 550;
			goal.y = 50;
			
			
			
			for (var k:int = 0; k < 4; k++) 
			{
				
				
				
				traps.push(new Trap);
				addChild(traps[k]);
				
			}
				traps[1].x = 100
				traps[1].y = 300
				traps[2].x = 1000
				traps[2].y = 600
				traps[3].x = 100
				traps[3].y = 100
				
			addChild(player);
			
			
			
				
			enemies = new Array();
			//enemies = []; korte notatie van array
			
			for ( i = 0; i < 8; i++ )
			{
				enemies.push(new Enemy());
				addChild(enemies[i]);
				enemies[i].addEventListener("geschoten", createBullet);
			}
			
			
		
			//later moet je ze stuk voor stuk plaatsen.
			
			enemies[1].x = 1000
			enemies[1].y = 400
			enemies[2].x = 1000
			enemies[2].y = 500
			enemies[3].x = 1000
			enemies[3].y = 250
			enemies[4].x = 60
			enemies[4].y = 200
			enemies[5].x = 100
			enemies[5].y = 100
			enemies[6].x = 150
			enemies[6].y = 230
			
			for (var i:int = 0; i < 7; i++ )
			
			{
				defensive.push(new Defense());
				addChild(defensive[i]);
				
			}
			
			defensive[0].x = 100
			defensive[0].y = 100
			defensive[1].x = 200
			defensive[1].y = 200
			defensive[2].x = 200
			defensive[2].y = 300
			defensive[3].x = 1000
			defensive[3].y = 100
			defensive[4].x = 1000
			defensive[4].y = 200
			defensive[5].x = 200
			defensive[5].y = 550
			defensive[6].x = 100
			defensive[6].y = 400
			//later moet je ze stuk voor stuk plaatsen
			
			addEventListener(Event.ENTER_FRAME, loop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyReleased);
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		private function createBullet(e:Event)
		{
			var en:Enemy = e.target as Enemy;
			var b:Bullet = new Bullet(2);
			enemyBullets.push(b);
			b.x = en.x;
			b.y = en.y;
			b.rotation = en.rotation;
			addChild(b);
		}
		private function onMouseClick(e:MouseEvent)
		{
			
			//manier 1
			bullets.push(new Bullet(1));
			addChild(bullets[bullets.length - 1]);
			addChildAt(bullets[bullets.length - 1], this.getChildIndex(player));
			bullets[bullets.length - 1].x = player.x;
			bullets[bullets.length - 1].y = player.y;
			
		
			bullets[bullets.length -1].rotation = player.rotation;
			
			/*
			//andere manier 2
			var b:Bullet = new Bullet();
			bullets.push(b);
			addChild(b);
			b.x = player.x;
			b.y = player.y;
			*/
		}
		private function loop(e:Event)
		{
			var playerDood:Boolean = false;
			for (var i:int = 0; i < enemies.length; i++ )
			{
				enemies[i].turnTo(new Point(player.x, player.y));
				enemies[i].move(1);
			}
			for each(var eb:Bullet in enemyBullets)
			{
				eb.move(12);
				if (player.hitTestPoint(eb.x,eb.y,true))
				{
					//verwijder kogel
					removeChild(eb);
					enemyBullets.splice(enemyBullets.indexOf(eb), 1);
					//leven van de speler af
					player.life--;
					//kijk of je dood bent
					if (player.life <= 0)
					{
						playerDood = true;
						//ben je dood						
						break;
					}
				}
				
				
				for each (var d:Defense in defensive)
				{
					if (d.hitTestPoint(eb.x,eb.y,true))
					{
						d.life--;
						//geeft een bug maar werkelijk werkt de functie??
						removeChild(eb);
						enemyBullets.splice(enemyBullets.indexOf(eb), 1);
					}
				}
				
			}
			for (var j:int = bullets.length-1; j >= 0; j-- )
			{
				var verwijderKogel:Boolean = false;
				bullets[j].move(20);
				for each(var def:Defense in defensive)
				{
					if (def.hitTestPoint(bullets[j].x, bullets[j].y, true))
					{
						verwijderKogel = true;
						def.life--;
					}
				}
				
				for each(var enemy:Enemy in enemies)
				{
					if (enemy.hitTestPoint(bullets[j].x,bullets[j].y,true))//als de kogel een enemy raakt
					{
						//kogel verwijderen
						
						//leven van enemy afhalen
						verwijderKogel = true;
						enemy.life --;
						if (enemy.life <= 0)
						{
							removeChild(enemy);
							enemy.removeEventListener("geschoten", createBullet);
							enemy.destroy();
							enemies.splice(enemies.indexOf(enemy), 1);
						}
						
					}
				}
				
				if (bullets[j].x <0 
				|| bullets[j].x > stage.stageWidth 
				|| bullets[j].y < 0
				|| bullets[j].y > stage.stageHeight)
				{
					verwijderKogel = true;
					
				}
				if (verwijderKogel)
				{
					//verwijder kogel van scherm
					removeChild(bullets[j]);
					//verwijder kogel uit geheugen
					bullets.splice(j, 1);
				}
			}
			
			for each(var de:Defense in defensive)
			{
				if (de.life <= 0)
				{
					removeChild(de);
					defensive.splice(defensive.indexOf(de), 1);
				}
			}
			for each (var trap:Trap in traps) 
			{
				if (trap.hitTestPoint(player.x,player.y,true))
				{
					player.life--;
					if (player.life <= 0)
					{
						playerDood = true;
					}
				}
			}
			
			player.turnTo(new Point(mouseX , mouseY));
			
			//oude besturing
			player.x += 5 * horKey;
			player.y += 5 * verKey;
		
			if (playerDood)
			{
				clearScreen();
				lost = new TextField();
				addChild(lost);
				lost.text = "Probeer het opnieuw.";
				lost.x = stage.stageWidth / 2 - lost.width;
				lost.y = stage.stageHeight / 2 - lost.height;
				
				restartKnop = new RestartKnop();
			addChild(restartKnop);
			restartKnop.x = stage.stageWidth * 0.5;
			restartKnop.y = stage.stageWidth * 0.5;
			restartKnop.addEventListener(MouseEvent.CLICK, restartGame);
		
			}
		
		}
		
		
	
	
			
			
		
		private function clearScreen()
		{
			//speler van het scherm
			removeChild(player);
			//speler uit het geheugen
			player = null;
			//gameloop stilzetten
			removeEventListener(Event.ENTER_FRAME, loop);
			//weg uit de for each loop
			
			
			stage.removeEventListener(MouseEvent.CLICK, onMouseClick);
			
			for each(var e:Enemy in enemies)
			{
				removeChild(e);
				e.destroy();
				e.removeEventListener("geschoten", createBullet);
			}
			enemies.splice(0, enemies.length);
			for each (var o:Defense in defensive) 
			{
				removeChild(o);
			}
			defensive.splice(0, defensive.length);
			for each (var b:Bullet in bullets) 
			{
				removeChild(b);
			}
			bullets.splice(0, bullets.length);
			for each (var eb:Bullet in enemyBullets) 
			{
				removeChild(eb);
			}
			enemyBullets.splice(0, enemyBullets.length);
			for each (var trap:Trap in traps) 
			{
				removeChild(trap);
			}
			traps.splice(0, traps.length);
			
			removeChild(goal);
			goal = null;
			
			removeChild(map);
			map = null;
					
			//Zet restart neer.
			restartKnop = new RestartKnop();
			addChild(restartKnop);
			restartKnop.x = stage.stageWidth * 0.5;
			restartKnop.y = stage.stageWidth * 0.5;
			restartKnop.addEventListener(MouseEvent.CLICK, restartGame);
			
		}
		private function restartGame(e:MouseEvent)
		{
			//Verwijderen van overigen knoppen.
			
			restartKnop.removeEventListener(MouseEvent.CLICK, restartGame);
			removeChild(restartKnop);
			init();
			//spel moet herstarten
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
		private function checkGoal()
		{
		if (goal.hitTestPoint(player.x,player.y,true))
			{
				clearScreen();
				win = new TextField();
				addChild(win);
				win.text = "YOU WIN";
				win.x = stage.stageWidth / 2 - win.width;
				win.y = stage.stageHeight / 2 - win.height;
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
				horKey = -3;
				checkGoal();
			}
			if (e.keyCode == 68)
			{
				//keyH2 = 1;
				horKey = 3;
				checkGoal();
			}
			if (e.keyCode == 87)
			{
				//keyV1 = 1;
				verKey = -3;
				checkGoal();
			}
			if (e.keyCode == 83)
			{
				//keyV2 = 1;
				verKey = 3;
				checkGoal();
			}
			
		}
		
	}

}