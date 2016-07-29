package com.giveawaytool.ui.views {
	import com.giveawaytool.effect.EffectFlashColor;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_PopUp;
	import com.giveawaytool.ui.UI_GiveawayMenu;
	import com.giveawaytool.ui.UI_SelectAnimation;
	import com.giveawaytool.ui.UI_WinnerPreview;
	import com.lachhh.draw.SwfExporterToFileOnDisk;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewExportPNG extends ViewBase {
		private var viewCustomBtn : ViewCustomAnimBtn;
		public function ViewExportPNG(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			pScreen.registerClick(exportPNGBtn, onExport);
			pScreen.registerClick(previewBtn, onPreview);
			pScreen.registerClick(selectBtn, onSelect);
		
			pScreen.setNameOfDynamicBtn(exportPNGBtn, "Export PNG");
			pScreen.setNameOfDynamicBtn(previewBtn, "Preview");
			
			
			pScreen.registerEvent(winnersTxt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerEvent(text1Txt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerEvent(text2Txt, FocusEvent.FOCUS_OUT, onEdit);
			pScreen.registerEvent(text3Txt, FocusEvent.FOCUS_OUT, onEdit);
			
			viewCustomBtn = new ViewCustomAnimBtn(pScreen, selectBtn, MetaGameProgress.instance.metaExportPNGConfig.metaAnimation);
			
		}

		private function onSelect() : void {
			new UI_SelectAnimation(MetaGameProgress.instance.metaExportPNGConfig.metaAnimation);
			
		}

		private function onEdit() : void {
			MetaGameProgress.instance.metaExportPNGConfig.winner = winnersTxt.text;
			MetaGameProgress.instance.metaExportPNGConfig.text1 = text1Txt.text;
			MetaGameProgress.instance.metaExportPNGConfig.text2 = text2Txt.text;
			MetaGameProgress.instance.metaExportPNGConfig.text3 = text3Txt.text;
			MetaGameProgress.instance.saveToLocal();
			(screen as UI_GiveawayMenu).viewShareOnTwitter.refresh();
			
			refresh();
		}		

		private function onPreview() : void {
			var test:UI_WinnerPreview = createPreview();
			test.renderComponent.animView.scaleX = 0.75;
			test.renderComponent.animView.scaleY = 0.75;

			EffectFlashColor.create(0xFFFFFF, 5);	
			
		}
		
		
		override public function refresh() : void {
			super.refresh();
			winnersTxt.text = MetaGameProgress.instance.metaExportPNGConfig.winner;
			text1Txt.text = MetaGameProgress.instance.metaExportPNGConfig.text1;
			text2Txt.text = MetaGameProgress.instance.metaExportPNGConfig.text2;
			text3Txt.text = MetaGameProgress.instance.metaExportPNGConfig.text3;
		}

		private function onExport() : void { 
			var test:UI_WinnerPreview = createPreview();
			test.viewPng.exportSnapShot(new Callback(saveComplete, this, [test]));
			
			
		}
		
		private function saveComplete(ui:UI_WinnerPreview):void {
			if(ui) ui.destroy();
			UI_PopUp.createOkOnly("Image saved with success!", null);
		}
		
		private function createPreview():UI_WinnerPreview {
			var test:UI_WinnerPreview = new UI_WinnerPreview();
			
			return test;
		}
		
		
		public function get winnersTxt() : TextField { return visual.getChildByName("winnersTxt") as TextField;}
		public function get text1Txt() : TextField { return visual.getChildByName("text1Txt") as TextField;}
		public function get text2Txt() : TextField { return visual.getChildByName("text2Txt") as TextField;}
		public function get text3Txt() : TextField { return visual.getChildByName("text3Txt") as TextField;}
		public function get exportPNGBtn() : MovieClip { return visual.getChildByName("exportPNGBtn") as MovieClip;}
		public function get previewBtn() : MovieClip { return visual.getChildByName("previewBtn") as MovieClip;}
		public function get selectBtn() : MovieClip { return visual.getChildByName("selectBtn") as MovieClip;}
		
		
	}
}
