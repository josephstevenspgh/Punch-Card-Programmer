package{
	import org.flixel.*;
	import flash.ui.Keyboard;
	
	import flash.events.Event;
	import Playtomic.*;
	import flash.events.KeyboardEvent;
	import flash.external.ExternalInterface;	 

 
	public class GameState extends FlxState{
		//graphics
		[Embed(source="PCP.png")] protected var ImgTitleBG:Class;
	
		private var BackgroundGroup:FlxGroup;
		private var TitleGroup:FlxGroup;
	
		//this handles initializing everything
		override public function create():void{	
			//Logging - FIXME
			if(ExternalInterface.available && ExternalInterface.objectID != null){
				//Log.View(4010, "2e2246c47d3b445d", ExternalInterface.call('window.location.href.toString'));
			}
			
			//this is now a title screen
			initGame();
		}
		
		private function Continue():void{
			var NextStage:GameStage = new GameStage(1);
			FlxG.switchState(NextStage);
		}
		
		
		//this is the update() function
		override public function update():void{		
			if(FlxG.keys.justPressed("X")){
				Continue();
			}
			super.update();
		}
		
		protected function initGame():void{
		
			//Group Initialization
			BackgroundGroup	= new FlxGroup();
			BackgroundGroup.add(new FlxSprite(0, 0, ImgTitleBG));
			//create background
			
			TitleGroup = new FlxGroup();
			var asdf:FlxText = new FlxText(FlxG.width/2, FlxG.height - 40, FlxG.width/2, "A prototype Action/Rythm Game!");
			asdf.alignment = "center";
			asdf.shadow = 0xFF000000;
			asdf.color = 0xFFFFFF00;
			TitleGroup.add(asdf);
			asdf = new FlxText(FlxG.width/2, FlxG.height - 20, FlxG.width/2, "http://www.splixel.com");
			asdf.alignment = "center";
			asdf.shadow = 0xFF000000;
			asdf.color = 0xFFFFFF00;
			TitleGroup.add(asdf);
			asdf = new FlxText(0, 20, FlxG.width, "PUNCH CARD");
			asdf.alignment = "center";
			asdf.shadow = 0xFF000000;
			asdf.color = 0xFFFFFF00;
			asdf.size = 24;
			TitleGroup.add(asdf);
			asdf = new FlxText(0, 50, FlxG.width, "PROGRAMMER");
			asdf.alignment = "center";
			asdf.shadow = 0xFF000000;
			asdf.color = 0xFFFFFF00;
			asdf.size = 32;
			TitleGroup.add(asdf);
			asdf = new FlxText(0, FlxG.height/2, FlxG.width, "Press X to start");
			asdf.alignment = "center";
			asdf.color = 0xFFFFFF00;
			asdf.shadow = 0xFF000000;
			asdf.size = 16;
			TitleGroup.add(asdf);
			
			add(BackgroundGroup);
			add(TitleGroup);
		}		
	}
}
