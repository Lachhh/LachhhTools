package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.giveawaytool.effect.EffectGotoEaseOut;
	import com.giveawaytool.DefaultMainGame;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.meta.MetaTwitterAlert;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIOpenClose;
	import com.lachhh.utils.Utils;

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author LachhhSSD
	 */
	public class UI_NewTweet extends UIOpenClose {
		private var metaTwitter:MetaTwitterAlert;
		public var callbackOnDestroy:Callback;
		public var goto:EffectGotoEaseOut;
		public function UI_NewTweet(m:MetaTwitterAlert) {
			super(AnimationFactory.ID_FX_TWEET, 10, 25);
			metaTwitter = m;
			px = 1280 - Math.random()*600;
			py = 720;
			renderComponent.animView.fps = 45;
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE);
			JukeBox.playSound(SfxFactory.ID_SFX_NEW_TWEET);
			goto = EffectGotoEaseOut.addToActor(this, px, py);
			goto.ease.x = 0.2;
			goto.ease.y = 0.2;
			refresh();
		}
	
		
		override protected function onIdle() : void {
			super.onIdle();
			var minWait:int = Math.max(3000, metaTwitter.message.length*80);
			CallbackTimerEffect.addWaitCallFctToActor(this, close, minWait);
			if(callbackOnDestroy) callbackOnDestroy.call();
		}
		
		override public function destroy() : void {
			super.destroy();
			if(callbackOnDestroy) callbackOnDestroy.call();
		}
		
		
		private function applyColorToText(tf:TextField, text:String, color:uint ):void {
			if(tf == null) return ;
			if(text == null) return ;
			var startI:int = tf.text.toLowerCase().indexOf(text.toLowerCase()) ;
			var endI:int = startI + text.length ;  
			
			if(startI != -1) { 
				if(startI < tf.text.length) {
					endI = Math.min(endI, tf.text.length);
					var tff:TextFormat = tf.getTextFormat(startI, endI);
					tff.color = color;
					tf.setTextFormat(tff, startI, endI);
				}
			}
		}
		
		override public function refresh() : void {
			super.refresh();
			nameTxt.text = metaTwitter.getNameWithAt();
			msgTxt.text = metaTwitter.message;
			Utils.SetMaxSizeOfTxtField(msgTxt, 24);
			applyColorToText(msgTxt, metaTwitter.searchedFor, 0xFF0000);
		}
		
		
		override public function update() : void {
			super.update();
			if(px > 1280) goto.goto.x -= 20;
			if(px < 680) goto.goto.x += 20;
			
			var output:Array = UIBase.manager.appendAllInstanceOf(UI_NewTweet, new Array());
			
			for (var i : int = 0; i < output.length; i++) {
				var tweet:UI_NewTweet = output[i];
				if(tweet == this) continue;
				var dx:int = px - tweet.px; 
				if(dx > 0 && dx < 400) goto.goto.x += 20;
				if(dx < 0 && dx > -400) goto.goto.x += -20;
			}
		}
		
		static public function closeAllTweets():void {
			var allTweets:Array = new Array();
			allTweets = UIBase.manager.appendAllInstanceOf(UI_NewTweet, allTweets);
			for (var i : int = 0; i < allTweets.length; i++) {
				var ui:UI_NewTweet = allTweets[i];
				ui.close();
			}
		}
		
		
		public function get tweetMc() : MovieClip { return visual.getChildByName("tweetMc") as MovieClip;}
		public function get twitterUpDownMc() : MovieClip { return tweetMc.getChildByName("twitterUpDownMc") as MovieClip;}
		public function get nameTxt() : TextField { return twitterUpDownMc.getChildByName("nameTxt") as TextField;}
		public function get msgTxt() : TextField { return twitterUpDownMc.getChildByName("msgTxt") as TextField;}
	}
}
