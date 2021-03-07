package com.lachhh.flash {
	import com.giveawaytool.MainGame;
	/**
	 * @author LachhhSSD
	 */
	public class Screen {
		static public function get width():int {
			 return MainGame.instance.stage.stageWidth;
		}
		
		static public function get height():int {
			 return MainGame.instance.stage.stageHeight;
		}
	}
}
