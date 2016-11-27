package com.giveawaytool.components {
	import com.giveawaytool.ui.views.MetaFollower;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaFollowAlert {
		public var metaFollower:MetaFollower ;
		
		private var saveData : Dictionary = new Dictionary();

		public function MetaFollowAlert() {
			
		}

		public function encode() : Dictionary {
			saveData["metaFollower"] = metaFollower.encode();
			
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			metaFollower.decode(loadData["metaFollower"]);
		}
		
		public function encodeForWidget():Dictionary {
			return metaFollower.encode();
		}
		
		static public function create(metaFollower:MetaFollower):MetaFollowAlert {
			var result:MetaFollowAlert = new MetaFollowAlert();
			result.metaFollower = metaFollower;
			return result;
		}

		public static function createDummy() : MetaFollowAlert {
			var result:MetaFollowAlert = new MetaFollowAlert();
			result.metaFollower = MetaFollower.createDUMMY();
			return result;
		}
	}
}
