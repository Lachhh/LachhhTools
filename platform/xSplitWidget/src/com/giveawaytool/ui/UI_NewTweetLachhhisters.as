package com.giveawaytool.ui {
	import com.giveawaytool.DefaultMainGame;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.effect.EffectGotoEaseOut;
	import com.giveawaytool.meta.MetaTwitterAlert;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.UIOpenClose;
	import com.lachhh.utils.Utils;

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;

	/**
	 * @author LachhhSSD
	 */
	public class UI_NewTweetLachhhisters extends UIOpenClose {
		private var metaTwitter:MetaTwitterAlert;
		public var callbackOnDestroy:Callback;
		public var goto : EffectGotoEaseOut;
		static public var lastTweet:UIBase;

		public function UI_NewTweetLachhhisters(m : MetaTwitterAlert) {
			super(AnimationFactory.ID_FX_TWEET_LACHHHISTER, 10, 25);
			metaTwitter = m;
			px = 1280 - Math.random()*600;
			py = 720;
			renderComponent.animView.fps = 60;
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE);
			//JukeBox.playSound(SfxFactory.ID_SFX_NEW_TWEET_LACHHHISTERS);
			SfxFactory.playRandomTweetLachhisters();
			

			pickGoodPosition();
			refresh();
			lastTweet = this;
		}
		
		public function pickGoodPosition():void{
			 
			
			if(lastTweet != null && lastTweet != this) {
				if(lastTweet.px < (1280-300)) {
					px = lastTweet.px +350+Math.random()*50;
				} else {
					px = lastTweet.px -(500+Math.random()*50);
				}
			} else {
				px = 1280 - Math.random()*600;
			}	
		}
		
		static public function activateAllGoto(b : Boolean) : void {
			var output:Array = UIBase.manager.appendAllInstanceOf(UI_NewTweetLachhhisters, new Array());
			
			for (var i : int = 0; i < output.length; i++) {
				var tweet:UI_NewTweetLachhhisters = output[i];
				tweet.goto.enabled = b;
			}
		}
		
		override protected function onIdle() : void {
			super.onIdle();
			var minWait:int = Math.max(3000, metaTwitter.message.length*80);
			CallbackTimerEffect.addWaitCallFctToActor(this, close, minWait);
			CallbackTimerEffect.addWaitCallFctToActor(this, callNextTweet, 1000+Math.random()*1500);
		}
		
		private function callNextTweet():void {
			if(callbackOnDestroy) callbackOnDestroy.call();
		}
		
		
		override public function close() : void {
			super.close();
			
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
			applyColorToText(msgTxt, metaTwitter.searchedFor, 0xFFFF33);
		}
		
		override public function update() : void {
			super.update();
			refreshGoto();
		}
		
		private function refreshGoto():void {
			if(goto == null) return ;
			if(px > 1280) goto.goto.x -= 50;
			if(px < 680) goto.goto.x += 50;
			
			var output:Array = UIBase.manager.appendAllInstanceOf(UI_NewTweetLachhhisters, new Array());
			
			for (var i : int = 0; i < output.length; i++) {
				var tweet:UI_NewTweetLachhhisters = output[i];
				if(tweet == this) continue;
				var dx:int = px - tweet.px; 
				if(dx > 0 && dx < 400) goto.goto.x += 50;
				if(dx < 0 && dx > -400) goto.goto.x += -50;
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
