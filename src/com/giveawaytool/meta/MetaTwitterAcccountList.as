package com.giveawaytool.meta {
	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaTwitterAcccountList {
		public var accounts:Vector.<MetaTwitterAccount> = new Vector.<MetaTwitterAccount>();
		
		private var saveData : Dictionary = new Dictionary();

		public function MetaTwitterAcccountList() {
			for (var i : int = 0; i < 10; i++) {
				//DEBUG_AddDummyValue();	
			}
			
		}

		public function refresh():void {
			for (var i : int = 0; i < accounts.length; i++) {
				accounts[i].refresh();	
			}
		}
		
		public function encode():Dictionary {			
			for (var i : int = 0; i < accounts.length; i++) {
				saveData["accounts"+i] = accounts[i].encode();	
			}

			return saveData; 
		}
		
		public function decode(obj:Dictionary):void {
			if(obj == null) return ;
			var i:int = 0;
			accounts = new Vector.<MetaTwitterAccount>();
			while(obj["accounts" + i]) {
				var newTwitter:MetaTwitterAccount = new MetaTwitterAccount();
				newTwitter.decode(obj["accounts" + i]);
				accounts.push(newTwitter);
				i++;
			}
		}
		
		public function addAccount(m:MetaTwitterAccount):void {
			 accounts.push(m);
		}
		
		public function removeAccount(m:MetaTwitterAccount):void {
			var i:int = accounts.indexOf(m);
			if(i == -1) return ;
			accounts.splice(i, 1);
		}
		
		private function DEBUG_AddDummyValue():void {
			var newREsult:MetaTwitterAccount = new MetaTwitterAccount();
			newREsult.accountName = "LachhhhhTest";
			accounts.push(newREsult);
		}
	}
}
