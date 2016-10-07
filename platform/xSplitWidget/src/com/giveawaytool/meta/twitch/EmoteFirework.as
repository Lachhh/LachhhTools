package com.giveawaytool.meta.twitch {
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.giveawaytool.effect.ui.EffectShakeConstantUI;
	import com.giveawaytool.effect.ui.EffectShakeUI;
	import com.giveawaytool.fx.GameEffectPlayOnce;
	import com.giveawaytool.fx.GameEffect;
	import com.lachhh.ResolutionManager;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.lachhh.lachhhengine.components.PhysicComponent;
	import com.giveawaytool.effect.EffectFadeInAlpha;
	import com.giveawaytool.effect.EffectFadeOut;
	import com.giveawaytool.effect.EffectScaleUp;
	import com.giveawaytool.effect.EffectScaleBackTo1;
	import com.giveawaytool.components.TweenNumberComponent;
	import com.lachhh.io.Callback;
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.effect.EffectBlinking;
	import com.giveawaytool.effect.EffectGotoEaseOut;
	import com.giveawaytool.effect.EffectGotoEaseOutUI;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.utils.Utils;
	import com.lachhh.lachhhengine.GameSpeed;
	import flash.display.Bitmap;
	import com.lachhh.lachhhengine.components.RenderComponent;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.actor.Actor;

	/**
	 * @author Eel
	 */
	public class EmoteFirework extends Actor {
		
		public var metaEmote:MetaTwitchEmote;
		public var emoteBitmap:Bitmap;
		
		public var isParticle:Boolean = false;
		public var shouldPlayLaunchSound:Boolean = true;
		public var wait:int = 0;
		
		public function EmoteFirework(pMetaEmote:MetaTwitchEmote) {
			super();
			
			metaEmote = pMetaEmote;
			
			UIBase.manager.add(this);
			
			var bmp:Bitmap = new Bitmap(metaEmote.modelEmote.bitmapData);
			emoteBitmap = bmp;
			UIBase.defaultUIContainer.addChild(bmp);
			emoteBitmap.alpha = 0;
		}
		
		public override function start():void{
			super.start();
			
			if(wait > 0){
				wait--;
				return;
			}
			
			emoteBitmap.alpha = 1;
			
			if(isParticle){
				emoteBitmap.scaleX = 0.5;
				emoteBitmap.scaleY = 0.5;
			} else {
				if(shouldPlayLaunchSound) SfxFactory.playRandomLaunchSfx(0.25);
				
				var firefx:GameEffect = GameEffectPlayOnce.createStaticFx(UIBase.defaultUIContainer, AnimationFactory.ID_FX_FIREWORK_TRAIL, px, py);
				UIBase.manager.add(firefx);
				
				emoteBitmap.scaleX = 1;
				emoteBitmap.scaleY = 1;
				
				var yOffset:Number = 250 - (Math.random() * 500);
				var xOffset:Number = 100 - (Math.random() * 200);
				
				if(px < 100){
					xOffset = 200;
				} else if(px > ResolutionManager.getGameWidth() - 100){
					xOffset = -200;
				}
				
				var ease:EffectGotoEaseOut = EffectGotoEaseOut.addToActor(this, px+xOffset, py-400+yOffset);
				ease.ease.x = 0.07;
				ease.ease.y = 0.07;
				
				var waitOffset:Number = 10 - (Math.random() * 20);
				
				CallbackWaitEffect.addWaitCallbackToActor(this, new Callback(blinkAndExplode, this, null), 70 + waitOffset);
			}
			
			refresh();
		}
			
		
		public function blinkAndExplode():void{
			EffectShakeConstantUI.addToActor(this, emoteBitmap, 10, 10);
			EffectBlinking.addToActorWithSpecificMc(this, emoteBitmap, 10, 0xFFFFFF);
			CallbackWaitEffect.addWaitCallbackToActor(this, new Callback(explode, this, null), 10);
		}
		
		public function explode():void{
			SfxFactory.playRandomMegaHit(0.25);
			SfxFactory.playRandomHouseExplodeSfx(0.25);
			
			var scale:EffectScaleUp = EffectScaleUp.addToActorWithSpecificDisplayObject(this, emoteBitmap);
			scale.scaleSpeed = 2;
			var fade:EffectFadeInAlpha = EffectFadeInAlpha.addToActorWithDisplayObject(this, emoteBitmap);
			fade.alphaFadeSpeed = 0.1;
			spawnParticles(10);
			CallbackWaitEffect.addWaitCallFctToActor(this, destroy, 5);
			var firefx:GameEffect = GameEffectPlayOnce.createStaticFx(UIBase.defaultUIContainer, AnimationFactory.ID_FX_CHEER_EXPLODE, px, py);
			UIBase.manager.add(firefx);
		}
		
		public function spawnParticles(num:int):void{
			var left:Boolean = true;
			for(var i:int = 0; i < num; i++){
				var particle:EmoteFirework = new EmoteFirework(metaEmote);
				particle.isParticle = true;
				particle.px = px;
				particle.py = py;
				var physics:PhysicComponent = new PhysicComponent();
				physics.gravY = 0.25;
				physics.vx = 10 * (left ? -1 : 1) * Math.random();
				physics.vy = -10 * Math.random();
				particle.physicComponent = physics;
				particle.addComponent(physics);
				var fade:EffectFadeInAlpha = EffectFadeInAlpha.addToActorWithDisplayObject(particle, particle.emoteBitmap);
				fade.wait = 45;
				CallbackWaitEffect.addWaitCallbackToActor(particle, new Callback(particle.destroy, particle, null), 90);
				left = !left;
			}
		}
		
		public override function update():void{
			updateBitmap();
			
			if(wait > 0){
				wait--;
				if(wait <= 0){
					start();
				}
				return;
			}
			
			super.update();
			
			/*
			if(frame < 120 && isRocketing){
				py -= speed;
				
				speed = startingSpeed - Utils.lerp(0, startingSpeed, frame/120);
				var size:Number = 1 - Utils.lerp(0.01, 1, frame/120);
				emoteBitmap.scaleX = size;
				emoteBitmap.scaleY = size;
				
				frame++;
				if(frame >= 120){
					isRocketing = false;
					frame = 0;
				}
			} else {
				scaleSpeed -= Utils.lerp(0.003, 0.03, frame/20);
				
				if(scaleSpeed < 0.01) scaleSpeed = 0.01;
				
				emoteBitmap.scaleX += scaleSpeed;
				emoteBitmap.scaleY += scaleSpeed;
				frame++;
				if(frame >= 20){
					emoteBitmap.alpha -= 0.1;
					if(emoteBitmap.alpha <= 0.01){
						destroy();
					}
				}
			}
			 */
		}
		
		public override function destroy():void{
			if(destroyed) return;
			//if(emoteBitmap) renderComponent.animView.anim.removeChild(emoteBitmap);
			if(emoteBitmap) UIBase.defaultUIContainer.removeChild(emoteBitmap);
			super.destroy();
		}
		
		public function updateBitmap():void{
			if(emoteBitmap){
				emoteBitmap.x = px - (emoteBitmap.width / 2);
				emoteBitmap.y = py - (emoteBitmap.height / 2);
			}
		}
	}
}