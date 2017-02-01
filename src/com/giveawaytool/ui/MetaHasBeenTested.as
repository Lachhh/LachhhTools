package com.giveawaytool.ui {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaHasBeenTested {
		public var hasBeenTested : Boolean = false;
		public var modelAlertType : ModelAlertType;
		private var saveData : Dictionary = new Dictionary();

		public function MetaHasBeenTested(pModelType:ModelAlertType) {
			modelAlertType = pModelType;
		}

		public function encode() : Dictionary {
			saveData["hasBeenTested"] = hasBeenTested;
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			hasBeenTested = loadData["hasBeenTested"];
		}

		public function testWidget() : void {
			modelAlertType.testWidget();
		}

		public function clear() : void {
			hasBeenTested = false;
		}
	}
}
