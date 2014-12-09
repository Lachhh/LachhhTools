package isle.susisu.twitter.utils
{
	import flash.utils.ByteArray;
	
	public class MultipartFormData extends Object
	{
		
		private var _dataList:Object;
		private var _boundary:String;
		
		public function MultipartFormData(boundary:String=null)
		{
			_dataList=new Object();
			if(boundary!=null)
			{
				_boundary=boundary;
			}
			else
			{
				_boundary="------------------------------"+makeNonce();
			}
		}
		
		public function get boundary():String
		{
			return _boundary;
		}
		
		public function addData(name:String,data:Object,fileName:String=null,mimeType:String=null):void
		{
			_dataList[name]={
				data:data,
				fileName:fileName,
				mimeType:mimeType
			};
		}
		
		public function getByteArray():ByteArray
		{
			var byteArray:ByteArray=new ByteArray();
			byteArray.writeUTFBytes("--"+_boundary);
			for(var name:String in _dataList)
			{
				byteArray.writeUTFBytes("\r\n");
				byteArray.writeUTFBytes("Content-Disposition: form-data; name=\""+name+"\"");
				if(_dataList[name].fileName!=null)
				{
					byteArray.writeUTFBytes("; filename=\""+_dataList[name].fileName+"\"");
				}
				byteArray.writeUTFBytes("\r\n");
				if(_dataList[name].mimeType!=null)
				{
					byteArray.writeUTFBytes("Content-Type: "+_dataList[name].mimeType+"\r\n");
				}
				byteArray.writeUTFBytes("\r\n");
				if(_dataList[name].data is ByteArray)
				{
					byteArray.writeBytes(_dataList[name].data);
				}
				else
				{
					byteArray.writeUTFBytes(_dataList[name].data.toString());
				}
				byteArray.writeUTFBytes("\r\n");
				byteArray.writeUTFBytes("--"+_boundary);
			}
			byteArray.writeUTFBytes("--");
			return byteArray;
		}
		
	}
	
}