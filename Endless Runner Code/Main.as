package src {

 import fl.transitions.Fade;
 import flash.events.Event;
 import flash.events.MouseEvent;
 import flash.events.KeyboardEvent;
 import flash.display.MovieClip;
 import flash.display.Stage;
 import flashx.textLayout.formats.BackgroundColor;
 import flash.utils.Timer;
 import flash.events.TimerEvent;
 import flash.display.Sprite;
 import flash.ui.Mouse;
 import flash.display.DisplayObject;
 import flash.media.Sound;
 import flash.media.SoundChannel;
 import fl.motion.Color;
 import flash.display.DisplayObjectContainer;
  //---VOEG TOE----
 import flash.display.Loader;
 import flash.net.URLRequest;
 import flash.text.TextField;
 import flash.media.SoundTransform;
 //---------------
 
 public class Main extends MovieClip
 {
	 
	//Layers die gebruikt  worden om de objecten op het scherm goed weer te geven
	private var layer1:Sprite = new Sprite();
	private var layer2:Sprite = new Sprite();
	private var layer3:Sprite = new Sprite();
	
	private var healthobj:HealthObj = new HealthObj;
	
	// Voor schieten naar rail
	private var Click_X:int;
	private var Click_Y:int;
	private var gotoRail:Boolean;
	private var onrail:int = 0; 
	
	
	
	private var player = new Player();
	
	// Voor springen
	private var spaceEnabled:int = 0;
	private var jumpForce:Number = 25;
	private var gravity:Number = 10;
	private var geland:Boolean = false;
	//
	
	//Arrays voor de game
	private var template:Array;
	private var background:Array;
	private var coin:Array;
	
	// timers voor als je doodgaat
	private var falltimer:Timer = new Timer(1, 1);
	private var waittimer:Timer = new Timer(3000, 1);
	
	private var hoogtegehaalt:Boolean;
	
	// random variablen voor de templates en achtergrond
	private var randomnum:int;
	private var randomnum2:int;
	
	
	//health
	private var Health:int;
	
	
	// voor Gameover scherm
	private var GG:GameOver;
	private var Score:int;
	private var lose:TextField;
	private var textveld:TextField;
	
	//Movement booleans
	public var left:Boolean = false;
	public var right:Boolean = false;
	public var sprint:Boolean = false;
	private var SprintSpeed = 5;
	private var gravitybool:Boolean;
	// schermen
	private var ss:Startscherm;
	private var infos:Info;
	
	// bools voor animatie
	private var landbool:Boolean;
	private var landing:Boolean;
	private var ducking:Boolean;
	
	//Ingame Geluid
	private var Game_Sound:Sound = new Sound_Game(); 
	private var Menu_Sound:Sound = new Sound_Menu(); 
	private var Walk_Sound:Sound = new Sound_Walk(); 
	private var Dead_Sound:Sound = new Sound_Die(); 
	private var Rail_Sound:Sound = new Sound_Rail();
	private var Hit_Sound:Sound = new Sound_Hit();
	private var Channel:SoundChannel = new SoundChannel();
	private var EffectChannel:SoundChannel = new SoundChannel();
	private var RailChannel:SoundChannel = new SoundChannel();
	private var HitChannel:SoundChannel = new SoundChannel();
	private var muziektrans = new SoundTransform();
	///////////////////////////////
	
	private var railbool:Boolean;
	private var duckint:int;
	public static var _main:Main;
	
	 public function Main() 
	{
		//speel muziek af, spawn het startscherm
		Channel = Menu_Sound.play();
	  ss = new Startscherm();
	  addChild(ss);
	  _main = this;

	}
	public function infoscherm()
	{
		//plaats infoscherm
		trace("addscherm");
		infos = new Info();
		addChild(infos);
	} 
	public function init()
	{
		//Run de game
		Channel.stop();
		Channel = Game_Sound.play();
	//haal startscherm weg
	if (stage.contains(ss)) {
	removeChild(ss);
	}
	//------------------------------
	// Add Layers //
  	stage.addChild(layer1);
	stage.addChild(layer2);
	stage.addChild(layer3);
	//------------------------
	//----// Event listeners enabled //----//

	stage.addEventListener(Event.ENTER_FRAME, Loop);
	stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
	stage.addEventListener(KeyboardEvent.KEY_UP, onKeyReleased);
	stage.addEventListener(MouseEvent.CLICK, ClickRail);
	
	//--------------------------------------------
	// Add 2 walls and templates, put them in a array
	background = new Array();
	template = new Array();
	coin = new Array();
	template.length = 0;
	background.length = 0;
	for (var l:int = 0; l < 3; l++) 
		{
			coin.push(new Coin);
			layer2.addChild(coin[l]);
			coin[l].y = l * 50;
			coin[l].x = l * 800;
		}
	for (var j:int = 0; j < 2; j++)
	{
		background.push(new Background);
		layer1.addChild(background[j]);
		background[j].x = j * 1600;
		background[j].y = 0;
		
		template.push(new Template1);
		layer2.addChild(template[j]);
		template[j].x = j * 1600;
		template[j].y = 0;
	}
	//-------------
	//spawn player
	Health = 100;
	player = new Player();
	stage.addChild(player);
	player.x = 100;
	player.y = 400;
	//
	// gui health fles
	healthobj = new HealthObj;
	layer3.addChild(healthobj);
	healthobj.x = 50;
	healthobj.y = 750;

	EffectChannel = null;
	HitChannel = null;
	player.gotoAndStop("walk");
	muziektrans.volume = 0.5;
	Channel.soundTransform = muziektrans;
	
		
  }

	public function Loop(e:Event)
	{
		//textveld.text = "Score: " + Score;
   
   // als de player zijn health zo laag is.
   switch (Health) {
    case 96:
     healthobj.gotoAndStop(2);
     break;
    case 92:
     healthobj.gotoAndStop(3);
     break;
    case 88:
     healthobj.gotoAndStop(4);
     break;
    case 84:
     healthobj.gotoAndStop(5);
     break;
    case 80:
     healthobj.gotoAndStop(6);
     break;
    case 76:
     healthobj.gotoAndStop(7);
     break;
    case 72:
     healthobj.gotoAndStop(8);
     break;
    case 68:
     healthobj.gotoAndStop(9);
     break;
    case 64:
     healthobj.gotoAndStop(10);
     break;
    case 60:
     healthobj.gotoAndStop(11);
     break;
    case 56:
     healthobj.gotoAndStop(12);
     break;
    case 52:
     healthobj.gotoAndStop(13);
     break;
    case 48:
     healthobj.gotoAndStop(14);
     break;
    case 44:
     healthobj.gotoAndStop(15);
     break;
    case 40:
     healthobj.gotoAndStop(16);
     break;
    case 36:
     healthobj.gotoAndStop(17);
     break;
    case 32:
     healthobj.gotoAndStop(18);
     break;
    case 28:
     healthobj.gotoAndStop(19);
     break;
    case 24:
     healthobj.gotoAndStop(20);
     break;
    case 20:
     healthobj.gotoAndStop(21);
     break;
    case 16:
     healthobj.gotoAndStop(22);
     break;
    case 12:
     healthobj.gotoAndStop(23);
     break;
    case 8:
     healthobj.gotoAndStop(24);
     break;
    case 6:
     healthobj.gotoAndStop(25);
     break;
    case 4:
     healthobj.gotoAndStop(26);
     break;
    case 3:
     healthobj.gotoAndStop(27);
     break;
    case 2:
     healthobj.gotoAndStop(28);
     break;
    case 1:
     healthobj.gotoAndStop(29);
     break;
    case 0:
     healthobj.gotoAndStop(30);
     break;
   }
		// als je dood bent
		if (Health <= 0)
		{
			falltimer.addEventListener(TimerEvent.TIMER, falling);
			waittimer.addEventListener(TimerEvent.TIMER_COMPLETE, gotoGameover);
			falltimer.start();
			waittimer.start();
		}
		// de loop van de muntjes
				for (var l:int = 0; l < 3; l++) 
				{
					coin[l].x -= 12;
					if (coin[l].y <= 350)
					{
						coin[l].y += l * 200;
					}
					if (coin[l].y <= 900)
					{
						coin.y = l + 1 * 550;
					}
					if (coin[l].x <= -1600)
					{
						coin[l].x += 3200 ;
					}
					if (coin[l].hitTestObject(player))
					{
						Score += 10;
						coin[l].x = l + 1600 * l;
					}
				}
				//-------------------------------------
				//als je bukt
		if (ducking && geland) {
			player.gotoAndStop("duck");
			
		}
		//
		//als je gevallen bent.
		if (player.y >= 800)
		{
			falltimer.addEventListener(TimerEvent.TIMER, falling);
			waittimer.addEventListener(TimerEvent.TIMER_COMPLETE, gotoGameover);
			falltimer.start();
			waittimer.start();
		}
		
		onrail = 0;
		
			for (var k:int = 0; k < template.length; k++) 
			{	
				if (template[k].rail.hitTestPoint(player.x, player.y, true)) {
					player.gotoAndStop("rail");
					if (railbool) {
						RailChannel = Rail_Sound.play();
						railbool = false;
					}
					onrail++;					
					gotoRail = false;
					
				}
				if (template[k].ground1.hitTestPoint(player.x + 100,player.y + 50,true))
				{
					player.x -= 8;
					right = false;
				}
				if (template[k].ball.hitTestPoint(player.x,player.y - duckint,true)) {
					Health--;
					if (HitChannel == null) {
					HitChannel = Hit_Sound.play(); 
					playHit();
				}
				}
				if (template[k].spike.hitTestObject(player)) {
					Health--;
					if (HitChannel == null) {
					HitChannel = Hit_Sound.play(); 
					playHit();
				}
				}
				if (template[k].spear.hitTestObject(player)) {
					Health--;
					if (HitChannel == null) {
					HitChannel = Hit_Sound.play(); 
					playHit();
				}
				}
				if (template[k].ground1.hitTestPoint(player.x,player.y + 100,true))
			{	
				if (EffectChannel == null) {
					EffectChannel = Walk_Sound.play(); 
				playMusic();
				}
				railbool = true;
				geland = true;
				if(!gotoRail && !ducking){
				player.gotoAndStop("walk");
				}
				player.y -= gravity;
				
			}
				
				
			}
			
			
			// als je richting de rail gaat
			if (onrail == 0 && !gotoRail)
			{
				player.y += gravity;
				RailChannel.stop();
			}
			// als je er nog niet op bent
			if (gotoRail && onrail == 0) {
				landbool = true;
				player.x += (Click_X - player.x) / 10;
				player.y += (Click_Y - player.y) / 10;
			}
		
			// voor movement
		if ( left && !right ) {
				player.x -= SprintSpeed;
			}
			if ( right && !left ) {
				player.x += SprintSpeed;
			}
		if (sprint)
			{
				SprintSpeed = 3;
			}
			else
			{
				SprintSpeed = 13;
			}
			////
			// Voor Springen
			if (onKeyPressed && spaceEnabled == 1 && geland == true)
			{	
			player.gotoAndStop("tojump");
			geland = false;
			jumpForce = 25;
			player.y -= 20;
			}
		else if(jumpForce > 0)
			{
			jumpForce--;
			hoogtegehaalt = true;
			}
			//
	// aply gravity	
	player.y -= jumpForce;
		
		// Move the Walls
		for each (var bg in background) {
			bg.x -= 10;
			if (bg.x <= -1600) {
				
				
				background.splice(background.indexOf(bg), 1);
				addWall();
			}
		}
		//------------------------------------------------------
		// Move the floor
		for each (var temp in template) {
			temp.x -= 10;
			if (temp.x <= -1600) {
				template.splice(template.indexOf(temp), 1);
				addTemp();
			}
		}
		
		//--------------------------------------------
	}
	public function falling(e:TimerEvent):void {
		player.gotoAndStop("dead");
		stage.removeEventListener(Event.ENTER_FRAME, Loop);
		stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPressed);
		stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyReleased);
		stage.removeEventListener(MouseEvent.CLICK, ClickRail);
	}	
	public function gotoGameover(e:TimerEvent):void {
		// verwijder alles.
	falltimer.removeEventListener(TimerEvent.TIMER, falling);
	falltimer.removeEventListener(TimerEvent.TIMER_COMPLETE, gotoGameover);
	Channel.stop();
	for (var i:int = 0; i < template.length; i++)
	{
	if (stage.contains(template[i])) {
	layer2.removeChild(template[i]);
	}
	}
	for (var n:int = 0; n < background.length; n++)
	{
	if (stage.contains(background[n])) {
	layer1.removeChild(background[n]);
	}
	}
	
	for (var l:int = 0; l < 3; l++) 
	{
		if (stage.contains(coin[l]))
		{
			layer2.removeChild(coin[l]);
		}
	}
	stage.removeChild(player);
	Lose();
	}
	// als je op de rail klikt
	private function ClickRail(MouseEvent) {
			for (var i:Number = 0; i < template.length; i++) {
				// if mouse hit rail
			
				if (template[i].rail.hitTestPoint(mouseX, mouseY, false)) {
					if (template[i].rail.x + template[i].x + template[i].rail.width >= player.x) {
					gotoRail = true;
					player.gotoAndStop("jumprail");
					Click_X = mouseX;
					Click_Y = mouseY;
					geland = false;
					}
				}
			}
				
				if (onrail != 0) {
					onrail = 0;
					gotoRail = false;
				}
			}
	// als je de knop loslaat.
	public function onKeyReleased(e:KeyboardEvent){
		switch( e.keyCode )
			{
				case 65:
					left = false;
					break;
 
				case 68:
					right = false;
					break;
				case 16:
					sprint = false;
					break;
				case 83:
					ducking = false;
					duckint = 100;
				break;	
				case 32:
					spaceEnabled = 0;
					break;
			}
	}
	// voegt een template toe.
	public function addTemp():void {
		var j = template.length;
		randomnum = Math.floor(Math.random() * 10) + 1;
		trace(randomnum);
		switch( randomnum )
			{
				case 1:
					template.push(new Template1);
					break;
					
 
				case 2:
					template.push(new Template2);
					break;
					
					
				case 3:
					template.push(new Template3);
					break;
					
				case 4:
					template.push(new Template4);
					break;
					
				case 5:
					template.push(new Template5);
					break;
					
				case 6:
					template.push(new Template6);
					break;
					
				case 7:
					template.push(new Template7);
					break;
					
				case 8:
					template.push(new Template8);
					break;
					
				case 9:
					template.push(new Template9);
					break;
					
				case 10:
					template.push(new Template10);
					break;
				
			}
		
		layer1.addChild(template[j]);
		template[j].x = 1600;
		template[j].y = 0;
		
	}
	// voeg wall toe.
	public function addWall():void {
		var j = background.length;
		randomnum2 = Math.floor(Math.random() * 2) + 1;
		trace(randomnum2);
		switch( randomnum2 )
			{
				case 1:
					background.push(new Background);
					break;
					
 
				case 2:
					background.push(new BackgroundOpen);
					break;
			}
		layer1.addChild(background[j]);
		background[j].x = 1600;
		background[j].y = 0;
		
	}
	// voor gameover
		public function Lose():void
				{
					   
					   GG = new GameOver();
					   addChild(GG);
						lose = new TextField();
						addChild(lose);
					   
						lose.text = "Score: " + Score;
						lose.textColor = 0xFFFFFF;
						lose.x = stage.stageWidth / 3 - lose.width;
						lose.y = 500;
						lose.scaleX = 20;
						lose.scaleY = 20;
						removeEventListener(Event.ENTER_FRAME, Loop);
					   
					   
					   
				}
			    // herstart het spel
				public function reload():void
				{
								removeChild(GG);
								removeChild(lose);
								trace("dit moet werken");
								var myLoader:Loader = new Loader();
								addChild(myLoader);
								var url:URLRequest = new URLRequest("Endless runner.swf");
								myLoader.load(url);
							   
						removeChild(lose);
					   addChild(ss);
					   
				}
				//--------------------------------------------------------------------------------
	public function onKeyPressed(e:KeyboardEvent){
	  switch( e.keyCode )
			{
				case 65:
					left = true;
					break;
 
				case 68:
					right = true;
					break;
					
				case 16:
					sprint = true;
					break;
				
				case 32:
					spaceEnabled = 1;
					break;
				case 83:
					ducking = true;
					duckint = -100;
				break;
			}
	}
	public function playMusic():void{
    EffectChannel.addEventListener(Event.SOUND_COMPLETE, loopMusic);
	}
	public function loopMusic(e:Event):void{
    if (EffectChannel != null)
    {
    EffectChannel.removeEventListener(Event.SOUND_COMPLETE, loopMusic);
	EffectChannel = null;
    }
	}
	public function getDammage() {
	playHit();
	Health--;
	}
	public function playHit():void {
		trace("sound");
    HitChannel.addEventListener(Event.SOUND_COMPLETE, loopHit);
	}
	public function loopHit(e:Event):void{
    if (HitChannel != null)
    {
    HitChannel.removeEventListener(Event.SOUND_COMPLETE, loopHit);
	HitChannel = null;
    }
	}
 }			
}