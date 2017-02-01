package com.giveawaytool.ui {
	import com.lachhh.lachhhengine.meta.ModelBase;

	/**
	 * @author LachhhSSD
	 */
	public class ModelAlertType extends ModelBase {
		public var idStr : String ;
		public var urlPreviewOnYoutube : String;

		public function ModelAlertType(pId : int, pStr : String, pUrlPreview : String) {
			super(pId);
			idStr = pStr;
			urlPreviewOnYoutube = pUrlPreview;
		}

		public function testWidget() : void {
			switch(id) {
				case ModelAlertTypeEnum.FOLLOW.id : UI_Menu.instance.logicNotification.logicSendToWidget.sendTestFollow(); break;
				case ModelAlertTypeEnum.SUB.id : UI_Menu.instance.logicNotification.logicSendToWidget.sendTestSub(); break;
				case ModelAlertTypeEnum.HOST.id : UI_Menu.instance.logicNotification.logicSendToWidget.sendTestHost(); break;
				case ModelAlertTypeEnum.DONATION.id : UI_Menu.instance.logicNotification.logicSendToWidget.sendTestDonation(); break;
				case ModelAlertTypeEnum.CHEERS.id : UI_Menu.instance.logicNotification.logicSendToWidget.sendTestCheer(); break;
				default :
					throw new Error("Test widget not implemented.");
				 
			}
		}

		public function getPlayOnTxt() : String {
			return "PREVIEW " + idStr.toUpperCase();
		}
	}
}
