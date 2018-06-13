package com.giveawaytool.ui {
	import com.giveawaytool.DefaultMainGame;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.effect.EffectFadeInAlpha;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class UI_News extends UIBase {
		public var logicInfernaxBossExplode : LogicInfernaxBossExplode;
		private var allNewsNonPG:Array = [ AnimationFactory.ID_FX_NEWS_6_CHARITYMOUSTACHE, AnimationFactory.ID_FX_NEWS_7_ZOMBIDLE, AnimationFactory.ID_FX_NEWS_3_WHOISLACHHH, AnimationFactory.ID_FX_NEWS_4_JSB, AnimationFactory.ID_FX_NEWS_1_FOLLOWMSG];
		private var allNewsPG:Array = [AnimationFactory.ID_FX_NEWS_7_ZOMBIDLEPG13, AnimationFactory.ID_FX_NEWS_3_WHOISLACHHH, AnimationFactory.ID_FX_NEWS_4_JSB, AnimationFactory.ID_FX_NEWS_1_FOLLOWMSGADOBE];
		private var allNews:Array = allNewsNonPG;
		private var WAIT_BETWEEN_NEWS:Number = 60000*5;
		static private var index:int = -1;

		public function UI_News() {
			super(0);
			
			renderComponent.animView.isLooping = false;
			if(VersionInfo.isPG13) allNews = allNewsPG;
			if(VersionInfo.charityOnly) {
				allNews = [AnimationFactory.ID_FX_NEWS_6_CHARITYMOUSTACHE];
				nextRoll();
			} else {
				CallbackTimerEffect.addWaitCallFctToActor(this, nextRoll, 2000);
			}
			
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_BELOW);
		}
		
		private function nextRoll():void {
			index++;
			if(index >= allNews.length) index = 0;
			setAnim(allNews[index]);
			
			if(!VersionInfo.charityOnly) { 
				CallbackTimerEffect.addWaitCallFctToActor(this, fadeToNext, WAIT_BETWEEN_NEWS);
			}
		}
		
		private function fadeToNext():void {
			var fade:EffectFadeInAlpha = EffectFadeInAlpha.addToActor(this);
			fade.callbackOnEnd = new Callback(nextRoll, this, null);
		}
		
		public function fadeToDestroy():void {
			if(renderComponent.animView.animId == 0) {
				destroy();
				return ;
			}
			
			removeComponent(getComponent(EffectFadeInAlpha));
			
			var fade:EffectFadeInAlpha = EffectFadeInAlpha.addToActor(this);
			fade.callbackOnEnd = new Callback(destroy, this, null);
		}
		
		private function setAnim(animId:int):void {
			renderComponent.setAnim(animId);
			if(animId == AnimationFactory.ID_FX_NEWS_2_INFERNAX) {
				//renderComponent.animView.gotoAndPlay(200);
				renderComponent.animView.addCallbackOnFrame(new Callback(explodeInfernaxBoss, this, null), 505);
			}
		}
		
		private function explodeInfernaxBoss():void {
			LogicInfernaxBossExplode.burstOfBones(this);
		}
		
		static public function closeAllNews():void {
			var uiNews:UI_News = UIBase.manager.getFirst(UI_News) as UI_News;
			if(uiNews) uiNews.fadeToDestroy();
		}
	}
}


