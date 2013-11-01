package 
{
	//alle Imports
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.TouchEvent;
	import flash.display.BlendMode;
	import flash.display.SimpleButton;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextDisplayMode;
	import flash.text.engine.FontWeight;
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	
	
	
	/**
	 * ...
	 * @author Fabian Verkuijlen
	 */
	public class Main extends Sprite 
	{
		// alle variables
		public var jump:KeyboardEvent;
		private var win:TextField;
		private var textveld:TextField;
		private var _platform:Array;
		private var _trap:Array;
		private var background:Background = new Background;
		private var bbackground:Background = new Background;
		private var spacePressed:Boolean;
		private var _player:PlayerClass;
		private var kloktimer:Timer;
		private var keyPressed:Boolean;
		private var jumpForce:Number = 0;
		private var gravity:Number = 40;
		private var geland:Boolean = false;
		private var start:Start;
		private var art:Startscherm;
		private var Score:int;
		private var gameState:String = "startscherm"
		
	
		public function Main():void 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		
			
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			//Om de reload functie te laten werken
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, reload);
			//
			stage.addEventListener(KeyboardEvent.KEY_DOWN, pressed );
			stage.addEventListener(KeyboardEvent.KEY_UP, released);
			gameState = "startscherm";
			//Voor het startscherm 
			art = new Startscherm();
			addChild(art);
			//Start Button
			start = new Start();
			addChild(start);
			start.x = 600;
			start.y = 800;
			start.width = 200;
			start.height = 100;
			
			
		
			
		}

		
		
			
		
			
		
		
		
		
		private function startGame():void 
		{
			removeChild(start);
			removeChild(art)
			
			gameState = "game";
			
			addChild(background);
			background.height = stage.stageHeight;
			background.width = stage.stageWidth;
			background.x = 400;
			//tweede background
			addChild(bbackground)
			bbackground.height = stage.stageHeight;
			bbackground.width = stage.stageWidth;
			background.x = 1600;
			
			
			//Timer voor Score
			kloktimer = new Timer (1000);
			kloktimer.addEventListener(TimerEvent.TIMER, Tik);
			kloktimer.addEventListener(TimerEvent.TIMER_COMPLETE, Done);
			kloktimer.start();
		//	addEventListener(Event.ENTER_FRAME, jump);
		
			//het tekst veld voor de Score(word later aangevraagt)
			textveld = new TextField();
			addChild(textveld); 
			TextScale(textveld, 20, 3);
			
			
		
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			// zet de player en platform neer
			makePlatform();
			
			makePlayer();
			
		
			
			
			addEventListener(Event.ENTER_FRAME, gameloop);
			
			
		}
		
		


		private function gameloop(e:Event):void 
		{
		//Hier word de score neergezet.
		textveld.text = "uw score is " + Score;
			
 		
			
			//Background positioning en functies
			bbackground.x = bbackground.x -10;
			background.x = background.x - 10;
			if (background.x < -1575)
			{
				
				background.x = 1600;
			}
			if (bbackground.x < -1575)
			{
				
				bbackground.x = 1600;
			}
			
			_player.x = 250;
			if (_player.y < 0)
			{
				_player.y = 0;
			}
			if (_player.y > 900)
			{
				Lose();
			}
			if (keyPressed && geland)
			{	
				geland = false;
				jumpForce = 75;
				_player.y -= 8;
			}else if(jumpForce > 0)
			{
				jumpForce--;
			}
			_player.y -= jumpForce;
			_player.y += gravity;
			
			
			for (var i:int = 0; i < 4; i++) 
			{
				if (_platform[i].x < -1600) 
				{
					
					_platform[i].x = Math.random() * 3200;
				}
				
				if (_platform[i].hitTestPoint(_player.x,_player.y,true))
				{
					_player.y = _platform[i].y;
					geland = true
				}
				
				else 
				{
					gravity = 50;
				}
					_platform[i].x -= 20;
					
					
					//Oude hittest Deze liet mijn character op een box met art lopen en ook nog eens gebugged worden als het niet hoger werd gezet.
				
				/*
				if (_player.hitTestObject(_platform[i])) {
					_player.y = _platform[i].y - _player.height +10;
					gravity = 20;
					geland = true
				}
				*/
				
			}
			
			

		}

		//Maakt het platform
		private function makePlatform():void
		{
			_platform = [];
		for (var i:int = 0; i < 4; i++) 
		{
			_platform.push(new PlatformClass());
		
			
		
			_platform[i].x = i * 1600;
			_platform[i].y = 600;
			addChild(_platform[_platform.length - 1]);
			
		}
		}
		private function makePlayer():void
		{
			_player = new PlayerClass();
			addChild(_player);
			_player.y = 0;
			_player.x = 250;
		}
		//Released functie voor de spring functie
		private function released(e:KeyboardEvent):void 
		{
			//trace("fall");
			//	
			keyPressed = false;
		}
		//pressed functie voor de spring functie
		private function pressed(e:KeyboardEvent):void 
		{
			//trace("jump");
			//_player.jump();
			if (e.keyCode == 32) {
				
				
				trace(gameState);
				if (gameState == "startscherm")
				{
					startGame();
				}else
				{
				
					keyPressed = true;
				}
			}
			
		}
		
		//Releas functie van de Spatie knop
		private function spaceUp(e:KeyboardEvent):void
		{
			
			if (e.keyCode == 32){
			spacePressed = false;
			}
			
			
		}
		//Ingedrukt functie van de spatie Knop
		private function spaceDown(e:KeyboardEvent):void
		{
			
			if (e.keyCode == 32){	
			spacePressed = true;
		}
				
		}
	
		private function Lose():void
		{
			
			//removeChildAt(_platform[_platform.length - 1]);
			//removeChild(_player);
			
			//removeChildren(0, numChildren - 1);
			trace("lose");
			for (var i:int = numChildren-1; i >= 0  ; i--) 
			{
				removeChildAt(i);
				
			}
			win = new TextField();
			addChild(win);
			
			win.text = "Score: " + Score;
			
			win.x = stage.stageWidth / 3 - win.width;
			win.y = stage.stageHeight / 3 - win.height;
			win.scaleX = 20;
			win.scaleY = 20;
			removeEventListener(Event.ENTER_FRAME, gameloop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, reload);
			reload;
			
		}
		
		private function reload(e:KeyboardEvent):void
		{
 			if(e.keyCode == 32 )
			{
				trace("dit moet werken");
				var myLoader:Loader = new Loader(); 
				addChild(myLoader); 
				var url:URLRequest = new URLRequest("Jumpgame.swf"); 
				myLoader.load(url);
				
			}
			removeChild(win);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, reload);
			
		}
		//Voor de timer die score optelt (per seconde)
		private function Done(e:Event):void 
		{
			trace(Score);
			Score += 1;
		}
		
		private function Tik(e:Event):void 
		{
			Score += 1;
		}
		
		//Tekst Scaling 
		private function TextScale(textveld:TextField, ScaleX:Number = 200, ScaleY:Number = 200):void
		{
			textveld.scaleX = ScaleX;
			textveld.scaleY = ScaleY;
		}
		}
	}

