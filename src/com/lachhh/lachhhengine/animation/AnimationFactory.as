package com.lachhh.lachhhengine.animation {
	import com.animation.exported.*;
	import com.lachhh.flash.FlashAnimation;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.ui.UIEffect;

	/**
	 * @author LachhhSSD
	 */
	public class AnimationFactory {
		static public var allAnimationClass:Vector.<Class> = new Vector.<Class>();
		
		static public var EMPTY:int = pushClassLink(FlashAnimation);
		static public var ID_UI_TODAYWINNER:int = pushClassLink(UI_TODAYWINNER);
		static public var ID_UI_LOTERYSPINNING:int = pushClassLink(UI_LOTERYSPINNING);
		static public var ID_UI_GIVEAWAY:int = pushClassLink(UI_GIVEAWAY);
		static public var ID_UI_CHEERSALERTS:int = pushClassLink(UI_CHEERSALERTS);
		//static public var ID_UI_PATREONPROMO:int = pushClassLink(UI_PATREONPROMO);
		

		static public var ID_UI_OVERLAY:int = pushClassLink(UI_OVERLAY);
		static public var ID_UI_POPUP:int = pushClassLink(UI_POPUP);
		static public var ID_UI_POPUPINSERTBIG:int = pushClassLink(UI_POPUPINSERTBIG);
		static public var ID_UI_POPUPINSERTONE:int = pushClassLink(UI_POPUPINSERTONE);
		static public var ID_UI_POPUPDONATIONSETTINGS:int = pushClassLink(UI_POPUPDONATIONSETTINGS);
		static public var ID_UI_MENU:int = pushClassLink(UI_MENU);
		
		static public var ID_FX_WINNERSNAPSHOT1:int = pushClassLink(FX_WINNERSNAPSHOT1);
		static public var ID_FX_MONSTER_EAT_EAT:int = pushClassLink(FX_MONSTER_EAT_EAT);
		static public var ID_FX_MONSTER_EAT_IDLE:int = pushClassLink(FX_MONSTER_EAT_IDLE);
		static public var ID_FX_BLOODPARTICLE_RANDOM:int = pushClassLink(FX_BLOODPARTICLE_RANDOM);
		static public var ID_FX_LETTER:int = pushClassLink(FX_LETTER);
		static public var ID_FX_MONSTER_EAT_BEATEN:int = pushClassLink(FX_MONSTER_EAT_BEATEN);
		static public var ID_FX_TWITTERACOUNT:int = pushClassLink(FX_TWITTERACOUNT);
		static public var ID_UI_SELECTANIMATION:int = pushClassLink(UI_SELECTANIMATION);
		static public var ID_UI_DONATION:int = pushClassLink(UI_DONATION);
		static public var ID_UI_PLAYMOVIE:int = pushClassLink(UI_PLAYMOVIE);
		static public var ID_UI_LOADING:int = pushClassLink(UI_LOADING);
		static public var ID_UI_ANNOYINGPOPUP:int = pushClassLink(UI_ANNOYINGPOPUP);
		
		static public var ID_FX_TWITTERSMALL:int = pushClassLink(FX_TWITTERSMALL);
		
		
		static public var ID_FX_IMPACT1:int = pushClassLink(FX_IMPACT1);
		static public var ID_FX_IMPACT2:int = pushClassLink(FX_IMPACT2);
		
		static public var ID_FX_BLOODPARTICLE_1:int = pushClassLink(FX_BLOODPARTICLE_1);
		static public var ID_FX_BLOODPARTICLE_2:int = pushClassLink(FX_BLOODPARTICLE_2);
		static public var ID_FX_BLOODPARTICLE_3:int = pushClassLink(FX_BLOODPARTICLE_3);
		static public var ID_FX_BLOODPARTICLE_4:int = pushClassLink(FX_BLOODPARTICLE_4);
		static public var ID_FX_GORE_BODY01:int = pushClassLink(FX_GORE_BODY01);
		static public var ID_FX_GORE_ARM01:int = pushClassLink(FX_GORE_ARM01);
		static public var ID_FX_GORE_FEET01:int = pushClassLink(FX_GORE_FEET01);
		static public var ID_FX_GORE_HEAD01:int = pushClassLink(FX_GORE_HEAD01);
		static public var ID_FX_GORE_RANDOM01:int = pushClassLink(FX_GORE_RANDOM01);
		static public var ID_FX_GORE_SHOULDER01:int = pushClassLink(FX_GORE_SHOULDER01);
		static public var ID_FX_DONATION:int = pushClassLink(FX_DONATION);
		static public var ID_FX_SUBSCRIBER:int = pushClassLink(FX_SUBSCRIBER);
		
		

		static public var ID_UI_PNGTHUMBNAIL:int = pushClassLink(UI_PNGTHUMBNAIL);
		static public var ID_UI_MONSTER_COUNTDOWN:int = pushClassLink(UI_MONSTER_COUNTDOWN);
		static public var ID_UI_UPDATE:int = pushClassLink(UI_UPDATE);
		static public var ID_UI_POPUPEDITDONATION:int = pushClassLink(UI_POPUPEDITDONATION);
		static public var ID_UI_FOLLOWSUBALERT:int = pushClassLink(UI_FOLLOWSUBALERT);
		static public var ID_UI_YOUTUBEPREVIEW:int = pushClassLink(UI_YOUTUBEPREVIEW);
		static public var ID_UI_TUTORIALWIDGET:int = pushClassLink(UI_TUTORIALWIDGET);
		static public var ID_UI_CREDITSPROMO:int = pushClassLink(UI_CREDITSPROMO);
		static public var ID_UI_VIPPROMO:int = pushClassLink(UI_VIPPROMO);
		static public var ID_FX_HALLOFFAME_BTN:int = pushClassLink(FX_HALLOFFAME_BTN);
		
		static public var ID_UI_ZOMBIDLEAD:int = pushClassLink(UI_ZOMBIDLEAD);
		static public var ID_UI_JSB_ADS:int = pushClassLink(UI_JSB_ADS);
		
		
		
		static public var ID_FX_LOTERYNAME:int = pushClassLink(FX_LOTERYNAME);
		static public var ID_FX_NAME:int = pushClassLink(FX_NAME);
		static public var ID_FX_NAME_CENTERED:int = pushClassLink(FX_NAME_CENTERED);
		static public var ID_FX_NAME_BTN:int = pushClassLink(FX_NAME_BTN);
				
		static public var ZZ_BTN_ARROW:int = pushBtnLink(BTN_ARROW);
		static public var ZZ_BTN_DONATION:int = pushBtnLink(BTN_DONATION);
		static public var ZZ_BTN_LOADALL:int = pushBtnLink(BTN_LOADALL);
		static public var ZZ_BTN_LOADDONATIONS:int = pushBtnLink(BTN_LOADDONATIONS);
		
		static public var ZZ_BTN_LOGOCREDITS:int = pushBtnLink(BTN_LOGOCREDITS);
		static public var ZZ_BTN_STARTANIMATION:int = pushBtnLink(BTN_STARTANIMATION);
		static public var ZZ_BTN_ADDFROMLISTOFNAME:int = pushBtnLink(BTN_ADDFROMLISTOFNAME);
		static public var ZZ_BTN_FETCHFROMIRC:int = pushBtnLink(BTN_FETCHFROMIRC);
		static public var ZZ_BTN_MANUALADD:int = pushBtnLink(BTN_MANUALADD);
		static public var ZZ_BTN_NAME:int = pushBtnLink(BTN_NAME);
		static public var ZZ_BTN_NO:int = pushBtnLink(BTN_NO);
		static public var ZZ_BTN_OK:int = pushBtnLink(BTN_OK);
		static public var ZZ_BTN_YES:int = pushBtnLink(BTN_YES);
		static public var ZZ_BTN_CANCEL:int = pushBtnLink(BTN_CANCEL);
		static public var ZZ_BTN_DYNAMICNAME:int = pushBtnLink(BTN_DYNAMICNAME);
		static public var ZZ_BTN_FULLSCREEN:int = pushBtnLink(BTN_FULLSCREEN);
		static public var ZZ_BTN_SKIP:int = pushBtnLink(BTN_SKIP);
		static public var ZZ_BTN_DYNAMICNAMESMALL:int = pushBtnLink(BTN_DYNAMICNAMESMALL);
		static public var ZZ_BTN_CHECKBOX:int = pushBtnLink(BTN_CHECKBOX);
		static public var ZZ_BTN_BACK:int = pushBtnLink(BTN_BACK);
		static public var ZZ_BTN_MORE:int = pushBtnLink(BTN_MORE);
		static public var ZZ_BTN_TWEET:int = pushBtnLink(BTN_TWEET);
		static public var ZZ_BTN_SELECT:int = pushBtnLink(BTN_SELECT);
		static public var ZZ_BTN_X:int = pushBtnLink(BTN_X);
		static public var ZZ_BTN_OPTIONSBOX:int = pushBtnLink(BTN_OPTIONSBOX);
		static public var ZZ_BTN_SAVETHEGUY:int = pushBtnLink(BTN_SAVETHEGUY);
		static public var ZZ_BTN_CHECKBOX2:int = pushBtnLink(BTN_CHECKBOX2);
		static public var ZZ_BTN_DYNAMICNAMESMALL2:int = pushBtnLink(BTN_DYNAMICNAMESMALL2);
		static public var ZZ_BTN_FOLLOWERS:int = pushBtnLink(BTN_FOLLOWERS);
		static public var ZZ_BTN_DONATIONS:int = pushBtnLink(BTN_DONATIONS);
		static public var ZZ_BTN_GIVEAWAY:int = pushBtnLink(BTN_GIVEAWAY);
		static public var ZZ_BTN_TWITTER:int = pushBtnLink(BTN_TWITTER);
		static public var ZZ_BTN_HOST:int = pushBtnLink(BTN_HOST);
		static public var ZZ_BTN_INFORMATION:int = pushBtnLink(BTN_INFORMATION);
		static public var ZZ_BTN_PLAYMOVIE:int = pushBtnLink(BTN_PLAYMOVIE);
		static public var ZZ_BTN_LISTENTOCHAT:int = pushBtnLink(BTN_LISTENTOCHAT);
		
		static public var ZZ_BTN_PREVIEWYOUTUBE:int = pushBtnLink(BTN_PREVIEWYOUTUBE);
		static public var ZZ_BTN_STREAMRPGPROMO:int = pushBtnLink(BTN_STREAMRPGPROMO);
		static public var ZZ_BTN_CHECKPATREON:int = pushBtnLink(BTN_CHECKPATREON);
		static public var ZZ_BTN_GOTOADOBE:int = pushBtnLink(BTN_GOTOADOBE);
		
		static public var ZZ_BTN_APPSTORE:int = pushBtnLink(BTN_APPSTORE);
		static public var ZZ_BTN_GOOGLEPLAY:int = pushBtnLink(BTN_GOOGLEPLAY);
		static public var ZZ_BTN_DYNAMICNAMESMALL3:int = pushBtnLink(BTN_DYNAMICNAMESMALL3);
		
		static public var ZZ_BTN_TESTONWIDGET:int = pushBtnLink(BTN_TESTONWIDGET);
		static public var ZZ_BTN_PREVIEWYOUTUBE2:int = pushBtnLink(BTN_PREVIEWYOUTUBE2);

		static public var ZZ_BTN_LACHHH:int = pushBtnLink(BTN_LACHHH);
		static public var ZZ_BTN_MARC:int = pushBtnLink(BTN_MARC);
		static public var ZZ_BTN_EMILIE:int = pushBtnLink(BTN_EMILIE);
		
		static public var ZZ_BTN_TWITCHHANDLELACHHH:int = pushBtnLink(BTN_TWITCHHANDLELACHHH);
		static public var ZZ_BTN_TWITTERHANDLEEM:int = pushBtnLink(BTN_TWITTERHANDLEEM);
		static public var ZZ_BTN_TWITTERHANDLELACHHH:int = pushBtnLink(BTN_TWITTERHANDLELACHHH);
		static public var ZZ_BTN_TWITTERHANDLEMARC:int = pushBtnLink(BTN_TWITTERHANDLEMARC);
		static public var ZZ_BTN_DYNAMICNAMESMALL4:int = pushBtnLink(BTN_DYNAMICNAMESMALL4);
		
		static public var ZZ_BTN_DISCORD:int = pushBtnLink(BTN_DISCORD);
		static public var ZZ_BTN_TUTORIAL:int = pushBtnLink(BTN_TUTORIAL);
		
		static public var ZZ_BTN_DISCORDCHANNEL:int = pushBtnLink(BTN_DISCORDCHANNEL);
		static public var ZZ_BTN_DYNAMICLINK:int = pushBtnLink(BTN_DYNAMICLINK);
		static public var ZZ_BTN_VIP:int = pushBtnLink(BTN_VIP);
		static public var ZZ_BTN_HALLOFFAME:int = pushBtnLink(BTN_HALLOFFAME);
		static public var ZZ_BTN_CHECKPROMOTE:int = pushBtnLink(BTN_CHECKPROMOTE);
		
		static public var ZZ_BTN_BERZERKHANDLE:int = pushBtnLink(BTN_BERZERKHANDLE);
		static public var ZZ_BTN_GAMEWISPLACHHHANDLE:int = pushBtnLink(BTN_GAMEWISPLACHHHANDLE);
		static public var ZZ_BTN_CHECKPATREON2:int = pushBtnLink(BTN_CHECKPATREON2);
		
		static public var ZZ_BTN_BERZERKCIRCLE:int = pushBtnLink(BTN_BERZERKCIRCLE);
		static public var ZZ_BTN_GAEMWISPSTARCIRCLE:int = pushBtnLink(BTN_GAEMWISPSTARCIRCLE);
		static public var ZZ_BTN_CURSORSLIDER:int = pushBtnLink(BTN_CURSORSLIDER);
		static public var ZZ_BTN_GOTOOBS:int = pushBtnLink(BTN_GOTOOBS);
		
		static public var ZZ_BTN_CONNECTGAMEWISP:int = pushBtnLink(BTN_CONNECTGAMEWISP);
		static public var ZZ_BTN_SUBSCRIBER:int = pushBtnLink(BTN_SUBSCRIBER);
		static public var ZZ_BTN_GAMEWISPBADGE:int = pushBtnLink(BTN_GAMEWISPBADGE);

		static public function pushClassLink(pClass:Class):int {
			allAnimationClass.push(pClass);
			return (allAnimationClass.length-1);
		}

		static public function pushBtnLink(pClass:Class):int {
			return -1;
		}

		static public function createAnimationInstance(instanceType:int):FlashAnimation {
			if(allAnimationClass[instanceType] == null) {
				throw new Error("Invalid ID");
			}
			
			var animationClass:Class = allAnimationClass[instanceType];
			
			return new animationClass();
		}
	
		
		static public function getClassAt(i:int):Class {
			return allAnimationClass[i];
		}
		
		static  public function getNbClass():int {
			return allAnimationClass.length;
		}
		
		static public function createStaticUiFxImpact():UIEffect { 
			var result:UIEffect = UIEffect.createStaticUiFx(0, KeyManager.GetMousePos().x, KeyManager.GetMousePos().y);
			return result; 
		}
		
		
	}
}
