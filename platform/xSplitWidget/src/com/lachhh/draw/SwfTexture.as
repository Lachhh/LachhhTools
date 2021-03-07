package com.lachhh.draw {
	import com.lachhh.ResolutionManager;
	import com.lachhh.draw.texturepack.TextureInfo;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	/**
	 * @author LachhhSSD
	 */
	public class SwfTexture {
		public var dataInPngFormat : ByteArray ;
		public var displayObject:DisplayObject;
		public var textureInfo:TextureInfo;
		public var copyPixel:CopypixelableBmpData;
		public var name:String;
		public var textureFormat:String = "SD_";
		
		public function SwfTexture(pDisplayIbject:DisplayObject, pName:String) {
			displayObject = pDisplayIbject;
			name = pName;
		}
		
		public function extractTexture(matrix:Matrix):void {
			copyPixel = CreateCopypixelableBmpDataUsingMatrix(displayObject, matrix);
			dataInPngFormat = EncodePNGUtils.encode(copyPixel.bmpData);
			createTextureInfo();
		}
				
		private function CreateCopypixelableBmpDataUsingMatrix(d:DisplayObject, matrix:Matrix):CopypixelableBmpData {
			var animPartBmpData:CopypixelableBmpData = new CopypixelableBmpData();
			var rect:Rectangle = new Rectangle(0,0,ResolutionManager.getGameWidth(),ResolutionManager.getGameHeight());
			var padding : int = padding ;
			
			try {
				var bd:BitmapData = new BitmapData(Math.ceil(rect.width)+padding , Math.ceil(rect.height)+padding, true, 0xFFFFFF);
			} catch(e:Error) {
				
				return null;	
			} 
			
			animPartBmpData.x = rect.x;
			animPartBmpData.y = rect.y;
			
			matrix.tx = -rect.x;
			matrix.ty = -rect.y;
			
			
			bd.draw(d, matrix, d.transform.concatenatedColorTransform, null, null, false);
			
			animPartBmpData.bmpData = bd;
			return animPartBmpData;
		}
		
		private function createTextureInfo():void {
			textureInfo = new TextureInfo();
			textureInfo.bitmap = copyPixel.bmpData;
			textureInfo.blend = false;
			textureInfo.name = name;
			textureInfo.bounds = new Rectangle(copyPixel.x,copyPixel.y, copyPixel.bmpData.width, copyPixel.bmpData.height);
		}
	}
}
