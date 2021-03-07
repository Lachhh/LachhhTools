package com.lachhh.flash {
	import com.giveawaytool.MainGameTools;
	/**
	 * @author LachhhSSD
	 */
	public class Screen {
		static public function get width():int {
			 return MainGameTools.instance.stage.stageWidth;
		}
		
		static public function get height():int {
			 return MainGameTools.instance.stage.stageHeight;
		}
	}
}
