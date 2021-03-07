package com.lachhh.lachhhengine.animation {
	import com.animation.exported.DUMMYOVERLAY;
	import com.animation.exported.FLV_DEALWITHIT;
	import com.animation.exported.FLV_ITSOVER9000;
	import com.animation.exported.FLV_JUSTDOIT;
	import com.animation.exported.FLV_THOMPSON;
	import com.animation.exported.FLV_VANDAMMECOVER;
	import com.animation.exported.FLV_VANDAMMESHOOT;
	import com.animation.exported.FLV_VANDAMME_EXPLODE;
	import com.animation.exported.FLV_VANDAMME_HIT;
	import com.animation.exported.FX_CHEER_BAG;
	import com.animation.exported.FX_CHEER_BIT1;
	import com.animation.exported.FX_CHEER_BIT100;
	import com.animation.exported.FX_CHEER_BIT1000;
	import com.animation.exported.FX_CHEER_BIT10000;
	import com.animation.exported.FX_CHEER_BIT5000;
	import com.animation.exported.FX_CHEER_CANON;
	import com.animation.exported.FX_CHEER_EXPLODE;
	import com.animation.exported.FX_CHEER_MONSTER_EAT;
	import com.animation.exported.FX_CHEER_MONSTER_IDLE;
	import com.animation.exported.FX_CHEER_MONSTER_IN;
	import com.animation.exported.FX_CHEER_MONSTER_OUT;
	import com.animation.exported.FX_CHEER_NAME;
	import com.animation.exported.FX_COUNTDOWNFEEDBACK;
	import com.animation.exported.FX_COUNTDOWN_SIMPLE;
	import com.animation.exported.FX_FIREWORK_TRAIL;
	import com.animation.exported.FX_GORE_1;
	import com.animation.exported.FX_GORE_2;
	import com.animation.exported.FX_GORE_3;
	import com.animation.exported.FX_NEWS_1_FOLLOWMSG;
	import com.animation.exported.FX_NEWS_1_FOLLOWMSGADOBE;
	import com.animation.exported.FX_NEWS_2_INFERNAX;
	import com.animation.exported.FX_NEWS_3_WHOISLACHHH;
	import com.animation.exported.FX_NEWS_4_JSB;
	import com.animation.exported.FX_NEWS_5_CHARITY;
	import com.animation.exported.FX_NEWS_6_CHARITYMOUSTACHE;
	import com.animation.exported.FX_NEWS_7_ZOMBIDLE;
	import com.animation.exported.FX_NEWS_7_ZOMBIDLEPG13;
	import com.animation.exported.FX_TWEET;
	import com.animation.exported.FX_TWEET_LACHHHISTER;
	import com.animation.exported.UI_DEBUGTEXT;
	import com.animation.exported.UI_DONATIONBIGGOALONLY;
	import com.animation.exported.UI_DONATIONINTRO;
	import com.animation.exported.UI_DONATIONINTROSMALL;
	import com.animation.exported.UI_DONATIONRECURGOALONLY;
	import com.animation.exported.UI_DONATIONTWOGOALS;
	import com.animation.exported.UI_DONATIONWIDGET;
	import com.animation.exported.UI_GOALREACHED;
	import com.animation.exported.UI_HALLOWEENDEAD;
	import com.animation.exported.UI_MOUSTACHECHARITY;
	import com.animation.exported.UI_NEWCHEER;
	import com.animation.exported.UI_NEWCHEEREXPLODE;
	import com.animation.exported.UI_NEWFOLLOWER;
	import com.animation.exported.UI_NEWHOSTBIG;
	import com.animation.exported.UI_NEWHOSTSMALL;
	import com.animation.exported.UI_NEWSUBSCRIBERS;
	import com.animation.exported.UI_NOCONNECTION;
	import com.lachhh.flash.FlashAnimation;
	import com.lachhh.io.KeyManager;
	import com.lachhh.lachhhengine.ui.UIEffect;

	/**
	 * @author LachhhSSD
	 */
	public class AnimationFactory {
		static public var allAnimationClass:Vector.<Class> = new Vector.<Class>();
		
		static public var EMPTY:int = pushClassLink(FlashAnimation);

		static public var ID_FX_GORE_1:int = pushClassLink(FX_GORE_1);
		static public var ID_FX_GORE_2:int = pushClassLink(FX_GORE_2);
		static public var ID_FX_GORE_3:int = pushClassLink(FX_GORE_3);		
		static public var ID_FX_COUNTDOWN_SIMPLE:int = pushClassLink(FX_COUNTDOWN_SIMPLE);
		static public var ID_FX_COUNTDOWNFEEDBACK:int = pushClassLink(FX_COUNTDOWNFEEDBACK);
		
		
		static public var ID_FX_CHEER_BAG:int = pushClassLink(FX_CHEER_BAG);
		static public var ID_FX_CHEER_BIT1:int = pushClassLink(FX_CHEER_BIT1);
		static public var ID_FX_CHEER_BIT100:int = pushClassLink(FX_CHEER_BIT100);
		static public var ID_FX_CHEER_BIT1000:int = pushClassLink(FX_CHEER_BIT1000);
		static public var ID_FX_CHEER_BIT10000:int = pushClassLink(FX_CHEER_BIT10000);
		static public var ID_FX_CHEER_BIT5000:int = pushClassLink(FX_CHEER_BIT5000);
		static public var ID_FX_CHEER_CANON:int = pushClassLink(FX_CHEER_CANON);
		static public var ID_FX_CHEER_EXPLODE:int = pushClassLink(FX_CHEER_EXPLODE);
		static public var ID_FX_CHEER_NAME:int = pushClassLink(FX_CHEER_NAME);
		static public var ID_FX_CHEER_MONSTER_EAT:int = pushClassLink(FX_CHEER_MONSTER_EAT);
		static public var ID_FX_CHEER_MONSTER_IDLE:int = pushClassLink(FX_CHEER_MONSTER_IDLE);
		static public var ID_FX_CHEER_MONSTER_IN:int = pushClassLink(FX_CHEER_MONSTER_IN);
		static public var ID_FX_CHEER_MONSTER_OUT:int = pushClassLink(FX_CHEER_MONSTER_OUT);
		
		static public var ID_FX_FIREWORK_TRAIL:int = pushClassLink(FX_FIREWORK_TRAIL);
		
		static public var ID_UI_DONATIONINTRO:int = pushClassLink(UI_DONATIONINTRO);
		static public var ID_UI_DONATIONRECURGOALONLY:int = pushClassLink(UI_DONATIONRECURGOALONLY);
		static public var ID_UI_DONATIONINTROSMALL:int = pushClassLink(UI_DONATIONINTROSMALL);
		static public var ID_UI_NEWHOSTBIG:int = pushClassLink(UI_NEWHOSTBIG);
		static public var ID_UI_NEWHOSTSMALL:int = pushClassLink(UI_NEWHOSTSMALL);
		static public var ID_UI_NEWCHEER:int = pushClassLink(UI_NEWCHEER);
		static public var ID_UI_NEWCHEEREXPLODE:int = pushClassLink(UI_NEWCHEEREXPLODE);
		static public var ID_UI_NOCONNECTION:int = pushClassLink(UI_NOCONNECTION);
		
		static public var ID_UI_HALLOWEENDEAD:int = pushClassLink(UI_HALLOWEENDEAD);
		
		static public var ID_FX_NEWS_6_CHARITYMOUSTACHE:int = pushClassLink(FX_NEWS_6_CHARITYMOUSTACHE);
		static public var ID_UI_MOUSTACHECHARITY:int = pushClassLink(UI_MOUSTACHECHARITY);
		

		
		
		static public var ID_UI_GOALREACHED:int = pushClassLink(UI_GOALREACHED);

		static public var ID_UI_DONATIONBIGGOALONLY:int = pushClassLink(UI_DONATIONBIGGOALONLY);
		static public var ID_UI_DONATIONTWOGOALS:int = pushClassLink(UI_DONATIONTWOGOALS);
		static public var ID_UI_DONATIONWIDGET:int = pushClassLink(UI_DONATIONWIDGET);
		static public var ID_DUMMYOVERLAY:int = pushClassLink(DUMMYOVERLAY);
		static public var ID_UI_DEBUGTEXT:int = pushClassLink(UI_DEBUGTEXT);
		
		static public var ID_FX_NEWS_1_FOLLOWMSG:int = pushClassLink(FX_NEWS_1_FOLLOWMSG);
		static public var ID_FX_NEWS_1_FOLLOWMSGADOBE:int = pushClassLink(FX_NEWS_1_FOLLOWMSGADOBE);
		
		static public var ID_FX_NEWS_2_INFERNAX:int = pushClassLink(FX_NEWS_2_INFERNAX);
		static public var ID_FX_NEWS_3_WHOISLACHHH:int = pushClassLink(FX_NEWS_3_WHOISLACHHH);
		static public var ID_FX_NEWS_4_JSB:int = pushClassLink(FX_NEWS_4_JSB);
		static public var ID_FX_NEWS_5_CHARITY:int = pushClassLink(FX_NEWS_5_CHARITY);
		static public var ID_FX_NEWS_7_ZOMBIDLE:int = pushClassLink(FX_NEWS_7_ZOMBIDLE);
		static public var ID_FX_NEWS_7_ZOMBIDLEPG13:int = pushClassLink(FX_NEWS_7_ZOMBIDLEPG13);
		
		
		static public var ID_FX_TWEET:int = pushClassLink(FX_TWEET);
		static public var ID_FX_TWEET_LACHHHISTER:int = pushClassLink(FX_TWEET_LACHHHISTER);
		
		
		static public var ID_FLV_JUSTDOIT:int = pushClassLink(FLV_JUSTDOIT);
		static public var ID_FLV_VANDAMMECOVER:int = pushClassLink(FLV_VANDAMMECOVER);
		static public var ID_FLV_VANDAMMESHOOT:int = pushClassLink(FLV_VANDAMMESHOOT);

		static public var ID_FLV_VANDAMME_EXPLODE:int = pushClassLink(FLV_VANDAMME_EXPLODE);
		static public var ID_FLV_VANDAMME_HIT:int = pushClassLink(FLV_VANDAMME_HIT);
		static public var ID_FLV_DEALWITHIT:int = pushClassLink(FLV_DEALWITHIT);
		static public var ID_FLV_THOMPSON:int = pushClassLink(FLV_THOMPSON);
		static public var ID_FLV_ITSOVER9000:int = pushClassLink(FLV_ITSOVER9000);
		
		static public var ID_UI_NEWSUBSCRIBERS:int = pushClassLink(UI_NEWSUBSCRIBERS);
		static public var ID_UI_NEWFOLLOWER:int = pushClassLink(UI_NEWFOLLOWER);
		
		
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
