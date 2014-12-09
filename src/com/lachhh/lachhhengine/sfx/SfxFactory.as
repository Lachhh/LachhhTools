package com.lachhh.lachhhengine.sfx {
	import com.starterkit.exported.sfx.*;

	import flash.media.Sound;
	/**
	 * @author LachhhSSD
	 */
	public class SfxFactory {
		static public var allSoundClass:Vector.<Class> = new Vector.<Class>();
		static public var ID_MUSIC_SLOT_MACHINE:int = pushClassLink(MUSIC_SLOT_MACHINE);
		static public var ID_MUSIC_COUNTDOWN_BEATEN:int = pushClassLink(MUSIC_COUNTDOWN_BEATEN);
		static public var ID_MUSIC_COUNTDOWN_WAIT:int = pushClassLink(MUSIC_COUNTDOWN_WAIT);
		
		static public var ID_SFX_UI_SLOT_MACHINE_BEEP_2:int = pushClassLink(SFX_UI_SLOT_MACHINE_BEEP_2);
		static public var ID_SFX_UI_MEDAL_MINIGAME:int = pushClassLink(SFX_UI_MEDAL_MINIGAME);
		static public var ID_SFX_CROWD:int = pushClassLink(SFX_CROWD);

		static public var ID_FX_MONSTER_GROWL:int = pushClassLink(FX_MONSTER_GROWL);
		static public var ID_SFX_EXPLOSION_1:int = pushClassLink(SFX_EXPLOSION_1);
		static public var ID_SFX_EXPLOSION:int = pushClassLink(SFX_EXPLOSION);

		
		static public function pushClassLink(pClass:Class):int {
			allSoundClass.push(pClass);
			return (allSoundClass.length-1);
		}
		
		static public function createSound(iSfx:int):Sound {
			var theClass:Class = allSoundClass[iSfx];
			var result:Sound = new theClass();
			return result; 
		}
		
		static public function onClickSound():void {
			//JukeBox.playSound(ID_SFX_ROLLOVER);			
		}
		
		static public function playRandomExplosion():void {
			var r:Number = Math.random();
			if(r < 0.5) { JukeBox.playSound(ID_SFX_EXPLOSION_1); return ;}
			if(r < 1) { JukeBox.playSound(ID_SFX_EXPLOSION); return ;}
			

		}
		
		static public function playRandomMusic():void {
		/*	var ingameMusic:Array = [ID_MUSIC_INGAME_1, ID_MUSIC_INGAME_2, ID_MUSIC_INGAME_3];
			Utils.RemoveFromArray(ingameMusic, lastIngameMusic);
			var id:int = ingameMusic[Math.floor(Math.random()*ingameMusic.length)];
			JukeBox.fadeToMusic(id, 60);
			lastIngameMusic = id;*/
		}

	}
}
