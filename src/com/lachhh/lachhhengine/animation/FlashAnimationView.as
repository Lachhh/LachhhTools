package com.lachhh.lachhhengine.animation {
	import com.lachhh.flash.FlashAnimation;
	import com.lachhh.flash.FlashUtils;
	import com.lachhh.io.Callback;
	import com.lachhh.lachhhengine.GameSpeed;
	import com.lachhh.lachhhengine.VersionInfo;
	import com.lachhh.lachhhengine.sfx.JukeBox;
	import com.lachhh.utils.Utils;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	/**
	 * @author LachhhSSD
	 */
	
	public class FlashAnimationView {
		static public var tempArray:Array = new Array();
		public var timeBased:Boolean = true;
		public var debugAnimName : String = "";
		
		public var visual:DisplayObjectContainer;
		public var anim:MovieClip;
		public var animId:int;
		public var x:Number;
		public var y:Number;
		public var scaleX:Number;
		public var scaleY:Number;
		public var rotation:Number;
		public var fps:Number = 60;
		public var isPlaying:Boolean;
		public var isLooping:Boolean;
		public var loops:int;
		
		public var bounds:Rectangle;
		public var controlChildrenTimeLineRecursively:Boolean = false;
		
		public var callbackOnEnd:Vector.<Callback>;
		public var callbackOnFrame:Vector.<FlashAnimationViewCallback>; 
		
		private var oldX:Number;
		private var oldY:Number;
		private var oldScaleX:Number;
		private var oldScaleY:Number;
		private var oldRotation:Number;
		
		private var timeLastFrame : Number;
		private var currentframeAsNumber : Number;
		
		private var childrenToNotUpdate: Array = new Array();
		
		public function FlashAnimationView(parentVisual:DisplayObjectContainer) {
			visual = parentVisual;
		    anim = null;
		    animId = -1;
		    x = 0;
		    y = 0;
		    scaleX = 1;
		    scaleY = 1;
			rotation = 0;
		    callbackOnEnd = new Vector.<Callback>();
		    callbackOnFrame = new Vector.<FlashAnimationViewCallback>();
			bounds = new Rectangle();
			isPlaying = true;
			isLooping = true;
			loops = 0;
			currentframeAsNumber = 1;
			controlChildrenTimeLineRecursively = false;
		}
		
		public function destroy():void { 
		    destroyAnimation();
		}
		
		public function destroyAnimation():void {
		    if(hasAnim()) {
				recurStop(anim);
				gotoAndStop(1);
				stop();
				anim.alpha = 1;
				anim.rotation = 0;
				Utils.SetColor(anim);
				AnimationManager.destroy(anim as FlashAnimation);
		        visual.removeChild(anim);
		        anim = null;
		        animId = -1;
			}
		}
		
		static public function recurStop(mc:MovieClip):void {
			for (var i:int = 0 ; i < mc.numChildren ; i++)	 {
				var m:MovieClip = mc.getChildAt(i) as MovieClip;
				if(m) {
					recurStop(m);
					m.gotoAndStop(1);
				}	
			}
		}
		
		public function recurPlay(mc:MovieClip):void {
			for (var i:int = 0 ; i < mc.numChildren ; i++)	 {
				var m:MovieClip = mc.getChildAt(i) as MovieClip;
				if(m) {
					recurPlay(m);
					m.gotoAndPlay(1);
				}	
			}
		}
		
		public function addEndCallback(callback:Callback):void {
			callbackOnEnd.push(callback);
		}
		
		public function addCallbackOnFrame(callback:Callback, frame:int):void {
		    addCallbackOnFrameRepeat(callback, frame, false);
		}
		
		public function addCallbackOnFrameRepeat(callback:Callback, frame:int, repeat:Boolean):void {
		    callbackOnFrame.push(new FlashAnimationViewCallback(callback, frame, repeat));
		}
		
		public function registerSound(frame:int, idSfx:int):void {
			addCallbackOnFrameRepeat(new Callback(JukeBox.playSound, JukeBox.playSound, [idSfx]), frame, true);
		}
		
		public function setAnim(idAnim:int):void {
		    if(idAnim != this.animId) {
		        destroyAnimation();
		        this.animId = idAnim;
				debugAnimName = "";
		        if(idAnim != -1) {
		            anim = AnimationManager.createAnimation(idAnim);
					recurPlay(anim);
		            visual.addChild(anim);
		            bounds.width = anim.width;
		            bounds.height = anim.height;
				    anim.x = x;
				    anim.y = y;
				    anim.scaleX = scaleX;
				    anim.scaleY = scaleY;
				    anim.stop();
					isPlaying = (anim.totalFrames > 1);
					loops = 0;
					if(VersionInfo.isDebug) {
						var a:Array = FlashUtils.mySplit(FlashUtils.myGetQualifiedClassName(anim), "::");
						if(a.length > 0) {
							debugAnimName = "> " + FlashUtils.mySplit(FlashUtils.myGetQualifiedClassName(anim), "::")[1];	
						}
					}   
				}
		        
		        callbackOnEnd = new Vector.<Callback>();
		        callbackOnFrame = new Vector.<FlashAnimationViewCallback>();
				timeLastFrame = GameSpeed.getTime();
			}
		}

		public function update():void {
		    if (!hasAnim()) return; 
		    if(isPlaying) {
				if(timeBased) {
					checkNextFrameTimeBased();
				} else {
					checkNextFrameSpeedBased();
				}
			}
		   	
			refresh();
		}
		
		public function refresh():void {
			if (!hasAnim()) return;
			
			refreshPosition();
			refreshScale();
			refreshRotation();
			bounds.x = anim.x;
			bounds.y = anim.y;
		}
		
		private function refreshPosition():void {
			if(x != oldX || y != oldY) {
		        anim.x = x;
				anim.y = y;
		        oldX = x;
		        oldY = y;
			}
		}
		
		private function refreshScale():void {
			if(scaleX != oldScaleX || scaleY != oldScaleY) {
				anim.scaleX = scaleX;
				anim.scaleY = scaleY;
		        oldScaleX = scaleX;
		        oldScaleY = scaleY;
			} 
		}
		
		private function refreshRotation():void {
			while(rotation > 360) rotation -= 360;
			while(rotation < 0) rotation += 360; 
			if(rotation != oldRotation) {
				anim.rotation = rotation;
		        oldRotation = rotation;
			} 
		}
		
		private function checkNextFrameTimeBased():void {
			var timePerFrame:Number = (1000/fps); 
			
			while(timeLastFrame < GameSpeed.getTime() && isPlaying) {
				timeLastFrame += timePerFrame;
				gotoNextFrame();
			}
			if(hasAnim()) currentframeAsNumber = anim.currentFrame;
		}
		
		private function checkNextFrameSpeedBased():void {
			currentframeAsNumber += GameSpeed.getSpeed(); 
			var frameToAdd:int = Math.floor(currentframeAsNumber) - anim.currentFrame;
			 
			while(frameToAdd > 0) {
				gotoNextFrame();
				if(!hasAnim()) return;
				frameToAdd--;
			}
			
			while(frameToAdd < 0) {
				gotoPrevFrame();
				if(!hasAnim()) return;
				frameToAdd++;
			}
		}
		
		private function gotoNextFrame():void {
			if(isOnLastFrame()) {
				if(isLooping) {
					anim.gotoAndStop(1);
				}
				checkEndCallbacks();
				loops++;
				if(!hasAnim()) return ;
			} else {
				anim.nextFrame();
				checkOnFrameCallbacks();
				if(controlChildrenTimeLineRecursively) {
					 nextFrameChildren(anim);
				}
			}
		}
		
		private function gotoPrevFrame():void {
			if(isOnFirstFrame()) {
				if(isLooping) {
					anim.gotoAndStop(anim.totalFrames);
				}
				checkEndCallbacks();
				if(!hasAnim()) return ;
			} else {
				anim.prevFrame();
				checkOnFrameCallbacks();
				if(controlChildrenTimeLineRecursively) {
					 prevFrameChildren(anim);
				}
			}
		}
		
		public function nextFrameChildren(mcParent:MovieClip):void {
			for (var i : int = 0; i < mcParent.numChildren; i++) {
				var mc:MovieClip = mcParent.getChildAt(i) as MovieClip;
				
				if(mc) {
					var isAChildrenToUpdate:Boolean = !(Utils.myIsInstanceOfClassDisplayObjectList(mc, childrenToNotUpdate));
					if(isAChildrenToUpdate) {
						if(mc.currentFrame == mc.totalFrames) {
							mc.gotoAndStop(1);
						} else {
							mc.gotoAndStop(mc.currentFrame+1);
						}
						nextFrameChildren(mc);
					} 
				}
			}
		}
		
		public function prevFrameChildren(mcParent:MovieClip):void {
			for (var i : int = 0; i < mcParent.numChildren; i++) {
				var mc:MovieClip = mcParent.getChildAt(i) as MovieClip;
				
				if(mc) {
					var isAChildrenToUpdate:Boolean = !(Utils.myIsInstanceOfClassDisplayObjectList(mc, childrenToNotUpdate));
					if(isAChildrenToUpdate) {
						if(mc.currentFrame == 1) {
							mc.gotoAndStop(mc.totalFrames);
						} else {
							mc.gotoAndStop(mc.currentFrame-1);
						}
						prevFrameChildren(mc);
					} 
				}
			}
		}
		
		private function checkEndCallbacks():void {
			while(callbackOnEnd.length > 0) {
				var v:Callback = callbackOnEnd.shift();
	            v.call();
			}
		}
		
		private function checkOnFrameCallbacks():void {
			var i:int;
		    for (i = callbackOnFrame.length-1 ; i >= 0 ; i--) {
		        var callbackOnFrameObj:FlashAnimationViewCallback = callbackOnFrame[i];
		        if(callbackOnFrameObj.frame == getCurrentFrame()) {
		           callbackOnFrameObj.callback.call();
				   if(!callbackOnFrameObj.repeat) {
						callbackOnFrame.splice(i, 1);  
				   }
		        }
			}
		}
		
		public function setChildToFrame(classes:Array, frame:int):void {
			addChildrenClassToNotUpdate(classes);
			
			while(tempArray.length > 0) tempArray.pop();
			tempArray = FlashAnimationView.getChildOfClassesRecur(anim, classes, tempArray);
			for (var i:int = 0; i < tempArray.length; i++) {
				var child:MovieClip = tempArray[i] as MovieClip;
				child.gotoAndStop(frame);
			} 
		}
		
		private function addChildrenClassToNotUpdate(classes:Array):void {
			var bFound:Boolean = false;
			for (var i : int = 0; i < classes.length; i++) {
				bFound = false;
				for (var j : int = 0; j < childrenToNotUpdate.length; j++) {
					if(childrenToNotUpdate[j] == classes[i]) {
						bFound = true;
						break;
					}
				} 
				if(!bFound) {
					childrenToNotUpdate.push(classes[i]);
				}
			}  
		}
		
		public function hasAnim():Boolean { 
		    return animId != -1;
		}
		
		public function getCurrentFrame():int { 
		    if (!hasAnim()) return 1 ;
		    return anim.currentFrame;
		}
		
		public function getNbFrames():int {
		    if (!hasAnim()) return 1 ;
		    return anim.totalFrames;
		}
		
		public function isOnLastFrame():Boolean { 
		    if (!hasAnim()) return false ;
		    return getCurrentFrame() >= anim.totalFrames;
		}
		
		public function isOnFirstFrame():Boolean { 
		    if (!hasAnim()) return false ;
		    return getCurrentFrame() <= 1;
		}
		
		public function gotoAndPlay(frame:int):void {
			play();
			anim.gotoAndStop(frame);
			currentframeAsNumber = frame;
		}
		
		public function gotoAndStop(frame:int):void {
			stop();
			if(hasAnim()) anim.gotoAndStop(frame);
			currentframeAsNumber = frame;
		}
		
		public function stop():void {
			isPlaying = false;
		}
		
		public function play():void {
			isPlaying = true;
			timeLastFrame = GameSpeed.getTime();
		}
		
		public function refreshGameTime():void {
			timeLastFrame = GameSpeed.getTime();
		}
		
		public function addChildOnNewParent(newParent:DisplayObjectContainer):void {
		    if(hasAnim()) {
		        visual.removeChild(anim);
				newParent.addChild(anim);
			}
			
		    visual = newParent;
		}
		
		public function sendToBack():void {
			visual.addChildAt(anim, 0);
		}
		
		public function cacheAsBmpOnLastFrame():void {
			addEndCallback(new Callback(cacheAsBmp, this, [true]));
		}
		
		public function cacheAsBmp(b:Boolean):void {
			anim.cacheAsBitmap = b;
			
		}
		
		static public function getChildOfClasses(parent:DisplayObjectContainer, classes:Array, output:Array):Array {
			while(output.length > 0) output.pop();
			for (var i : int = 0; i < parent.numChildren; i++) {
				var child:DisplayObject = parent.getChildAt(i);
				for (var j : int = 0; j < classes.length; j++) {
					var theClass:Class = classes[j];
					if(Utils.myIsInstanceOfClassDisplayObject(child, theClass)) {
						output.push(child) ;
					}
				}
			}
			return output;
		}
		
		static public function getChildOfClassesRecur(parent:DisplayObjectContainer, classes:Array, output:Array):Array {
			for (var i : int = 0; i < parent.numChildren; i++) {
				var child:DisplayObject = parent.getChildAt(i);
				for (var j : int = 0; j < classes.length; j++) {
					var theClass:Class = classes[j];
					if(Utils.myIsInstanceOfClassDisplayObject(child, theClass)) {
						output.push(child) ;
					} else {
						var dc:DisplayObjectContainer = child as DisplayObjectContainer;
						if(dc) {
							getChildOfClassesRecur(dc, classes, output);
						}
					}
				}
			}
			return output;
		}
	}
}



