package com.giveawaytool.meta {
	import com.lachhh.lachhhengine.animation.AnimationFactory;

	import flash.utils.Dictionary;
	/**
	 * @author LachhhSSD
	 */
	public class MetaPlayMovie {
		static public var NULL:MetaPlayMovie = new MetaPlayMovie();
		public var movieName:String;
		
		private var saveData : Dictionary = new Dictionary();

		public function MetaPlayMovie() {
		}
		
		public function clear():void {
			movieName = "";
		}

		public function encode():Dictionary {
			saveData["movieName"] = movieName;
			return saveData;
		}
		
		public function decode(loadData:Dictionary):void {
			if(loadData == null) return ;
			movieName = loadData["movieName"];
		}
		
		static public function createDummy():MetaPlayMovie {
			var result:MetaPlayMovie = new MetaPlayMovie();
			result.movieName = "JustDoIt";
			return result;
		}
		
		static public function create(name:String):MetaPlayMovie {
			var result:MetaPlayMovie = new MetaPlayMovie();
			result.movieName = name;
			return result;
		}
	}
}
