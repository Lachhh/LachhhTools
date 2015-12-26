package com.giveawaytool.meta.donations {
	/**
	 * @author LachhhSSD
	 */
	public class MetaCharityOrganizationEnum {
		static public var ALL:Array = new Array();
		static public var NULL : MetaCharityOrganization = new MetaCharityOrganization("", "", "", "");
				
		
		static public var CHILD_PLAY:MetaCharityOrganization = create("org1", "Child's Play", "Child's Play seeks to improve the lives of children in hospitals and domestic violence shelters.", "http://www.childsplaycharity.org/");
		static public var DUMMY_1:MetaCharityOrganization = create("org2", "American Red Cross", "Help people affected by the refugee and migration crisis across the Mediterranean Sea and Europe.", "http://www.redcross.org/");
		static public var DUMMY_2:MetaCharityOrganization = create("org4", "Wikimedia Foundation", "Empower people around the world to collect and develop educational content.", "https://wikimediafoundation.org/wiki/Home");
		static public var DUMMY_3:MetaCharityOrganization = create("org5", "Charity: Water", "Bring clean and safe drinking water to every person on the planet.", "http://www.charitywater.org/");
		static public var DUMMY_4:MetaCharityOrganization = create("org6", "Extra Life", "All the money you raised will go directly to the Children's Miracle Network Hospital of your choice.", "http://www.extra-life.org/");
		static public var DUMMY_5:MetaCharityOrganization = create("org7", "Doctors Without Borders", "We help people worldwide where the need is greatest, delivering emergency medical aid to people", "http://www.doctorswithoutborders.org/");
		static public var DUMMY_6:MetaCharityOrganization = create("org8", "World Wildlife Fund", "Stops the degradation of the planet's natural environment.", "http://www.wwf.ca/");
		static public var DUMMY_7:MetaCharityOrganization = create("org3", "Games Aid", "Distribute funds to a diverse range of children and young peoples charities.", "http://www.gamesaid.org/");
		
		static public function create(id:String, name:String, description:String, urlWebsite:String):MetaCharityOrganization {
			var m:MetaCharityOrganization = new MetaCharityOrganization(id, name,description, urlWebsite);
			if(!getFromId(id).isNull) throw new Error("Duplicate ID!");
			ALL.push(m);
			return m;
		}
		
		static public function getFromId(id:String):MetaCharityOrganization {
			for (var i : int = 0; i < ALL.length; i++) {
				var g:MetaCharityOrganization = ALL[i] as MetaCharityOrganization;
				if(id == g.id) return g;
			}
			return NULL;
		} 
		
		static public function getFromIndex(index:int):MetaCharityOrganization {
			if(index >= ALL.length) return NULL;
			if(index < 0) return NULL;
			return ALL[index] as MetaCharityOrganization;
		}  
				
		static public function getNum():int {
			return ALL.length;
		}
	}
}
