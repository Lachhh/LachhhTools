package com.giveawaytool.meta.player {
	import com.lachhh.lachhhengine.meta.MetaUpgrade;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaPlayer {
		static private var LEVELS:Array = [0,50,150,350,650,1050];
		public var name:String;
		public var xp:MetaUpgrade;
		public var slotSword:MetaEquipSlot;
		public var slotShield:MetaEquipSlot; 
		public var slotHelmet:MetaEquipSlot; 
		public var slotBody:MetaEquipSlot; 
		public var slotArm:MetaEquipSlot;
	        
		private var saveData : Dictionary = new Dictionary();

		public function MetaPlayer() {
			xp = new MetaUpgrade(LEVELS);
			slotSword = new MetaEquipSlot(ModelItemGenreEnum.SWORD);
			slotShield = new MetaEquipSlot(ModelItemGenreEnum.SHIELD);
			slotHelmet = new MetaEquipSlot(ModelItemGenreEnum.HELMET);
			slotBody = new MetaEquipSlot(ModelItemGenreEnum.BODY);
			slotArm = new MetaEquipSlot(ModelItemGenreEnum.ARM);
		}
	
		public function clear():void {
			name = "Dummy";
			xp.value = 0;
		}
		
		public function encode():Dictionary {
			saveData["name"] = name;
			saveData["xp"] = xp.value;
			return saveData; 
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			name = loadData["name"];
			xp.value = loadData["xp"];
		}
		
		static public function createDummy():MetaPlayer {
			var result:MetaPlayer = new MetaPlayer();
			
			result.name = "Mister Dummy" + Math.floor(Math.random()*37);
			result.xp.value = 50;
			
			var frame:int = Math.floor(Math.random()*10); 
			
			result.slotSword.DEBUGEquipItemFromIndex(frame);
			result.slotShield.DEBUGEquipItemFromIndex(frame);
			result.slotHelmet.DEBUGEquipItemFromIndex(frame);
			result.slotBody.DEBUGEquipItemFromIndex(frame);
			result.slotArm.DEBUGEquipItemFromIndex(frame);
			
			return result; 
		}
		
		static public function createDummyList(names:Array):Array{
			var result:Array = new Array();
			for (var i : int = 0; i < names.length; i++) {
				var m:MetaPlayer = MetaPlayer.createDummy();
				m.name = names[i];
				result.push(m);
			}
			
			return result; 
		}
		
		public function getName():String{
			return name ;// + " : LVL " + xp.crntLevel;
		}
	}
}
