package com.greensock.core
{
   import flash.display.Shape;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class Animation extends Object
   {
      
      public function Animation(param1:Number = 0, param2:Object = null)
      {
         super();
         this.vars = param2 || {};
         if(this.vars._isGSVars)
         {
            this.vars = this.vars.vars;
         }
         this._duration = this._totalDuration = (param1) || (0);
         this._delay = (Number(this.vars.delay)) || (0);
         this._timeScale = 1;
         this._totalTime = this._time = 0;
         this.data = this.vars.data;
         this._rawPrevTime = -1;
         if(_rootTimeline == null)
         {
            if(_rootFrame == -1)
            {
               _rootFrame = 0;
               _rootFramesTimeline = new SimpleTimeline();
               _rootTimeline = new SimpleTimeline();
               _rootTimeline._startTime = getTimer() / 1000;
               _rootFramesTimeline._startTime = 0;
               _rootTimeline._active = _rootFramesTimeline._active = true;
               ticker.addEventListener("enterFrame",_updateRoot,false,0,true);
            }
            else
            {
               return;
            }
         }
         var _loc3_:SimpleTimeline = this.vars.useFrames?_rootFramesTimeline:_rootTimeline;
         _loc3_.add(this,_loc3_._time);
         this._reversed = this.vars.reversed == true;
         if(this.vars.paused)
         {
            this.paused(true);
         }
      }
      
      public static const version:String = "12.1.1";
      
      public static var ticker:Shape = new Shape();
      
      public static var _rootTimeline:SimpleTimeline;
      
      public static var _rootFramesTimeline:SimpleTimeline;
      
      protected static var _rootFrame:Number = -1;
      
      protected static var _tickEvent:Event = new Event("tick");
      
      protected static var _tinyNum:Number = 1.0E-10;
      
      public static function _updateRoot(param1:Event = null) : void
      {
         _rootFrame++;
         _rootTimeline.render((getTimer() / 1000 - _rootTimeline._startTime) * _rootTimeline._timeScale,false,false);
         _rootFramesTimeline.render((_rootFrame - _rootFramesTimeline._startTime) * _rootFramesTimeline._timeScale,false,false);
         ticker.dispatchEvent(_tickEvent);
      }
      
      protected var _onUpdate:Function;
      
      public var _delay:Number;
      
      public var _rawPrevTime:Number;
      
      public var _active:Boolean;
      
      public var _gc:Boolean;
      
      public var _initted:Boolean;
      
      public var _startTime:Number;
      
      public var _time:Number;
      
      public var _totalTime:Number;
      
      public var _duration:Number;
      
      public var _totalDuration:Number;
      
      public var _pauseTime:Number;
      
      public var _timeScale:Number;
      
      public var _reversed:Boolean;
      
      public var _timeline:SimpleTimeline;
      
      public var _dirty:Boolean;
      
      public var _paused:Boolean;
      
      public var _next:Animation;
      
      public var _prev:Animation;
      
      public var vars:Object;
      
      public var timeline:SimpleTimeline;
      
      public var data;
      
      public function play(param1:* = null, param2:Boolean = true) : *
      {
         if(arguments.length)
         {
            this.seek(param1,param2);
         }
         this.reversed(false);
         return this.paused(false);
      }
      
      public function pause(param1:* = null, param2:Boolean = true) : *
      {
         if(arguments.length)
         {
            this.seek(param1,param2);
         }
         return this.paused(true);
      }
      
      public function resume(param1:* = null, param2:Boolean = true) : *
      {
         if(arguments.length)
         {
            this.seek(param1,param2);
         }
         return this.paused(false);
      }
      
      public function seek(param1:*, param2:Boolean = true) : *
      {
         return this.totalTime(Number(param1),param2);
      }
      
      public function restart(param1:Boolean = false, param2:Boolean = true) : *
      {
         this.reversed(false);
         this.paused(false);
         return this.totalTime(param1?-this._delay:0,param2,true);
      }
      
      public function reverse(param1:* = null, param2:Boolean = true) : *
      {
         if(arguments.length)
         {
            this.seek(param1 || this.totalDuration(),param2);
         }
         this.reversed(true);
         return this.paused(false);
      }
      
      public function render(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
      }
      
      public function invalidate() : *
      {
         return this;
      }
      
      public function isActive() : Boolean
      {
         var _loc2_:* = NaN;
         var _loc1_:SimpleTimeline = this._timeline;
         return _loc1_ == null || !this._gc && !this._paused && (_loc1_.isActive()) && (_loc2_ = _loc1_.rawTime()) >= this._startTime && _loc2_ < this._startTime + this.totalDuration() / this._timeScale;
      }
      
      public function _enabled(param1:Boolean, param2:Boolean = false) : Boolean
      {
         this._gc = !param1;
         this._active = Boolean(param1 && !this._paused && this._totalTime > 0 && this._totalTime < this._totalDuration);
         if(!param2)
         {
            if((param1) && this.timeline == null)
            {
               this._timeline.add(this,this._startTime - this._delay);
            }
            else if(!param1 && !(this.timeline == null))
            {
               this._timeline._remove(this,true);
            }
            
         }
         return false;
      }
      
      public function _kill(param1:Object = null, param2:Object = null) : Boolean
      {
         return this._enabled(false,false);
      }
      
      public function kill(param1:Object = null, param2:Object = null) : *
      {
         this._kill(param1,param2);
         return this;
      }
      
      protected function _uncache(param1:Boolean) : *
      {
         var _loc2_:Animation = param1?this:this.timeline;
         while(_loc2_)
         {
            _loc2_._dirty = true;
            _loc2_ = _loc2_.timeline;
         }
         return this;
      }
      
      protected function _swapSelfInParams(param1:Array) : Array
      {
         var _loc2_:int = param1.length;
         var _loc3_:Array = param1.concat();
         while(--_loc2_ > -1)
         {
            if(param1[_loc2_] === "{self}")
            {
               _loc3_[_loc2_] = this;
            }
         }
         return _loc3_;
      }
      
      public function eventCallback(param1:String, param2:Function = null, param3:Array = null) : *
      {
         if(param1 == null)
         {
            return null;
         }
         if(param1.substr(0,2) == "on")
         {
            if(arguments.length == 1)
            {
               return this.vars[param1];
            }
            if(param2 == null)
            {
               delete this.vars[param1];
               true;
            }
            else
            {
               this.vars[param1] = param2;
               this.vars[param1 + "Params"] = param3 is Array && !(param3.join("").indexOf("{self}") === -1)?this._swapSelfInParams(param3):param3;
            }
            if(param1 == "onUpdate")
            {
               this._onUpdate = param2;
            }
         }
         return this;
      }
      
      public function delay(param1:Number = NaN) : *
      {
         if(!arguments.length)
         {
            return this._delay;
         }
         if(this._timeline.smoothChildTiming)
         {
            this.startTime(this._startTime + param1 - this._delay);
         }
         this._delay = param1;
         return this;
      }
      
      public function duration(param1:Number = NaN) : *
      {
         if(!arguments.length)
         {
            this._dirty = false;
            return this._duration;
         }
         this._duration = this._totalDuration = param1;
         this._uncache(true);
         if(this._timeline.smoothChildTiming)
         {
            if(this._time > 0)
            {
               if(this._time < this._duration)
               {
                  if(param1 != 0)
                  {
                     this.totalTime(this._totalTime * param1 / this._duration,true);
                  }
               }
            }
         }
         return this;
      }
      
      public function totalDuration(param1:Number = NaN) : *
      {
         this._dirty = false;
         return !arguments.length?this._totalDuration:this.duration(param1);
      }
      
      public function time(param1:Number = NaN, param2:Boolean = false) : *
      {
         if(!arguments.length)
         {
            return this._time;
         }
         if(this._dirty)
         {
            this.totalDuration();
         }
         if(param1 > this._duration)
         {
            param1 = this._duration;
         }
         return this.totalTime(param1,param2);
      }
      
      public function totalTime(param1:Number = NaN, param2:Boolean = false, param3:Boolean = false) : *
      {
         var _loc5_:SimpleTimeline = null;
         if(!arguments.length)
         {
            return this._totalTime;
         }
         if(this._timeline)
         {
            if(param1 < 0 && !param3)
            {
               param1 = param1 + this.totalDuration();
            }
            if(this._timeline.smoothChildTiming)
            {
               if(this._dirty)
               {
                  this.totalDuration();
               }
               if(param1 > this._totalDuration && !param3)
               {
                  param1 = this._totalDuration;
               }
               _loc5_ = this._timeline;
               this._startTime = (this._paused?this._pauseTime:_loc5_._time) - (!this._reversed?param1:this._totalDuration - param1) / this._timeScale;
               if(!this._timeline._dirty)
               {
                  this._uncache(false);
               }
               if(_loc5_._timeline != null)
               {
                  while(_loc5_._timeline)
                  {
                     if(_loc5_._timeline._time !== (_loc5_._startTime + _loc5_._totalTime) / _loc5_._timeScale)
                     {
                        _loc5_.totalTime(_loc5_._totalTime,true);
                     }
                     _loc5_ = _loc5_._timeline;
                  }
               }
            }
            if(this._gc)
            {
               this._enabled(true,false);
            }
            if(!(this._totalTime == param1) || this._duration === 0)
            {
               this.render(param1,param2,false);
            }
         }
         return this;
      }
      
      public function progress(param1:Number = NaN, param2:Boolean = false) : *
      {
         return !arguments.length?this._time / this.duration():this.totalTime(this.duration() * param1,param2);
      }
      
      public function totalProgress(param1:Number = NaN, param2:Boolean = false) : *
      {
         return !arguments.length?this._time / this.duration():this.totalTime(this.duration() * param1,param2);
      }
      
      public function startTime(param1:Number = NaN) : *
      {
         if(!arguments.length)
         {
            return this._startTime;
         }
         if(param1 != this._startTime)
         {
            this._startTime = param1;
            if(this.timeline)
            {
               if(this.timeline._sortChildren)
               {
                  this.timeline.add(this,param1 - this._delay);
               }
            }
         }
         return this;
      }
      
      public function timeScale(param1:Number = NaN) : *
      {
         var _loc3_:* = NaN;
         if(!arguments.length)
         {
            return this._timeScale;
         }
         var param1:Number = (param1) || (1.0E-6);
         if((this._timeline) && (this._timeline.smoothChildTiming))
         {
            _loc3_ = (this._pauseTime) || this._pauseTime == 0?this._pauseTime:this._timeline._totalTime;
            this._startTime = _loc3_ - (_loc3_ - this._startTime) * this._timeScale / param1;
         }
         this._timeScale = param1;
         return this._uncache(false);
      }
      
      public function reversed(param1:Boolean = false) : *
      {
         if(!arguments.length)
         {
            return this._reversed;
         }
         if(param1 != this._reversed)
         {
            this._reversed = param1;
            this.totalTime((this._timeline) && !this._timeline.smoothChildTiming?this.totalDuration() - this._totalTime:this._totalTime,true);
         }
         return this;
      }
      
      public function paused(param1:Boolean = false) : *
      {
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         if(!arguments.length)
         {
            return this._paused;
         }
         if(param1 != this._paused)
         {
            if(this._timeline)
            {
               _loc3_ = this._timeline.rawTime();
               _loc4_ = _loc3_ - this._pauseTime;
               if(!param1 && (this._timeline.smoothChildTiming))
               {
                  this._startTime = this._startTime + _loc4_;
                  this._uncache(false);
               }
               this._pauseTime = param1?_loc3_:NaN;
               this._paused = param1;
               this._active = !param1 && this._totalTime > 0 && this._totalTime < this._totalDuration;
               if(!param1 && !(_loc4_ == 0) && (this._initted) && !(this.duration() === 0))
               {
                  this.render(this._timeline.smoothChildTiming?this._totalTime:(_loc3_ - this._startTime) / this._timeScale,true,true);
               }
            }
         }
         if((this._gc) && !param1)
         {
            this._enabled(true,false);
         }
         return this;
      }
   }
}
