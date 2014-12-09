package isle.susisu.twitter
{
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	
	import isle.susisu.twitter.events.TwitterErrorEvent;
	import isle.susisu.twitter.events.TwitterStreamEvent;
	import isle.susisu.twitter.utils.getOAuthParameters;
	import isle.susisu.twitter.utils.makeAuthorizationHeader;
	import isle.susisu.twitter.utils.makeOAuthSignature;
	import isle.susisu.twitter.utils.mergeObjects;
	import isle.susisu.twitter.utils.MultipartFormData;
	import isle.susisu.twitter.utils.objectToSortedQueryString;
	
	public class TwitterStream extends EventDispatcher
	{
		
		private var _urlRequest:URLRequest;
		private var _urlStream:URLStream;
		
		private var _tokenSet:TwitterTokenSet;
		private var _url:String;
		private var _method:String;
		private var _data:Object;
		private var _buffer:String;
		private var _status:int;
		
		public function TwitterStream(tokenSet:TwitterTokenSet, url:String, method:String = "GET", data:Object = null)
		{
			_tokenSet = tokenSet;
			_url = url;
			_method = method;
			_data = data;
			_buffer = "";
			_status = TwitterStreamStatus.DISCONNECTED;
			
			_urlRequest = new URLRequest(_url);
			_urlRequest.method = _method;
			
			_urlStream = new URLStream();
		}
		
		public function get tokenSet():TwitterTokenSet
		{
			return _tokenSet;
		}
		public function set tokenSet(value:TwitterTokenSet):void
		{
			_tokenSet = value;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		public function get method():String
		{
			return _method;
		}
		
		public function get data():Object
		{
			return _data;
		}
		
		public function get status():int
		{
			return _status;
		}
		
		public function open():void
		{
			if(_status > TwitterStreamStatus.DISCONNECTED)
			{
				close();
			}
			addListeners();
			_buffer = "";
			_status = TwitterStreamStatus.WAITING;
			
			
			var parameters:Object;
			var query:String;
			var base:String;
			var signature:String;
			
			if(_method.toUpperCase() == "GET")
			{
				parameters = mergeObjects(_data, getOAuthParameters(_tokenSet));
				//convert to query
				query = objectToSortedQueryString(parameters);
				//base to make signature
				base = _method.toUpperCase() + "&" + encodeURIComponent(_url) + "&" + encodeURIComponent(query);
				//make signature
				signature = encodeURIComponent(makeOAuthSignature(_tokenSet, base));
				
				_urlRequest.data = query + "&oauth_signature=" + signature;
				_urlRequest.requestHeaders = [];
				_urlRequest.contentType = "application/x-www-form-urlencoded";
			}
			else
			{
				var oauthParameters:Object = getOAuthParameters(_tokenSet);
				if(_data is MultipartFormData)
				{
					query = objectToSortedQueryString(oauthParameters);
					base = _method.toUpperCase() + "&" + encodeURIComponent(_url) + "&" + encodeURIComponent(query);
					signature = encodeURIComponent(makeOAuthSignature(_tokenSet, base));
					oauthParameters["oauth_signature"] = signature;
					
					_urlRequest.data = _data.getByteArray();
					_urlRequest.requestHeaders = [makeAuthorizationHeader(oauthParameters)];
					_urlRequest.contentType = "multipart/form-data, boundary=" + _data.boundary;
				}
				else
				{
					parameters = mergeObjects(_data,oauthParameters);
					query = objectToSortedQueryString(parameters);
					base = _method.toUpperCase() + "&" + encodeURIComponent(_url) + "&" + encodeURIComponent(query);
					signature = encodeURIComponent(makeOAuthSignature(_tokenSet, base));
					oauthParameters["oauth_signature"] = signature;
					
					_urlRequest.data = objectToSortedQueryString(_data);
					_urlRequest.requestHeaders = [makeAuthorizationHeader(oauthParameters)];
					_urlRequest.contentType = "application/x-www-form-urlencoded";
				}
			}
			
			_urlStream.load(_urlRequest);
		}
		
		public function close():void
		{
			if(_status > TwitterStreamStatus.DISCONNECTED)
			{
				removeListeners();
				_status = TwitterStreamStatus.DISCONNECTED;
				dispatchEvent(new TwitterStreamEvent(TwitterStreamEvent.DISCONNECTED));
				
				_urlStream.close();
			}
		}
		
		private function addListeners():void
		{
			_urlStream.addEventListener(Event.COMPLETE, onComplete);
			_urlStream.addEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
			_urlStream.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlStream.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_urlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function removeListeners():void
		{
			_urlStream.removeEventListener(Event.COMPLETE, onComplete);
			_urlStream.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onHTTPStatus);
			_urlStream.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlStream.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			_urlStream.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function onComplete(e:Event):void
		{
			removeListeners();
			_status = TwitterStreamStatus.DISCONNECTED;
			
			dispatchEvent(new TwitterStreamEvent(TwitterStreamEvent.DISCONNECTED));
		}
		
		private function onHTTPStatus(e:HTTPStatusEvent):void
		{
			if(e.status >= 400 && e.status < 500)
			{
				if(!dispatchEvent(new TwitterErrorEvent(TwitterErrorEvent.CLIENT_ERROR, false, true, e.status)))
				{
					_status = TwitterStreamStatus.DISCONNECTED;
				}
			}
			else if(e.status>=500)
			{
				if(!dispatchEvent(new TwitterErrorEvent(TwitterErrorEvent.SERVER_ERROR, false, true, e.status)))
				{
					_status = TwitterStreamStatus.DISCONNECTED;
				}
			}
			else
			{
				_status = TwitterStreamStatus.DISCONNECTED;
			}
		}
		
		private function onIOError(e:IOErrorEvent):void
		{
			removeListeners();
			if(_status > TwitterStreamStatus.DISCONNECTED)
			{
				_status = TwitterStreamStatus.DISCONNECTED;
				
				dispatchEvent(e);
			}
		}
		
		private function onProgress(e:ProgressEvent):void
		{
			if(_status < TwitterStreamStatus.CONNECTING)
			{
				_status = TwitterStreamStatus.CONNECTING;
				dispatchEvent(new TwitterStreamEvent(TwitterStreamEvent.CONNECTED));
			}
			_buffer += _urlStream.readUTFBytes(_urlStream.bytesAvailable);
			if(_buffer.indexOf("\r\n") >= 0)
			{
				var div:Array = _buffer.split("\r\n");
				var len:int = div.length;
				for(var i:int = 0; i < len - 1; i++)
				{
					dispatchEvent(new TwitterStreamEvent(TwitterStreamEvent.MESSAGE_RECEIVED, false, false, div[i]));
				}
				_buffer = div[len-1];
			}
		}
		
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			removeListeners();
			_status = TwitterStreamStatus.DISCONNECTED;
			
			dispatchEvent(e);
		}
		
	}
	
}