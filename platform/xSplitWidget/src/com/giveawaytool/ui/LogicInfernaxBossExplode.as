package com.giveawaytool.ui {
	import com.giveawaytool.components.ParticleEmitter;
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.components.PhysicComponent;
	/**
	 * @author LachhhSSD
	 */
	public class LogicInfernaxBossExplode {
		
		static public function burstOfBones(actor:Actor):void {
			if(!actor.renderComponent.animView.hasAnim()) return ;
			
			for (var i : int = 0; i < 2; i++) {
				var p:ParticleEmitter = ParticleEmitter.addToActor(actor);
				p.offSet.x = 1195;
				p.offSet.y = 582;
				p.offSetPRandom.x = 80;
				p.offSetPRandom.y = 100;
				p.offSetVRandom.x = 16;
				p.offSetVRandom.y = -16;
				p.physicComponentToClone = new PhysicComponent();
				p.physicComponentToClone.vx = -10;
				p.physicComponentToClone.vy = -6;
				p.physicComponentToClone.gravY = 0.4;
				p.animId = [AnimationFactory.ID_FX_GORE_1, AnimationFactory.ID_FX_GORE_2, AnimationFactory.ID_FX_GORE_3];
				p.parentVisual = actor.renderComponent.animView.anim;
				p.numParticleToEmit = 20;
				p.waitBetweenParticle = 0;
				p.particleAnimLooping = true;
				p.onEmitCallback = new Callback(waitBeforeSetOnTop, LogicInfernaxBossExplode, [p]);
			}
		}
		
		static private function waitBeforeSetOnTop(p:ParticleEmitter):void {
			CallbackTimerEffect.addWaitCallbackToActor(p.lastEmitted, new Callback(setLastEmittedOnTop, LogicInfernaxBossExplode, [p.lastEmitted]), 1000);
			
			p.lastEmitted.renderComponent.animView.sendToBack();
		}
		
		static private function setLastEmittedOnTop(a:Actor):void {
			if(a.destroyed) return ;
			if(a.renderComponent == null) return ;
			a.renderComponent.animView.sendToTop();
		}
	}
}
