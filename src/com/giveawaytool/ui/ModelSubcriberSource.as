package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.meta.ModelBaseStr;

	/**
	 * @author LachhhSSD
	 */
	public class ModelSubcriberSource extends ModelBaseStr {
		public var iconFrame : int = 1;

		public function ModelSubcriberSource(pId : String, pIconFrame : int) {
			super(pId);
			iconFrame = pIconFrame;
		}

		public function isGameWisp() : Boolean {
			return id == ModelSubcriberSourceEnum.GAMEWISP.id;
		}
	}
}
