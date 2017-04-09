package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewSubscriberAlert extends ViewBase {
		public var viewGameWispSubAlert : ViewGameWispSubAlert;
		public function ViewSubscriberAlert(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewGameWispSubAlert = new ViewGameWispSubAlert(screen, gameWispConnectMc);
			screen.registerClick(newSubBtn, onNewSub);
			screen.registerClick(resubBtn, onReSub);
			screen.registerClick(viewGameWispSubAlert.newSubGamewispBtn, onNewSubGameWisp);
			
			
		}

		

		private function onNewSubGameWisp() : void {
			MetaGameProgress.instance.metaSubsConfig.alertOnGameWispSub = !MetaGameProgress.instance.metaSubsConfig.alertOnGameWispSub;
			refresh();
		}

		private function onReSub() : void {
			MetaGameProgress.instance.metaSubsConfig.alertOnReSub = !MetaGameProgress.instance.metaSubsConfig.alertOnReSub;
			refresh();
		}

		private function onNewSub() : void {
			MetaGameProgress.instance.metaSubsConfig.alertOnNewSub = !MetaGameProgress.instance.metaSubsConfig.alertOnNewSub;
			refresh();
		}

		override public function refresh() : void {
			super.refresh();
			
			setCheckBox(MetaGameProgress.instance.metaSubsConfig.alertOnNewSub, newSubBtn);
			setCheckBox(MetaGameProgress.instance.metaSubsConfig.alertOnReSub, resubBtn);
			setCheckBox(MetaGameProgress.instance.metaSubsConfig.alertOnGameWispSub, viewGameWispSubAlert.newSubGamewispBtn);
			viewGameWispSubAlert.refresh();
		}

		public function setCheckBox(value : Boolean, btn : MovieClip) : void {
			var checkedMc : MovieClip = btn.getChildByName("checkedMc") as MovieClip;
			if(checkedMc) checkedMc.visible = value;
		}
		
		
		public function get newSubBtn() : MovieClip { return visual.getChildByName("newSubBtn") as MovieClip;}
		public function get resubBtn() : MovieClip { return visual.getChildByName("resubBtn") as MovieClip;}
		public function get gameWispConnectMc() : MovieClip { return visual.getChildByName("gameWispConnectMc") as MovieClip;}
		
		
		
		
	}
}
