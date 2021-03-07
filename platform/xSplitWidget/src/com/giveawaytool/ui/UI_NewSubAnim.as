package com.giveawaytool.ui {
	import com.giveawaytool.DefaultMainGame;
	import com.giveawaytool.meta.MetaSubcriberAlert_widget;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.MovieClip;
	import flash.media.SoundTransform;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class UI_NewSubAnim extends UIBase {
		private var metaSubAlert : MetaSubcriberAlert_widget;
		public var callbackOnDestroy:Callback;
		
		public function UI_NewSubAnim(m:MetaSubcriberAlert_widget) {
			super(AnimationFactory.ID_UI_NEWSUBSCRIBERS);
			renderComponent.animView.stop();
			renderComponent.animView.anim.play();
		
			metaSubAlert = m;
			px = 640;
			py = 360;
			renderComponent.animView.addChildOnNewParent(DefaultMainGame.UI_CONTAINER_ABOVE_NO_CLICK);
			var st:SoundTransform = visual.soundTransform;
			st.volume = JukeBox.SFX_VOLUME;
			visual.soundTransform = st; 
			refresh();
		}
		
		override public function destroy() : void {
			super.destroy();
			if(callbackOnDestroy) callbackOnDestroy.call();
		}
		
		override public function refresh() : void {
			super.refresh();
			nameTxt.text = metaSubAlert.name;
			numMonthTxt.text = metaSubAlert.numMonthInARow + " MONTHS";
			titleTxt.text = metaSubAlert.metaGameWispSubInfo.tierTitle ;
			punchNewSubMc.visible = metaSubAlert.isNewSubscriberOnTwitch() || metaSubAlert.isGameWispSub();;
			punchReSubMc.visible = !punchNewSubMc.visible;
			
			newSubMc.visible = metaSubAlert.isNewSubscriberOnTwitch(); 
			reSubMc.visible = metaSubAlert.isReSubOnTwitch();
			gameWispSubMc.visible = metaSubAlert.isGameWispSub();
		}
		
		
		override public function update() : void {
			super.update();
			if(visual.currentFrame >= visual.totalFrames-2) {
				destroy();
			}
		}
		
		public function get doorsMc() : MovieClip { return visual.getChildByName("doorsMc") as MovieClip;}
		public function get nameMc() : MovieClip { return doorsMc.getChildByName("nameMc") as MovieClip;}
		public function get nameTxt() : TextField { return nameMc.getChildByName("nameTxt") as TextField;}
		
		public function get msgMc() : MovieClip { return doorsMc.getChildByName("msgMc") as MovieClip;}
		public function get reSubMc() : MovieClip { return msgMc.getChildByName("reSubMc") as MovieClip;}
		public function get numMonthTxt() : TextField { return reSubMc.getChildByName("numMonthTxt") as TextField;}
		
		public function get gameWispSubMc() : MovieClip { return msgMc.getChildByName("gameWispSubMc") as MovieClip;}
		public function get titleTxt() : TextField { return gameWispSubMc.getChildByName("titleTxt") as TextField;}
		
		public function get newSubMc() : MovieClip { return msgMc.getChildByName("newSubMc") as MovieClip;}
		
		public function get punchMc() : MovieClip { return visual.getChildByName("punchMc") as MovieClip;}
		public function get punchNewSubMc() : MovieClip { return punchMc.getChildByName("punchNewSubMc") as MovieClip;}
		public function get punchReSubMc() : MovieClip { return punchMc.getChildByName("punchReSubMc") as MovieClip;}
	}
}
