package com.giveawaytool.ui.views {
	import com.giveawaytool.effect.CallbackTimerEffect;
	import com.giveawaytool.effect.CallbackWaitEffect;
	import com.giveawaytool.effect.EffectGotoElastic2;
	import com.giveawaytool.ui.UI_LoteryWinner;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.lachhhengine.sfx.SfxFactory;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.ui.views.ViewBase;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;
	import flash.utils.getTimer;

	/**
	 * @author LachhhSSD
	 */
	public class ViewLoteryNameGroup extends ViewBase {
		public var Y_THRESHOLD:int = 530;
		public var MAX_VIEW:int = 10;
		public var names:Array ;
		public var speed:Number = 25 ;
		public var modSpeed:Number = 0 ;
		public var isSpinning:Boolean = true ;
		public var rectify:Boolean = false ;
		public var callbackOnEnd:Callback;
		public var callbackOnDestroy:Callback;
		public var currentWinner:ViewLoteryName;
		private var lastTimer:int;
		private var indexInList:int = 0;
			
		public var views:Vector.<ViewLoteryName> = new Vector.<ViewLoteryName>();
		public function ViewLoteryNameGroup(pScreen : UIBase, pVisual : DisplayObject) {
			super(pScreen, pVisual);
		}
		
		public function destroyAllChildren():void {
			while(views.length > 0) {
				var view:ViewBase = views.shift();
				view.destroy();
			}
		}
		
		public function createViews():void {
			destroyAllChildren();
			
			randomizeNames();
			
			while(names.length < MAX_VIEW) {
				duplicateNames();
			}
			
			
			for (var i : int = 0; i < MAX_VIEW; i++) {
				var name:String = names[i];
				var newView:ViewLoteryName = new ViewLoteryName(screen);
				newView.name = name;
				newView.refresh();
				newView.visual.x = 640;
				newView.visual.y = i*80-(MAX_VIEW*80);
				visualMc.addChild(newView.visual);
				views.push(newView);
			}
			indexInList = MAX_VIEW;
		}
		
		private function randomizeNames():void {
			var m = names.length;
			var temp;
			var i;

			while(m){
				i = Math.floor(Math.random() * m--);
				temp = names[m]
				names[m] = names[i];
				names[i] = temp;
			}
		}
		
		private function duplicateNames():void {
			names = names.concat(names);
		}
		
		
		public function stop():void {
			modSpeed = -0.05;
			lastTimer = getTimer();
		}	
				
		override public function update() : void {
			super.update();
			if(views.length <= 0) return ;
			if(isSpinning) {
				spinWheel();
				if(speed <= 5) {
					modSpeed = -0.04;
				}
				
				if(speed <= 2) {
					modSpeed = -0.03;
				}
				
				if(speed <= 0) {
					CallbackWaitEffect.addWaitCallFctToActor(actor, onWaitAfterSpin, 30);
					isSpinning = false;
				}
			} else if(rectify) {
				
				rectifyPosition();
				spinWheel();
			}

			setTintOfAllView();
			
			var delta:Number = getTimer() - lastTimer;
			var speedRectify:Number = delta / (1000/28); 
			speed += modSpeed*speedRectify;		
			lastTimer = getTimer();
		}
		
		private function setTintOfAllView():void {
			var theView:ViewLoteryName;
			for (var i : int = 0; i < views.length; i++) {
				theView = views[i] as ViewLoteryName;
				Utils.SetColor(theView.visual);
				theView.visual.scaleX +=(0.75-theView.visual.scaleX)*0.5;
				theView.visual.scaleY = theView.visual.scaleX; 
			}
			
			theView = getClosestToMiddleOfScreen();
			//theView.visual.scaleX += (1.5-theView.visual.scaleX)*0.1;
			//theView.visual.scaleY = theView.visual.scaleX;
			
			theView.visual.scaleX += (1.5-theView.visual.scaleX)*0.5;
			theView.visual.scaleY = theView.visual.scaleX;
			
			Utils.SetColor2(theView.visual, 0xFFFFFF);
			
			if(currentWinner != theView){ 
				currentWinner = theView;
				JukeBox.playSound(SfxFactory.ID_SFX_UI_SLOT_MACHINE_BEEP_2);
			}
		}
		
		private function onWaitAfterSpin():void {
			rectify = true;
			fadeOutLosers();
			var winner:ViewLoteryName = getClosestToMiddleOfScreen(); 
			winner.startWinAnim();
			
			var screen:UI_LoteryWinner = new UI_LoteryWinner(winner.name);
			screen.callbackEnd = callbackOnDestroy;
			if(callbackOnEnd) callbackOnEnd.call();
		}
		
		private function fadeOutLosers():void {
			var winner:ViewBase = getClosestToMiddleOfScreen();
			for (var i : int = 0; i < views.length; i++) {
				var theView:ViewLoteryName = views[i] as ViewLoteryName;
				if(winner != theView) {
					theView.fadeOut();
				}
			}
		}
		
		private function rectifyPosition():void {
			var theView:ViewBase = getClosestToMiddleOfScreen();
			var diff:Number = (theView.visual.y - 360);
			speed = -(diff*0.1);
		}
		
		private function getClosestToMiddleOfScreen():ViewLoteryName {
			var minDiff:int = 9999;
			var result:ViewLoteryName ;
			for (var i : int = 0; i < views.length; i++) {
				var theView:ViewLoteryName = views[i] ;
				var diff:int = Math.abs(theView.visual.y - 360);
				if(diff < minDiff) {
					minDiff = diff;
					result = theView;
				}
			}
			return result;
		}
		
		private function spinWheel():void {
			for (var i : int = 0; i < views.length; i++) {
				var theView:ViewLoteryName = views[i];
				theView.visual.y += speed;
				
				var isOutSideOfView:Boolean = (theView.visual.y > Y_THRESHOLD); 
				if(isOutSideOfView) {
					 theView.visual.y -= (views.length*80);
					 indexInList++;
					 if(indexInList >= names.length) {
						indexInList -= names.length;
					 }
					 theView.name = names[indexInList];
					 theView.refresh();
					 
				}
			}
		}
		
		

		override public function refresh() : void {
			super.refresh();
			createViews();
		}
	}
}
