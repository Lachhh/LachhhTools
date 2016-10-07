package com.giveawaytool.ui.views {
	import flash.text.TextField;
	import com.giveawaytool.meta.MetaGameProgress;
	import flash.display.MovieClip;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.lachhhengine.ui.UIBase;

	import flash.display.DisplayObject;

	/**
	 * @author Eel
	 */
	public class ViewFireworksOptions extends ViewBase {
		public function ViewFireworksOptions(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
			
			screen.registerClick(toggleChatCommand, onEnableChatCmd);
			screen.registerClick(toggleChatCmdMods, onModsCanUseCmd);
			screen.registerClick(fireworksAutoTrigger, onAutoTrigger);
			
			screen.registerClick(toggleAutoOnDonation, onToggleAutoDonation);
			screen.registerClick(toggleAutoOnSub, onToggleAutoSub);
			screen.registerClick(toggleAutoOnHost, onToggleAutoHost);
			
			screen.registerClick(toggleEnabled, toggleFireworksEnabled);
			screen.setNameOfDynamicBtn(toggleEnabled, "Toggle");
		}
		
		public override function start():void{
			super.start();
		}
		
		public override function refresh():void{
			super.refresh();
			setCheckBox(MetaGameProgress.instance.metaEmoteFireworksSettings.chatCommandEnabled, toggleChatCommand);
			setCheckBox(MetaGameProgress.instance.metaEmoteFireworksSettings.modsCanUseCommand, toggleChatCmdMods);
			setCheckBox(MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerOnBigEvent, fireworksAutoTrigger);
			
			setCheckBox(MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerOnBigDonation, toggleAutoOnDonation);
			setCheckBox(MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerOnSubscription, toggleAutoOnSub);
			setCheckBox(MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerOnBigHost, toggleAutoOnHost);
		}
		
		public function setCheckBox(value : Boolean, btn : MovieClip) : void {
			var checkedMc : MovieClip = btn.getChildByName("checkedMc") as MovieClip;
			if(checkedMc) checkedMc.visible = value;
		}
		
		private function toggleFireworksEnabled():void{
			MetaGameProgress.instance.metaEmoteFireworksSettings.toggleForceEnabled();
			refresh();
		}
		
		private function onEnableChatCmd():void{
			MetaGameProgress.instance.metaEmoteFireworksSettings.chatCommandEnabled = !MetaGameProgress.instance.metaEmoteFireworksSettings.chatCommandEnabled;
			refresh();
		}
		
		private function onModsCanUseCmd():void{
			MetaGameProgress.instance.metaEmoteFireworksSettings.modsCanUseCommand = !MetaGameProgress.instance.metaEmoteFireworksSettings.modsCanUseCommand;
			refresh();
		}
		
		private function onAutoTrigger():void{
			MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerOnBigEvent = !MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerOnBigEvent;
			refresh();
		}
		
		private function onToggleAutoDonation():void{
			MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerOnBigDonation = !MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerOnBigDonation;
			refresh();
		}
		
		private function onToggleAutoSub():void{
			MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerOnSubscription = !MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerOnSubscription;
			refresh();
		}
		
		private function onToggleAutoHost():void{
			MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerOnBigHost = !MetaGameProgress.instance.metaEmoteFireworksSettings.autoTriggerOnBigHost;
			refresh();
		}
		
		public override function update():void{
			super.update();
			if(MetaGameProgress.instance.metaEmoteFireworksSettings.forceFireworksEnabled){
				fireworksStatus.text = "Force Enabled! Go crazy!";
			} else {
				if(MetaGameProgress.instance.metaEmoteFireworksSettings.canShowFireworks()){
					var duration:Number = MetaGameProgress.instance.metaEmoteFireworksSettings.getDurationRemaining();
					fireworksStatus.text = "Enabled! " + duration + " seconds left";
				} else {
					fireworksStatus.text = "Disabled";
				}
			}
		}
		
		public function get toggleChatCommand(): MovieClip { return visual.getChildByName("toggleChatCommand") as MovieClip;}
		public function get toggleChatCmdMods(): MovieClip { return visual.getChildByName("toggleChatCmdMods") as MovieClip;}
		public function get fireworksAutoTrigger(): MovieClip { return visual.getChildByName("fireworksAutoTrigger") as MovieClip;}
		public function get toggleEnabled(): MovieClip { return visual.getChildByName("toggleEnabled") as MovieClip;}
		public function get fireworksStatus() : TextField { return visual.getChildByName("fireworksStatus") as TextField;}
		
		public function get toggleAutoOnDonation(): MovieClip { return visual.getChildByName("toggleAutoOnDonation") as MovieClip;}
		public function get toggleAutoOnSub(): MovieClip { return visual.getChildByName("toggleAutoOnSub") as MovieClip;}
		public function get toggleAutoOnHost(): MovieClip { return visual.getChildByName("toggleAutoOnHost") as MovieClip;}
	}
}