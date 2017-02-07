package com.giveawaytool.meta.donations {
	/**
	 * @author LachhhSSD
	 */
	public class ModelDonationSourceEnum {
		static private var _id:int = 0 ;
		static public var ALL:Array = new Array();
				
		static public var NULL:ModelDonationSource = new ModelDonationSource(-1, "");
		
		static public var STREAM_TIP:ModelDonationSourceStreamTip = create(_id++, "StreamTip", ModelDonationSourceStreamTip) as ModelDonationSourceStreamTip;//192A2C
		static public var TILTIFY:ModelDonationSourceTiltify = create(_id++, "Tiltify", ModelDonationSourceTiltify) as ModelDonationSourceTiltify;//192A2C
		static public var STREAM_LABS:ModelDonationSourceStreamLabs = create(_id++, "StreamLabs", ModelDonationSourceStreamLabs) as ModelDonationSourceStreamLabs;//192A2C
		static public var CALCULATED:ModelDonationSource = create(_id++, "Calculated", ModelDonationSource) as ModelDonationSource;//192A2C
		
		static public function create(id:int, name:String, className:Class):ModelDonationSource {
			var m:ModelDonationSource = new className(id, name);
			ALL.push(m);
			return m;
		}
		
		static public function getFromId(id:int):ModelDonationSource {
			for (var i : int = 0; i < ALL.length; i++) {
				var g:ModelDonationSource = ALL[i] as ModelDonationSource;
				if(id == g.id) return g;
			}
			return NULL;
		} 
		
		static public function getNum():int {
			return _id;
		}
	}
}
