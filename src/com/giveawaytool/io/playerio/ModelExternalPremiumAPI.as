package com.giveawaytool.io.playerio {
	import com.lachhh.lachhhengine.meta.ModelBase;

	/**
	 * @author Lachhh
	 */
	public class ModelExternalPremiumAPI extends ModelBase {
		private var _prefixId:String;
		private var _nameOfSystem:String;
		public function ModelExternalPremiumAPI(id:int, prefixId:String, nameOfSystem:String) {
			super(id);
			_prefixId = prefixId;
			_nameOfSystem = nameOfSystem;
		}
		
		public function get prefixId() : String {
			return _prefixId;
		}

		public function get nameOfSystem() : String {
			return _nameOfSystem;
		}
		
		public function get isBerzerkPals():Boolean{
			return id == ModelExternalPremiumAPIEnum.BERZERK.id;
		}
	}
}
