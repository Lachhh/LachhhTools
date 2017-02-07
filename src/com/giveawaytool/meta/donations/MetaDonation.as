package com.giveawaytool.meta.donations {
	import com.lachhh.utils.Utils;
	import com.lachhh.flash.FlashUtils;
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaDonation extends MetaData {
		static public var NULL:MetaDonation = new MetaDonation(ModelDonationSourceEnum.NULL);
		static public var MSG_NULL:String = "<No Messsage>";
		public var donatorName:String = "";
		public var donatorMsg:String = "";
		public var amount:Number = 0;
		public var id : String = "";
		public var modelSource : ModelDonationSource = ModelDonationSourceEnum.NULL;
		public var date:Date = new Date();
		
		public var isNew:Boolean = false;
		
		private var saveData : Dictionary = new Dictionary();

		public function MetaDonation(pModel : ModelDonationSource) {
			modelSource = pModel;
		}
		
		public function clear():void {
			donatorName = "";
			donatorMsg = "";
			amount = 0;
			date = new Date();
		}

		public function encode():Dictionary {
			saveData = new Dictionary();
			saveData["modelSource"] = modelSource.id;
			saveData["donatorName"] = donatorName;
			saveData["amount"] = amount;
			saveData["donatorMsg"] = donatorMsg;
			saveData["date"] = date.time;
			saveData["isNew"] = isNew;
			saveData["id"] = id;
			
			return saveData;
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			var modelId:int = loadData["modelSource"];
			donatorName = loadData["donatorName"];
			amount = loadData["amount"];
			donatorMsg = loadData["donatorMsg"];
			date = new Date(loadData["date"]);
			isNew = loadData["isNew"];
			id = loadData["id"];
			
			modelSource = ModelDonationSourceEnum.getFromId(modelId);
		}
		
		static public function createDummy():MetaDonation {
			var result:MetaDonation = new MetaDonation(ModelDonationSourceEnum.STREAM_TIP);
			result.donatorName = "An Awesome Dude";
			result.donatorMsg = "OMG This is a test donation!";
			result.amount = Math.random()*35+5;
			result.date = new Date();
			return result;
		}
		
		static public function createDateInTheFuture():MetaDonation {
			var result:MetaDonation = new MetaDonation(ModelDonationSourceEnum.CALCULATED);
			result.donatorName = "None";
			result.donatorMsg = "";
			result.amount = 0;
			result.date = new Date();
			result.date.date += 50;
			return result;
		}
		
		static public function createTopDefault():MetaDonation {
			var result:MetaDonation = new MetaDonation(ModelDonationSourceEnum.CALCULATED);
			result.donatorName = "None";
			result.donatorMsg = "";
			result.amount = 0;
			result.date = new Date();
			return result;
		}
		
		static public function createFromStreamLabs(d:Dictionary):MetaDonation {
			var result:MetaDonation = new MetaDonation(ModelDonationSourceEnum.STREAM_TIP);
			result.donatorName = d.name;
			result.donatorMsg = d.message;
			result.amount = FlashUtils.myParseFloat(d.amount);
			result.id = d.donation_id;
			if(result.id == null) {
				result.id = d._id;	
			}
			var timeInStr:String = d.created_at +"000";
			var timeInMs:Number = FlashUtils.myParseFloat(timeInStr);
			var date:Date = new Date();
			date.time = timeInMs;
			
			result.date = date; 
			return result;
		}
		
		static public function createFromTiltifyData(d:Dictionary):MetaDonation {
			var result:MetaDonation = new MetaDonation(ModelDonationSourceEnum.TILTIFY);
			result.donatorName = d.name;
			result.donatorMsg = d.comment;
			result.amount = FlashUtils.myParseFloat(d.amount);
			result.id = d.id;
			if(result.id == null) {
				result.id = d.created;	
			}
			
			var date:Date = Utils.parseDateYYYYMMDDHHMMSS(d.created);
			
			result.date = date; 
			return result;
		}
		
		static public function createFromStreamTipData(d:Dictionary):MetaDonation {
			var result:MetaDonation = new MetaDonation(ModelDonationSourceEnum.STREAM_TIP);
			result.donatorName = d.username;
			result.donatorMsg = d.note;
			result.amount = FlashUtils.myParseFloat(d.amount);
			result.id = d.id;
			if(result.id == null) {
				result.id = d._id;	
			}
			
			var date:Date = Utils.parseDateYYYYMMDDHHMMSS(d.date);
			
			result.date = date; 
			return result;
		}
		
		static public function create(d:Dictionary):MetaDonation {
			var result:MetaDonation = new MetaDonation(ModelDonationSourceEnum.NULL);
			result.decode(d);
			return result;
		}
		
		public function clone():MetaDonation {
			var newDonation:MetaDonation = new MetaDonation(modelSource);
			newDonation.decode(encode());
			return newDonation;
		}
		
		public function getDonationScrollMsg():String {
			if(this == NULL) return "None";
			return donatorName + " - " + getAmountTxt();
		}
		
		public function getAmountTxt():String {
			return "$" + amount; 
		}
		
		public function getMsg():String {
			if(donatorMsg == null) return MSG_NULL;
			if(donatorMsg == "") return MSG_NULL;
			return donatorMsg +"\nCreated at " + date.toDateString();
		}
		
		public function isThisMonth():Boolean {
			if(isNull()) return false;
			if(date == null) return false;
			if(date.month != TodayDate.today.month) return false;
			return true;
		}
		
		public function isThisDay():Boolean {
			if(isNull()) return false;
			if(date == null) return false;
			if(date.month != TodayDate.today.month) return false;
			if(date.date != TodayDate.today.date) return false;	
			return true;
		}
		
		public function isThisWeek() : Boolean {
			return TodayDate.isThisWeek(date);
		}
		
		public function isNull():Boolean {
			return modelSource.isNull;
		}
		
		public function isEquals(m:MetaDonation):Boolean {
			return (m.id == id) && (m.modelSource.id == modelSource.id);
		}

		
	}
}
