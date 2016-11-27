package com.giveawaytool.ui {
	import com.MetaIRCMessage;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaSubcriberAlert {
		public var metaSubscriber:MetaSubscriber;
		
		private var saveData : Dictionary = new Dictionary();
				
		public function encode():Dictionary {
			saveData["metaSubscriber"] = metaSubscriber.encode();
			
			return saveData; 
		}
		
		public function encodeForWidget():Dictionary {
			return metaSubscriber.encode();
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			metaSubscriber.decode(loadData["metaSubscriber"]);
			
		}
		
		public function isNewSubscriber():Boolean {
			return metaSubscriber.isNewSubscriber();
		}
		
		static public function createFromIRCMsg(m:MetaIRCMessage):MetaSubcriberAlert {
			var result:MetaSubcriberAlert = new MetaSubcriberAlert();
			result.metaSubscriber = MetaSubscriber.createFromIRCMsg(m);
			return result;
		}
		
		static public function createFromSub(m:MetaSubscriber):MetaSubcriberAlert {
			var result:MetaSubcriberAlert = new MetaSubcriberAlert();
			result.metaSubscriber = m;
			return result;
		}

		public static function createDummy() : MetaSubcriberAlert {
			return createFromSub(MetaSubscriber.createDummy());
		}
	}
}
