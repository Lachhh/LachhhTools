package com.giveawaytool.meta {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.effect.EffectGotoEaseOutUI;
	import com.lachhh.flash.FlashAnimation;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.components.JukeboxSfxComponent;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaPlayMovie {
		static public var NULL:MetaPlayMovie = new MetaPlayMovie();
		public var movieName:String;
		
		private var saveData : Dictionary = new Dictionary();

		public function MetaPlayMovie() {
		}
		
		public function clear():void {
			movieName = "";
		}
		
		public function getIdFromName():int {
			switch(movieName) {
				case "JustDoIt" : return AnimationFactory.ID_FLV_JUSTDOIT;
				case "VanDammeHit" : return AnimationFactory.ID_FLV_VANDAMME_HIT;
				case "VanDammeExplode" : return AnimationFactory.ID_FLV_VANDAMME_EXPLODE;
				case "VanDammeCover" : return AnimationFactory.ID_FLV_VANDAMMECOVER;
				case "VanDammeShoot" : return AnimationFactory.ID_FLV_VANDAMMESHOOT;
				case "DealWithIt" : return AnimationFactory.ID_FLV_DEALWITHIT;
				case "MrThompson" : return AnimationFactory.ID_FLV_THOMPSON;
				case "ItsOver9000" : return AnimationFactory.ID_FLV_ITSOVER9000;
			}
			return AnimationFactory.ID_FLV_VANDAMMECOVER;
		}
	

		public function encode():Dictionary {
			saveData["movieName"] = movieName;
			return saveData;
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			movieName = loadData["movieName"];
		}
		
		static public function createDummy():MetaPlayMovie {
			var result:MetaPlayMovie = new MetaPlayMovie();
			result.movieName = "JustDoIt";
			return result;
		}

		public function setPositionOfMovie(flv : FlashAnimation) : void {
			if(playInSmallCornerRight()){
				flv.scaleX = 0.5;
				flv.scaleY = 0.5;
				flv.x = 1280*0.5;
				flv.y = 720*0.5;
				var e:EffectGotoEaseOutUI = EffectGotoEaseOutUI.addToActor(MainGame.dummyActor, flv.x, flv.y, flv);
				flv.y += 360;
				
				e.ease.x = 0.3;
				e.ease.y = 0.3;
			}
			
			if (getIdFromName() == AnimationFactory.ID_FLV_ITSOVER9000) {
				CallbackWaitEffect.addWaitCallbackToActor(MainGame.dummyActor, new Callback(playSound, this, [SfxFactory.ID_SFX_NOOOOOO, 0.75]), 75);
				CallbackWaitEffect.addWaitCallbackToActor(MainGame.dummyActor, new Callback(playSound, this, [SfxFactory.ID_SFX_CANON, 1]), 75);
				CallbackWaitEffect.addWaitCallbackToActor(MainGame.dummyActor, new Callback(playSound, this, [SfxFactory.ID_SFX_BIG_EXPLOSION, 1]), 75);
			}
		}

		private function playSound(id:int, vol:Number) : void {
			var s:JukeboxSfxComponent = JukeBox.playSound(id);
			s.sfxView.volume = 0.5;
		}
		
		private function playFullScreen():Boolean {
			if(getIdFromName() == AnimationFactory.ID_FLV_DEALWITHIT) return true;
			if(getIdFromName() == AnimationFactory.ID_FLV_THOMPSON) return true;
			if(getIdFromName() == AnimationFactory.ID_FLV_ITSOVER9000) return true;
			return false;
		}
		
		private function playInSmallCornerRight():Boolean {
			return !playFullScreen();
		}

		public function fadeOut(flv : FlashAnimation, c:Callback) : void {
			var e:EffectGotoEaseOutUI;
			if(playFullScreen()) {
				if(getIdFromName() == AnimationFactory.ID_FLV_DEALWITHIT || getIdFromName() == AnimationFactory.ID_FLV_ITSOVER9000) {
					e = EffectGotoEaseOutUI.addToActor(MainGame.dummyActor, 1280, 0, flv);
					e.ease.x = 0.3;
					e.ease.y = 0.3;
					e.callbackOnEnd = c;
				}
				
				return ;
			}
			e = EffectGotoEaseOutUI.addToActor(MainGame.dummyActor, 0, 720, flv);
			e.ease.x = 0.3;
			e.ease.y = 0.3;
			e.callbackOnEnd = c;
		}
	}
}
