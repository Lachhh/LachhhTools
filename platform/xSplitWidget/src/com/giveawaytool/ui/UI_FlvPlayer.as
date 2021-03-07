package com.giveawaytool.ui {
	import com.giveawaytool.effect.EffectGotoEaseOutUI;
	import com.giveawaytool.meta.MetaPlayMovie;
	import com.lachhh.flash.FlashAnimation;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.utils.Utils;

	/**
	 * @author LachhhSSD
	 */
	public class UI_FlvPlayer extends UIBase {
		private var flv : FlashAnimation;
		public var callbackOnEnd:Callback;
		public var metaPlayMovie:MetaPlayMovie;
		public function UI_FlvPlayer(pMetaPlayMovie : MetaPlayMovie) {
			super(0);
			metaPlayMovie = pMetaPlayMovie;
			flv = AnimationFactory.createAnimationInstance(metaPlayMovie.getIdFromName());
			visual.addChild(flv);
			
			metaPlayMovie.setPositionOfMovie(flv);

		}
		
		static public function createMovie(m:MetaPlayMovie):UI_FlvPlayer {
			 return new UI_FlvPlayer(m);
		}

		override public function update() : void {
			super.update();
			if((flv.currentFrame >= flv.totalFrames)) {
				if(getComponent(EffectGotoEaseOutUI) == null) {
					flv.stop();
					
					metaPlayMovie.fadeOut(flv, new Callback(destroy, this, null));
				}
			}
		}

		override public function destroy() : void {
			super.destroy();
			flv.stop();
			Utils.LazyRemoveFromParent(flv);
			if(callbackOnEnd) callbackOnEnd.call();
		}

	}
}
