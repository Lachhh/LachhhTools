package com.giveawaytool.ui {
	import flash.media.SoundTransform;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.effect.EffectFlashColor;
	import com.giveawaytool.effect.EffectShake;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.views.ViewLoteryNameGroup;
	import com.lachhh.io.Callback;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIOpenClose;

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;

	/**
	 * @author LachhhSSD
	 */
	public class UI_LoterySpin extends UIOpenClose {
		private var viewNamesGroup:ViewLoteryNameGroup ;
		private var animToDestroy:Boolean = false;
		private var hasShaken:Boolean = false;
		private var timer:int = 0;
		private var newWinner:Boolean = false;
		

		public function UI_LoterySpin(arrayOfNames:Array) {
			super(AnimationFactory.ID_UI_LOTERYSPINNING, 335, 340);
			viewNamesGroup = new ViewLoteryNameGroup(this, nameContainer);
			viewNamesGroup.names = arrayOfNames;
			renderComponent.animView.timeBased = true;
		
			var wait:Number = 8000+Math.random()*2000;
			CallbackTimerEffect.addWaitCallFctToActor(this, stopRoulette, wait);
			viewNamesGroup.callbackOnEnd = new Callback(onEnd, this, null);
			viewNamesGroup.callbackOnDestroy = new Callback(startAnimToDestroy, this, null);
			JukeBox.fadeToMusic(SfxFactory.ID_MUSIC_SLOT_MACHINE, 1);
			timer = getTimer();
			
			UI_Overlay.hide();
			
			setTextOnVisual(textMc);
			setTextOnVisual(textShakeTextMc);
			newWinner = false;
			UI_Menu.instance.show(false);
			visual.graphics.beginFill(0x000000);
			visual.graphics.drawRect(0, 0, 1280, 720);
			visual.graphics.endFill();
			
			var st:SoundTransform = visual.soundTransform;
			st.volume = MetaGameProgress.instance.metaGiveawayConfig.metaAnimation.volume;
			visual.soundTransform = st; 
			JukeBox.SFX_VOLUME = MetaGameProgress.instance.metaGiveawayConfig.metaAnimation.volume;
			JukeBox.MUSIC_VOLUME = MetaGameProgress.instance.metaGiveawayConfig.metaAnimation.volume;
		}

		
		private function startAnimToDestroy() : void {
			animToDestroy = true;
			JukeBox.fadeAllMusicToDestroy(300);
			
			if(viewNamesGroup.currentWinner) {
				MetaGameProgress.instance.winners.push(viewNamesGroup.currentWinner.name);
				MetaGameProgress.instance.metaExportPNGConfig.winner = viewNamesGroup.currentWinner.name;
				MetaGameProgress.instance.metaCountdownConfig.target = viewNamesGroup.currentWinner.name;
				newWinner = true;
			}
		}
		
		private function onEnd() : void {
			close();
		}
		
		
		override protected function onIdle() : void {
			super.onIdle();
			viewNamesGroup.createViews();
			refresh();
		}

		private function stopRoulette() : void {
			viewNamesGroup.stop();
		}
		
		
		
		
		override public function update() : void {
			super.update();
			var diff:int = getTimer() - timer;
			var frame:int = (diff/1000)*36;
			if(frame < idleFrame) {
				renderComponent.animView.gotoAndPlay(frame);
				
				if(!hasShaken  && frame > 202) {
					hasShaken = true;
					EffectShake.addToActor(this, 50, 50);
				}
			}
			
			if(animToDestroy) {
				visual.alpha -= 0.01;
				if(visual.alpha <= 0) {
					 backToMenu();
				}
			} else {
				if(KeyManager.IsKeyPressed(Keyboard.ESCAPE)) {
					 skipAnim();
				}
			}
		}

		private function skipAnim() : void {
			backToMenu();
			JukeBox.fadeAllMusicToDestroy(15);
		}
		
		private function backToMenu():void {
		
			var fx:EffectFlashColor  = EffectFlashColor.create(0x000000, 5);
			fx.start();
			destroy();
			var m:UI_GiveawayMenu = new UI_GiveawayMenu();
			UI_Menu.instance.show(true);
			if(newWinner) {
				m.flashNewWinner();	
			}
		}
		
		override public function refresh() : void {
			super.refresh();	
			
		}
		
		private function setTextOnVisual(visual:MovieClip):void {
			var text1Txt : TextField = visual.getChildByName("text1Txt") as TextField;
			var text2Txt : TextField = visual.getChildByName("text2Txt") as TextField;
			text1Txt.text = MetaGameProgress.instance.metaGiveawayConfig.text1;
			text2Txt.text = MetaGameProgress.instance.metaGiveawayConfig.text2;	
		}
		
		public function get nameContainer() : MovieClip { return visual.getChildByName("nameContainer") as MovieClip;}
		
		public function get textMc() : MovieClip { return visual.getChildByName("textMc") as MovieClip;}
		public function get textShakeMc() : MovieClip { return visual.getChildByName("textShakeMc") as MovieClip;}
		public function get textShakeTextMc() : MovieClip { return textShakeMc.getChildByName("textMc") as MovieClip;}
		
		
	}
}
