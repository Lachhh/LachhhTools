package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.MetaTwitterAccount;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewTwitterAccountSmall extends ViewBase {
		public var metaTwitterAccount:MetaTwitterAccount;
		
		public function ViewTwitterAccountSmall(pScreen : UIBase, visual:MovieClip) {
			super(pScreen, visual);
		}

		
		override public function destroy() : void {
			super.destroy();
			
			while(contentMc.numChildren > 0) {
				contentMc.removeChildAt(0);
			}
		}
		
		override public function refresh() : void {
			super.refresh();
			if(visual == null) return ;
			if(metaTwitterAccount == null) return ;
			
			if(metaTwitterAccount.isLoading) {
				winnersTxt.text = "Loading...";
			} else {
				winnersTxt.text = metaTwitterAccount.accountName;
				if(metaTwitterAccount.bmp) {
					contentMc.addChild(metaTwitterAccount.bmp);
					metaTwitterAccount.bmp.width = 45;
					metaTwitterAccount.bmp.height = 45;
				}
			}
		}
		
		
		public function get winnersTxt() : TextField { return visual.getChildByName("winnersTxt") as TextField;}
		
		public function get avatarMc() : MovieClip { return visual.getChildByName("avatarMc") as MovieClip;}
		public function get avatarMcPreview() : MovieClip { return avatarMc.getChildByName("avatarMc") as MovieClip;}
		public function get contentMc() : MovieClip { return avatarMcPreview.getChildByName("contentMc") as MovieClip;}
	}
}
