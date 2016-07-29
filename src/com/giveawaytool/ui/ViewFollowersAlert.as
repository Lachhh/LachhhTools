package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaFollowConfig;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewFollowersAlert extends ViewBase {
		public function ViewFollowersAlert(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			screen.registerClick(newFollowBtn, onNewFollow);
			screen.registerClick(refollowBtn, onReFollow);
			screen.registerClick(followTrainBtn, onFollowTrain);
			pScreen.registerEvent(followTrainTxt, FocusEvent.FOCUS_OUT, onEdit);			
		}

		private function onEdit() : void {
			var crntAmount:int = FlashUtils.myParseFloat(followTrainTxt.text);
			var m:MetaFollowConfig = MetaGameProgress.instance.metaFollowConfig;
			if(!isNaN(crntAmount)) m.followTrainNum = crntAmount;
			
			MetaGameProgress.instance.saveToLocal();
			UIBase.manager.refresh(); 
		}

		private function onFollowTrain() : void {
			MetaGameProgress.instance.metaFollowConfig.followTrain = !MetaGameProgress.instance.metaFollowConfig.followTrain;
			refresh();
		}

		private function onReFollow() : void {
			MetaGameProgress.instance.metaFollowConfig.alertOnReFollow = !MetaGameProgress.instance.metaFollowConfig.alertOnReFollow;
			refresh();
		}

		private function onNewFollow() : void {
			MetaGameProgress.instance.metaFollowConfig.alertOnNewFollow = !MetaGameProgress.instance.metaFollowConfig.alertOnNewFollow;
			refresh();
		}

		override public function refresh() : void {
			super.refresh();
			
			setCheckBox(MetaGameProgress.instance.metaFollowConfig.alertOnNewFollow, newFollowBtn);
			setCheckBox(MetaGameProgress.instance.metaFollowConfig.alertOnReFollow, refollowBtn);
			setCheckBox(MetaGameProgress.instance.metaFollowConfig.followTrain, followTrainBtn);
			followTrainTxt.text = MetaGameProgress.instance.metaFollowConfig.followTrainNum+"";
		}

		public function setCheckBox(value : Boolean, btn : MovieClip) : void {
			var checkedMc : MovieClip = btn.getChildByName("checkedMc") as MovieClip;
			if(checkedMc) checkedMc.visible = value;
		}
		
		
		public function get newFollowBtn() : MovieClip { return visual.getChildByName("newFollowBtn") as MovieClip;}
		public function get refollowBtn() : MovieClip { return visual.getChildByName("refollowBtn") as MovieClip;}
		public function get followTrainBtn() : MovieClip { return visual.getChildByName("followTrainBtn") as MovieClip;}
		public function get followTrainTxt() : TextField { return visual.getChildByName("followTrainTxt") as TextField;}
	}
}
