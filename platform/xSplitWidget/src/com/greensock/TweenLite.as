package com.greensock
{
   import com.greensock.core.Animation;
   import com.greensock.easing.Ease;
   import flash.display.Shape;
   import flash.utils.Dictionary;
   import flash.events.Event;
   import com.greensock.core.SimpleTimeline;
   import com.greensock.core.PropTween;
   
   public class TweenLite extends Animation
   {
      
      public function TweenLite(param1:Object, param2:Number, param3:Object)
      {
         var _loc4_:* = 0;
         super(param2,param3);
         if(param1 == null)
         {
            throw new Error("Cannot tween a null object. Duration: " + param2 + ", data: " + this.data);
         }
         else
         {
            if(!_overwriteLookup)
            {
               _overwriteLookup = {
                  "none":0,
                  "all":1,
                  "auto":2,
                  "concurrent":3,
                  "allOnStart":4,
                  "preexisting":5,
                  "true":1,
                  "false":0
               };
               ticker.addEventListener("enterFrame",_dumpGarbage,false,-1,true);
            }
            this.ratio = 0;
            this.target = param1;
            this._ease = defaultEase;
            this._overwrite = !("overwrite" in this.vars)?_overwriteLookup[defaultOverwrite]:typeof this.vars.overwrite === "number"?this.vars.overwrite >> 0:_overwriteLookup[this.vars.overwrite];
            if(this.target is Array && typeof this.target[0] === "object")
            {
               this._targets = this.target.concat();
               this._propLookup = [];
               this._siblings = [];
               _loc4_ = this._targets.length;
               while(--_loc4_ > -1)
               {
                  this._siblings[_loc4_] = _register(this._targets[_loc4_],this,false);
                  if(this._overwrite == 1)
                  {
                     if(this._siblings[_loc4_].length > 1)
                     {
                        _applyOverwrite(this._targets[_loc4_],this,null,1,this._siblings[_loc4_]);
                     }
                  }
               }
            }
            else
            {
               this._propLookup = {};
               this._siblings = _tweenLookup[param1];
               if(this._siblings == null)
               {
                  this._siblings = _tweenLookup[param1] = [this];
               }
               else
               {
                  this._siblings[this._siblings.length] = this;
                  if(this._overwrite == 1)
                  {
                     _applyOverwrite(param1,this,null,1,this._siblings);
                  }
               }
            }
            if((this.vars.immediateRender) || param2 == 0 && _delay == 0 && !(this.vars.immediateRender == false))
            {
               this.render(-_delay,false,true);
            }
            return;
         }
      }
      
      public static const version:String = "12.1.2";
      
      public static var defaultEase:Ease = new Ease(null,null,1,1);
      
      public static var defaultOverwrite:String = "auto";
      
      public static var ticker:Shape = Animation.ticker;
      
      public static var _plugins:Object = {};
      
      public static var _onPluginEvent:Function;
      
      protected static var _tweenLookup:Dictionary = new Dictionary(false);
      
      protected static var _reservedProps:Object = {
         "ease":1,
         "delay":1,
         "overwrite":1,
         "onComplete":1,
         "onCompleteParams":1,
         "onCompleteScope":1,
         "useFrames":1,
         "runBackwards":1,
         "startAt":1,
         "onUpdate":1,
         "onUpdateParams":1,
         "onUpdateScope":1,
         "onStart":1,
         "onStartParams":1,
         "onStartScope":1,
         "onReverseComplete":1,
         "onReverseCompleteParams":1,
         "onReverseCompleteScope":1,
         "onRepeat":1,
         "onRepeatParams":1,
         "onRepeatScope":1,
         "easeParams":1,
         "yoyo":1,
         "onCompleteListener":1,
         "onUpdateListener":1,
         "onStartListener":1,
         "onReverseCompleteListener":1,
         "onRepeatListener":1,
         "orientToBezier":1,
         "immediateRender":1,
         "repeat":1,
         "repeatDelay":1,
         "data":1,
         "paused":1,
         "reversed":1
      };
      
      protected static var _overwriteLookup:Object;
      
      public static function to(param1:Object, param2:Number, param3:Object) : TweenLite
      {
         return new TweenLite(param1,param2,param3);
      }
      
      public static function from(param1:Object, param2:Number, param3:Object) : TweenLite
      {
         var param3:Object = _prepVars(param3,true);
         param3.runBackwards = true;
         return new TweenLite(param1,param2,param3);
      }
      
      public static function fromTo(param1:Object, param2:Number, param3:Object, param4:Object) : TweenLite
      {
         var param4:Object = _prepVars(param4,true);
         var param3:Object = _prepVars(param3);
         param4.startAt = param3;
         param4.immediateRender = !(param4.immediateRender == false) && !(param3.immediateRender == false);
         return new TweenLite(param1,param2,param4);
      }
      
      protected static function _prepVars(param1:Object, param2:Boolean = false) : Object
      {
         if(param1._isGSVars)
         {
            param1 = param1.vars;
         }
         if((param2) && !("immediateRender" in param1))
         {
            param1.immediateRender = true;
         }
         return param1;
      }
      
      public static function delayedCall(param1:Number, param2:Function, param3:Array = null, param4:Boolean = false) : TweenLite
      {
         return new TweenLite(param2,0,{
            "delay":param1,
            "onComplete":param2,
            "onCompleteParams":param3,
            "onReverseComplete":param2,
            "onReverseCompleteParams":param3,
            "immediateRender":false,
            "useFrames":param4,
            "overwrite":0
         });
      }
      
      public static function set(param1:Object, param2:Object) : TweenLite
      {
         return new TweenLite(param1,0,param2);
      }
      
      private static function _dumpGarbage(param1:Event) : void
      {
         var _loc2_:* = 0;
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(_rootFrame / 60 >> 0 === _rootFrame / 60)
         {
            for(_loc4_ in _tweenLookup)
            {
               _loc3_ = _tweenLookup[_loc4_];
               _loc2_ = _loc3_.length;
               while(--_loc2_ > -1)
               {
                  if(_loc3_[_loc2_]._gc)
                  {
                     _loc3_.splice(_loc2_,1);
                  }
               }
               if(_loc3_.length === 0)
               {
                  delete _tweenLookup[_loc4_];
                  true;
               }
            }
         }
      }
      
      public static function killTweensOf(param1:*, param2:* = false, param3:Object = null) : void
      {
         if(typeof param2 === "object")
         {
            param3 = param2;
            param2 = false;
         }
         var _loc4_:Array = TweenLite.getTweensOf(param1,param2);
         var _loc5_:int = _loc4_.length;
         while(--_loc5_ > -1)
         {
            _loc4_[_loc5_]._kill(param3,param1);
         }
      }
      
      public static function killDelayedCallsTo(param1:Function) : void
      {
         killTweensOf(param1);
      }
      
      public static function getTweensOf(param1:*, param2:Boolean = false) : Array
      {
         var _loc3_:* = 0;
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         var _loc6_:TweenLite = null;
         if(param1 is Array && !(typeof param1[0] == "string") && !(typeof param1[0] == "number"))
         {
            _loc3_ = param1.length;
            _loc4_ = [];
            while(--_loc3_ > -1)
            {
               _loc4_ = _loc4_.concat(getTweensOf(param1[_loc3_],param2));
            }
            _loc3_ = _loc4_.length;
            while(--_loc3_ > -1)
            {
               _loc6_ = _loc4_[_loc3_];
               _loc5_ = _loc3_;
               while(--_loc5_ > -1)
               {
                  if(_loc6_ === _loc4_[_loc5_])
                  {
                     _loc4_.splice(_loc3_,1);
                  }
               }
            }
         }
         else
         {
            _loc4_ = _register(param1).concat();
            _loc3_ = _loc4_.length;
            while(--_loc3_ > -1)
            {
               if((_loc4_[_loc3_]._gc) || (param2) && !_loc4_[_loc3_].isActive())
               {
                  _loc4_.splice(_loc3_,1);
               }
            }
         }
         return _loc4_;
      }
      
      protected static function _register(param1:Object, param2:TweenLite = null, param3:Boolean = false) : Array
      {
         var _loc5_:* = 0;
         var _loc4_:Array = _tweenLookup[param1];
         if(_loc4_ == null)
         {
            _loc4_ = _tweenLookup[param1] = [];
         }
         if(param2)
         {
            _loc5_ = _loc4_.length;
            _loc4_[_loc5_] = param2;
            if(param3)
            {
               while(--_loc5_ > -1)
               {
                  if(_loc4_[_loc5_] === param2)
                  {
                     _loc4_.splice(_loc5_,1);
                  }
               }
            }
         }
         return _loc4_;
      }
      
      protected static function _applyOverwrite(param1:Object, param2:TweenLite, param3:Object, param4:int, param5:Array) : Boolean
      {
         var _loc6_:* = 0;
         var _loc7_:* = false;
         var _loc8_:TweenLite = null;
         var _loc13_:* = NaN;
         var _loc14_:* = 0;
         if(param4 == 1 || param4 >= 4)
         {
            _loc14_ = param5.length;
            _loc6_ = 0;
            while(_loc6_ < _loc14_)
            {
               _loc8_ = param5[_loc6_];
               if(_loc8_ != param2)
               {
                  if(!_loc8_._gc)
                  {
                     if(_loc8_._enabled(false,false))
                     {
                        _loc7_ = true;
                     }
                  }
               }
               else if(param4 == 5)
               {
                  break;
               }
               
               _loc6_++;
            }
            return _loc7_;
         }
         var _loc9_:Number = param2._startTime + 1.0E-10;
         var _loc10_:Array = [];
         var _loc11_:* = 0;
         var _loc12_:* = param2._duration == 0;
         _loc6_ = param5.length;
         while(--_loc6_ > -1)
         {
            _loc8_ = param5[_loc6_];
            if(!(_loc8_ === param2 || (_loc8_._gc) || (_loc8_._paused)))
            {
               if(_loc8_._timeline != param2._timeline)
               {
                  _loc13_ = (_loc13_) || (_checkOverlap(param2,0,_loc12_));
                  if(_checkOverlap(_loc8_,_loc13_,_loc12_) === 0)
                  {
                     _loc10_[_loc11_++] = _loc8_;
                  }
               }
               else if(_loc8_._startTime <= _loc9_)
               {
                  if(_loc8_._startTime + _loc8_.totalDuration() / _loc8_._timeScale > _loc9_)
                  {
                     if(!(((_loc12_) || !_loc8_._initted) && _loc9_ - _loc8_._startTime <= 2.0E-10))
                     {
                        _loc10_[_loc11_++] = _loc8_;
                     }
                  }
               }
               
            }
         }
         _loc6_ = _loc11_;
         while(--_loc6_ > -1)
         {
            _loc8_ = _loc10_[_loc6_];
            if(param4 == 2)
            {
               if(_loc8_._kill(param3,param1))
               {
                  _loc7_ = true;
               }
            }
            if(!(param4 === 2) || !_loc8_._firstPT && (_loc8_._initted))
            {
               if(_loc8_._enabled(false,false))
               {
                  _loc7_ = true;
               }
            }
         }
         return _loc7_;
      }
      
      private static function _checkOverlap(param1:Animation, param2:Number, param3:Boolean) : Number
      {
         var _loc4_:SimpleTimeline = param1._timeline;
         var _loc5_:Number = _loc4_._timeScale;
         var _loc6_:Number = param1._startTime;
         var _loc7_:Number = 1.0E-10;
         while(_loc4_._timeline)
         {
            _loc6_ = _loc6_ + _loc4_._startTime;
            _loc5_ = _loc5_ * _loc4_._timeScale;
            if(_loc4_._paused)
            {
               return -100;
            }
            _loc4_ = _loc4_._timeline;
         }
         _loc6_ = _loc6_ / _loc5_;
         return _loc6_ > param2?_loc6_ - param2:(param3) && _loc6_ == param2 || !param1._initted && _loc6_ - param2 < 2 * _loc7_?_loc7_:(_loc6_ = _loc6_ + param1.totalDuration() / param1._timeScale / _loc5_) > param2 + _loc7_?0:_loc6_ - param2 - _loc7_;
      }
      
      public var target:Object;
      
      public var ratio:Number;
      
      public var _propLookup:Object;
      
      public var _firstPT:PropTween;
      
      protected var _targets:Array;
      
      public var _ease:Ease;
      
      protected var _easeType:int;
      
      protected var _easePower:int;
      
      protected var _siblings:Array;
      
      protected var _overwrite:int;
      
      protected var _overwrittenProps:Object;
      
      protected var _notifyPluginsOfEnabled:Boolean;
      
      protected var _startAt:TweenLite;
      
      protected function _init() : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = false;
         var _loc4_:PropTween = null;
         var _loc5_:String = null;
         var _loc6_:Object = null;
         var _loc1_:Boolean = vars.immediateRender;
         if(vars.startAt)
         {
            if(this._startAt != null)
            {
               this._startAt.render(-1,true);
            }
            vars.startAt.overwrite = 0;
            vars.startAt.immediateRender = true;
            this._startAt = new TweenLite(this.target,0,vars.startAt);
            if(_loc1_)
            {
               if(_time > 0)
               {
                  this._startAt = null;
               }
               else if(_duration !== 0)
               {
                  return;
               }
               
            }
         }
         else if((vars.runBackwards) && !(_duration === 0))
         {
            if(this._startAt != null)
            {
               this._startAt.render(-1,true);
               this._startAt = null;
            }
            else
            {
               _loc6_ = {};
               for(_loc5_ in vars)
               {
                  if(!(_loc5_ in _reservedProps))
                  {
                     _loc6_[_loc5_] = vars[_loc5_];
                  }
               }
               _loc6_.overwrite = 0;
               _loc6_.data = "isFromStart";
               this._startAt = TweenLite.to(this.target,0,_loc6_);
               if(!_loc1_)
               {
                  this._startAt.render(-1,true);
               }
               else if(_time === 0)
               {
                  return;
               }
               
            }
         }
         
         if(vars.ease is Ease)
         {
            this._ease = vars.easeParams is Array?vars.ease.config.apply(vars.ease,vars.easeParams):vars.ease;
         }
         else if(typeof vars.ease === "function")
         {
            this._ease = new Ease(vars.ease,vars.easeParams);
         }
         else
         {
            this._ease = defaultEase;
         }
         
         this._easeType = this._ease._type;
         this._easePower = this._ease._power;
         this._firstPT = null;
         if(this._targets)
         {
            _loc2_ = this._targets.length;
            while(--_loc2_ > -1)
            {
               if(this._initProps(this._targets[_loc2_],this._propLookup[_loc2_] = {},this._siblings[_loc2_],this._overwrittenProps?this._overwrittenProps[_loc2_]:null))
               {
                  _loc3_ = true;
               }
            }
         }
         else
         {
            _loc3_ = this._initProps(this.target,this._propLookup,this._siblings,this._overwrittenProps);
         }
         if(_loc3_)
         {
            _onPluginEvent("_onInitAllProps",this);
         }
         if(this._overwrittenProps)
         {
            if(this._firstPT == null)
            {
               if(typeof this.target !== "function")
               {
                  this._enabled(false,false);
               }
            }
         }
         if(vars.runBackwards)
         {
            _loc4_ = this._firstPT;
            while(_loc4_)
            {
               _loc4_.s = _loc4_.s + _loc4_.c;
               _loc4_.c = -_loc4_.c;
               _loc4_ = _loc4_._next;
            }
         }
         _onUpdate = vars.onUpdate;
         _initted = true;
      }
      
      protected function _initProps(param1:Object, param2:Object, param3:Array, param4:Object) : Boolean
      {
         var _loc6_:String = null;
         var _loc7_:* = 0;
         var _loc8_:* = false;
         var _loc9_:Object = null;
         var _loc10_:Object = null;
         var _loc5_:Object = this.vars;
         if(param1 == null)
         {
            return false;
         }
         for(_loc6_ in _loc5_)
         {
            _loc10_ = _loc5_[_loc6_];
            if(_loc6_ in _reservedProps)
            {
               if(_loc10_ is Array)
               {
                  if(_loc10_.join("").indexOf("{self}") !== -1)
                  {
                     _loc5_[_loc6_] = _swapSelfInParams(_loc10_ as Array);
                  }
               }
            }
            else if(_loc6_ in _plugins && ((_loc9_ = new _plugins[_loc6_]())._onInitTween(param1,_loc10_,this)))
            {
               this._firstPT = new PropTween(_loc9_,"setRatio",0,1,_loc6_,true,this._firstPT,_loc9_._priority);
               _loc7_ = _loc9_._overwriteProps.length;
               while(--_loc7_ > -1)
               {
                  param2[_loc9_._overwriteProps[_loc7_]] = this._firstPT;
               }
               if((_loc9_._priority) || "_onInitAllProps" in _loc9_)
               {
                  _loc8_ = true;
               }
               if("_onDisable" in _loc9_ || "_onEnable" in _loc9_)
               {
                  this._notifyPluginsOfEnabled = true;
               }
            }
            else
            {
               this._firstPT = param2[_loc6_] = new PropTween(param1,_loc6_,0,1,_loc6_,false,this._firstPT);
               this._firstPT.s = !this._firstPT.f?Number(param1[_loc6_]):param1[(_loc6_.indexOf("set")) || !("get" + _loc6_.substr(3) in param1)?_loc6_:"get" + _loc6_.substr(3)]();
               this._firstPT.c = typeof _loc10_ === "number"?Number(_loc10_) - this._firstPT.s:typeof _loc10_ === "string" && _loc10_.charAt(1) === "="?int(_loc10_.charAt(0) + "1") * Number(_loc10_.substr(2)):(Number(_loc10_)) || (0);
            }
            
         }
         if(param4)
         {
            if(this._kill(param4,param1))
            {
               return this._initProps(param1,param2,param3,param4);
            }
         }
         if(this._overwrite > 1)
         {
            if(this._firstPT != null)
            {
               if(param3.length > 1)
               {
                  if(_applyOverwrite(param1,this,param2,this._overwrite,param3))
                  {
                     this._kill(param2,param1);
                     return this._initProps(param1,param2,param3,param4);
                  }
               }
            }
         }
         return _loc8_;
      }
      
      override public function render(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc4_:* = false;
         var _loc5_:String = null;
         var _loc6_:PropTween = null;
         var _loc7_:* = NaN;
         var _loc9_:* = NaN;
         var _loc8_:Number = _time;
         if(param1 >= _duration)
         {
            _totalTime = _time = _duration;
            this.ratio = this._ease._calcEnd?this._ease.getRatio(1):1;
            if(!_reversed)
            {
               _loc4_ = true;
               _loc5_ = "onComplete";
            }
            if(_duration == 0)
            {
               _loc7_ = _rawPrevTime;
               if(param1 === 0 || _loc7_ < 0 || _loc7_ === _tinyNum)
               {
                  if(_loc7_ !== param1)
                  {
                     param3 = true;
                     if(_loc7_ > _tinyNum)
                     {
                        _loc5_ = "onReverseComplete";
                     }
                  }
               }
               _rawPrevTime = _loc7_ = !param2 || !(param1 === 0)?param1:_tinyNum;
            }
         }
         else if(param1 < 1.0E-7)
         {
            _totalTime = _time = 0;
            this.ratio = this._ease._calcEnd?this._ease.getRatio(0):0;
            if(!(_loc8_ == 0) || _duration == 0 && _rawPrevTime > _tinyNum)
            {
               _loc5_ = "onReverseComplete";
               _loc4_ = _reversed;
            }
            if(param1 < 0)
            {
               _active = false;
               if(_duration == 0)
               {
                  if(_rawPrevTime >= 0)
                  {
                     param3 = true;
                  }
                  _rawPrevTime = _loc7_ = !param2 || !(param1 === 0)?param1:_tinyNum;
               }
            }
            else if(!_initted)
            {
               param3 = true;
            }
            
         }
         else
         {
            _totalTime = _time = param1;
            if(this._easeType)
            {
               _loc9_ = param1 / _duration;
               if(this._easeType == 1 || this._easeType == 3 && _loc9_ >= 0.5)
               {
                  _loc9_ = 1 - _loc9_;
               }
               if(this._easeType == 3)
               {
                  _loc9_ = _loc9_ * 2;
               }
               if(this._easePower == 1)
               {
                  _loc9_ = _loc9_ * _loc9_;
               }
               else if(this._easePower == 2)
               {
                  _loc9_ = _loc9_ * _loc9_ * _loc9_;
               }
               else if(this._easePower == 3)
               {
                  _loc9_ = _loc9_ * _loc9_ * _loc9_ * _loc9_;
               }
               else if(this._easePower == 4)
               {
                  _loc9_ = _loc9_ * _loc9_ * _loc9_ * _loc9_ * _loc9_;
               }
               
               
               
               if(this._easeType == 1)
               {
                  this.ratio = 1 - _loc9_;
               }
               else if(this._easeType == 2)
               {
                  this.ratio = _loc9_;
               }
               else if(param1 / _duration < 0.5)
               {
                  this.ratio = _loc9_ / 2;
               }
               else
               {
                  this.ratio = 1 - _loc9_ / 2;
               }
               
               
            }
            else
            {
               this.ratio = this._ease.getRatio(param1 / _duration);
            }
         }
         
         if(_time == _loc8_ && !param3)
         {
            return;
         }
         if(!_initted)
         {
            this._init();
            if(!_initted || (_gc))
            {
               return;
            }
            if((_time) && !_loc4_)
            {
               this.ratio = this._ease.getRatio(_time / _duration);
            }
            else if((_loc4_) && (this._ease._calcEnd))
            {
               this.ratio = this._ease.getRatio(_time === 0?0:1);
            }
            
         }
         if(!_active)
         {
            if(!_paused && !(_time === _loc8_) && param1 >= 0)
            {
               _active = true;
            }
         }
         if(_loc8_ == 0)
         {
            if(this._startAt != null)
            {
               if(param1 >= 0)
               {
                  this._startAt.render(param1,param2,param3);
               }
               else if(!_loc5_)
               {
                  _loc5_ = "_dummyGS";
               }
               
            }
            if(vars.onStart)
            {
               if(!(_time == 0) || _duration == 0)
               {
                  if(!param2)
                  {
                     vars.onStart.apply(null,vars.onStartParams);
                  }
               }
            }
         }
         _loc6_ = this._firstPT;
         while(_loc6_)
         {
            if(_loc6_.f)
            {
               _loc6_.t[_loc6_.p](_loc6_.c * this.ratio + _loc6_.s);
            }
            else
            {
               _loc6_.t[_loc6_.p] = _loc6_.c * this.ratio + _loc6_.s;
            }
            _loc6_ = _loc6_._next;
         }
         if(_onUpdate != null)
         {
            if(param1 < 0 && !(this._startAt == null) && !(_startTime == 0))
            {
               this._startAt.render(param1,param2,param3);
            }
            if(!param2)
            {
               if(!(_time === _loc8_) || (_loc4_))
               {
                  _onUpdate.apply(null,vars.onUpdateParams);
               }
            }
         }
         if(_loc5_)
         {
            if(!_gc)
            {
               if(param1 < 0 && !(this._startAt == null) && _onUpdate == null && !(_startTime == 0))
               {
                  this._startAt.render(param1,param2,param3);
               }
               if(_loc4_)
               {
                  if(_timeline.autoRemoveChildren)
                  {
                     this._enabled(false,false);
                  }
                  _active = false;
               }
               if(!param2)
               {
                  if(vars[_loc5_])
                  {
                     vars[_loc5_].apply(null,vars[_loc5_ + "Params"]);
                  }
               }
               if(_duration === 0 && _rawPrevTime === _tinyNum && !(_loc7_ === _tinyNum))
               {
                  _rawPrevTime = 0;
               }
            }
         }
      }
      
      override public function _kill(param1:Object = null, param2:Object = null) : Boolean
      {
         var _loc3_:* = 0;
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:PropTween = null;
         var _loc7_:Object = null;
         var _loc8_:* = false;
         var _loc9_:Object = null;
         var _loc10_:* = false;
         if(param1 === "all")
         {
            param1 = null;
         }
         if(param1 == null)
         {
            if(param2 == null || param2 == this.target)
            {
               return this._enabled(false,false);
            }
         }
         var param2:Object = param2 || this._targets || this.target;
         if(param2 is Array && typeof param2[0] === "object")
         {
            _loc3_ = param2.length;
            while(--_loc3_ > -1)
            {
               if(this._kill(param1,param2[_loc3_]))
               {
                  _loc8_ = true;
               }
            }
         }
         else
         {
            if(this._targets)
            {
               _loc3_ = this._targets.length;
               while(--_loc3_ > -1)
               {
                  if(param2 === this._targets[_loc3_])
                  {
                     _loc7_ = this._propLookup[_loc3_] || {};
                     this._overwrittenProps = this._overwrittenProps || [];
                     _loc4_ = this._overwrittenProps[_loc3_] = param1?this._overwrittenProps[_loc3_] || {}:"all";
                     break;
                  }
               }
            }
            else
            {
               if(param2 !== this.target)
               {
                  return false;
               }
               _loc7_ = this._propLookup;
               _loc4_ = this._overwrittenProps = param1?this._overwrittenProps || {}:"all";
            }
            if(_loc7_)
            {
               _loc9_ = param1 || _loc7_;
               _loc10_ = !(param1 == _loc4_) && !(_loc4_ == "all") && !(param1 == _loc7_) && (!(typeof param1 == "object") || !(param1._tempKill == true));
               for(_loc5_ in _loc9_)
               {
                  _loc6_ = _loc7_[_loc5_];
                  if(_loc6_ != null)
                  {
                     if((_loc6_.pg) && (_loc6_.t._kill(_loc9_)))
                     {
                        _loc8_ = true;
                     }
                     if(!_loc6_.pg || _loc6_.t._overwriteProps.length === 0)
                     {
                        if(_loc6_._prev)
                        {
                           _loc6_._prev._next = _loc6_._next;
                        }
                        else if(_loc6_ == this._firstPT)
                        {
                           this._firstPT = _loc6_._next;
                        }
                        
                        if(_loc6_._next)
                        {
                           _loc6_._next._prev = _loc6_._prev;
                        }
                        _loc6_._next = _loc6_._prev = null;
                     }
                     delete _loc7_[_loc5_];
                     true;
                  }
                  if(_loc10_)
                  {
                     _loc4_[_loc5_] = 1;
                  }
               }
               if(this._firstPT == null && (_initted))
               {
                  this._enabled(false,false);
               }
            }
         }
         return _loc8_;
      }
      
      override public function invalidate() : *
      {
         if(this._notifyPluginsOfEnabled)
         {
            _onPluginEvent("_onDisable",this);
         }
         this._firstPT = null;
         this._overwrittenProps = null;
         _onUpdate = null;
         this._startAt = null;
         _initted = _active = this._notifyPluginsOfEnabled = false;
         this._propLookup = this._targets?{}:[];
         return this;
      }
      
      override public function _enabled(param1:Boolean, param2:Boolean = false) : Boolean
      {
         var _loc3_:* = 0;
         if((param1) && (_gc))
         {
            if(this._targets)
            {
               _loc3_ = this._targets.length;
               while(--_loc3_ > -1)
               {
                  this._siblings[_loc3_] = _register(this._targets[_loc3_],this,true);
               }
            }
            else
            {
               this._siblings = _register(this.target,this,true);
            }
         }
         super._enabled(param1,param2);
         if(this._notifyPluginsOfEnabled)
         {
            if(this._firstPT != null)
            {
               return _onPluginEvent(param1?"_onEnable":"_onDisable",this);
            }
         }
         return false;
      }
   }
}
