package com.giveawaytool.ui {
	import com.lachhh.io.Callback;
	import flash.text.TextField;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.utils.Utils;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class UI_PatreonPromo extends UIBase {
		private var URL_SUB:String = "https://www.youtube.com/embed/4WArVMN5Q2s";
		private var URL_HOST:String = "https://www.youtube.com/embed/N4Bsg4M9YDs";
		private var URL_FOLLOW:String = "https://www.youtube.com/embed/8vKuIXjy8fI";
		private var URL_CHEERS:String = "https://www.youtube.com/embed/BoxuIm3A59M";
		private var URL_DONATION:String = "https://www.youtube.com/embed/VoevVsIOSog";
		private var URL_STREAMRPG:String = "https://www.youtube.com/embed/MX5SlhnutBo";
		

		public function UI_PatreonPromo() {
			super(AnimationFactory.ID_UI_PATREONPROMO);
			
			//var test:Youtube_AIR_Code = new Youtube_AIR_Code();
			// visual.addChild(test);
			//registerClick(subPreviewBtn, onClick);
			initBtn(subPreview, URL_SUB, "Sub alerts");
			initBtn(followPreview, URL_FOLLOW, "Follow alerts");
			initBtn(hostPreview, URL_HOST, "Host alerts");
			initBtn(donationPreview, URL_DONATION, "Donation alerts");
			initBtn(cheersPreview, URL_CHEERS, "Cheers alerts");
			
			registerClick(patreonBtn, onClickPatreon);
			registerClick(streamRPGPreview, onClickPatreon);
			//registerClickWithCallback(streamRPGPreview, new Callback(onClick, this, [URL_STREAMRPG]));
			
			setNameOfDynamicBtn(patreonBtn, "Go to Patreon");
			refresh();
		}
		
		private function initBtn(btn:MovieClip, idVideo:String, label:String):void {
			setBtnLabel(btn, label);
			registerClickWithCallback(btn, new Callback(onClick, this, [idVideo]));
		}
		
		private function setBtnLabel(btn:MovieClip, labelString:String):void {
			var txt:TextField = btn.getChildByName("lblTxt") as TextField;
			if(txt == null) return ;
			txt.text = labelString;
		}
		
		private function onClickPatreon() : void {
			Utils.navigateToURLAndRecord(VersionInfo.URL_STREAMRPG);
		}

		private function onClick(idVideo:String) : void {
			new UI_YoutubePreview(idVideo);
		}
		
		public function get subPreview() : MovieClip { return visual.getChildByName("subPreview") as MovieClip;}
		public function get followPreview() : MovieClip { return visual.getChildByName("followPreview") as MovieClip;}
		public function get hostPreview() : MovieClip { return visual.getChildByName("hostPreview") as MovieClip;}
		public function get donationPreview() : MovieClip { return visual.getChildByName("donationPreview") as MovieClip;}
		public function get cheersPreview() : MovieClip { return visual.getChildByName("cheersPreview") as MovieClip;}
		public function get streamRPGPreview() : MovieClip { return visual.getChildByName("streamRPGPreview") as MovieClip;}
		
		
		public function get patreonBtn() : MovieClip { return visual.getChildByName("patreonBtn") as MovieClip;}
		
	}
}
