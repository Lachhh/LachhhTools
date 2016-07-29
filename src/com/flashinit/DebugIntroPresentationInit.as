package com.flashinit {
	import com.giveawaytool.MainGame;
	import com.giveawaytool.scenes.GameScene;
	import com.giveawaytool.ui.UI_IntroPresentationAnim;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.camera.CameraFlash;
	import com.lachhh.lachhhengine.camera.CameraFlashContainers;
	import com.lachhh.lachhhengine.components.RenderComponent;

	import flash.display.Sprite;
	/**
	 * @author LachhhSSD
	 */
	public class DebugIntroPresentationInit extends Sprite {
		
		//IDEA : PistolGaming001 : Is it possible so with levels you could buy a emoticon of your character
		
		public function DebugIntroPresentationInit() {
			super();
			
			VersionInfo.isDebug = false;
			var m:MainGame = new MainGame();
			stage.addChild(m);
			m.init();
		}
	}
}
