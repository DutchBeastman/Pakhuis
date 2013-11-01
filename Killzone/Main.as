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
		private var player:Player;
		private var horKey:int;
		private var verKey:int;
		private var enemies:Array;
		private var bullets:Array;
		private var enemyBullets:Array;
		private var defensive:Array;
		private var restartKnop:SimpleButton;
		private var traps:Array;
		private var goal:Goal;
		private var win:TextField;
		public function Main() 
		{
			init();
			
		}	
		private function init()
		{
				
			player = new Player();
			
		
			defensive = new Array();
			bullets = new Array();
			enemyBullets = new Array();
			
			traps = []; // anderen vorm van het aanmaken array
			goal = new Goal();
			addChild(goal);
			goal.x = 780;
			goal.y = 500;
			
			for (var j:int = 0; j < 4; j++) 
			{
				var t:Trap = new Trap();
				traps.push(new Trap());
				addChild(traps[j]);
				
				
				traps.push(t);
				t.x = Math.random() * stage.stageWidth;
				t.y = Math.random() * stage.stageHeight;
				addChild(t);
				
			}
			addChild(player);
			for (var i:int = 0; i < 7; i++ )
			
			{
				defensive.push(new Defense());
				addChild(defensive[i]);
				
			}
			
			defensive[0].x = 300
			defensive[0].y = 400
			defensive[1].x = 560
			defensive[1].y = 400
			defensive[2].x = 550
			defensive[2].y = 600
			defensive[3].x = 300
			defensive[3].y = 600
			defensive[4].x = 800
			defensive[4].y = 400
			defensive[5].x = 800
			defensive[5].y = 400
			defensive[6].x = 800
			defensive[6].y = 500
			
			defensive.push(new Defense());
			addChild(defensive[i]);
			
			enemies = new Array();
			//enemies = []; korte notatie van array
			
			for ( i = 0; i < 4; i++ )
			{
				enemies.push(new Enemy());
				addChild(enemies[i]);
				enemies[i].addEventListener("geschoten", createBullet);
			}
			
			
		
			//later moet je ze stuk voor stuk plaatsen.
			
			enemies[1].x = 630
			enemies[1].y = 830
			enemies[2].x = 400
			enemies[2].y = 500
			enemies[3].x = 250
			enemies[3].y = 250
			
			
			enemies.push(new Enemy());
			addChild(enemies[i]);
			
		
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
			
			bullets.push(new Bullet(1));
			//addChild (bullets[bullets.length - 1]);
			addChildAt(bullets[bullets.length - 1], this.getChildIndex(player));
			bullets[bullets.length - 1].x = player.x; 
			bullets[bullets.length - 1].y = player.y;
			bullets[bullets.length - 1].rotation = player.rotation;
		
			
			/*
			//anderen manier
			var b:Bullet = new Bullet();
			Bullet.push(b);
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
				enemies[i].move(5);
			
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
						removeChild(eb);
						enemyBullets.splice(enemyBullets.indexOf(eb), 1);
						d.life --;
					}
				}
			}
			for (var j:int = bullets.length -1; j >= 0; j-- )
			{
				var verwijderKogel:Boolean = false;
				bullets[j].move(140);
				for each(var de:Defense in defensive)
				{
					if (de.hitTestPoint(bullets[j].x, bullets[j].y, true))
					{
						verwijderKogel = true;
						de.life --;
					}
				}
				for each(var enemy:Enemy in enemies) 
				{
					
				
					if (enemy.hitTestPoint(bullets[j].x,bullets[j].y ,true))//mits de kogel een enemie raakt
					{
						//kogel verwijderen
						
						//leven van enemie halen
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
				if (bullets[j].x < 0
				|| bullets[j].x > stage.stageWidth 
				|| bullets[j].y < 0 
				|| bullets[j].y > stage.stageHeight )
				{
					verwijderKogel = true;
					
				}
				if (verwijderKogel) {
					//verwijdert kogel van scherm
					removeChild(bullets[j]);
					//verwijder kogel van geheugen
					bullets.splice(j, 1)
				}
				
			}
			for each(var d:Defense in defensive)
			{
				if (d.life <= 0)
				{
					removeChild(d);
					defensive.splice(defensive.indexOf(d), 1);
				}
				
				
				
			}
			for each (var trap:Trap in traps ) 
			{
				if (trap.hitTestPoint(player.x,player.y ,true))
				{
					player.life --;
					if (player.life <= 0)
					{
						playerDood = true;
					}
					
				}
			}
			
			player.turnTo(new Point(mouseX , mouseY));
			
			//nieuwe besturing
			//player.move(-verKey * 16);
			
			//oude besturing
			player.x += 5 * horKey;
			player.y += 5 * verKey;
			
			//player.x += (keyH1 - keyH2) *5;
			//player.y += (keyV1 - keyV2) *5;
			
			if (playerDood)
			{
				clearScreen();
				
			}
		}
		private function clearScreen()
		{
			//ben je dood
			//removin player
			removeChild(player);
			//speler uit het geheugen
			player = null;
			//remove loop
			removeEventListener(Event.ENTER_FRAME, loop);
			stage.removeEventListener(MouseEvent.CLICK, onMouseClick);
			for each(var e:Enemy in enemies)
			{
				removeChild(e);
				e.destroy();
				e.removeEventListener("geschoten", createBullet);
			}
			enemies.splice(0, enemies.length);
			for each (var d:Defense in defensive)
			{
				removeChild(d)
			}
			defensive.splice(0, defensive.length);
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
			
			
			restartKnop = new RestartKnop();
			addChild(restartKnop);
			restartKnop.x = stage.stageWidth * 0.5;
			restartKnop.y = stage.stageWidth * 0.75;
			restartKnop.addEventListener(MouseEvent.CLICK, restartGame);
			
			
		}
		 
		private function restartGame(e:MouseEvent)
		{
			removeChild(win);
			restartKnop.removeEventListener(MouseEvent.CLICK, restartGame);
			removeChild(restartKnop);
			// Game moet ge-reboot worden
			init();
			
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
				var win:TextField = new TextField();
				addChild(win);
				win.text = "Gefeliciteerd YOU WIN!!"
				win.x = stage.stageWidth/2 - win.width;
				win.y = stage.stageHeight/2 - win.height;
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
				horKey = -8;
				checkGoal();
			}
			if (e.keyCode == 68)
			{
				//keyH2 = 1;
				horKey = 8;
				checkGoal();
			}
			if (e.keyCode == 87)
			{
				//keyV1 = 1;
				verKey = -8;
				checkGoal();
			}
			if (e.keyCode == 83)
			{
				//keyV2 = 1;
				verKey = 8;
				checkGoal();
			}
			
		}
		
	}


}