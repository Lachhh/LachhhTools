package com.lachhh.flash {
	import com.giveawaytool.MainGame;
	import com.lachhh.ResolutionManager;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.ui.UIBase;

	/**
	 * @author LachhhSSD
	 */
	public class UILostFocus extends UIBase {
		private var _wasMusicMuted:Boolean ;
		private var _wasSoundMuted:Boolean ; 
		public function UILostFocus() {
			super(AnimationFactory.ID_UI_LOSTFOCUS);
			if(MainGame.instance.gameSceneManager.hasAScene && MainGame.instance.gameSceneManager.gameScene.enabled) {
				MainGame.instance.gameSceneManager.gameScene.pause(true);
				_wasMusicMuted = JukeBox.MUSIC_MUTED;
				_wasSoundMuted = JukeBox.SFX_MUTED;
				JukeBox.MUSIC_MUTED = true;
				JukeBox.SFX_MUTED = true ;
				px = ResolutionManager.getGameWidth()*0.5;
				py = ResolutionManager.getGameHeight()*0.5;
			} else {
				destroy();
			}
		}

		override public function update() : void {
			super.update();
			if(KeyManager.IsMouseDown()) {
				MainGame.instance.gameSceneManager.gameScene.pause(false);
				JukeBox.MUSIC_MUTED = _wasMusicMuted;
				JukeBox.SFX_MUTED = _wasSoundMuted ;
				destroy();
			}
		}
	}
}
