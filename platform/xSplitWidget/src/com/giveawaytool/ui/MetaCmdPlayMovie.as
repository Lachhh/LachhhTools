package com.giveawaytool.ui {
	import com.giveawaytool.meta.MetaDonationsConfig;
	import com.giveawaytool.meta.MetaPlayMovie;
	import com.lachhh.io.Callback;
	/**
	 * @author LachhhSSD
	 */
	public class MetaCmdPlayMovie extends MetaCmd {
		public var metaPlayMovie:MetaPlayMovie;
		

		public function MetaCmdPlayMovie(m : MetaPlayMovie) {
			metaPlayMovie = m;
		}

		override public function execute(pMetaConfig:MetaDonationsConfig):void {
			var ui:UI_FlvPlayer = UI_FlvPlayer.createMovie(metaPlayMovie);
			ui.callbackOnEnd = new Callback(endCmd, this, null); 
		}
	}
}
