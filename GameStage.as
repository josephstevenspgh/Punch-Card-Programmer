package{
	import org.flixel.*;
	import flash.ui.Keyboard;
	
	import flash.events.Event;
	import Playtomic.*;
	import flash.events.KeyboardEvent;
	import flash.external.ExternalInterface;	 

 
	public class GameStage extends FlxState{
		//graphics
		[Embed(source="Visual/StageBG.png")] protected var ImgBG:Class;
		[Embed(source="Visual/StageBG2.png")] protected var ImgBG2:Class;
		
	
		private var BackgroundGroup:FlxGroup;
		private var SpriteGroup:FlxGroup;
		private var CardChunkGroup:FlxGroup;
		private var StatusGroup:FlxGroup;
		
		private var StageNumber:uint = 0;
		
		//Status BS
		private var TimeLeft:Number = 1000;
		private var Score:uint = 0;
		private var Bonus:Number = 0;
		private var MissCount:uint = 0;

		public function GameStage(StageNum:uint = 0):void{
			StageNumber = StageNum;
		}
		
		override public function create():void{
			initGame();
		}			
		
		private function DrawCardChunk():void{
			CardChunk.stamp(SpriteGroup.members[0].FullCard, 0, 0 - SpriteGroup.members[0].height);
			CardChunk.x = SpriteGroup.members[0].x;
			CardChunk.y = 189-16;
			CardChunk.alpha = 1;
			CardChunk.angle = 0;
			CardChunkDirection = CurA;
		}
		
		
		//this is the update() function
		override public function update():void{
			//Check for player actions, if a hit, send it to the punch card
			var CurA:uint = SpriteGroup.members[2].CurrentAction;
			if(CurA > 0 && CurA < 5){
				if(SpriteGroup.members[0].Ready){
					if(SpriteGroup.members[0].Hit(CurA)){
						//Draw CardChunk
						DrawCardChunk();
						//Increase Score
						Score += (100 + Bonus);
						Bonus += 10;
						
						//Update HUD
						StatusGroup.members[3].text = Score;
						StatusGroup.members[5].text = Bonus;
					}else{
						//Reset Bonus
						Bonus = 0;
						MissCount++;
						FlxG.log("Miss Count: "+MissCount);
					}
				}
			}
			//Move CardChunk around if you have to.
			if(CardChunk.y >= 0){
				switch(CardChunkDirection){
					case 1:
						CardChunk.y++;
						CardChunk.x -= 2;
						CardChunk.angle -= 3;
						CardChunk.alpha -= 0.025;
						break;
					case 2:
						CardChunk.y++;
						CardChunk.x--;
						CardChunk.angle -= 2;
						CardChunk.alpha -= 0.025;
						break;
					case 3:
						CardChunk.y++;
						CardChunk.x++;
						CardChunk.angle += 2;
						CardChunk.alpha -= 0.025;
						break;
					case 4:
						CardChunk.y++;
						CardChunk.x += 2;
						CardChunk.angle += 3;
						CardChunk.alpha -= 0.025;
						break;
				}
			}
			//Decrease Time
			TimeLeft -= FlxG.elapsed;
			StatusGroup.members[1].text = int(TimeLeft);
			//Decrease Bonus
			Bonus -= FlxG.elapsed*10;
			if(Bonus <= 0){
				Bonus = 0;
			}
			StatusGroup.members[5].text = int(Bonus);
			super.update();
		}
		
		
		
		
		protected function initGame():void{		
			//Group Initialization
			BackgroundGroup	= new FlxGroup();
			SpriteGroup		= new FlxGroup();
			StatusGroup		= new FlxGroup();
			CardChunkGroup	= new FlxGroup();
			
			//Background
			BackgroundGroup.add(new FlxSprite(0, 0, ImgBG2));
			BackgroundGroup.add(new FlxSprite(0, 0, ImgBG));
			//Borders
			var BlackRectangle:FlxSprite = new FlxSprite();
			BlackRectangle.makeGraphic(72, 240, 0xFF202020);
			BackgroundGroup.add(BlackRectangle);
			BlackRectangle = new FlxSprite();
			BlackRectangle.makeGraphic(72, 240, 0xFF202020);
			BlackRectangle.x = FlxG.width - BlackRectangle.width;
			BackgroundGroup.add(BlackRectangle);
			
			//Sprites
			SpriteGroup.add(new PunchCard(StageNumber));
			CardChunk = new FlxSprite();
			CardChunk.makeGraphic(5*16, 16, 0x00ffffff);
			SpriteGroup.add(CardChunk);
			SpriteGroup.add(new LittleJoe());
			
			//Status
			StatusGroup.add(new FlxText(0, 16, 72, "Time"));
			StatusGroup.add(new FlxText(0, 36, 72, "1000"));
			StatusGroup.add(new FlxText(FlxG.width-72, 16, 72, "Score"));
			StatusGroup.add(new FlxText(FlxG.width-72, 36, 72, "0"));
			StatusGroup.add(new FlxText(FlxG.width-72, 60, 72, "Bonus"));
			StatusGroup.add(new FlxText(FlxG.width-72, 80, 72, "0"));
			StatusGroup.members[0].setFormat(null, 16, 0xffffff, "center", 0xff000000);
			StatusGroup.members[1].setFormat(null, 8, 0xffffff, "center", 0xff000000);
			StatusGroup.members[2].setFormat(null, 16, 0xffffff, "center", 0xff000000);
			StatusGroup.members[3].setFormat(null, 8, 0xffffff, "center", 0xff000000);
			StatusGroup.members[4].setFormat(null, 16, 0xffffff, "center", 0xff000000);
			StatusGroup.members[5].setFormat(null, 8, 0xffffff, "center", 0xff000000);
			
			
			add(BackgroundGroup);
			add(SpriteGroup);
			add(StatusGroup);
			FlxG.log("Background Done");
		}		
	}
}
