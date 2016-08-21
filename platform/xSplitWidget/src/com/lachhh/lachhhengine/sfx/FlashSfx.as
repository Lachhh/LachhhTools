package com.lachhh.lachhhengine.sfx {
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.utils.Utils;
	import avmplus.getQualifiedClassName;

	import com.lachhh.lachhhengine.VersionInfo;

	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	/**
	 * @author Lachhh
	 */
	public class FlashSfx {		 
		public var sound:Sound ;
		public var looping:Boolean = false;
		public var volume:Number = 1;
		public var startTime:Number = 0;
		public var debugSoundName:String = "";
		public var idSfx:int = -1;
		private var _soundTransform:SoundTransform ;
		private var _oldVolume:Number = 1;
		private var _isMusic:Boolean;
		private var _isPlaying:Boolean = false;
		private var _hasFinishedPlaying:Boolean = false;
		private var _soundChannel:SoundChannel = null;
		
		
		public function FlashSfx(s:Sound, pIsMusic:Boolean){
			_isMusic = pIsMusic;
			sound = s;
			_soundTransform = new SoundTransform(getTotalVolume());
			_oldVolume = _soundTransform.volume;
			
			if(VersionInfo.isDebug) {
				debugSoundName = FlashUtils.mySplit(FlashUtils.myGetQualifiedClassName(sound), "::")[1]; 
			}
			
		}
		
		public function destroy():void {
			 stop();
			 _soundChannel = null;
			 sound = null;
		}
		
		public function play():void {
			if(_isPlaying) return ;
			_soundChannel = sound.play(startTime, (looping ? int.MAX_VALUE : 1), _soundTransform);
			_hasFinishedPlaying = false;
			if(_soundChannel) {
				_isPlaying = true;
				if(!looping) {
					_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				}
			}
		}
		
		private function onSoundComplete(e:Event):void {
			if(!looping) {
				_hasFinishedPlaying = true;
			}
		}
		
		public function refresh():void {
			if(volume > 1) volume = 1;
			if(volume < 0) volume = 0;
			var totalVolume:Number = volume*getTotalVolume();
			if(_oldVolume != totalVolume) {
				_oldVolume = totalVolume;
				_soundTransform.volume = totalVolume;
				if(_soundChannel) _soundChannel.soundTransform = _soundTransform; 
			}
		}
		
		public function stop():void {
			if(!_isPlaying) return ;
			if(_soundChannel) {
				_soundChannel.stop();
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			}
			
			_isPlaying = false;
		}
		
		public function getTotalVolume():Number {
			if(isMusic) return (JukeBox.MUSIC_MUTED ? 0 : volume*JukeBox.MUSIC_VOLUME);
			return (JukeBox.SFX_MUTED ? 0 : volume*JukeBox.SFX_VOLUME); 
		}
		
		public function get isMusic():Boolean { return _isMusic ;}
		public function get isSfx():Boolean { return !_isMusic ;}

		public function get isPlaying() : Boolean {
			return _isPlaying;
		}

		public function get hasFinishedPlaying() : Boolean {
			return _hasFinishedPlaying;
		}				
	}
}


