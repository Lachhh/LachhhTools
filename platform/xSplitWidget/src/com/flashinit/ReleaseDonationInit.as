package com.flashinit {
	import com.giveawaytool.MainGame;
	import com.lachhh.lachhhengine.VersionInfo;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	/**
	 * @author LachhhSSD
	 */
	public class ReleaseDonationInit extends Sprite {
		static public var t:TextField ;
		static private var tMsg:String = "";
		public function ReleaseDonationInit() {
			super();
			
			VersionInfo.isDebug = false;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addLine("0");	
		}
		
		protected function addDebugTextfield():void {
			t = new TextField();
			t.type = TextFieldType.INPUT;
			t.multiline = false;
			t.height = 1280;
			t.width = 350;
			t.background = true;
			t.backgroundColor = 0x666666;
			t.textColor = 0xFFFFFF;	
		}
		
		protected function onAddedToStage(e:Event):void {
			if(t) stage.addChild(t);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			var m:MainGame = new MainGame();
			stage.addChild(m);
			m.init();
			m.startNormalDonation();
		}
		
		static public function addLine(str:String):void {
			if(t == null) return ;
			tMsg += str + "\n";
			t.text = tMsg;
		}
	}
}
