package com.lachhh.lachhhengine.sfx {
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;
	import com.lachhh.lachhhengine.components.JukeboxSfxComponent;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class JukeBox extends Actor {
		static public var SFX_VOLUME:Number = 1;
		static public var MUSIC_VOLUME:Number = 1;
		static public var SFX_MUTED:Boolean = false;
		static public var MUSIC_MUTED:Boolean = false;
		
		static private var instance:JukeBox;
		static public var allMusic:Vector.<JukeboxSfxComponent> = new Vector.<JukeboxSfxComponent>();
		
		static public var currentMusicComponent:JukeboxSfxComponent;
		
		public function JukeBox() {
			instance = this;
			
		}

		override public function removeComponent(component : ActorComponent) : void {
			super.removeComponent(component);
			var sfxComp:JukeboxSfxComponent = component as JukeboxSfxComponent;
			if(sfxComp) {
				for (var i : int = 0; i < allMusic.length; i++) {
					if(allMusic[i] == sfxComp) allMusic.splice(i, 1);
				}
			}
		}
		
		
		override public function addComponent(component : ActorComponent) : ActorComponent {
			var result:ActorComponent = super.addComponent(component);
			var sfxComp:JukeboxSfxComponent = component as JukeboxSfxComponent;
			if(sfxComp) {
				allMusic.push(sfxComp);
			}
			return result;
		}
		
		static public function muteMusic():void {
			
		}
		
		static public function playSound(iSfx:int):JukeboxSfxComponent {
			return playSoundLoop(iSfx, instance, false);
		}
		
		static public function playSoundAtVolume(iSfx:int, vol:Number):JukeboxSfxComponent {
			var sfx:JukeboxSfxComponent = playSoundLoop(iSfx, instance, false);
			sfx.sfxView.volume = vol ;
			sfx.gotoVolume = vol;
			sfx.sfxView.refresh();
			return sfx;
		}
		
		static public function playSoundLoop(iSfx:int, actor:Actor, isLooping:Boolean):JukeboxSfxComponent {
			var result:JukeboxSfxComponent = JukeboxSfxComponent.addToActor(actor, iSfx, false, isLooping);
			return result;
		}
		
		public function encode():Dictionary {
			var o:Dictionary = new Dictionary();
			o.SFX_VOLUME = SFX_VOLUME;
			o.MUSIC_VOLUME = MUSIC_VOLUME;
			o.SFX_MUTED = SFX_MUTED;
			o.MUSIC_MUTED = MUSIC_MUTED;
			
			return o; 
		}
		
		public function decode(obj:Dictionary):void {
			if(obj == null) return ;
			SFX_VOLUME = obj.SFX_VOLUME;
			MUSIC_VOLUME = obj.MUSIC_VOLUME;
			SFX_MUTED = obj.SFX_MUTED;
			MUSIC_MUTED = obj.MUSIC_MUTED;
		}
		
		
		static public function fadeToMusic(iSfx:int, numFrame:int):JukeboxSfxComponent {
			if(currentMusicComponent && currentMusicComponent.sfxView.idSfx == iSfx) return currentMusicComponent;
			
			fadeAllMusicToDestroy(numFrame);
			
			var result:JukeboxSfxComponent = JukeboxSfxComponent.addToActor(instance, iSfx, true, true);
			result.gotoVolume = 1;
			result.gotoVolumeMod = (numFrame <= 0 ? 1 : (1/(numFrame+0.0)));
			result.sfxView.volume = 0;
			result.sfxView.refresh();
			
			currentMusicComponent = result;
			
			return result;
		}
		
		static public function fadeAllMusicToDestroy(numFrame:int):void {
			for (var i : int = 0; i < allMusic.length; i++) {
				var music:JukeboxSfxComponent = allMusic[i];
				music.fadeToDestroy(numFrame);
			}
			currentMusicComponent = null;
		}
		
		static public function getInstance():JukeBox {
			return instance;
		}

	}
}
