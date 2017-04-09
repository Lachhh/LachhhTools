package com.giveawaytool.ui {
	import com.giveawaytool.io.playerio.MetaGameWispSub;
	import com.giveawaytool.meta.donations.MetaData;
	import com.MetaIRCMessage;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaSubscriber  extends MetaData {
		public static const NULL : MetaSubscriber = new MetaSubscriber();
		public var isNew : Boolean = false ;
		public var numMonthInARow : int = 0 ;
		public var name:String = "Dummy" ;
		public var metaGameWispSubInfo:MetaGameWispSub = new MetaGameWispSub() ;
		public var date : Date = new Date() ;
		public var modelSubSource : ModelSubcriberSource = ModelSubcriberSourceEnum.TWITCH;
		private var saveData : Dictionary = new Dictionary();

		public function MetaSubscriber() {
			
		}

		public function encode() : Dictionary {
			saveData["modelSubSource"] = modelSubSource.id;
			saveData["metaGameWispSubInfo"] = metaGameWispSubInfo.encode();
			saveData["numMonthInARow"] = numMonthInARow;
			saveData["name"] = name;
			saveData["date"] = date.time;
			
			return saveData; 
		}

		public function decode(loadData : Dictionary) : void {
			if (loadData == null) return ;
			numMonthInARow = loadData["numMonthInARow"];
			name = loadData["name"];
			metaGameWispSubInfo.decode(loadData["metaGameWispSubInfo"]);
			modelSubSource = ModelSubcriberSourceEnum.getFromId(loadData["modelSubSource"]);
			date = new Date(loadData["date"]);
			
			if(modelSubSource.isNull) modelSubSource = ModelSubcriberSourceEnum.TWITCH;
		}
		
		public function isNewSubscriber():Boolean {
			return (numMonthInARow <= 1);
		}
		
		static public function createFromIRCMsg(m:MetaIRCMessage):MetaSubscriber {
			var result:MetaSubscriber = new MetaSubscriber();
			result.name = m.getSubName();
			result.numMonthInARow = m.getResubMonth();
			result.date = new Date();
			return result;
		}

		public function clone() : MetaSubscriber {
			var result : MetaSubscriber = new MetaSubscriber();
			result.decode(encode());
			return result;
		}

		public function isEquals(m : MetaSubscriber) : Boolean {
			if(name != m.name) return false;
			if(date.time != m.date.time) return false;
			if(numMonthInARow != m.numMonthInARow) return false;
			return true;
		}

		public static function create(d : Dictionary) : MetaSubscriber {
			var result:MetaSubscriber = new MetaSubscriber();
			result.decode(d);
			return result;
		}
		
		public static function create2(name : String, num:int) : MetaSubscriber {
			var result:MetaSubscriber = new MetaSubscriber();
			result.name = name;
			result.numMonthInARow = num;
			
			return result;
		}
		
		public function isSameNameAndSource(metaSub : MetaSubscriber) : Boolean {
			if(name.toLowerCase() != metaSub.name.toLowerCase()) return false;
			if(modelSubSource.id != metaSub.modelSubSource.id) return false;
			return true;
		}
		
		public function isSameNameAndSource2(pName :String, pModelSource:ModelSubcriberSource ) : Boolean {
			if(name.toLowerCase() != pName .toLowerCase()) return false;
			if(modelSubSource.id != pModelSource.id) return false;
			return true;
		}
		
		public function isNull() : Boolean {
			return this == NULL;
		}
		
		public function getMonthNumShort():String {
			switch(modelSubSource.id) {
				case ModelSubcriberSourceEnum.TWITCH.id :
					if(numMonthInARow <= 0) return "-";
					return numMonthInARow + " month" + (numMonthInARow > 1 ? "s" : "");
				case ModelSubcriberSourceEnum.GAMEWISP.id :
					return metaGameWispSubInfo.tierCostStr+"";
			}
			
			return "";
		}

		public function getDescForToolTip() : String {
			switch(modelSubSource.id) {
				case ModelSubcriberSourceEnum.TWITCH.id :
					return name + "\n" + "Subscribed " + numMonthInARow + " month(s) in a row.\nfrom Twitch"; 
				case ModelSubcriberSourceEnum.GAMEWISP.id :
					return name + "\n" + "Subscribed on " + metaGameWispSubInfo.tierCostStr + " tier.\nfrom GameWisp - " + metaGameWispSubInfo.status;
			}
			
			return "";
		}

		public static function createDummy() : MetaSubscriber {
			return create2("An Awesome Dude", (Math.random() < 0.5 ? 1 : 2));
		}

		
	}
}
