package com.giveawaytool.fx {
	import com.giveawaytool.effect.EffectRotate;
	import com.giveawaytool.ui.UI_NewCheerAnimExplode;
	import com.lachhh.ResolutionManager;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.MyMath;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.components.RenderComponent;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	/**
	 * @author LachhhSSD
	 */
	public class FxMonster extends Actor {
		static public var shouldBarf : Boolean = false;
		static private var instance : FxMonster;
		private var cheerBitToFollow : Actor;
		private var destroyWhenAllBitGone:Boolean = false;
		private var logicRotate : EffectRotate;
		private var rot : Number = 0;
		private var gotoX : Number = 0;
		 

		public function FxMonster() {
			super();
			UIBase.manager.add(this);
			renderComponent = RenderComponent.addToActor(this, UIBase.defaultUIContainer, AnimationFactory.ID_FX_CHEER_MONSTER_IN);
			animIn();
			renderComponent.animView.scaleX = 0.6;
			renderComponent.animView.scaleY = 0.6;
			px = ResolutionManager.getGameWidth()*0.5;
			py = ResolutionManager.getGameHeight();
			instance = this;
			cheerBitToFollow = null;
			logicRotate = EffectRotate.addToActor(this);
			logicRotate.xDistance = 100;
			logicRotate.speedRotX = 5;
			logicRotate.enabled = false;
		}
		
		private function setCheerToFollow():void {
			cheerBitToFollow = UIBase.manager.getFirst(FxCheerBag) as FxCheerBag;
			if(cheerBitToFollow == null) cheerBitToFollow = getFistBit();
		}
		
		private function getFistBit():FxCheerBit {
			if(FxCheerBit.allBits.length <= 0) return null;
			return FxCheerBit.allBits[FxCheerBit.allBits.length-1];
		}

		override public function update() : void {
			super.update();
			
			rotate();
			if(cheerBitToFollow == null || cheerBitToFollow.destroyed) {
				setCheerToFollow();
				logicRotate.speedRotX = 2;
				if(destroyWhenAllBitGone && cheerBitToFollow == null) {
					animOutToDestroy();
					destroyWhenAllBitGone = false;
				}
				return ;
			}
			logicRotate.speedRotX = 5;
			logicRotate.xDistance = 50;
			logicRotate.speedRotY = 1;
			logicRotate.yDistance = 20;
			destroyWhenAllBitGone = true;
			
			var speed:int = 10;
			gotoX = cheerBitToFollow.px + MyMath.myCos(rot)*100;
			
			px += (gotoX-px)*0.05;
			
			
			checkCheerBitToEat();
		}
		
		private function rotate():void {
			//px -= MyMath.myCos(rot)*50;
			rot += 5;
			if(rot >= 360) rot -= 360;
			//px += MyMath.myCos(rot)*50;
		}

		private function checkCheerBitToEat() : void {
			var hasEnten:Boolean = false;
			for (var i : int = 0; i < FxCheerBit.allBits.length; i++) {
				var a:Actor = FxCheerBit.allBits[i];
				if(!isCheerBitInsideMe(a)) continue ;
				a.destroy();
				hasEnten = true;
			}
			if(hasEnten) animEat();
		}
		
		private function isCheerBitInsideMe(a:Actor) : Boolean {
			if(a.px < px-60) return false;
			if(a.px > px+60) return false;
			if(a.py < py-100) return false;
			return true;
		}

		override public function destroy() : void {
			super.destroy();
			instance = null;
			if(shouldBarf) {
				new UI_NewCheerAnimExplode();
				shouldBarf = false;
			}
		}

		public function animOutToDestroy() : void {
			renderComponent.setAnim(AnimationFactory.ID_FX_CHEER_MONSTER_OUT);
			renderComponent.animView.addEndCallback(new Callback(destroy, this, null));
		}
		
		public function animIn():void {
			renderComponent.setAnim(AnimationFactory.ID_FX_CHEER_MONSTER_IN);
			renderComponent.animView.addEndCallback(new Callback(animIdle, this, null));
		}
		
		public function animIdle():void {
			renderComponent.setAnim(AnimationFactory.ID_FX_CHEER_MONSTER_IDLE);
		}
		
		public function animEat():void {
			if(renderComponent.animView.animId != AnimationFactory.ID_FX_CHEER_MONSTER_EAT) {
				JukeBox.playSoundAtVolume(SfxFactory.ID_SFX_GULP, 0.1);
			}
			
			renderComponent.setAnim(AnimationFactory.ID_FX_CHEER_MONSTER_EAT);
			renderComponent.animView.addEndCallback(new Callback(animIdle, this, null));
			
		}
		
		static public function showMonster():FxMonster {
			 if(instance == null) new FxMonster();
			 return instance;
		}
		
		static public function hideMonster():FxMonster {
			 if(instance == null) new FxMonster();
			 return instance;
		}
		
		static public function addBarfChance():void {
			if(shouldBarf) return ;
			shouldBarf = (Math.random() < 0.1); 
		}
	}
}
