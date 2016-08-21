package com.adobe.serialization.json
{
   public final class JSONToken extends Object
   {
      
      public function JSONToken(param1:int = -1, param2:Object = null)
      {
         super();
         this.type = param1;
         this.value = param2;
      }
      
      static const token:JSONToken = new JSONToken();
      
      static function create(param1:int = -1, param2:Object = null) : JSONToken
      {
         token.type = param1;
         token.value = param2;
         return token;
      }
      
      public var type:int;
      
      public var value:Object;
   }
}
