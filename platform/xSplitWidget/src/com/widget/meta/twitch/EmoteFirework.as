package com.giveawaytool.meta.twitch {
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.effect.EffectBlinking;
	import com.giveawaytool.effect.EffectFadeInAlpha;
	import com.giveawaytool.effect.EffectGotoEaseOut;
	import com.giveawaytool.effect.ui.EffectShakeConstantUI;
	import com.giveawaytool.fx.GameEffectPlayOnce;
	import com.lachhh.ResolutionManager;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.components.PhysicComponent;
	import com.lachhh.lachhhengine.components.RenderComponent;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.utils.Utils;

	import flash.display.Bitmap;

	/**
	 * @author Eel
	 */
	public class EmoteFirework extends Actor {
		
		public var metaEmote:MetaTwitchEmote;
		public var emoteBitmap:Bitmap;
		
		public var isParticle:Boolean = false;
		public var shouldPlayLaunchSound:Boolean = true;
		
		public function EmoteFirework(pMetaEmote:MetaTwitchEmote) {
			super();
			
			metaEmote = pMetaEmote;
			
			UIBase.manager.add(this);
			renderComponent = RenderComponent.addToActor(this, UIBase.defaultUIContainer, AnimationFactory.EMPTY);
			
			emoteBitmap = new Bitmap(metaEmote.modelEmote.bitmapData);
			emoteBitmap.x = -emoteBitmap.width*0.5;
			emoteBitmap.y = -emoteBitmap.height*0.5;
			renderComponent.animView.anim.addChild(emoteBitmap);
		}
		
		public override function start():void{
			super.start();
			
			if(isParticle){
				
				
			} else {
				if(shouldPlayLaunchSound) SfxFactory.playRandomLaunchSfx(0.25);
				
				if(!tooManyEmotes()) {
					GameEffectPlayOnce.createStaticFx(UIBase.defaultUIContainer, AnimationFactory.ID_FX_FIREWORK_TRAIL, px, py);
					renderComponent.animView.scaleX = 1;
					renderComponent.animView.scaleY = 1;
				} else {
					renderComponent.animView.scaleX = 0.5;
					renderComponent.animView.scaleY = 0.5;
				}
				
				
				
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
			
		static public function tooManyEmotes():Boolean {
			if(UIBase.manager.getNbActive() >= 50) return true;
			return false;
		}
		
		
		
		public function blinkAndExplode():void{
			EffectShakeConstantUI.addToActor(this, renderComponent.animView.anim, 10, 10);
			EffectBlinking.addToActorWithSpecificMc(this, renderComponent.animView.anim, 10, 0xFFFFFF);
			CallbackWaitEffect.addWaitCallbackToActor(this, new Callback(explode, this, null), 10);
		}
		
		public function explode():void{
			SfxFactory.playRandomMegaHit(0.25);
			SfxFactory.playRandomHouseExplodeSfx(0.25);
			
			var fade:EffectFadeInAlpha = EffectFadeInAlpha.addToActorWithDisplayObject(this, emoteBitmap);
			fade.alphaFadeSpeed = 0.1;
			spawnParticles(10);
			CallbackWaitEffect.addWaitCallFctToActor(this, destroy, 5);
			
			var fx:GameEffectPlayOnce = GameEffectPlayOnce.createStaticFx(UIBase.defaultUIContainer, AnimationFactory.ID_FX_CHEER_EXPLODE, px, py);
			fx.renderComponent.animView.scaleX = renderComponent.animView.scaleX;
			fx.renderComponent.animView.scaleY = renderComponent.animView.scaleY;
			 
		}
		
		public function spawnParticles(num:int):void{
			var left:Boolean = true;
			for(var i:int = 0; i < num; i++){
				var speed:Number = 2 + Math.random()*2;
				var particle:EmoteFirework = new EmoteFirework(metaEmote);
				particle.isParticle = true;
				particle.px = px;
				particle.py = py;
				particle.renderComponent.animView.scaleX = 1/speed;
				particle.renderComponent.animView.scaleY = 1/speed;
				particle.renderComponent.animView.scaleX *= renderComponent.animView.scaleX ;
				particle.renderComponent.animView.scaleY *= renderComponent.animView.scaleY ;
					
				var physics:PhysicComponent = new PhysicComponent();
				physics.gravY = 0.25;
				physics.vx = 5 * (left ? -1 : 1) * Math.random()*speed;
				physics.vy = -5 * Math.random()*speed ;
				
				particle.physicComponent = physics;
				particle.addComponent(physics);
				var fade:EffectFadeInAlpha = EffectFadeInAlpha.addToActorWithDisplayObject(particle, particle.emoteBitmap);
				fade.wait = 45;
				CallbackWaitEffect.addWaitCallbackToActor(particle, new Callback(particle.destroy, particle, null), 90);
				left = !left;
			}
		}
		
		public override function update():void{
			super.update();
			
			if(isParticle) {
				if(renderComponent.animView.hasAnim()) renderComponent.animView.anim.rotation += 5;
			}
		
		}
		
		public override function destroy():void{
			if(destroyed) return;
			Utils.LazyRemoveFromParent(emoteBitmap);
			super.destroy();
		}
		
	}
}