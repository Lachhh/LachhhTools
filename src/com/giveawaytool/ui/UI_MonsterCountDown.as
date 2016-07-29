package com.giveawaytool.ui {
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import com.giveawaytool.DefaultMainGame;
	import flash.events.KeyboardEvent;
	import com.giveawaytool.MainGame;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.effect.EffectFadeOut;
	import com.giveawaytool.effect.EffectFlashColor;
	import com.giveawaytool.effect.EffectFlashColorFadeIn;
	import com.giveawaytool.effect.EffectScaleBackTo1;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.views.ViewMonsterCountdown;
	import com.lachhh.io.Callback;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	/**
	 * @author LachhhSSD
	 */
	public class UI_MonsterCountDown extends UIBase {
		
		public var countDown:int = 30;
		public var countDownStart:int = 30;
		public var quickMsg:String = "";
		public var viewMonsterCountdown:ViewMonsterCountdown;
		
		public function UI_MonsterCountDown() {
			super(AnimationFactory.ID_UI_MONSTER_COUNTDOWN);
			viewMonsterCountdown = new ViewMonsterCountdown(this, monsterEatMc);
			viewMonsterCountdown.name = MetaGameProgress.instance.metaCountdownConfig.target;
			
			CallbackTimerEffect.addWaitCallFctToActor(this, tick, 1000);
			
			countDown = MetaGameProgress.instance.metaCountdownConfig.countdown;
			countDownStart = countDown ;
			quickMsg = MetaGameProgress.instance.metaCountdownConfig.text1;
			//UI_Overlay.hide();
			renderComponent.animView.fps = 60;
			
			
			JukeBox.fadeToMusic(SfxFactory.ID_MUSIC_COUNTDOWN_WAIT, 1);
			
			var fx:EffectFlashColor = EffectFlashColor.create(0xFFFFFF, 15);
			fx.start();
			
			refresh();
			
			//visual.stage.focus = visual.stage;

			//visual.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			DefaultMainGame.UI_CONTAINER_ABOVE_NO_CLICK.visible = false;
			//registerClick(visual.stage, saveTheGuy);
			visual.buttonMode = true;
			visual.stage.focus = visual.stage;
		}

		private function onClick(event : MouseEvent) : void {
			backToMenu();
		}
		
		
		override public function start() : void {
			super.start();
		}		
		
		private function tick():void {
			countDown--;
			if(countDown > 0) {
				viewMonsterCountdown.prct = 1-((countDown-1)/countDownStart);
				CallbackTimerEffect.addWaitCallFctToActor(this, tick, 1000);
				refreshCountDown();
				JukeBox.playSound(SfxFactory.ID_SFX_UI_SLOT_MACHINE_BEEP_2);
			} else {
				endTimer();
			}
		}
		
		private function endTimer():void {
			
			viewMonsterCountdown.setEat(new Callback(animToBackToMenu, this, null));
			refresh();
		}
		
		private function backToMenu():void {
			JukeBox.fadeAllMusicToDestroy(15);
			destroy();
			new UI_GiveawayMenu();
			var fx:EffectFlashColor = EffectFlashColor.create(0, 10);
			fx.start();
		}
		
		private function animToBackToMenu():void {
			 EffectFlashColorFadeIn.create(0, 10, new Callback(backToMenu, this, null));
			 JukeBox.fadeAllMusicToDestroy(15);
		}
		
		private function refreshCountDown():void {
			countDowntxt.text = countDown + "";
			EffectScaleBackTo1.addToActorWithSpecificMc(this, countDownMc, 2, 2);
			EffectFadeOut.addToActorWithSpecificMc(this, countDownMc, 5, 0xFF0000);
		}
		
		override public function refresh() : void {
			super.refresh();
	  		quickLbl.visible = (countDown > 0);
			countDownMc.visible = (countDown > 0);
			quickLblTxt.text = quickMsg;
			refreshCountDown();
		}
		
		public function saveTheGuy():void {
			if(!inputEnabled) return;
			inputEnabled = false;
			viewMonsterCountdown.setBeaten(new Callback(animToBackToMenu, this, null));
			countDownMc.visible = false;
			quickLbl.visible = false;	
			countDown = 0;
			
			viewMonsterCountdown.animView.addCallbackOnFrame(new Callback(showBackground, this, [false]), 90);
			viewMonsterCountdown.animView.addCallbackOnFrame(new Callback(showBackground, this, [true]), 263);
		}

		private function showBackground(b:Boolean) : void {
			back.visible = b;
		}
		
		override public function update() : void {
			super.update();
			
			if(!inputEnabled) return ;
			if(KeyManager.IsKeyPressed(Keyboard.ESCAPE)) {
				backToMenu();
			} else if(KeyManager.IsAnyKeyPressed()) {
				saveTheGuy();
			}
		}
		
		public function get quickLbl() : MovieClip { return visual.getChildByName("quickLbl") as MovieClip;}
		public function get quickLbl2() : MovieClip { return quickLbl.getChildByName("quickLbl2") as MovieClip;}
		public function get quickLblTxt() : TextField { return quickLbl2.getChildByName("txt") as TextField;}
		public function get countDownMc() : MovieClip { return visual.getChildByName("countDownMc") as MovieClip;}
		public function get countDowntxt() : TextField { return countDownMc.getChildByName("txt") as TextField;}
		public function get monsterEatMc() : MovieClip { return visual.getChildByName("monsterEatMc") as MovieClip;}
		public function get back() : MovieClip { return visual.getChildByName("back") as MovieClip;}
		
		
	}
	
}
