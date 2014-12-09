package com.giveawaytool.ui.views {
	import com.giveawaytool.effect.EffectFlashColor;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_NewTwitterAccount;
	import com.giveawaytool.ui.UI_WinnerPreview;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewShareOnTwitter extends ViewBase {
		public var viewPreviewImage : ViewWinnerPng; 
		public var viewTwitterAccountList:ViewTwitterAccountList; 
		public function ViewShareOnTwitter(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			viewTwitterAccountList = new ViewTwitterAccountList(pScreen, twitterAccountsMc);
			viewTwitterAccountList.setAccount(MetaGameProgress.instance.metaShareOnTwitter.twitterAccounts);
			viewPreviewImage = new ViewWinnerPng(pScreen, previewMc);
			viewPreviewImage.visual.scaleX = 0.164;
			viewPreviewImage.visual.scaleY = 0.164;
			
			previewMc.buttonMode = true;
			contentMc.mouseEnabled = false;
			contentMc.mouseChildren = false;
			
			pScreen.registerClick(previewMc, onClickPreview); 
			pScreen.registerClick(attachPreviewBtn, onAttach);
			pScreen.setNameOfDynamicBtn(addTwitterBtn, "Add Account");
			pScreen.setNameOfDynamicBtn(refreshBtn, "Refresh");
			pScreen.registerEvent(tweetTxt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerClick(tweetBtn, onStartEdit);
			pScreen.registerClick(addTwitterBtn, onAddTwitter);
			pScreen.registerClick(refreshBtn, onRefresh);
			
			editMode(false);
		}

		private function onRefresh() : void {
			viewTwitterAccountList.metaAccountList.refresh();
			refresh();
			viewTwitterAccountList.refresh();
		}

		private function onAddTwitter() : void {
			var newAccount:UI_NewTwitterAccount = new UI_NewTwitterAccount();
			newAccount.onCompleteCallback = new Callback(onNewAccount, this, null);
		}

		private function onNewAccount() : void {
			viewTwitterAccountList.refresh();
			refresh();
			MetaGameProgress.instance.saveToLocal();
		}

		private function onClickPreview() : void {
			var test : UI_WinnerPreview = new UI_WinnerPreview();
			test.renderComponent.animView.scaleX = 0.75;
			test.renderComponent.animView.scaleY = 0.75;

			EffectFlashColor.create(0xFFFFFF, 5);
		}

		private function onStartEdit() : void {
			editMode(true);
			visual.stage.focus = tweetTxt;
		}

		private function onEdit() : void {
			MetaGameProgress.instance.metaShareOnTwitter.tweet = tweetTxt.text;
			MetaGameProgress.instance.saveToLocal();
			editMode(false);
			refresh();
		}

		private function onAttach() : void {
			MetaGameProgress.instance.metaShareOnTwitter.attachImage = !MetaGameProgress.instance.metaShareOnTwitter.attachImage;
			viewTwitterAccountList.refresh();
			refresh();
		}
		
		
		override public function refresh() : void {
			super.refresh();
			refreshCharLeft();
			checkedMc.visible = MetaGameProgress.instance.metaShareOnTwitter.attachImage;
			tweetTxt.text = MetaGameProgress.instance.metaShareOnTwitter.tweet;
			tweetPreviewTxt.text = MetaGameProgress.instance.metaShareOnTwitter.getCompleteTweetMsg();
		}
		
		
		private function editMode(b:Boolean):void {
			tweetPreviewTxt.visible = !b;
			tweetTxt.visible = b;
		}
		
		private function refreshCharLeft():void {
			charLeftTxt.text = MetaGameProgress.instance.metaShareOnTwitter.charLeft() + " Char left(s)";
			if(MetaGameProgress.instance.metaShareOnTwitter.hasTooMuchChars()) {
				charLeftTxt.textColor = 0xFF0000;	
			} else {
				charLeftTxt.textColor = 0x465A66;
			}
			viewPreviewImage.refresh();
		}
		
		override public function update() : void {
			super.update();
			if(KeyManager.IsAnyKeyPressed()) {
				MetaGameProgress.instance.metaShareOnTwitter.tweet = tweetTxt.text;
				refreshCharLeft();
			}
		}
		
		public function get tweetTxt() : TextField { return visual.getChildByName("tweetTxt") as TextField;}
		public function get tweetBtn() : MovieClip { return visual.getChildByName("tweetBtn") as MovieClip;}
		public function get tweetMc() : MovieClip { return tweetBtn.getChildByName("tweetMc") as MovieClip;}
		public function get tweetPreviewTxt() : TextField { return tweetMc.getChildByName("tweetTxt") as TextField;}
		
		
		public function get charLeftTxt() : TextField { return visual.getChildByName("charLeftTxt") as TextField;}
		public function get attachPreviewBtn() : ButtonSelect { return visual.getChildByName("attachPreviewBtn") as ButtonSelect;}
		public function get checkedMc() : MovieClip { return attachPreviewBtn.getChildByName("checkedMc") as MovieClip;}
		
		public function get previewMc() : MovieClip { return visual.getChildByName("previewMc") as MovieClip;}
		public function get contentMc() : MovieClip { return previewMc.getChildByName("contentMc") as MovieClip;}
		
		
		public function get twitterAccountsMc() : MovieClip { return visual.getChildByName("twitterAccountsMc") as MovieClip;}
		public function get addTwitterBtn() : MovieClip { return visual.getChildByName("addTwitterBtn") as MovieClip;}
		public function get refreshBtn() : MovieClip { return visual.getChildByName("refreshBtn") as MovieClip;}
		
		
		
	}
}
