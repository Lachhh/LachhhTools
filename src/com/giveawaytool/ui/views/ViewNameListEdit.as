package com.giveawaytool.ui.views {
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UIPopUp;
	import com.giveawaytool.ui.UIPopupInsert;
	import com.giveawaytool.ui.UI_MainMenu;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;

	/**
	 * @author LachhhSSD
	 */
	public class ViewNameListEdit extends ViewBase {
		private var popupInsert:UIPopupInsert;
		private var uiMainMenu:UI_MainMenu;
		
		public function ViewNameListEdit(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			uiMainMenu = (screen as UI_MainMenu);
			pScreen.registerClick(addFromListBtn, onAddFromList);
			pScreen.registerClick(fetchFromIRCBtn, onIRC);
		}
		
		private function onAddFromList() : void {
			if(uiMainMenu.viewNameList.isLoading()) return ;
			popupInsert = UIPopupInsert.createInsertReplaceAppendCancel("Enter list of names\n(separated by spaces)", new Callback(onAddFromListInput, this, null), new Callback(onAppendFromListInput, this, null), null);
			screen.doBtnPressAnim(addFromListBtn);
		}
		
		private function onIRC() : void {
			if(uiMainMenu.viewNameList.isLoading()) return ;
			popupInsert = UIPopupInsert.createInsertOne("Enter Channel Name", new Callback(onIRCInput, this, null), null);
			popupInsert.inputTxt.text = MetaGameProgress.instance.metaGiveawayConfig.channelToLoad;
			screen.doBtnPressAnim(fetchFromIRCBtn);
		}

		private function onIRCInput() : void {
			var channelName:String = popupInsert.inputTxt.text;
			if(channelName != "") {
				loadDataFromChannel(channelName);		
				MetaGameProgress.instance.metaGiveawayConfig.channelToLoad = channelName;	
				MetaGameProgress.instance.saveToLocal();
			}
		}
		
		private function loadDataFromChannel(channelName:String):void {
			DataManager.loadExternalNames(channelName, new Callback(onDataLoaded, this, null), new Callback(onDataLoadedError, this, null));
			uiMainMenu.viewNameList.showLoading(true);
			uiMainMenu.viewNameList.clear();
			MetaGameProgress.instance.participants = [];
			refresh();
		}
		
		public function cancelLoading():void {
			DataManager.cancel();
			uiMainMenu.viewNameList.showLoading(false);
			refresh();
		}

		private function onDataLoaded() : void {
			var obj:Object = JSON.parse(DataManager.loadedData);
		   	var arrayOfNames:Array = obj.chatters.viewers;
			uiMainMenu.viewNameList.showLoading(false);
			uiMainMenu.viewNameList.setNames(arrayOfNames);
			MetaGameProgress.instance.participants = arrayOfNames;
			uiMainMenu.viewNameList.refresh();
			refresh();
		}

		private function onDataLoadedError() : void {
			uiMainMenu.viewNameList.showLoading(false);
			refresh();
			UIPopUp.createOkOnly("Oops, can't retrieve data from " + popupInsert.inputTxt.text + "'s Twitch Channel.", null);
		}
		
		private function onAddFromListInput() : void {
			var listNames:String = popupInsert.inputTxt.text;
			uiMainMenu.viewNameList.setNames(nameToArray(listNames));
			MetaGameProgress.instance.participants = uiMainMenu.viewNameList.getNames();
			uiMainMenu.viewNameList.refresh();
		}
		
		private function onAppendFromListInput() : void {
			var listNames:String = popupInsert.inputTxt.text;
			var a:Array = uiMainMenu.viewNameList.getNames();
			var b:Array = nameToArray(listNames);
			a = a.concat(b);
			uiMainMenu.viewNameList.setNames(a);
			MetaGameProgress.instance.participants = a;
			uiMainMenu.viewNameList.refresh();
		}
		
		static public function nameToArray(names:String):Array {
			var splitter:String = "" ;
			var arrayTest:Array ;
			var justNamesSeparatedWithSpace:String ; 
			var result:Array ;
			
			if(hasInstanceOf(names, "VIEWERS")) splitter = "VIEWERS";
			if(hasInstanceOf(names, "\nVIEWERS")) splitter = "\nVIEWERS";
			if(hasInstanceOf(names, "\\nVIEWERS")) splitter = "\\nVIEWERS";
			if(hasInstanceOf(names, "\r\nVIEWERS")) splitter = "\r\nVIEWERS"; 
			
			if(splitter == "") {
				justNamesSeparatedWithSpace = names;
			} else {
				arrayTest = names.split(splitter);
				justNamesSeparatedWithSpace = arrayTest[1];
			}
			
			result = justNamesSeparatedWithSpace.split(" ");
			
			return result;
		}

		override public function refresh() : void {
			super.refresh();
			addFromListBtn.selectIfBoolean(uiMainMenu.viewNameList.isLoading());
			fetchFromIRCBtn.selectIfBoolean(uiMainMenu.viewNameList.isLoading()); 
		}
		
		static private function hasInstanceOf(str:String, msg:String):Boolean {
			 return (str.indexOf(msg) != -1);
		}
		
		public function get addFromListBtn() : ButtonSelect { return visual.getChildByName("addFromListBtn") as ButtonSelect;}
		public function get fetchFromIRCBtn() : ButtonSelect { return visual.getChildByName("fetchFromIRCBtn") as ButtonSelect;}
		
		
		
	}
}
