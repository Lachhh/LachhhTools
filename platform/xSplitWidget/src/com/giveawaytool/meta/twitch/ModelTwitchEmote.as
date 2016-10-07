package com.giveawaytool.meta.twitch {
	import com.lachhh.io.Callback;
	import flash.display.BitmapData;
	import com.lachhh.lachhhengine.meta.ModelBase;

	/**
	 * @author Eel
	 */
	public class ModelTwitchEmote extends ModelBase {
		
		public var bitmapData:BitmapData;
		
		public function ModelTwitchEmote(pId : int) {
			super(pId);
		}
		
		public function isBitmapDataLoaded():Boolean{
			return (bitmapData != null);
		}
		
		public function loadBitmapData(success:Callback, error:Callback):void{
			if(isNull) return;
			
			var request:TwitchRequestEmoteBitmap = new TwitchRequestEmoteBitmap(id);
			request.sendRequest(new Callback(loadSuccess, this, [request, success]), new Callback(loadError, this, [error]));
		}
		
		public function loadSuccess(request:TwitchRequestEmoteBitmap, success:Callback):void{
			bitmapData = request.bitmapResult;
			if(success) success.call();
		}
		
		public function loadError(onError:Callback):void{
			trace("ERROR LOADING EMOTE");
			if(onError) onError.call();
		}
	}
}