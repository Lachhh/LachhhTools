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
		static public var ID_UI_MAINMENU:int = pushClassLink(UI_MAINMENU);
		static public var ID_UI_OVERLAY:int = pushClassLink(UI_OVERLAY);
		static public var ID_UI_POPUP:int = pushClassLink(UI_POPUP);
		static public var ID_UI_POPUPINSERTBIG:int = pushClassLink(UI_POPUPINSERTBIG);
		static public var ID_UI_POPUPINSERTONE:int = pushClassLink(UI_POPUPINSERTONE);
		static public var ID_FX_WINNERSNAPSHOT1:int = pushClassLink(FX_WINNERSNAPSHOT1);
		static public var ID_FX_MONSTER_EAT_EAT:int = pushClassLink(FX_MONSTER_EAT_EAT);
		static public var ID_FX_MONSTER_EAT_IDLE:int = pushClassLink(FX_MONSTER_EAT_IDLE);
		static public var ID_FX_BLOODPARTICLE_RANDOM:int = pushClassLink(FX_BLOODPARTICLE_RANDOM);
		static public var ID_FX_LETTER:int = pushClassLink(FX_LETTER);
		static public var ID_FX_MONSTER_EAT_BEATEN:int = pushClassLink(FX_MONSTER_EAT_BEATEN);
		static public var ID_FX_TWITTERACOUNT:int = pushClassLink(FX_TWITTERACOUNT);
		static public var ID_UI_SELECTANIMATION:int = pushClassLink(UI_SELECTANIMATION);
		
		
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

		static public var ID_UI_PNGTHUMBNAIL:int = pushClassLink(UI_PNGTHUMBNAIL);
		static public var ID_UI_MONSTER_COUNTDOWN:int = pushClassLink(UI_MONSTER_COUNTDOWN);
		static public var ID_UI_UPDATE:int = pushClassLink(UI_UPDATE);
		
		
		static public var ID_FX_LOTERYNAME:int = pushClassLink(FX_LOTERYNAME);
		static public var ID_FX_NAME:int = pushClassLink(FX_NAME);
		static public var ID_FX_NAME_CENTERED:int = pushClassLink(FX_NAME_CENTERED);
		static public var ID_FX_NAME_BTN:int = pushClassLink(FX_NAME_BTN);
		
		static public var ZZ_BTN_ARROW:int = pushBtnLink(BTN_ARROW);
		
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
