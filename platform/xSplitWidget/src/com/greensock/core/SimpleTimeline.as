package com.greensock.core
{
   public class SimpleTimeline extends Animation
   {
      
      public function SimpleTimeline(param1:Object = null)
      {
         super(0,param1);
         this.autoRemoveChildren = this.smoothChildTiming = true;
      }
      
      public var autoRemoveChildren:Boolean;
      
      public var smoothChildTiming:Boolean;
      
      public var _sortChildren:Boolean;
      
      public var _first:Animation;
      
      public var _last:Animation;
      
      public function insert(param1:*, param2:* = 0) : *
      {
         return this.add(param1,param2 || 0);
      }
      
      public function add(param1:*, param2:* = "+=0", param3:String = "normal", param4:Number = 0) : *
      {
         var _loc6_:* = NaN;
         param1._startTime = Number(param2 || 0) + param1._delay;
         if(param1._paused)
         {
            if(this != param1._timeline)
            {
               param1._pauseTime = param1._startTime + (this.rawTime() - param1._startTime) / param1._timeScale;
            }
         }
         if(param1.timeline)
         {
            param1.timeline._remove(param1,true);
         }
         param1.timeline = param1._timeline = this;
         if(param1._gc)
         {
            param1._enabled(true,true);
         }
         var _loc5_:Animation = this._last;
         if(this._sortChildren)
         {
            _loc6_ = param1._startTime;
            while((_loc5_) && _loc5_._startTime > _loc6_)
            {
               _loc5_ = _loc5_._prev;
            }
         }
         if(_loc5_)
         {
            param1._next = _loc5_._next;
            _loc5_._next = Animation(param1);
         }
         else
         {
            param1._next = this._first;
            this._first = Animation(param1);
         }
         if(param1._next)
         {
            param1._next._prev = param1;
         }
         else
         {
            this._last = Animation(param1);
         }
         param1._prev = _loc5_;
         if(_timeline)
         {
            _uncache(true);
         }
         return this;
      }
      
      public function _remove(param1:Animation, param2:Boolean = false) : *
      {
         if(param1.timeline == this)
         {
            if(!param2)
            {
               param1._enabled(false,true);
            }
            param1.timeline = null;
            if(param1._prev)
            {
               param1._prev._next = param1._next;
            }
            else if(this._first === param1)
            {
               this._first = param1._next;
            }
            
            if(param1._next)
            {
               param1._next._prev = param1._prev;
            }
            else if(this._last === param1)
            {
               this._last = param1._prev;
            }
            
            if(_timeline)
            {
               _uncache(true);
            }
         }
         return this;
      }
      
      override public function render(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc5_:Animation = null;
         var _loc4_:Animation = this._first;
         _totalTime = _time = _rawPrevTime = param1;
         while(_loc4_)
         {
            _loc5_ = _loc4_._next;
            if((_loc4_._active) || param1 >= _loc4_._startTime && !_loc4_._paused)
            {
               if(!_loc4_._reversed)
               {
                  _loc4_.render((param1 - _loc4_._startTime) * _loc4_._timeScale,param2,param3);
               }
               else
               {
                  _loc4_.render((!_loc4_._dirty?_loc4_._totalDuration:_loc4_.totalDuration()) - (param1 - _loc4_._startTime) * _loc4_._timeScale,param2,param3);
               }
            }
            _loc4_ = _loc5_;
         }
      }
      
      public function rawTime() : Number
      {
         return _totalTime;
      }
   }
}
