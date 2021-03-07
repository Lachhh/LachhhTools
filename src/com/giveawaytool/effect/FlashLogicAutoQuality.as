package com.giveawaytool.effect {
	import com.giveawaytool.MainGameTools;
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.actor.Actor;
	import com.lachhh.lachhhengine.components.ActorComponent;

	import flash.display.StageQuality;

	/**
	 * @author LachhhSSD
	 */
	public class FlashLogicAutoQuality extends ActorComponent {
		private var initTime : Number;
		private var frame : int;
		private var fps : int;
		
		private var nbUnderThreshold : int = 0;
		public function FlashLogicAutoQuality() {
			super();
		}
		
		
		override public function start() : void {
			super.start();
			initTime = GameSpeed.getTime();
			nbUnderThreshold = 0;
		}

		override public function update() : void {
			super.update();
			var timeNow:int = GameSpeed.getTime();
			if (timeNow - initTime >= 1000) {
				fps = frame ;
				initTime = timeNow;
				frame = 0 ;
				
				if(fps < 30) {
					nbUnderThreshold++;
					if(nbUnderThreshold >= 10) {
						switch(MainGameTools.instance.stage.quality) {
							case StageQuality.LOW:
							case StageQuality.MEDIUM:
								//MainGame.instance.stage.quality = StageQuality.LOW;
								break;
							default : 
								MainGameTools.instance.stage.quality = StageQuality.MEDIUM;
								break;
						}
						
						destroyAndRemoveFromActor();
					}
				} else {
					nbUnderThreshold = 0;
				}
			} else {
				frame++; 
			}
		}
		
		static public function addToActor(actor:Actor):FlashLogicAutoQuality {
			var result:FlashLogicAutoQuality = new FlashLogicAutoQuality();
			actor.addComponent(result);
			return result;
		}
	}
}
