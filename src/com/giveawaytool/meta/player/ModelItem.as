package com.giveawaytool.meta.player {
	import com.lachhh.lachhhengine.meta.ModelBase;

	/**
	 * @author LachhhSSD
	 */
	public class ModelItem extends ModelBase {
		public var frame:int = 0;
		public var genre:ModelItemGenre= ModelItemGenreEnum.NULL;		
		public function ModelItem(pId : int, pFrame:int, pGenre:ModelItemGenre) {
			super(pId);
			frame = pFrame;
			genre = pGenre;
		}
		
	}
}
