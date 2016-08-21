package com.greensock
{
   import com.greensock.core.SimpleTimeline;
   import com.greensock.core.Animation;
   
   public class TimelineLite extends SimpleTimeline
   {
      
      public function TimelineLite(param1:Object = null)
      {
         var _loc2_:Object = null;
         var _loc3_:String = null;
         super(param1);
         this._labels = {};
         autoRemoveChildren = this.vars.autoRemoveChildren == true;
         smoothChildTiming = this.vars.smoothChildTiming == true;
         _sortChildren = true;
         _onUpdate = this.vars.onUpdate;
         for(_loc3_ in this.vars)
         {
            _loc2_ = this.vars[_loc3_];
            if(_loc2_ is Array)
            {
               if(_loc2_.join("").indexOf("{self}") !== -1)
               {
                  this.vars[_loc3_] = _swapSelfInParams(_loc2_ as Array);
               }
            }
         }
         if(this.vars.tweens is Array)
         {
            this.add(this.vars.tweens,0,this.vars.align || "normal",(this.vars.stagger) || (0));
         }
      }
      
      public static const version:String = "12.1.2";
      
      protected static function _prepVars(param1:Object) : Object
      {
         return param1._isGSVars?param1.vars:param1;
      }
      
      protected static function _copy(param1:Object) : Object
      {
         var _loc3_:String = null;
         var _loc2_:Object = {};
         for(_loc3_ in param1)
         {
            _loc2_[_loc3_] = param1[_loc3_];
         }
         return _loc2_;
      }
      
      public static function exportRoot(param1:Object = null, param2:Boolean = true) : TimelineLite
      {
         var _loc6_:Animation = null;
         var param1:Object = param1 || {};
         if(!("smoothChildTiming" in param1))
         {
            param1.smoothChildTiming = true;
         }
         var _loc3_:TimelineLite = new TimelineLite(param1);
         var _loc4_:SimpleTimeline = _loc3_._timeline;
         _loc4_._remove(_loc3_,true);
         _loc3_._startTime = 0;
         _loc3_._rawPrevTime = _loc3_._time = _loc3_._totalTime = _loc4_._time;
         var _loc5_:Animation = _loc4_._first;
         while(_loc5_)
         {
            _loc6_ = _loc5_._next;
            if(!param2 || !(_loc5_ is TweenLite && TweenLite(_loc5_).target == _loc5_.vars.onComplete))
            {
               _loc3_.add(_loc5_,_loc5_._startTime - _loc5_._delay);
            }
            _loc5_ = _loc6_;
         }
         _loc4_.add(_loc3_,0);
         return _loc3_;
      }
      
      protected var _labels:Object;
      
      public function to(param1:Object, param2:Number, param3:Object, param4:* = "+=0") : *
      {
         return param2?this.add(new TweenLite(param1,param2,param3),param4):this.set(param1,param3,param4);
      }
      
      public function from(param1:Object, param2:Number, param3:Object, param4:* = "+=0") : *
      {
         return this.add(TweenLite.from(param1,param2,param3),param4);
      }
      
      public function fromTo(param1:Object, param2:Number, param3:Object, param4:Object, param5:* = "+=0") : *
      {
         return param2?this.add(TweenLite.fromTo(param1,param2,param3,param4),param5):this.set(param1,param4,param5);
      }
      
      public function staggerTo(param1:Array, param2:Number, param3:Object, param4:Number, param5:* = "+=0", param6:Function = null, param7:Array = null) : *
      {
         var _loc8_:TimelineLite = new TimelineLite({
            "onComplete":param6,
            "onCompleteParams":param7,
            "smoothChildTiming":this.smoothChildTiming
         });
         var _loc9_:* = 0;
         while(_loc9_ < param1.length)
         {
            if(param3.startAt != null)
            {
               param3.startAt = _copy(param3.startAt);
            }
            _loc8_.to(param1[_loc9_],param2,_copy(param3),_loc9_ * param4);
            _loc9_++;
         }
         return this.add(_loc8_,param5);
      }
      
      public function staggerFrom(param1:Array, param2:Number, param3:Object, param4:Number = 0, param5:* = "+=0", param6:Function = null, param7:Array = null) : *
      {
         var param3:Object = _prepVars(param3);
         if(!("immediateRender" in param3))
         {
            param3.immediateRender = true;
         }
         param3.runBackwards = true;
         return this.staggerTo(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function staggerFromTo(param1:Array, param2:Number, param3:Object, param4:Object, param5:Number = 0, param6:* = "+=0", param7:Function = null, param8:Array = null) : *
      {
         var param4:Object = _prepVars(param4);
         var param3:Object = _prepVars(param3);
         param4.startAt = param3;
         param4.immediateRender = !(param4.immediateRender == false) && !(param3.immediateRender == false);
         return this.staggerTo(param1,param2,param4,param5,param6,param7,param8);
      }
      
      public function call(param1:Function, param2:Array = null, param3:* = "+=0") : *
      {
         return this.add(TweenLite.delayedCall(0,param1,param2),param3);
      }
      
      public function set(param1:Object, param2:Object, param3:* = "+=0") : *
      {
         var param3:* = this._parseTimeOrLabel(param3,0,true);
         var param2:Object = _prepVars(param2);
         if(param2.immediateRender == null)
         {
            param2.immediateRender = param3 === _time && !_paused;
         }
         return this.add(new TweenLite(param1,0,param2),param3);
      }
      
      public function addPause(param1:* = "+=0", param2:Function = null, param3:Array = null) : *
      {
         return this.call(this._pauseCallback,["{self}",param2,param3],param1);
      }
      
      protected function _pauseCallback(param1:TweenLite, param2:Function = null, param3:Array = null) : void
      {
         pause(param1._startTime);
         if(param2 != null)
         {
            param2.apply(null,param3);
         }
      }
      
      override public function insert(param1:*, param2:* = 0) : *
      {
         return this.add(param1,param2 || 0);
      }
      
      override public function add(param1:*, param2:* = "+=0", param3:String = "normal", param4:Number = 0) : *
      {
         var _loc5_:* = 0;
         var _loc6_:* = NaN;
         var _loc7_:* = NaN;
         var _loc8_:* = undefined;
         var _loc9_:SimpleTimeline = null;
         var _loc10_:* = false;
         if(typeof param2 !== "number")
         {
            param2 = this._parseTimeOrLabel(param2,0,true,param1);
         }
         if(!(param1 is Animation))
         {
            if(param1 is Array)
            {
               _loc6_ = Number(param2);
               _loc7_ = param1.length;
               _loc5_ = 0;
               while(_loc5_ < _loc7_)
               {
                  _loc8_ = param1[_loc5_];
                  if(_loc8_ is Array)
                  {
                     _loc8_ = new TimelineLite({"tweens":_loc8_});
                  }
                  this.add(_loc8_,_loc6_);
                  if(!(typeof _loc8_ === "string" || typeof _loc8_ === "function"))
                  {
                     if(param3 === "sequence")
                     {
                        _loc6_ = _loc8_._startTime + _loc8_.totalDuration() / _loc8_._timeScale;
                     }
                     else if(param3 === "start")
                     {
                        _loc8_._startTime = _loc8_._startTime - _loc8_.delay();
                     }
                     
                  }
                  _loc6_ = _loc6_ + param4;
                  _loc5_++;
               }
               return _uncache(true);
            }
            if(typeof param1 === "string")
            {
               return this.addLabel(String(param1),param2);
            }
            if(typeof param1 === "function")
            {
               param1 = TweenLite.delayedCall(0,param1);
            }
            else
            {
               return this;
            }
         }
         super.add(param1,param2);
         if(_gc)
         {
            if(!_paused)
            {
               if(_duration < this.duration())
               {
                  _loc9_ = this;
                  _loc10_ = _loc9_.rawTime() > param1._startTime;
                  while((_loc9_._gc) && (_loc9_._timeline))
                  {
                     if((_loc9_._timeline.smoothChildTiming) && (_loc10_))
                     {
                        _loc9_.totalTime(_loc9_._totalTime,true);
                     }
                     else
                     {
                        _loc9_._enabled(true,false);
                     }
                     _loc9_ = _loc9_._timeline;
                  }
               }
            }
         }
         return this;
      }
      
      public function remove(param1:*) : *
      {
         var _loc2_:* = NaN;
         if(param1 is Animation)
         {
            return this._remove(param1,false);
         }
         if(param1 is Array)
         {
            _loc2_ = param1.length;
            while(--_loc2_ > -1)
            {
               this.remove(param1[_loc2_]);
            }
            return this;
         }
         if(typeof param1 == "string")
         {
            return this.removeLabel(String(param1));
         }
         return kill(null,param1);
      }
      
      override public function _remove(param1:Animation, param2:Boolean = false) : *
      {
         super._remove(param1,param2);
         if(_last == null)
         {
            _time = _totalTime = 0;
         }
         else if(_time > _last._startTime + _last._totalDuration / _last._timeScale)
         {
            _time = this.duration();
            _totalTime = _totalDuration;
         }
         
         return this;
      }
      
      public function append(param1:*, param2:* = 0) : *
      {
         return this.add(param1,this._parseTimeOrLabel(null,param2,true,param1));
      }
      
      public function insertMultiple(param1:Array, param2:* = 0, param3:String = "normal", param4:Number = 0) : *
      {
         return this.add(param1,param2 || 0,param3,param4);
      }
      
      public function appendMultiple(param1:Array, param2:* = 0, param3:String = "normal", param4:Number = 0) : *
      {
         return this.add(param1,this._parseTimeOrLabel(null,param2,true,param1),param3,param4);
      }
      
      public function addLabel(param1:String, param2:* = "+=0") : *
      {
         this._labels[param1] = this._parseTimeOrLabel(param2);
         return this;
      }
      
      public function removeLabel(param1:String) : *
      {
         delete this._labels[param1];
         true;
         return this;
      }
      
      public function getLabelTime(param1:String) : Number
      {
         return param1 in this._labels?Number(this._labels[param1]):-1;
      }
      
      protected function _parseTimeOrLabel(param1:*, param2:* = 0, param3:Boolean = false, param4:Object = null) : Number
      {
         var _loc5_:* = 0;
         if(param4 is Animation && param4.timeline === this)
         {
            this.remove(param4);
         }
         else if(param4 is Array)
         {
            _loc5_ = param4.length;
            while(--_loc5_ > -1)
            {
               if(param4[_loc5_] is Animation && param4[_loc5_].timeline === this)
               {
                  this.remove(param4[_loc5_]);
               }
            }
         }
         
         if(typeof param2 === "string")
         {
            return this._parseTimeOrLabel(param2,(param3) && typeof param1 === "number" && !(param2 in this._labels)?param1 - this.duration():0,param3);
         }
         var param2:* = param2 || 0;
         if(typeof param1 === "string" && ((isNaN(param1)) || param1 in this._labels))
         {
            _loc5_ = param1.indexOf("=");
            if(_loc5_ === -1)
            {
               if(!(param1 in this._labels))
               {
                  return param3?this._labels[param1] = this.duration() + param2:param2;
               }
               return this._labels[param1] + param2;
            }
            param2 = parseInt(param1.charAt(_loc5_ - 1) + "1",10) * Number(param1.substr(_loc5_ + 1));
            param1 = _loc5_ > 1?this._parseTimeOrLabel(param1.substr(0,_loc5_ - 1),0,param3):this.duration();
         }
         else if(param1 == null)
         {
            param1 = this.duration();
         }
         
         return Number(param1) + param2;
      }
      
      override public function seek(param1:*, param2:Boolean = true) : *
      {
         return totalTime(typeof param1 === "number"?Number(param1):this._parseTimeOrLabel(param1),param2);
      }
      
      public function stop() : *
      {
         return paused(true);
      }
      
      public function gotoAndPlay(param1:*, param2:Boolean = true) : *
      {
         return play(param1,param2);
      }
      
      public function gotoAndStop(param1:*, param2:Boolean = true) : *
      {
         return pause(param1,param2);
      }
      
      override public function render(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc9_:Animation = null;
         var _loc10_:* = false;
         var _loc11_:Animation = null;
         var _loc12_:String = null;
         var _loc13_:* = false;
         if(_gc)
         {
            this._enabled(true,false);
         }
         var _loc4_:Number = !_dirty?_totalDuration:this.totalDuration();
         var _loc5_:Number = _time;
         var _loc6_:Number = _startTime;
         var _loc7_:Number = _timeScale;
         var _loc8_:Boolean = _paused;
         if(param1 >= _loc4_)
         {
            _totalTime = _time = _loc4_;
            if(!_reversed)
            {
               if(!this._hasPausedChild())
               {
                  _loc10_ = true;
                  _loc12_ = "onComplete";
                  if(_duration === 0)
                  {
                     if(param1 === 0 || _rawPrevTime < 0 || _rawPrevTime === _tinyNum)
                     {
                        if(!(_rawPrevTime === param1) && !(_first == null))
                        {
                           _loc13_ = true;
                           if(_rawPrevTime > _tinyNum)
                           {
                              _loc12_ = "onReverseComplete";
                           }
                        }
                     }
                  }
               }
            }
            _rawPrevTime = !(_duration === 0) || !param2 || !(param1 === 0)?param1:_tinyNum;
            param1 = _loc4_ + 1.0E-4;
         }
         else if(param1 < 1.0E-7)
         {
            _totalTime = _time = 0;
            if(!(_loc5_ == 0) || _duration == 0 && (_rawPrevTime > _tinyNum || param1 < 0 && _rawPrevTime >= 0))
            {
               _loc12_ = "onReverseComplete";
               _loc10_ = _reversed;
            }
            if(param1 < 0)
            {
               _active = false;
               if(_duration == 0)
               {
                  if(_rawPrevTime >= 0 && !(_first == null))
                  {
                     _loc13_ = true;
                  }
               }
               _rawPrevTime = param1;
            }
            else
            {
               _rawPrevTime = (_duration) || (!param2) || !(param1 === 0)?param1:_tinyNum;
               param1 = 0;
               if(!_initted)
               {
                  _loc13_ = true;
               }
            }
         }
         else
         {
            _totalTime = _time = _rawPrevTime = param1;
         }
         
         if((_time == _loc5_ || !_first) && !param3 && !_loc13_)
         {
            return;
         }
         if(!_initted)
         {
            _initted = true;
         }
         if(!_active)
         {
            if(!_paused && !(_time === _loc5_) && param1 > 0)
            {
               _active = true;
            }
         }
         if(_loc5_ == 0)
         {
            if(vars.onStart)
            {
               if(_time != 0)
               {
                  if(!param2)
                  {
                     vars.onStart.apply(null,vars.onStartParams);
                  }
               }
            }
         }
         if(_time >= _loc5_)
         {
            _loc9_ = _first;
            while(_loc9_)
            {
               _loc11_ = _loc9_._next;
               if((_paused) && !_loc8_)
               {
                  break;
               }
               if((_loc9_._active) || _loc9_._startTime <= _time && !_loc9_._paused && !_loc9_._gc)
               {
                  if(!_loc9_._reversed)
                  {
                     _loc9_.render((param1 - _loc9_._startTime) * _loc9_._timeScale,param2,param3);
                  }
                  else
                  {
                     _loc9_.render((!_loc9_._dirty?_loc9_._totalDuration:_loc9_.totalDuration()) - (param1 - _loc9_._startTime) * _loc9_._timeScale,param2,param3);
                  }
               }
               _loc9_ = _loc11_;
            }
         }
         else
         {
            _loc9_ = _last;
            while(_loc9_)
            {
               _loc11_ = _loc9_._prev;
               if((_paused) && !_loc8_)
               {
                  break;
               }
               if((_loc9_._active) || _loc9_._startTime <= _loc5_ && !_loc9_._paused && !_loc9_._gc)
               {
                  if(!_loc9_._reversed)
                  {
                     _loc9_.render((param1 - _loc9_._startTime) * _loc9_._timeScale,param2,param3);
                  }
                  else
                  {
                     _loc9_.render((!_loc9_._dirty?_loc9_._totalDuration:_loc9_.totalDuration()) - (param1 - _loc9_._startTime) * _loc9_._timeScale,param2,param3);
                  }
               }
               _loc9_ = _loc11_;
            }
         }
         if(_onUpdate != null)
         {
            if(!param2)
            {
               _onUpdate.apply(null,vars.onUpdateParams);
            }
         }
         if(_loc12_)
         {
            if(!_gc)
            {
               if(_loc6_ == _startTime || !(_loc7_ == _timeScale))
               {
                  if(_time == 0 || _loc4_ >= this.totalDuration())
                  {
                     if(_loc10_)
                     {
                        if(_timeline.autoRemoveChildren)
                        {
                           this._enabled(false,false);
                        }
                        _active = false;
                     }
                     if(!param2)
                     {
                        if(vars[_loc12_])
                        {
                           vars[_loc12_].apply(null,vars[_loc12_ + "Params"]);
                        }
                     }
                  }
               }
            }
         }
      }
      
      public function _hasPausedChild() : Boolean
      {
         var _loc1_:Animation = _first;
         while(_loc1_)
         {
            if((_loc1_._paused) || _loc1_ is TimelineLite && (TimelineLite(_loc1_)._hasPausedChild()))
            {
               return true;
            }
            _loc1_ = _loc1_._next;
         }
         return false;
      }
      
      public function getChildren(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true, param4:Number = -9.999999999E9) : Array
      {
         var _loc5_:Array = [];
         var _loc6_:Animation = _first;
         var _loc7_:* = 0;
         while(_loc6_)
         {
            if(_loc6_._startTime >= param4)
            {
               if(_loc6_ is TweenLite)
               {
                  if(param2)
                  {
                     _loc5_[_loc7_++] = _loc6_;
                  }
               }
               else
               {
                  if(param3)
                  {
                     _loc5_[_loc7_++] = _loc6_;
                  }
                  if(param1)
                  {
                     _loc5_ = _loc5_.concat(TimelineLite(_loc6_).getChildren(true,param2,param3));
                     _loc7_ = _loc5_.length;
                  }
               }
            }
            _loc6_ = _loc6_._next;
         }
         return _loc5_;
      }
      
      public function getTweensOf(param1:Object, param2:Boolean = true) : Array
      {
         var _loc3_:Array = TweenLite.getTweensOf(param1);
         var _loc4_:int = _loc3_.length;
         var _loc5_:Array = [];
         var _loc6_:* = 0;
         while(--_loc4_ > -1)
         {
            if(_loc3_[_loc4_].timeline == this || (param2) && (this._contains(_loc3_[_loc4_])))
            {
               _loc5_[_loc6_++] = _loc3_[_loc4_];
            }
         }
         return _loc5_;
      }
      
      private function _contains(param1:Animation) : Boolean
      {
         var _loc2_:SimpleTimeline = param1.timeline;
         while(_loc2_)
         {
            if(_loc2_ == this)
            {
               return true;
            }
            _loc2_ = _loc2_.timeline;
         }
         return false;
      }
      
      public function shiftChildren(param1:Number, param2:Boolean = false, param3:Number = 0) : *
      {
         var _loc5_:String = null;
         var _loc4_:Animation = _first;
         while(_loc4_)
         {
            if(_loc4_._startTime >= param3)
            {
               _loc4_._startTime = _loc4_._startTime + param1;
            }
            _loc4_ = _loc4_._next;
         }
         if(param2)
         {
            for(_loc5_ in this._labels)
            {
               if(this._labels[_loc5_] >= param3)
               {
                  this._labels[_loc5_] = this._labels[_loc5_] + param1;
               }
            }
         }
         _uncache(true);
         return this;
      }
      
      override public function _kill(param1:Object = null, param2:Object = null) : Boolean
      {
         if(param1 == null)
         {
            if(param2 == null)
            {
               return this._enabled(false,false);
            }
         }
         var _loc3_:Array = param2 == null?this.getChildren(true,true,false):this.getTweensOf(param2);
         var _loc4_:int = _loc3_.length;
         var _loc5_:* = false;
         while(--_loc4_ > -1)
         {
            if(_loc3_[_loc4_]._kill(param1,param2))
            {
               _loc5_ = true;
            }
         }
         return _loc5_;
      }
      
      public function clear(param1:Boolean = true) : *
      {
         var _loc2_:Array = this.getChildren(false,true,true);
         var _loc3_:int = _loc2_.length;
         _time = _totalTime = 0;
         while(--_loc3_ > -1)
         {
            _loc2_[_loc3_]._enabled(false,false);
         }
         if(param1)
         {
            this._labels = {};
         }
         return _uncache(true);
      }
      
      override public function invalidate() : *
      {
         var _loc1_:Animation = _first;
         while(_loc1_)
         {
            _loc1_.invalidate();
            _loc1_ = _loc1_._next;
         }
         return this;
      }
      
      override public function _enabled(param1:Boolean, param2:Boolean = false) : Boolean
      {
         var _loc3_:Animation = null;
         if(param1 == _gc)
         {
            _loc3_ = _first;
            while(_loc3_)
            {
               _loc3_._enabled(param1,true);
               _loc3_ = _loc3_._next;
            }
         }
         return super._enabled(param1,param2);
      }
      
      override public function duration(param1:Number = NaN) : *
      {
         if(!arguments.length)
         {
            if(_dirty)
            {
               this.totalDuration();
            }
            return _duration;
         }
         if(this.duration() !== 0)
         {
            if(param1 !== 0)
            {
               timeScale(_duration / param1);
            }
         }
         return this;
      }
      
      override public function totalDuration(param1:Number = NaN) : *
      {
         var _loc3_:* = NaN;
         var _loc4_:Animation = null;
         var _loc5_:* = NaN;
         var _loc6_:Animation = null;
         var _loc7_:* = NaN;
         if(!arguments.length)
         {
            if(_dirty)
            {
               _loc3_ = 0;
               _loc4_ = _last;
               _loc5_ = Infinity;
               while(_loc4_)
               {
                  _loc6_ = _loc4_._prev;
                  if(_loc4_._dirty)
                  {
                     _loc4_.totalDuration();
                  }
                  if(_loc4_._startTime > _loc5_ && (_sortChildren) && !_loc4_._paused)
                  {
                     this.add(_loc4_,_loc4_._startTime - _loc4_._delay);
                  }
                  else
                  {
                     _loc5_ = _loc4_._startTime;
                  }
                  if(_loc4_._startTime < 0 && !_loc4_._paused)
                  {
                     _loc3_ = _loc3_ - _loc4_._startTime;
                     if(_timeline.smoothChildTiming)
                     {
                        _startTime = _startTime + _loc4_._startTime / _timeScale;
                     }
                     this.shiftChildren(-_loc4_._startTime,false,-9.999999999E9);
                     _loc5_ = 0;
                  }
                  _loc7_ = _loc4_._startTime + _loc4_._totalDuration / _loc4_._timeScale;
                  if(_loc7_ > _loc3_)
                  {
                     _loc3_ = _loc7_;
                  }
                  _loc4_ = _loc6_;
               }
               _duration = _totalDuration = _loc3_;
               _dirty = false;
            }
            return _totalDuration;
         }
         if(this.totalDuration() != 0)
         {
            if(param1 != 0)
            {
               timeScale(_totalDuration / param1);
            }
         }
         return this;
      }
      
      public function usesFrames() : Boolean
      {
         var _loc1_:SimpleTimeline = _timeline;
         while(_loc1_._timeline)
         {
            _loc1_ = _loc1_._timeline;
         }
         return _loc1_ == _rootFramesTimeline;
      }
      
      override public function rawTime() : Number
      {
         return _paused?_totalTime:(_timeline.rawTime() - _startTime) * _timeScale;
      }
   }
}
