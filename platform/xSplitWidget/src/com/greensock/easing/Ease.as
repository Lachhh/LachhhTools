package com.greensock.easing
{
   public class Ease extends Object
   {
      
      public function Ease(param1:Function = null, param2:Array = null, param3:Number = 0, param4:Number = 0)
      {
         super();
         this._func = param1;
         this._params = param2?_baseParams.concat(param2):_baseParams;
         this._type = param3;
         this._power = param4;
      }
      
      protected static var _baseParams:Array = [0,0,1,1];
      
      protected var _func:Function;
      
      protected var _params:Array;
      
      protected var _p1:Number;
      
      protected var _p2:Number;
      
      protected var _p3:Number;
      
      public var _type:int;
      
      public var _power:int;
      
      public var _calcEnd:Boolean;
      
      public function getRatio(param1:Number) : Number
      {
         var _loc2_:* = NaN;
         if(this._func != null)
         {
            this._params[0] = param1;
            return this._func.apply(null,this._params);
         }
         _loc2_ = this._type == 1?1 - param1:this._type == 2?param1:param1 < 0.5?param1 * 2:(1 - param1) * 2;
         if(this._power == 1)
         {
            _loc2_ = _loc2_ * _loc2_;
         }
         else if(this._power == 2)
         {
            _loc2_ = _loc2_ * _loc2_ * _loc2_;
         }
         else if(this._power == 3)
         {
            _loc2_ = _loc2_ * _loc2_ * _loc2_ * _loc2_;
         }
         else if(this._power == 4)
         {
            _loc2_ = _loc2_ * _loc2_ * _loc2_ * _loc2_ * _loc2_;
         }
         
         
         
         return this._type == 1?1 - _loc2_:this._type == 2?_loc2_:param1 < 0.5?_loc2_ / 2:1 - _loc2_ / 2;
      }
   }
}
