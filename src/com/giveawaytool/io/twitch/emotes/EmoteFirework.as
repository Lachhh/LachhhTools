package com.giveawaytool.io.twitch.emotes {
	import com.lachhh.lachhhengine.animation.AnimationFactory;
	import com.lachhh.utils.Utils;
	import com.lachhh.lachhhengine.GameSpeed;
	import flash.display.Bitmap;
	import com.lachhh.lachhhengine.components.RenderComponent;
	import com.lachhh.lachhhengine.ui.UIBase;
	import com.lachhh.lachhhengine.actor.Actor;

	/**
	 * @author Eel
	 */
	public class EmoteFirework extends Actor {
		
		public var metaEmote:MetaTwitchEmote;
		public var emoteBitmap:Bitmap;
		
		public var isRocketing:Boolean = true;
		
		public var startingSpeed:Number = 3;
		public var speed:Number = 4;
		public var frame:int = 0;
		public var scaleSpeed:Number = 0.3;
		
		public function EmoteFirework(pMetaEmote:MetaTwitchEmote) {
			super();
			
			metaEmote = pMetaEmote;
			
			UIBase.manager.add(this);
			//renderComponent = RenderComponent.addToActor(this, UIBase.defaultUIContainer, AnimationFactory.ID_FX_IMPACT1);
		}
		
		public override function start():void{
			super.start();
			
			var bmp:Bitmap = new Bitmap(metaEmote.modelEmote.bitmapData);
			emoteBitmap = bmp;
			//renderComponent.animView.visual.addChild(bmp);
			UIBase.defaultUIContainer.addChild(bmp);
			emoteBitmap.scaleX = 0.25;
			emoteBitmap.scaleY = 0.25;
			
			startingSpeed += (6 - (Math.random() * 3));
			
			refresh();
		}
		
		public override function update():void{
			super.update();
			
			if(frame < 120 && isRocketing){
				py -= speed;
				
				speed = startingSpeed - Utils.lerp(0, startingSpeed, frame/120);
				var size:Number = 0.25 - Utils.lerp(0.01, 0.25, frame/120);
				emoteBitmap.scaleX = size;
				emoteBitmap.scaleY = size;
				
				frame++;
				if(frame >= 120){
					isRocketing = false;
					frame = 0;
				}
			} else {
				scaleSpeed -= Utils.lerp(0.003, 0.03, frame/20);
				
				if(scaleSpeed < 0.01) scaleSpeed = 0.01;
				
				emoteBitmap.scaleX += scaleSpeed;
				emoteBitmap.scaleY += scaleSpeed;
				frame++;
				if(frame >= 20){
					emoteBitmap.alpha -= 0.1;
					if(emoteBitmap.alpha <= 0.01){
						destroy();
					}
				}
			}
			
			updateBitmap();
		}
		
		public override function destroy():void{
			if(destroyed) return;
			//if(emoteBitmap) renderComponent.animView.anim.removeChild(emoteBitmap);
			if(emoteBitmap) UIBase.defaultUIContainer.removeChild(emoteBitmap);
			super.destroy();
		}
		
		public function updateBitmap():void{
			if(emoteBitmap){
				emoteBitmap.x = px - (emoteBitmap.width / 2);
				emoteBitmap.y = py - (emoteBitmap.height / 2);
			}
		}
	}
}