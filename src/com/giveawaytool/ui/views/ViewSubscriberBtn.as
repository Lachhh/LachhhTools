package com.giveawaytool.ui.views {
	import com.giveawaytool.ui.MetaSubscriber;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewSubscriberBtn extends ViewBase {
		private var viewDonation : ViewSubscriber;

		public function ViewSubscriberBtn(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewDonation = new ViewSubscriber(pScreen, donationMc);
		}	
		
		override public function refresh() : void {
			super.refresh();
			viewDonation.metaSubscriber = getMetaSubscriber();
			viewDonation.refresh();
		}

		public function getMetaSubscriber() : MetaSubscriber {
			return metaData as MetaSubscriber;
		}
		
		public function get donationMc() : MovieClip { return visual.getChildByName("donationMc") as MovieClip;}
	}
}
