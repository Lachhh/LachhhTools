package com.giveawaytool.ui {
	import com.lachhh.utils.Utils;
	import com.giveawaytool.DefaultMainGame;
	import flash.geom.Point;
	import com.giveawaytool.MainGameTools;
	import com.lachhh.ResolutionManager;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIOpenClose;

	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.media.StageWebView;

	/**
	 * @author LachhhSSD
	 */
	public class UI_YoutubePreview extends UIOpenClose {
		private var webview : StageWebView ;
		private var idUrl : String;

		public function UI_YoutubePreview(pIdUrl : String) {
			super(AnimationFactory.ID_UI_YOUTUBEPREVIEW, 20, 35);
			idUrl = pIdUrl;
			registerClick(xBtn, onClickX);
			registerClick(backMc, onClickX);
			registerClick(onYoutubeBtn, onClickYoutube);

			setNameOfDynamicBtn(onYoutubeBtn, "Watch on Youtube");
			
			px = ResolutionManager.getGameWidth() * 0.5;
			py = ResolutionManager.getGameHeight() * 0.5;
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE);
			refresh();
		}

		override public function start() : void {
			super.start();
			var newUrl:String = idUrl.split("embed/").join("watch?v=");
			Utils.navigateToURLAndRecord(newUrl);
			destroy();
		}

		private function onClickYoutube() : void {
			var newUrl:String = idUrl.split("embed/").join("watch?v=");
			Utils.navigateToURLAndRecord(newUrl);
		}
		
		private function createPreview(id:String):void {
			var wt:uint;
			var ht:uint ;
			var rect:Rectangle;
			var url:String;
			
			url = id;
			
			trace(url);
			
			wt = 900;
			ht = 465;
			
			webview = new StageWebView();
			var p:Point = new Point(youtubeContainerMc.x+20, youtubeContainerMc.y);
			p.x += ResolutionManager.getGameWidth()*0.5;
			p.y += ResolutionManager.getGameHeight()*0.5;
			
			rect = new Rectangle(p.x,p.y,wt,ht);
			
			webview.stage = MainGameTools.instance.stage;
			webview.viewPort = rect;
			webview.loadURL(url);
		}

		override protected function onIdle() : void {
			super.onIdle();
			createPreview(idUrl);
			
		}

		private function onClickX() : void {
			destroyWebView();
			close();
		}
		
		private function destroyWebView():void {
			if(webview == null) return;
			webview.stage = null;
			webview.stop();
			webview.dispose();
			webview = null;
		}

		override public function destroy() : void {
			super.destroy();
			destroyWebView();
		}

		public function get panel() : MovieClip {return visual.getChildByName("panel") as MovieClip;}
		public function get youtubeContainerMc() : MovieClip {return panel.getChildByName("youtubeContainerMc") as MovieClip;}
		public function get xBtn() : MovieClip { return panel.getChildByName("xBtn") as MovieClip;}
		public function get backMc() : MovieClip { return visual.getChildByName("backMc") as MovieClip;}
		public function get onYoutubeBtn() : MovieClip { return panel.getChildByName("onYoutubeBtn") as MovieClip;}
		
	}
}
