package com.giveawaytool.ui {
	import com.lachhh.utils.Utils;
	import com.giveawaytool.MetaCheerAlert;
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.fx.FxCheerBag;
	import com.giveawaytool.fx.FxMonster;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class UI_NewCheerAnim extends UIBase {
		public var callbackOnFinish : Callback;
		private var metaCheerAlert : MetaCheerAlert;
		static private var tempArray:Array = new Array();
		public function UI_NewCheerAnim(pMetaCheerAlert : MetaCheerAlert) {
			super(AnimationFactory.ID_UI_NEWCHEER);
			
			metaCheerAlert = pMetaCheerAlert;
			
			px = 850 + Math.random()*300;
			py = 503 + Math.random() * 50;
			renderComponent.animView.addEndCallback(new Callback(onEndAnim, this, null));
			renderComponent.animView.addCallbackOnFrame(new Callback(shoot, this, null), 52);
			renderComponent.animView.addCallbackOnFrame(new Callback(soundRobot, this, null), 10);
			FxMonster.addBarfChance();
			FxMonster.showMonster();
			
			
		}

		private function soundRobot() : void {
			Utils.ClearArray(tempArray);
			tempArray = UIBase.manager.appendAllInstanceOf(UI_NewCheerAnim, tempArray);
			if(tempArray.length <= 1) JukeBox.playSoundAtVolume(SfxFactory.ID_SFX_ENTER_CANON, 0.1);
		}

		private function onEndAnim() : void {
			destroy();
		}
		
		private function shoot() : void {
			var cashBag:FxCheerBag = new FxCheerBag(metaCheerAlert);
			cashBag.px = px;
			cashBag.py = py;
			 
			var gotoX:int = (px - Math.random()*200) -500;
			var gotoY:int = (py - Math.random()*100) -250;
			cashBag.gotoPoint(gotoX, gotoY);
			//JukeBox.playSound(SfxFactory.ID_SFX_CANON_3_FIRE);
			//JukeBox.playSoundAtVolume(SfxFactory.ID_SFX_CANON_3_FIRE, 0.3);	
			JukeBox.playSoundAtVolume(SfxFactory.ID_SFX_BOOM_DEEP, 0.25);
		}
	}
}
