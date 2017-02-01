package com.giveawaytool.meta.donations {
	import com.giveawaytool.ui.ModelAlertTypeEnum;
	import com.LogicTransferFileToUserDoc;
	import com.giveawaytool.meta.MetaSelectAnimation;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaSelectAnimationConfig {
		public var metaCustomAnimNewFollow : MetaSelectAnimation = new MetaSelectAnimation(ModelAlertTypeEnum.FOLLOW);
		public var metaCustomAnimNewSub : MetaSelectAnimation = new MetaSelectAnimation(ModelAlertTypeEnum.SUB);
		public var metaCustomAnimNewHost : MetaSelectAnimation = new MetaSelectAnimation(ModelAlertTypeEnum.HOST);
		public var metaCustomAnimNewCheers : MetaSelectAnimation = new MetaSelectAnimation(ModelAlertTypeEnum.CHEERS);
		public var metaCustomAnimNewDonation : MetaSelectAnimation = new MetaSelectAnimation(ModelAlertTypeEnum.DONATION);
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["metaCustomAnimNewFollow"] = metaCustomAnimNewFollow.encode();
			saveData["metaCustomAnimNewSub"] = metaCustomAnimNewSub.encode();
			saveData["metaCustomAnimNewHost"] = metaCustomAnimNewHost.encode();
			saveData["metaCustomAnimNewCheers"] = metaCustomAnimNewCheers.encode();
			saveData["metaCustomAnimNewDonation"] = metaCustomAnimNewDonation.encode();
			return saveData; 
		}
		
		public function encodeWidget():Dictionary {
			saveData["metaCustomAnimNewFollow"] = metaCustomAnimNewFollow.encodeForWidget();
			saveData["metaCustomAnimNewSub"] = metaCustomAnimNewSub.encodeForWidget();
			saveData["metaCustomAnimNewHost"] = metaCustomAnimNewHost.encodeForWidget();
			saveData["metaCustomAnimNewCheers"] = metaCustomAnimNewCheers.encodeForWidget();
			saveData["metaCustomAnimNewDonation"] = metaCustomAnimNewDonation.encodeForWidget();
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			metaCustomAnimNewFollow.decode(loadData["metaCustomAnimNewFollow"]);
			metaCustomAnimNewSub.decode(loadData["metaCustomAnimNewSub"]);
			metaCustomAnimNewHost.decode(loadData["metaCustomAnimNewHost"]);
			metaCustomAnimNewCheers.decode(loadData["metaCustomAnimNewCheers"]);
			metaCustomAnimNewDonation.decode(loadData["metaCustomAnimNewDonation"]);
		}
		
		public function transfertCustomAnimToFolder():void {
			 transferCustomFile(metaCustomAnimNewFollow);
			 transferCustomFile(metaCustomAnimNewSub);
			 transferCustomFile(metaCustomAnimNewHost);
			 transferCustomFile(metaCustomAnimNewCheers);
			 transferCustomFile(metaCustomAnimNewDonation);
		}
		
		private function transferCustomFile(metaSelect:MetaSelectAnimation):void {
			if(metaSelect.isUseDefault()) return ;
			LogicTransferFileToUserDoc.createAndTransfer(metaSelect.pathToSwf, metaSelect.getPathAsWidgetLocal());
		}
	}
}
