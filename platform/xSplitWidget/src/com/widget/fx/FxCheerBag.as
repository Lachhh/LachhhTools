package com.giveawaytool.fx {
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.giveawaytool.DefaultMainGame;
	import com.lachhh.io.Callback;
	import com.giveawaytool.MainGame;
	import com.giveawaytool.MetaCheerAlert;
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.effect.EffectBlinking;
	import com.giveawaytool.effect.EffectGotoEaseOut;
	import com.giveawaytool.effect.LogicRotate;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.components.PhysicComponent;
	import com.lachhh.lachhhengine.components.RenderComponent;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.UIEffect;

	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class FxCheerBag extends Actor {
		public var metaCheer : MetaCheerAlert ;

		public function FxCheerBag(metaCheerAlert : MetaCheerAlert) {
			super();
			metaCheer = metaCheerAlert;
			UIBase.manager.add(this);
			renderComponent = RenderComponent.addToActor(this, UIBase.defaultUIContainer, AnimationFactory.ID_FX_CHEER_BAG);
			renderComponent.animView.sendToBack();
			physicComponent = PhysicComponent.addToActor(this);
			CallbackWaitEffect.addWaitCallFctToActor(this, blink, 30);
			var l : LogicRotate = LogicRotate.addToActor(this);
			l.rotateSpeed = 5 + Math.random() * 5;
		}

		override public function destroy() : void {
			super.destroy();
		}

		private function blink() : void {
			EffectBlinking.addToActor(this, 60, 0xFFFFFF);
			CallbackWaitEffect.addWaitCallFctToActor(this, explode, 30);
			//JukeBox.playSound(SfxFactory.ID_SFX_BEEP);
			if(metaCheer.numBits >= 100) {
				JukeBox.playSoundAtVolume(SfxFactory.ID_SFX_BEEP, 0.25);
			}
		}
		
		public function explode():void {
			
			
			animBitExplosion();
			animNameExplosion();
			destroy();
		}

		private function animBitExplosion() : void {
			var amountSmall:int = metaCheer.numBits/10;
			var amountBig:int = metaCheer.numBits;
			var delay:int = 20;
			if(metaCheer.numBits >= 10000) {
				animBitExplosionSingle(amountSmall, px, py);
				animBitExplosionSingleWithDelay(delay, amountSmall);
				animBitExplosionSingleWithDelay(delay*2, amountSmall);
				animBitExplosionSingleWithDelay(delay*3, amountSmall);
				animBitExplosionSingleWithDelay(delay*4, amountBig);
				FxMonster.shouldBarf = true;
			} else if(metaCheer.numBits >= 5000) {
				animBitExplosionSingle(amountSmall, px, py);
				animBitExplosionSingleWithDelay(delay, amountSmall);
				animBitExplosionSingleWithDelay(delay*2, amountSmall);
				animBitExplosionSingleWithDelay(delay*3, amountBig);
				FxMonster.shouldBarf = true;
			} else if(metaCheer.numBits >= 1000) {
				animBitExplosionSingle(amountSmall, px, py);
				animBitExplosionSingleWithDelay(delay, amountSmall);
				animBitExplosionSingleWithDelay(delay*2, amountBig);
				FxMonster.addBarfChance();
				FxMonster.addBarfChance();
				FxMonster.addBarfChance();
			} else if(metaCheer.numBits >= 100) {
				animBitExplosionSingle(amountSmall, px, py);
				animBitExplosionSingleWithDelay(delay, amountBig);
				FxMonster.addBarfChance();
			} else {
				animBitExplosionSingle(metaCheer.numBits, px, py);
			}
		}
		
		private function animBitExplosionSingleWithDelay(delay:int, amount:int) : void {
			CallbackWaitEffect.addWaitCallbackToActor(MainGame.dummyActor, new Callback(animBitExplosionSingle, this, [amount, px+Math.random()*150-75, py+Math.random()*150-60]), delay);
		}
		
		private function animBitExplosionSingle(amount:int, x:int, y:int) : void {
			FxCheerBit.setRandomForce();
			UIEffect.createStaticUiFx(AnimationFactory.ID_FX_CHEER_EXPLODE, x, y);
			FxCheerBit.createBitExplosion(amount, x, y);
			if(amount >= 100) {
				JukeBox.playSoundAtVolume(SfxFactory.ID_SFX_SPARKLES, 0.25);
			}
			SfxFactory.playRandomFlyingCurreny(0.25);
			SfxFactory.playRandomMegaHit(0.25);
			
		}
		
		private function animNameExplosion():void {
			if(metaCheer == null) return;
			var nameFx:UIEffect = UIEffect.createStaticUiFx(AnimationFactory.ID_FX_CHEER_NAME, px, py);
			nameFx.renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE);
			
			var nameTxt:TextField = getNameTxt(nameFx);
			var bitsTxt:TextField = getBitsTxt(nameFx);
			
			if(nameTxt) nameTxt.text = metaCheer.name;
			if(bitsTxt) bitsTxt.text = metaCheer.getBitsText();
				
			
		}
		
		private function getNameTxt(nameFx : UIEffect) : TextField {
			if (nameFx.renderComponent.animView.anim == null) return null;
			var nameMc : MovieClip = nameFx.renderComponent.animView.anim.getChildByName("nameMc") as MovieClip;
			if(nameMc == null) return null;
			return nameMc.getChildByName("nameTxt") as TextField; 
		}
		
		private function getBitsTxt(nameFx : UIEffect) : TextField {
			if (nameFx.renderComponent.animView.anim == null) return null;
			var nameMc : MovieClip = nameFx.renderComponent.animView.anim.getChildByName("nameMc") as MovieClip;
			if(nameMc == null) return null;
			return nameMc.getChildByName("bitsTxt") as TextField; 
		}

		public function gotoPoint(gotoX : int, gotoY : int) : void {
			var fx:EffectGotoEaseOut = EffectGotoEaseOut.addToActor(this, gotoX, gotoY);
			fx.ease.x = 0.05;
			fx.ease.y = 0.05;
			
			
			/*physicComponent.vx = Math.random() * -2 -7;
			physicComponent.vy = Math.random() * -5 -5;
			physicComponent.gravY = 0.2;*/
		}
	}
}
