package com.giveawaytool.meta {
	import com.lachhh.lachhhengine.meta.ModelBase;
	/**
	 * @author LachhhSSD
	 */
	public class ModelDonationAward extends ModelBase {
		public var frame:int;
		public var title:String;
		public function ModelDonationAward(pId : int, pFrame:int, pTitle:String) {
			super(pId);
			frame = pFrame;
			title = pTitle;
		}
	}
}
