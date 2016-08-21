package com.lachhh.lachhhengine.sfx {
	import com.starterkit.exported.sfx.*;

	import flash.media.Sound;
	/**
	 * @author LachhhSSD
	 */
	public class SfxFactory {
		static public var allSoundClass:Vector.<Class> = new Vector.<Class>();
		static public var ID_MUSIC_METAL:int = pushClassLink(MUSIC_METAL);
		static public var ID_MUSIC_INTRO:int = pushClassLink(MUSIC_INTRO);
		
		static public var ID_SFX_BURP:int = pushClassLink(SFX_BURP);
		static public var ID_SFX_ENTER_CANON:int = pushClassLink(SFX_ENTER_CANON);
		static public var ID_SFX_BOOM_DEEP:int = pushClassLink(SFX_BOOM_DEEP);
		static public var ID_SFX_BEEP:int = pushClassLink(SFX_BEEP);
		static public var ID_SFX_CANON_3_FIRE:int = pushClassLink(SFX_CANON_3_FIRE);
		static public var ID_SFX_GULP:int = pushClassLink(SFX_GULP);
		static public var ID_SFX_FLYING_CURRENCY_2:int = pushClassLink(SFX_FLYING_CURRENCY_2);
		static public var ID_SFX_FLYING_CURRENCY_3:int = pushClassLink(SFX_FLYING_CURRENCY_3);
		static public var ID_SFX_FLYING_CURRENCY_4:int = pushClassLink(SFX_FLYING_CURRENCY_4);
		static public var ID_SFX_HIT_KRAKEN:int = pushClassLink(SFX_HIT_KRAKEN);
		static public var ID_SFX_HIT_KRAKEN_2:int = pushClassLink(SFX_HIT_KRAKEN_2);
		static public var ID_SFX_FLYING_CURRENCY_1:int = pushClassLink(SFX_FLYING_CURRENCY_1);
		
		static public var ID_SFX_UI_MEGAPUNCH_02:int = pushClassLink(SFX_UI_MEGAPUNCH_02);
		static public var ID_SFX_UI_MEGAPUNCH_03:int = pushClassLink(SFX_UI_MEGAPUNCH_03);
		static public var ID_SFX_UI_MEGAPUNCH_01:int = pushClassLink(SFX_UI_MEGAPUNCH_01);
		
		static public var ID_SFX_UI_MEDAL_MINIGAME:int = pushClassLink(SFX_UI_MEDAL_MINIGAME);
		static public var ID_SFX_WORKSHOP_MEGA_UPGRADE:int = pushClassLink(SFX_WORKSHOP_MEGA_UPGRADE);
		static public var ID_SFX_CROWD:int = pushClassLink(SFX_CROWD);
		static public var ID_SFX_FLAMER_START:int = pushClassLink(SFX_FLAMER_START);
		static public var ID_SFX_FORGE:int = pushClassLink(SFX_FORGE);
		static public var ID_SFX_INGAME_DOOR:int = pushClassLink(SFX_INGAME_DOOR);
		static public var ID_SFX_MEDAL_POP:int = pushClassLink(SFX_MEDAL_POP);
		static public var ID_SFX_UI_DOOR_OPEN:int = pushClassLink(SFX_UI_DOOR_OPEN);
		static public var ID_SFX_TRANSITION_WOOSH_04:int = pushClassLink(SFX_TRANSITION_WOOSH_04);
		static public var ID_SFX_TRANSITION_WOOSH_01:int = pushClassLink(SFX_TRANSITION_WOOSH_01);
		static public var ID_SFX_TRANSITION_WOOSH_02:int = pushClassLink(SFX_TRANSITION_WOOSH_02);
		static public var ID_SFX_UI_BONUS_BEEP:int = pushClassLink(SFX_UI_BONUS_BEEP);
		static public var ID_SFX_SPARKLES:int = pushClassLink(SFX_SPARKLES);
		static public var ID_SFX_CHILD_YAY:int = pushClassLink(SFX_CHILD_YAY);
		static public var ID_SFX_NEW_HOST:int = pushClassLink(SFX_NEW_HOST);
		
		static public var ID_SFX_TRANSITION_WOOSH_03:int = pushClassLink(SFX_TRANSITION_WOOSH_03);
		static public var ID_SFX_UI_BUY:int = pushClassLink(SFX_UI_BUY);
		static public var ID_SFX_UI_REWARD_SMALL:int = pushClassLink(SFX_UI_REWARD_SMALL);
		static public var ID_SFX_UPGRADE_SIMPLE:int = pushClassLink(SFX_UPGRADE_SIMPLE);
		static public var ID_SFX_NOOOOOO:int = pushClassLink(SFX_NOOOOOO);
		

		static public var ID_SFX_CANON:int = pushClassLink(SFX_CANON);
		static public var ID_SFX_WEAPON_AIRSTRIKE:int = pushClassLink(SFX_WEAPON_AIRSTRIKE);
		static public var ID_SFX_WEAPON14_DINO:int = pushClassLink(SFX_WEAPON14_DINO);
		static public var ID_SFX_BIG_EXPLOSION:int = pushClassLink(SFX_BIG_EXPLOSION);
		static public var ID_SFX_GAZ:int = pushClassLink(SFX_GAZ);
		static public var ID_SFX_TING:int = pushClassLink(SFX_TING);
		static public var ID_SFX_CHALLENGE_BELL:int = pushClassLink(SFX_CHALLENGE_BELL);
		static public var ID_SFX_NEW_TWEET:int = pushClassLink(SFX_NEW_TWEET);
		static public var ID_SFX_NEW_TWEET_LACHHHISTERS:int = pushClassLink(SFX_NEW_TWEET_LACHHHISTERS);
		static public var ID_SFX_NEW_TWEET_LACHHHISTERS_2:int = pushClassLink(SFX_NEW_TWEET_LACHHHISTERS_2);
		static public var ID_SFX_NEW_TWEET_LACHHHISTERS_3:int = pushClassLink(SFX_NEW_TWEET_LACHHHISTERS_3);

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
		
		static public function playRandomTweetLachhisters():void {
			var r:Number = Math.random();
			if(r < 0.33) {JukeBox.playSound(ID_SFX_NEW_TWEET_LACHHHISTERS); return; }
			if(r < 0.66) {JukeBox.playSound(ID_SFX_NEW_TWEET_LACHHHISTERS_2); return; }
			JukeBox.playSound(ID_SFX_NEW_TWEET_LACHHHISTERS_3); 
		}
		
		static public function playRandomMusic():void {
		/*	var ingameMusic:Array = [ID_MUSIC_INGAME_1, ID_MUSIC_INGAME_2, ID_MUSIC_INGAME_3];
			Utils.RemoveFromArray(ingameMusic, lastIngameMusic);
			var id:int = ingameMusic[Math.floor(Math.random()*ingameMusic.length)];
			JukeBox.fadeToMusic(id, 60);
			lastIngameMusic = id;*/
		}

		static public function playRandomFlyingCurreny(vol : Number) : void {
			var r:Number = Math.random();
			if(r < 0.5) {JukeBox.playSoundAtVolume(ID_SFX_FLYING_CURRENCY_2, vol); return; }
			JukeBox.playSoundAtVolume(ID_SFX_FLYING_CURRENCY_4, vol); 
		}
		
		static public function playRandomHitKraken(vol : Number):void {
			var r:Number = Math.random();
			if(r < 0.5) {JukeBox.playSoundAtVolume(ID_SFX_HIT_KRAKEN, vol); return; }
			JukeBox.playSoundAtVolume(ID_SFX_HIT_KRAKEN, vol); 
		}
		
		static public function playRandomMegaHit(vol : Number):void {
			var r:Number = Math.random();
			if(r < 0.33) {JukeBox.playSoundAtVolume(ID_SFX_UI_MEGAPUNCH_01, vol); return; }
			if(r < 0.66) {JukeBox.playSoundAtVolume(ID_SFX_UI_MEGAPUNCH_02, vol); return; }
			JukeBox.playSoundAtVolume(ID_SFX_UI_MEGAPUNCH_03, vol); 
		}
		
	}
}
