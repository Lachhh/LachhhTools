package com.giveawaytool.ui.views {
	import com.giveawaytool.components.LogicTwitchChat;
	import com.lachhh.flash.LogicLostFocus;
	import com.giveawaytool.components.TwitchRequestMods;
	import com.giveawaytool.ui.UI_Menu;
	import com.giveawaytool.io.twitch.TwitchConnection;
	import com.giveawaytool.meta.MetaGameProgress;
	import com.giveawaytool.ui.UI_PopUp;
	import com.giveawaytool.ui.UIPopupInsert;
	import com.giveawaytool.ui.UI_GiveawayMenu;
	import com.lachhh.flash.ui.ButtonSelect;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.DataManager;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.FocusEvent;
	import flash.text.TextField;

	/**
	 * @author LachhhSSD
	 */
	public class ViewGiveawayAddParticipants extends ViewBase {
		private var popupInsert:UIPopupInsert;
		private var uiMainMenu : UI_GiveawayMenu;

		public function ViewGiveawayAddParticipants(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			new ViewNeedToBeOnline(screen, needOnlineMc1);
			new ViewNeedToBeOnline(screen, needOnlineMc2);
			new ViewNeedToBeOnline(screen, needOnlineMc3);
			new ViewNeedToBeOnline(screen, needOnlineMc4);
			new ViewNeedToBeOnline(screen, needOnlineMc5);
			new ViewNeedToBeOnline(screen, needOnlineMc6);
			
			
			uiMainMenu = (screen as UI_GiveawayMenu);
			screen.setNameOfDynamicBtn(addFromListBtn, "Add Manually");
			screen.setNameOfDynamicBtn(fetchFromIRCBtn, "Add Viewers");
			screen.setNameOfDynamicBtn(addSubsBtn, "Add Subs");
			screen.setNameOfDynamicBtn(removeSubBtn, "Remove\nSubs");
			screen.setNameOfDynamicBtn(keepOnlySubBtn, "Remove\nnon-subs");
			screen.setNameOfDynamicBtn(addModBtn, "Add Mods");
			screen.setNameOfDynamicBtn(keepOnlyModBtn, "Remove\nnon-mod");
			screen.setNameOfDynamicBtn(clearBtn, "CLEAR");
			
			
			
			
			
			pScreen.registerClick(addFromListBtn, onAddFromList);
			pScreen.registerClick(fetchFromIRCBtn, onIRC);
			pScreen.registerClick(addSubsBtn, onAddSubs);
			pScreen.registerClick(removeSubBtn, onRemoveSubs);
			pScreen.registerClick(keepOnlySubBtn, onKeepSubsOnly);
			pScreen.registerClick(clearBtn, onClear);

			pScreen.registerClick(addModBtn, onAddMods);
			pScreen.registerClick(keepOnlyModBtn, onKeepModsOnly);

			pScreen.registerClick(autoAddBtn, onAutoAdd);

			pScreen.registerEvent(chatCmdTxt, FocusEvent.FOCUS_OUT, onEdit);			
		}

		private function onClear() : void {
			uiMainMenu.viewGiveaway.viewNameList.removeViewFromParticipants(MetaGameProgress.instance.metaGiveawayConfig.participants);
			MetaGameProgress.instance.metaGiveawayConfig.participants = new Vector.<MetaParticipant>();
			uiMainMenu.viewGiveaway.viewNameList.setNames(MetaGameProgress.instance.metaGiveawayConfig.participants);
			uiMainMenu.viewGiveaway.viewNameList.refresh();
		}

		private function onKeepModsOnly() : void {
			if(uiMainMenu.viewGiveaway.viewNameList.isLoading()) return ;
			if(!TwitchConnection.isLoggedIn()) {
				UI_PopUp.createTwitchLoginRequired();
				return ;
			}
			
			var trimmedNames:Array = MetaGameProgress.instance.metaGiveawayConfig.removeNonMod();
			uiMainMenu.viewGiveaway.viewNameList.removeViewFromNames(trimmedNames);
			uiMainMenu.viewGiveaway.viewNameList.setNames(MetaGameProgress.instance.metaGiveawayConfig.participants);
			uiMainMenu.viewGiveaway.viewNameList.refresh();
		}

		private function onAddMods() : void {
			if(uiMainMenu.viewGiveaway.viewNameList.isLoading()) return ;
			if(!TwitchConnection.isLoggedIn()) {
				UI_PopUp.createTwitchLoginRequired();
				return ;
			}
			
			uiMainMenu.viewGiveaway.viewNameList.showLoading(true);
			
			var logicChat:LogicTwitchChat = UI_Menu.instance.logicNotification.logicListenToChat;
			TwitchConnection.instance.refreshMods(logicChat, new Callback(onModRefreshed, this, null), new Callback(onSubRefreshError, this, null));
			refresh();
		}

		private function onModRefreshed() : void {
			MetaGameProgress.instance.metaGiveawayConfig.addListInParticipants(TwitchConnection.instance.listOfMods, false);
			uiMainMenu.viewGiveaway.viewNameList.showLoading(false);
			uiMainMenu.viewGiveaway.viewNameList.setNames(MetaGameProgress.instance.metaGiveawayConfig.participants);
			uiMainMenu.viewGiveaway.viewNameList.refresh();
			refresh();
		}

		private function onKeepSubsOnly() : void {
			if(uiMainMenu.viewGiveaway.viewNameList.isLoading()) return ;
			if(!TwitchConnection.isLoggedIn()) {
				UI_PopUp.createTwitchLoginRequired();
				return ;
			}
			
			var trimmedNames:Array = MetaGameProgress.instance.metaGiveawayConfig.removeNonSub();
			uiMainMenu.viewGiveaway.viewNameList.removeViewFromNames(trimmedNames);
			uiMainMenu.viewGiveaway.viewNameList.setNames(MetaGameProgress.instance.metaGiveawayConfig.participants);
			uiMainMenu.viewGiveaway.viewNameList.refresh();
		}

		private function onAddSubs() : void {
			if(uiMainMenu.viewGiveaway.viewNameList.isLoading()) return ;
			if(!TwitchConnection.isLoggedIn()) {
				UI_PopUp.createTwitchLoginRequired();
				return ;
			}
			uiMainMenu.viewGiveaway.viewNameList.showLoading(true);
			TwitchConnection.instance.refreshSub(new Callback(onSubRefreshed, this, null), new Callback(onSubRefreshError, this, null));
			refresh();			
		}

		private function onSubRefreshed() : void {
			MetaGameProgress.instance.metaGiveawayConfig.addListInParticipants(TwitchConnection.instance.listOfSubs.createArrayOfName(), false);
			uiMainMenu.viewGiveaway.viewNameList.showLoading(false);
			uiMainMenu.viewGiveaway.viewNameList.setNames(MetaGameProgress.instance.metaGiveawayConfig.participants);
			uiMainMenu.viewGiveaway.viewNameList.refresh();
			refresh();
		}
		
		private function onRemoveSubs() : void {
			if(uiMainMenu.viewGiveaway.viewNameList.isLoading()) return ;
			if(!TwitchConnection.isLoggedIn()) {
				UI_PopUp.createTwitchLoginRequired();
				return ;
			}
			
			var trimmedNames:Array = MetaGameProgress.instance.metaGiveawayConfig.removeSub();
			uiMainMenu.viewGiveaway.viewNameList.removeViewFromNames(trimmedNames);
			uiMainMenu.viewGiveaway.viewNameList.setNames(MetaGameProgress.instance.metaGiveawayConfig.participants);
			uiMainMenu.viewGiveaway.viewNameList.refresh();
		}

		
		private function onSubRefreshError() : void {
			uiMainMenu.viewGiveaway.viewNameList.showLoading(false);
			refresh();
			
			if(!TwitchConnection.isLoggedIn()) return ;
			UI_PopUp.createOkOnly("Oops, I can't fetch your subs. Are you a partner on Twitch?", null);
		}
		
		public function addFromChat(name:String):void {
			if(MetaGameProgress.instance.metaGiveawayConfig.contains(name)) return;
			if(name == "") return; 
			MetaGameProgress.instance.metaGiveawayConfig.addSingleParticipant(name);
			uiMainMenu.viewGiveaway.viewNameList.setNames(MetaGameProgress.instance.metaGiveawayConfig.participants);
			uiMainMenu.viewGiveaway.viewNameList.refreshQuick();
			uiMainMenu.viewGiveaway.viewNameList.flash();
		}

		private function onEdit() : void {
			MetaGameProgress.instance.metaGiveawayConfig.autoChatAddCmd = chatCmdTxt.text;
			MetaGameProgress.instance.saveToLocal();
			UIBase.manager.refresh(); 
		}

		private function onAutoAdd() : void {
			MetaGameProgress.instance.metaGiveawayConfig.autoChatAdd = !MetaGameProgress.instance.metaGiveawayConfig.autoChatAdd;
			refresh();
		}
		
		private function onAddFromList() : void {
			if(uiMainMenu.viewGiveaway.viewNameList.isLoading()) return ;
			popupInsert = UIPopupInsert.createInsertReplaceAppendCancel("Enter list of names\n(separated by spaces)", new Callback(onAddFromListInput, this, null), new Callback(onAppendFromListInput, this, null), null);
			screen.doBtnPressAnim(addFromListBtn);
		}
		
		private function onIRC() : void {
			if(uiMainMenu.viewGiveaway.viewNameList.isLoading()) return ;
			popupInsert = UIPopupInsert.createInsertOne("Enter Channel Name", new Callback(onIRCInput, this, null), null);
			if(TwitchConnection.instance.isLoggedIn) {
				popupInsert.inputTxt.text = TwitchConnection.getNameOfAccount();
			} else {
				popupInsert.inputTxt.text = MetaGameProgress.instance.metaGiveawayConfig.channelToLoad;
			}
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
			DataManager.loadExternalNames(channelName, new Callback(onDataLoaded, this, [channelName]), new Callback(onDataLoadedError, this, null));
			uiMainMenu.viewGiveaway.viewNameList.showLoading(true);
			refresh();
		}
		
		public function cancelLoading():void {
			DataManager.cancel();
			uiMainMenu.viewGiveaway.viewNameList.showLoading(false);
			refresh();
		}

		private function onDataLoaded(channelName:String) : void {
			var obj:Object = JSON.parse(DataManager.loadedData);
		   	var arrayOfNames:Array = obj.chatters.viewers;
			var arrayOfMods:Array = obj.chatters.moderators;
			
			arrayOfNames = arrayOfNames.concat(arrayOfMods);
			removeNameFromList(arrayOfNames, channelName);
			
			MetaGameProgress.instance.metaGiveawayConfig.addListInParticipants(arrayOfNames, false);
			
			uiMainMenu.viewGiveaway.viewNameList.showLoading(false);
			uiMainMenu.viewGiveaway.viewNameList.setNames(MetaGameProgress.instance.metaGiveawayConfig.participants);
			MetaGameProgress.instance.metaGiveawayConfig.moderators = arrayOfMods;
			uiMainMenu.viewGiveaway.viewNameList.refresh();
			refresh();
		}
		
		private function removeNameFromList(list:Array, name:String):void {
			for (var i : int = 0; i < list.length; i++) {
				var crnt:String = list[i];
				if(crnt.toLowerCase() == name.toLowerCase()) {
					list.splice(i, 1);
					return ;
				}
			}
		}

		private function onDataLoadedError() : void {
			uiMainMenu.viewGiveaway.viewNameList.showLoading(false);
			refresh();
			UI_PopUp.createOkOnly("Oops, can't retrieve data from " + popupInsert.inputTxt.text + "'s Twitch Channel.", null);
		}
		
		private function onAddFromListInput() : void {
			var listNames:String = popupInsert.inputTxt.text;
			uiMainMenu.viewGiveaway.viewNameList.setNames(nameToArray(listNames));
			MetaGameProgress.instance.metaGiveawayConfig.participants = uiMainMenu.viewGiveaway.viewNameList.getNames();
			uiMainMenu.viewGiveaway.viewNameList.refresh();
		}
		
		private function onAppendFromListInput() : void {
			var listNames:String = popupInsert.inputTxt.text;
			var a:Vector.<MetaParticipant> = uiMainMenu.viewGiveaway.viewNameList.getNames();
			var b:Vector.<MetaParticipant> = nameToArray(listNames);
			a = a.concat(b);
			uiMainMenu.viewGiveaway.viewNameList.setNames(a);
			MetaGameProgress.instance.metaGiveawayConfig.participants = a;
			uiMainMenu.viewGiveaway.viewNameList.refresh();
		}
		
		static public function nameToArray(names:String):Vector.<MetaParticipant> {
			var splitter:String = "" ;
			var arrayTest:Array ;
			var justNamesSeparatedWithSpace:String ; 
			var resultString:Array ;
			var result:Vector.<MetaParticipant> = new Vector.<MetaParticipant>();
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
			
			resultString = justNamesSeparatedWithSpace.split(" ");
			
			for (var i : int = 0; i < resultString.length; i++) {
				result.push(new MetaParticipant(resultString[i]));
			}
			
			return result;
		}

		override public function refresh() : void {
			super.refresh();
			addFromListBtn.selectIfBoolean(uiMainMenu.viewGiveaway.viewNameList.isLoading());
			fetchFromIRCBtn.selectIfBoolean(uiMainMenu.viewGiveaway.viewNameList.isLoading());
			addSubsBtn.selectIfBoolean(uiMainMenu.viewGiveaway.viewNameList.isLoading());
			keepOnlySubBtn.selectIfBoolean(uiMainMenu.viewGiveaway.viewNameList.isLoading());
			addModBtn.selectIfBoolean(uiMainMenu.viewGiveaway.viewNameList.isLoading());
			keepOnlyModBtn.selectIfBoolean(uiMainMenu.viewGiveaway.viewNameList.isLoading());
			
			screen.setCheckBox(MetaGameProgress.instance.metaGiveawayConfig.autoChatAdd, autoAddBtn); 
			chatCmdTxt.text = MetaGameProgress.instance.metaGiveawayConfig.autoChatAddCmd;
		}
		
		static private function hasInstanceOf(str:String, msg:String):Boolean {
			 return (str.indexOf(msg) != -1);
		}
		
		public function get addFromListBtn() : ButtonSelect { return visual.getChildByName("addFromListBtn") as ButtonSelect;}
		public function get fetchFromIRCBtn() : ButtonSelect { return visual.getChildByName("fetchFromIRCBtn") as ButtonSelect;}
		public function get addSubsBtn() : ButtonSelect { return visual.getChildByName("addSubsBtn") as ButtonSelect;}
		public function get keepOnlySubBtn() : ButtonSelect { return visual.getChildByName("keepOnlySubBtn") as ButtonSelect;}
		public function get addModBtn() : ButtonSelect { return visual.getChildByName("addModBtn") as ButtonSelect;}
		public function get keepOnlyModBtn() : ButtonSelect { return visual.getChildByName("keepOnlyModBtn") as ButtonSelect;}
		public function get clearBtn() : ButtonSelect { return visual.getChildByName("clearBtn") as ButtonSelect;}
		public function get removeSubBtn() : ButtonSelect { return visual.getChildByName("removeSubBtn") as ButtonSelect;}
		
		
		
		
		public function get autoAddBtn() : MovieClip { return visual.getChildByName("autoAddBtn") as MovieClip;}
		public function get chatCmdTxt() : TextField { return visual.getChildByName("chatCmdTxt") as TextField;}
		public function get needOnlineMc1() : MovieClip { return visual.getChildByName("needOnlineMc1") as MovieClip;}
		public function get needOnlineMc2() : MovieClip { return visual.getChildByName("needOnlineMc2") as MovieClip;}
		public function get needOnlineMc3() : MovieClip { return visual.getChildByName("needOnlineMc3") as MovieClip;}
		public function get needOnlineMc4() : MovieClip { return visual.getChildByName("needOnlineMc4") as MovieClip;}
		public function get needOnlineMc5() : MovieClip { return visual.getChildByName("needOnlineMc5") as MovieClip;}
		public function get needOnlineMc6() : MovieClip { return visual.getChildByName("needOnlineMc6") as MovieClip;}	
		
	}
}
