package isle.susisu.twitter
{
	
	public class TwitterTokenSet extends Object
	{
		
		private var _consumerKey:String;
		private var _consumerKeySecret:String;
		private var _oauthToken:String;
		private var _oauthTokenSecret:String;
		
		public function TwitterTokenSet(consumerKey:String,consumerKeySecret:String,oauthToken:String,oauthTokenSecret:String)
		{
			_consumerKey=consumerKey;
			_consumerKeySecret=consumerKeySecret;
			_oauthToken=oauthToken;
			_oauthTokenSecret=oauthTokenSecret;
		}
		
		public function get consumerKey():String
		{
			return _consumerKey;
		}
		
		public function get consumerKeySecret():String
		{
			return _consumerKeySecret
		}
		
		public function get oauthToken():String
		{
			return _oauthToken;
		}
		
		public function get oauthTokenSecret():String
		{
			return _oauthTokenSecret;
		}
		
	}
	
}