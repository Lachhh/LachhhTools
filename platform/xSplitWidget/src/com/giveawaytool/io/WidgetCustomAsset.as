package com.giveawaytool.io {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class WidgetCustomAsset {
		public var assetLoader : WidgetCustomAssetLoader;
		public var dataPath:String;
		private var callbackOnFinishPlay : Callback;
		private var values : Dictionary;
		
		public function WidgetCustomAsset(pDataPath:String) {
			assetLoader = new WidgetCustomAssetLoader(pDataPath);
			dataPath = pDataPath;
		}

		public function isEquals(pDataPath : String) : Boolean {
			return dataPath == pDataPath;
		}
		
		public function showAnim(pValues:Dictionary, cOnFinish:Callback):void {
			values = pValues;
			callbackOnFinishPlay = cOnFinish;
			if (assetLoader.isLoaded) {
				play();
			} else {
				assetLoader.loadAssets(new Callback(play, this, null));
			}
		}
		
		public function getMyAnim():DisplayObject {
			return assetLoader.content;
		}

		private function play() : void {
			var d:DisplayObject = getMyAnim();
			var m:MovieClip = d as MovieClip;
			if(m) {
				m.gotoAndPlay(1);
				var st:SoundTransform = m.soundTransform;
				st.volume = JukeBox.SFX_VOLUME;
				m.soundTransform = st; 
			}
			assetLoader.content["values"] = values;
			MainGame.instance.addChild(assetLoader.content);
			addTimerBasedOnContent();
		}
		
		public function addTimerBasedOnContent():void {
			var d:DisplayObject = getMyAnim();
			var m:MovieClip = d as MovieClip;
			if (m && m.totalFrames > 1) {
				addTimerForMovieClip(m);
			} else {
				addTimer(5);
			}
		}

		private function addTimer(numSec : int) : void {
			CallbackTimerEffect.addWaitCallFctToActor(MainGame.dummyActor, triggerAnimComplete, 1000*numSec);
		}

		private function addTimerForMovieClip(m : MovieClip) : void {
			CallbackWaitEffect.addWaitCallFctToActor(MainGame.dummyActor, triggerAnimComplete, m.totalFrames);	
		}
		
		public function triggerAnimComplete():void {
			if(callbackOnFinishPlay) callbackOnFinishPlay.call();
			removeAndStop();
		}
		
		public function removeAndStop():void {
			var d:DisplayObject = getMyAnim();
			var m:MovieClip = d as MovieClip;
			Utils.LazyRemoveFromParent(d);
			m.gotoAndStop(1);
		}
		
		static public function createAsset(dataPath : String) : WidgetCustomAsset {
			var result:WidgetCustomAsset = new WidgetCustomAsset(dataPath);
			return result;
		}
	}
}
