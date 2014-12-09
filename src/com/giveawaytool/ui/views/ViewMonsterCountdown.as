package com.giveawaytool.ui.views {
	import com.giveawaytool.effect.EffectFadeOut;
	import com.giveawaytool.effect.EffectKickBack;
	import com.giveawaytool.effect.EffectScaleBackTo1;
	import com.giveawaytool.effect.LogicDestroyOutsideOfBounds;
	import com.giveawaytool.effect.LogicRotate;
	import com.giveawaytool.effect.ui.EffectShakeUI;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.animation.FlashAnimationView;
	import com.lachhh.lachhhengine.components.PhysicComponent;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.UIEffect;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewMonsterCountdown extends ViewBase {
		public var animView : FlashAnimationView;
		public var name : String = "";
		public var prct : Number = 0;	
		private var startBloodAndGoreAnim : Boolean = false;
		static private var END_X:int = -272.7;
		static private var START_X:int = -75.9;
		
		
		
		public function ViewMonsterCountdown(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			animView = new FlashAnimationView(visual);
			setAnim(AnimationFactory.ID_FX_MONSTER_EAT_IDLE);
			prct = 0;
			monsterIdleMc.x = START_X;
		}
		
		public function setAnim(animId:int):void {
			animView.setAnim(animId);
			refresh();
		}
		
		public function setBeaten(cFinish:Callback):void {
			if(!isIdle()) return;
			//var x:int = monsterM
			var x:int = 0;
			if(monsterIdleMc) {
				x = monsterIdleMc.x; 
			}
			JukeBox.fadeAllMusicToDestroy(1);
			JukeBox.playSound(SfxFactory.ID_MUSIC_COUNTDOWN_BEATEN); 
			setAnim(AnimationFactory.ID_FX_MONSTER_EAT_BEATEN);
			animView.isLooping = false;
			animView.addEndCallback(cFinish);
			
			for (var i:int = 0; i < 30; i+=3) {
				animView.addCallbackOnFrame(new Callback(playExplosion, this, null), 170+i*2);	
			}
			
			for (i = 205; i < 280; i+=5) {
				animView.addCallbackOnFrame(new Callback(spewBunchOfGore, this, [3]), i);	
			}
			
			for (i = 325; i < 700; i+=1) {
				animView.addCallbackOnFrame(new Callback(createGoreRain, this, null), i);	
			}
			
			if(monsterIdleMc) {
				monsterIdleMc.x = x;
			}
			prct = 1;
		}
		
		private function playExplosion():void {
			SfxFactory.playRandomExplosion();
		}
		
		public function setEat(cFinish:Callback):void {
			if(!isIdle()) return;
			JukeBox.fadeAllMusicToDestroy(15);
			setAnim(AnimationFactory.ID_FX_MONSTER_EAT_EAT);
			animView.isLooping = false;
			animView.addEndCallback(cFinish);
			var i :int = 0;
			for (i = 65; i < 155; i+=10) {
				animView.addCallbackOnFrame(new Callback(spewBunchOfGore, this, [15]), i);	
			}
			
			
			var arrayOfLetters:Array = [];
			for (i = 0; i < name.length; i++) {
				arrayOfLetters.push(name.substr(i, 1));	
			}
			arrayOfLetters.sort(randomize);
			
			for (i = 0; i < arrayOfLetters.length; i++) {
				animView.addCallbackOnFrame(new Callback(spewLetter, this, [5+i, arrayOfLetters[i]]), 179+i*2);	
			}
			
			
			startBloodAndGoreAnim = true;
		}
				
		private function randomize ( a : *, b : * ) : int {
		    return ( Math.random() > .5 ) ? 1 : -1;
		}
		
		public function spewBunchOfGore(n:int):void{
			for (var i : int = 0; i < n; i++) {
				spewGore(n);
			}
		}
		
		public function spewLetter(force:int, letter:String):void{ 
			var fx:UIEffect = createParticule(AnimationFactory.ID_FX_LETTER);
			
			fx.physicComponent.vx = Math.random()*-20 -force*2;
			fx.physicComponent.vy = -8+Math.random()*10;
			var tf:TextField = fx.renderComponent.animView.anim.getChildByName("txt") as TextField;
			tf.text = letter;
			EffectShakeUI.addToActor(screen, screen.visual, 15, 15);
			
		}
		
		public function spewGore(force:int):void{
			var animId:int = (Math.random() < 0.5 ? AnimationFactory.ID_FX_GORE_RANDOM01 : AnimationFactory.ID_FX_BLOODPARTICLE_RANDOM); 
			var fx:UIEffect = createParticule(animId);
			
			fx.physicComponent.vx = Math.random()*-20 -force*2;
			fx.physicComponent.vy = -4+Math.random()*10;
			
		}
		
		private function createParticule(animId:int):UIEffect {
			var parentMc:MovieClip = (Math.random() < 0.5 ? backFxMc : foreFxMc);
			var fx:UIEffect = UIEffect.createStaticUiFx(animId, 0, 0);
			fx.renderComponent.animView.addChildOnNewParent(parentMc);
			var frameRandom:int = Math.ceil(fx.renderComponent.animView.getNbFrames()*Math.random());
			fx.renderComponent.animView.gotoAndStop(frameRandom);
			fx.physicComponent = PhysicComponent.addToActor(fx);
			fx.physicComponent.gravY = 1;
			fx.px = Math.random()*40-20;
			fx.py = Math.random()*100-50;
			
			LogicRotate.addToActor(fx);
			var d:LogicDestroyOutsideOfBounds = LogicDestroyOutsideOfBounds.addToActorBasedOnUI(fx);
			d.bounds.x -= 1000;
			d.bounds.width += 1000;
			return fx;
		}
		
		private function createGoreRain():UIEffect {
			var animId:int = (Math.random() < 0.5 ? AnimationFactory.ID_FX_GORE_RANDOM01 : AnimationFactory.ID_FX_BLOODPARTICLE_RANDOM);
			var parentMc:MovieClip = bloodRainMc;
			var fx:UIEffect = UIEffect.createStaticUiFx(animId, 0, 0);
			fx.renderComponent.animView.addChildOnNewParent(parentMc);
			var frameRandom:int = Math.ceil(fx.renderComponent.animView.getNbFrames()*Math.random());
			fx.renderComponent.animView.gotoAndStop(frameRandom);
			fx.physicComponent = PhysicComponent.addToActor(fx);
			fx.physicComponent.gravY = 1;
			fx.px = Math.random()*1280-640;
			fx.py = Math.random()*-100-50;
			
			LogicRotate.addToActor(fx);
			var d:LogicDestroyOutsideOfBounds = LogicDestroyOutsideOfBounds.addToActorBasedOnUI(fx);
			d.bounds.x -= 1000;
			d.bounds.width += 1000;
			return fx;
		}
	

		override public function destroy() : void {
			super.destroy();
			animView.destroy();
		}
		
		override public function update() : void {
			super.update();
			animView.update();
			checkForGore();
			
			if(monsterIdleMc) {
				var diff:int = END_X - START_X;
				var goto:int = prct*diff+START_X; 
				
				monsterIdleMc.x += (goto-monsterIdleMc.x)*0.1;
			}
		}
		
		private function checkForGore():void {
			if(startBloodAndGoreAnim == false) return;
			if(animView.getCurrentFrame() > 54 && animView.getCurrentFrame() < 154) {
				spewBunchOfGore(1);
			}
		}
		
		
		
		override public function refresh() : void {
			super.refresh();
			if(nameMc && nameTxt) nameTxt.text = name;
			if(nameRotateMc) nameRotateTxt.text = name;	
		}
		
		public function isIdle():Boolean  {
			return (animView.animId == AnimationFactory.ID_FX_MONSTER_EAT_IDLE);
		}
		
		public function get nameRotateMc() : MovieClip { return animView.anim.getChildByName("nameRotateMc") as MovieClip;}
		public function get nameRotateMc2() : MovieClip { return nameRotateMc.getChildByName("nameMc") as MovieClip;}
		public function get nameRotateTxt() : TextField { return nameRotateMc2.getChildByName("nameTxt") as TextField;}
		
		public function get nameMc() : MovieClip { return animView.anim.getChildByName("nameMc") as MovieClip;}
		public function get nameTxt() : TextField { return nameMc.getChildByName("nameTxt") as TextField;}
		
		
		public function get foreFxMc() : MovieClip { return animView.anim.getChildByName("foreFxMc") as MovieClip;}
		public function get backFxMc() : MovieClip { return animView.anim.getChildByName("backFxMc") as MovieClip;}
		public function get bloodRainMc() : MovieClip { return animView.anim.getChildByName("bloodRainMc") as MovieClip;}
		public function get monsterIdleMc() : MovieClip { return animView.anim.getChildByName("monsterIdleMc") as MovieClip;}
		
		
		
	}
}
