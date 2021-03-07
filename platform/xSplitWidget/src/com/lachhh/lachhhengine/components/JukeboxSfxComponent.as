package com.lachhh.lachhhengine.components {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.sfx.FlashSfx;
	import com.lachhh.lachhhengine.sfx.SfxFactory;

	import flash.media.Sound;

	/**
	 * @author LachhhSSD
	 */
	public class JukeboxSfxComponent extends ActorComponent {
		public var sfxView:FlashSfx;
		public var gotoVolume:Number = 1 ;
		public var gotoVolumeMod:Number = 0.01;
		
		private var destroyOnZeroVolume:Boolean = false;
		public function JukeboxSfxComponent(sound:Sound, isMusic:Boolean) {
			super();
			sfxView = new FlashSfx(sound, isMusic);
			debugInfo = (isMusic ? "MUSIC:": "SFX:") + "> " + sfxView.debugSoundName;
		}
				
		override public function destroy() : void {
			super.destroy();
			sfxView.destroy();
		}
		
		public function fadeToDestroy(nFrames:int):void {
			destroyOnZeroVolume = true;
			fadeTo(0, nFrames);
		}
		
		public function fadeTo(volume:Number, nFrames:int):void {
			gotoVolume = volume;
			gotoVolumeMod = (1/(nFrames+0.0));
		}
		
		public function play():void {
			if(destroyed) return ;
			sfxView.play();
		}
		
		public function stop():void {
			if(destroyed) return ;
			sfxView.stop();	
		}
		
		
		override public function update() : void {
			super.update();
			updateVolume();
			checkIfMustDestroy();
		}
		
		private function updateVolume():void {
			if(sfxView.volume > gotoVolume) {
				sfxView.volume -= gotoVolumeMod;
			} else if(sfxView.volume < gotoVolume) {
				sfxView.volume += gotoVolumeMod;
			}
		}
		
		private function checkIfMustDestroy():void {
			var needToDestroy:Boolean = sfxView.hasFinishedPlaying || (destroyOnZeroVolume && sfxView.volume <= 0);
			if(needToDestroy) {
				destroyAndRemoveFromActor();
			} else {
				sfxView.refresh();
			}
		}
		
		static public function addToActor(actor:Actor, iSfx:int, isMusic:Boolean, looping:Boolean):JukeboxSfxComponent {
			var sound:Sound = SfxFactory.createSound(iSfx);
			
			var result:JukeboxSfxComponent = new JukeboxSfxComponent(sound, isMusic);
			result.sfxView.idSfx = iSfx;
			result.sfxView.looping = looping;
			result.sfxView.play();
			
			actor.addComponent(result);
			return result;
		}
	}
}
