package com.lachhh.draw.texturepack {
	import flash.geom.Rectangle;

public class Node{
	public var rect:Rectangle;
	public var child0:Node = null;
	public var child1:Node = null;
	public var textureInfo:TextureInfo = null;

	public function Node(x:int, y:int, width:int, height:int){
		rect = new Rectangle(x, y, width, height);
	}

	public function isLeaf(){
		return child0 === null && child1 === null;
	}

	public function insert(textureInfo:TextureInfo, padding:int){
		if(!isLeaf()){
			var newNode = child0.insert(textureInfo, padding);
			if(newNode != null)
			{
				return newNode;
			}
			return  child1.insert(textureInfo, padding);
		}
		else{
			if(this.textureInfo != null){
				return null;
			}
			if(textureInfo.bounds.width > rect.width || textureInfo.bounds.height > rect.height){
				return null;
			}
			if(textureInfo.bounds.width == rect.width && textureInfo.bounds.height == rect.height){
				this.textureInfo  = textureInfo;
				return this;
			}

			var dw:int = rect.width - textureInfo.bounds.width;
			var dh:int = rect.height - textureInfo.bounds.height;

			if(dw > dh){
				child0 = new Node(rect.x, rect.y, textureInfo.bounds.width, rect.height);
				child1 = new Node(padding + rect.x + textureInfo.bounds.width, rect.y, rect.width -textureInfo.bounds.width - padding, rect.height);
			}
			else{
				child0 = new Node(rect.x, rect.y, rect.width, textureInfo.bounds.height);
				child1 = new Node(rect.x, padding + rect.y + textureInfo.bounds.height, rect.width, rect.height - textureInfo.bounds.height - padding);
			}

			return child0.insert(textureInfo, padding);

		}
	}
}
}