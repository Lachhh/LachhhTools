package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.meta.MetaPlayMovie;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UI_PlayMovies extends UIBase {
		public function UI_PlayMovies() {
			super(AnimationFactory.ID_UI_PLAYMOVIE);
			
			createSendMovieBtn(0, "JustDoIt", "Just Do It");
			createSendMovieBtn(1, "VanDammeHit", "VanDamme Hit");
			createSendMovieBtn(2, "VanDammeExplode", "VanDamme Explode");
			createSendMovieBtn(3, "VanDammeCover", "VanDamme Cover");
			createSendMovieBtn(4, "VanDammeShoot", "VanDamme Shoot");
			createSendMovieBtn(5, "DealWithIt", "Deal with it");
			createSendMovieBtn(6, "MrThompson", "Mr. Thompson");
			createSendMovieBtn(7, "ItsOver9000", "It's Over 9000");
			//getPlayMovieBtn(6).visible = false;
			//getPlayMovieBtn(7).visible = false;
			getPlayMovieBtn(8).visible = false;
			getPlayMovieBtn(9).visible = false;
			
			/*registerClickWithCallback(playMovie1Btn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create("JustDoIt")]));
			registerClickWithCallback(playMovie2Btn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create("VanDammeHit")]));
			registerClickWithCallback(playMovie3Btn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create("VanDammeExplode")]));
			registerClickWithCallback(playMovie4Btn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create("VanDammeCover")]));
			registerClickWithCallback(playMovie5Btn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create("VanDammeShoot")]));
			registerClickWithCallback(playMovie5Btn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create("DealWithIt")]));
			
			setNameOfDynamicBtn(playMovie1Btn, "Just Do It");
			setNameOfDynamicBtn(playMovie2Btn, "VanDamme Hit");
			setNameOfDynamicBtn(playMovie3Btn, "VanDamme Explode");
			setNameOfDynamicBtn(playMovie4Btn, "VanDamme Cover");
			setNameOfDynamicBtn(playMovie5Btn, "VanDamme Shoot");
			setNameOfDynamicBtn(playMovie5Btn, "VanDamme Shoot");*/
			refresh();
		}
		
		private function createSendMovieBtn(i:int, msgToSend:String, btnLabel:String):void {
			var visualBtn:MovieClip = getPlayMovieBtn(i);
			setNameOfDynamicBtn(visualBtn, btnLabel);
			registerClickWithCallback(visualBtn, new Callback(sendPlayMovie, this, [MetaPlayMovie.create(msgToSend)]));
		}

		override public function refresh() : void {
			super.refresh();
			chatLogTxt.text = MetaGameProgress.instance.metaTwitchChat.debugLog;
		}

		public function sendPlayMovie(m : MetaPlayMovie) : void {
			UI_Menu.instance.logicNotification.logicSendToWidgetPlayMovie.sendPlayMovie(m);
		}
		
		public function getPlayMovieBtn(i:int) : MovieClip { return visual.getChildByName("playMovieBtn" + i) as MovieClip;}
		public function get chatLogTxt() : TextField { return visual.getChildByName("chatLogTxt") as TextField;}
	}
}
