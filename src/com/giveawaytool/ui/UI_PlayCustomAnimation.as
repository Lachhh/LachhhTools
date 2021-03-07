package com.giveawaytool.ui {
	import com.giveawaytool.MainGameTools;
	import com.giveawaytool.effect.EffectFlashColor;
	import com.giveawaytool.effect.EffectFlashColorFadeIn;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaSelectAnimation;
	import com.lachhh.io.Callback;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.SwfLoaderManager;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.media.SoundTransform;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;

	/**
	 * @author LachhhSSD
	 */
	public class UI_PlayCustomAnimation extends UIBase {
		public var metaSelectAnimation : MetaSelectAnimation;
		public var loadedSwf:DisplayObjectContainer;
		public var values:Dictionary;
		public var back:Sprite;
		public function UI_PlayCustomAnimation(pAnimation:MetaSelectAnimation, pValues:Dictionary) {
			super(AnimationFactory.EMPTY);
			metaSelectAnimation = pAnimation;
			values = pValues;
			
			visual.stage.focus = MainGameTools.instance;
			SwfLoaderManager.loadSwf(metaSelectAnimation.pathToSwf, new Callback(onSwfLoaded, this, null), new Callback(onSwfLoadedError, this, null));
			UI_Menu.instance.show(false);
		}

		override public function update() : void {
			super.update();
			if(!inputEnabled) return ;
			//if(KeyManager.IsMousePressed()) {
				//visual.stage.focus = null;
			//}
			
			if(KeyManager.IsKeyPressed(Keyboard.ESCAPE)) {
				animToBackToMenu();
				enableAllClicks(false);
			}
		}


		override public function destroy() : void {
			
			if(back) {
				Utils.LazyRemoveFromParent(back);
				back = null;	
			}
			
			if(loadedSwf) {
				var mc:MovieClip = loadedSwf as MovieClip;
				if(mc) {
					mc.gotoAndStop(1);
					var s:SoundTransform = new SoundTransform();
					s.volume = 0;
					mc.soundTransform = s;	
				}
				
				
				
				loadedSwf.removeEventListener(KeyboardEvent.KEY_DOWN, KeyManager.keyDownHandler);
				try {
					Utils.LazyRemoveFromParent(loadedSwf);
				} catch(e:Error) {
					trace(e);
				}
				loadedSwf = null;
			}
			super.destroy();
		}
		
		private function onSwfLoaded(o:Object):void {
			loadedSwf = o as DisplayObjectContainer;
			if(loadedSwf) {
				loadedSwf["values"] = values;
				visual.addChild(loadedSwf);
				loadedSwf.addEventListener(KeyboardEvent.KEY_DOWN, KeyManager.keyDownHandler);
				loadedSwf.addEventListener("countdownFail", onCountdownFail);
				loadedSwf.addEventListener("countdownWin", onCountdownWin);
				loadedSwf.addEventListener("giveawayComplete", giveawayComplete);
				var loadedMc:MovieClip = loadedSwf as MovieClip;
				if(loadedMc) { 
					var st:SoundTransform = loadedMc.soundTransform;
					st.volume = metaSelectAnimation.volume;
					loadedMc.soundTransform = st;
				} 
			}
			
			MainGameTools.instance.stage.focus = null;
		}

		private function onCountdownFail(event : Event) : void {
			backToMenu();
		}

		private function onCountdownWin(event : Event) : void {
			backToMenu();
		}
		
		private function giveawayComplete(e:DataEvent):void {
			//var winner:String = e.currentTarget.spinnerScene.theTV.currentWinner.nMC.nameTxt.text;
			var winner:String = e.data;
			trace(winner);
			MetaGameProgress.instance.winners.push(winner);
			MetaGameProgress.instance.metaExportPNGConfig.winner = winner;
			MetaGameProgress.instance.metaCountdownConfig.target = winner;
			backToMenu();
		}
		
		private function onSwfLoadedError():void {
			UI_PopUp.createOkOnly("Couldn't load the swf :(", null);
			backToMenu();
		}
		
		private function backToMenu():void {
			destroy();
			new UI_GiveawayMenu();
			UI_Menu.instance.show(true);
			var fx:EffectFlashColor = EffectFlashColor.create(0, 10);
			fx.start();
		}
		
		private function animToBackToMenu():void {
			 EffectFlashColorFadeIn.create(0, 10, new Callback(backToMenu, this, null));
			 JukeBox.fadeAllMusicToDestroy(15);
		}
		

	}
}
