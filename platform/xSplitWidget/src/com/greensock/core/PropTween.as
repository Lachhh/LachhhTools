package com.greensock.core
{
   public final class PropTween extends Object
   {
      
      public function PropTween(param1:Object, param2:String, param3:Number, param4:Number, param5:String, param6:Boolean, param7:PropTween = null, param8:int = 0)
      {
         super();
         this.t = param1;
         this.p = param2;
         this.s = param3;
         this.c = param4;
         this.n = param5;
         this.f = param1[param2] is Function;
         this.pg = param6;
         if(param7)
         {
            param7._prev = this;
            this._next = param7;
         }
         this.pr = param8;
      }
      
      public var t:Object;
      
      public var p:String;
      
      public var s:Number;
      
      public var c:Number;
      
      public var f:Boolean;
      
      public var pr:int;
      
      public var pg:Boolean;
      
      public var n:String;
      
      public var r:Boolean;
      
      public var _next:PropTween;
      
      public var _prev:PropTween;
   }
}
