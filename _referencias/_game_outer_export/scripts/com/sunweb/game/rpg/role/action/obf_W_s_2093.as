package com.sunweb.game.rpg.role.action
{
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.role.SkillConfig;
   import com.sunweb.game.rpg.role.obf_0_8_w_387;
   import com.sunweb.game.rpg.role.obf_0_9_V_473;
   import com.sunweb.game.rpg.role.obf_0_M_3913;
   import com.sunweb.game.rpg.role.obf_0_Y_3475;
   import com.sunweb.game.rpg.sound.obf_q_6_3634;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   import gs.TweenLite;
   import gs.easing.Linear;
   import gs.utils.tween.TweenInfo;
   
   public class obf_W_s_2093
   {
      
      public static var showSkillEffect:Boolean = true;
      
      public var skillSn:int = 0;
      
      public var skillCode:String = null;
      
      public var skillLevel:int = 1;
      
      public var singTime:int = 0;
      
      public var castTime:int = 0;
      
      public var targetObject:MapInteractiveObject = null;
      
      public var targetPoint:Point = null;
      
      public var visualConfig:Object = null;
      
      public var obf_7_5_2557:int = 0;
      
      public var obf_w_1_952:int = 0;
      
      public var isRendering:Boolean = false;
      
      public var isCasting:Boolean = false;
      
      private var _owner:obf_0_Y_3475 = null;
      
      private var obf_0_5_4_652:uint = 0;
      
      private var obf_0___Q_218:TweenLite = null;
      
      private var _flyVisualConfig:Object = null;
      
      private var _flyTargetPoint:Point = null;
      
      private var _flyTargetObject:MapInteractiveObject = null;
      
      private var obf_q_x_2265:int = 0;
      
      private var obf_l_b_1320:int = 0;
      
      private var obf_c_V_1498:int = 0;
      
      private var obf_6_1_3390:int = 0;
      
      private var _lastEffectList:Array = null;
      
      public function obf_W_s_2093(param1:obf_0_Y_3475)
      {
         super();
         this._owner = param1;
      }
      
      public function reset() : void
      {
         if(this.isRendering)
         {
            this.stop();
         }
         this.visualConfig = null;
         this.singTime = 0;
         this.castTime = 0;
         this.obf_7_5_2557 = 0;
         this.obf_w_1_952 = 0;
         this.targetObject = null;
         this.targetPoint = null;
         this.isRendering = false;
         this.isCasting = false;
      }
      
      public function start() : Boolean
      {
         var skillConfig:Object = null;
         var levelInfo:Object = null;
         if(this._owner == null)
         {
            return false;
         }
         if(this.skillLevel < 1)
         {
            this.skillLevel = 1;
         }
         try
         {
            skillConfig = SkillConfig.getSkillConfig(this.skillCode);
            this.visualConfig = skillConfig.visual;
            if(this.visualConfig == null)
            {
               return false;
            }
            levelInfo = skillConfig.levelInfo[this.skillLevel - 1];
            this.obf_7_5_2557 = levelInfo.castRule.singTime;
            this.obf_w_1_952 = levelInfo.castRule.castTime;
            if(this.obf_w_1_952 <= 0)
            {
               return false;
            }
         }
         catch(e:Error)
         {
            return false;
         }
         this.isRendering = true;
         this._owner.stopWalking();
         this.obf_C_6_894();
         if(this.targetObject == null && this.targetPoint == null)
         {
            this.targetObject = this._owner;
         }
         this.obf_l_b_1320 = getTimer();
         this.obf_c_V_1498 = this.obf_l_b_1320 + this.singTime;
         this.obf_6_1_3390 = this.obf_c_V_1498 + this.castTime;
         if(this.singTime > 0)
         {
            this.showSingEffect();
         }
         else
         {
            this.showCastEffect();
         }
         return true;
      }
      
      public function stop() : void
      {
         if(this._owner == null)
         {
            return;
         }
         if(!this.isRendering)
         {
            return;
         }
         this._owner.stopAction();
         this.obf_C_6_894();
         if(this.obf_0_5_4_652 > 0)
         {
            clearTimeout(this.obf_0_5_4_652);
            this.obf_0_5_4_652 = 0;
         }
         this.isRendering = false;
         this.isCasting = false;
         if(this._owner.obf_6_U_3121 != null)
         {
            this._owner.obf_6_U_3121(this._owner,true);
         }
      }
      
      private function obf_0_6_q_667() : Boolean
      {
         var _loc1_:Map = this._owner.getMap();
         if(!_loc1_)
         {
            return false;
         }
         return this._owner == this._owner.getMap().player || showSkillEffect;
      }
      
      private function showSingEffect() : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         this.isCasting = false;
         if(this._owner == null || !this._owner.isInStage)
         {
            return;
         }
         var _loc1_:Object = this.visualConfig.sing;
         if(_loc1_ == null)
         {
            _loc1_ = new Object();
            _loc1_.action = obf_S_c_3330.obf_X_6_4123;
         }
         if(this.targetObject != null)
         {
            this._owner.turnTowardsObject(this.targetObject);
         }
         else if(this.targetPoint != null)
         {
            this._owner.obf_g_2_2378(this.targetPoint.x,this.targetPoint.y);
         }
         var _loc2_:Boolean = this._owner is obf_0_M_3913 && (this._owner as obf_0_M_3913).isActiveOrPassiveRiding;
         var _loc3_:String = _loc2_ ? obf_S_c_3330.obf_k_4_4106(_loc1_.action) : _loc1_.action;
         this._owner.doAction(_loc3_,-1,true,this.singTime);
         if(obf_0_8_w_387.isEnabled(this._owner))
         {
            _loc4_ = Boolean(_loc1_.hideEffOnRide);
            if(this._owner.obf_X_f_2691 && !(_loc2_ && _loc4_) && this.obf_0_6_q_667())
            {
               _loc5_ = obf_0_9_V_473.showEffects(this._owner.getMap(),this._owner,null,_loc1_.effectsAuto,this.singTime,null,-1,true);
               this._lastEffectList = obf_0_9_V_473.showEffects(this._owner.getMap(),this._owner,null,_loc1_.effects,this.singTime);
               if(this._lastEffectList == null)
               {
                  this._lastEffectList = _loc5_;
               }
               else if(_loc5_ != null)
               {
                  for each(_loc6_ in _loc5_)
                  {
                     this._lastEffectList.push(_loc6_);
                  }
               }
            }
         }
         obf_q_6_3634.obf_e_J_1876(_loc1_.effectSound,_loc1_.effectSoundLoop);
      }
      
      private function showCastEffect() : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         this.isCasting = true;
         if(this._owner == null || !this._owner.isInStage)
         {
            return;
         }
         var _loc1_:Object = this.visualConfig.cast;
         if(_loc1_ == null)
         {
            _loc1_ = new Object();
            _loc1_.action = obf_S_c_3330.obf_Q_L_2061;
         }
         if(this.targetObject != null)
         {
            this._owner.turnTowardsObject(this.targetObject);
         }
         else if(this.targetPoint != null)
         {
            this._owner.obf_g_2_2378(this.targetPoint.x,this.targetPoint.y);
         }
         var _loc2_:Boolean = this._owner is obf_0_M_3913 && (this._owner as obf_0_M_3913).isActiveOrPassiveRiding;
         var _loc3_:String = _loc2_ ? obf_S_c_3330.obf_k_4_4106(_loc1_.action) : _loc1_.action;
         this._owner.doAction(_loc3_,-1,false,this.castTime,null,true);
         if(obf_0_8_w_387.isEnabled(this._owner))
         {
            _loc4_ = Boolean(_loc1_.hideEffOnRide);
            if(this._owner.obf_X_f_2691 && !(_loc2_ && _loc4_) && this.obf_0_6_q_667())
            {
               _loc5_ = obf_0_9_V_473.showEffects(this._owner.getMap(),this._owner,null,_loc1_.effectsAuto,this.castTime,null,-1,true);
               this._lastEffectList = obf_0_9_V_473.showEffects(this._owner.getMap(),this._owner,null,_loc1_.effects);
               if(this._lastEffectList == null)
               {
                  this._lastEffectList = _loc5_;
               }
               else if(_loc5_ != null)
               {
                  for each(_loc6_ in _loc5_)
                  {
                     this._lastEffectList.push(_loc6_);
                  }
               }
            }
         }
         if(obf_0_8_w_387.isEnabled(this._owner))
         {
            this.obf_E_W_2375();
         }
         obf_q_6_3634.obf_e_J_1876(_loc1_.effectSound,_loc1_.effectSoundLoop);
      }
      
      private function obf_c_S_4121() : void
      {
         if(this._owner == null)
         {
            return;
         }
         this.isRendering = false;
         this.isCasting = false;
         this._lastEffectList = null;
         if(this._owner.obf_6_U_3121 != null)
         {
            this._owner.obf_6_U_3121(this._owner,false);
         }
      }
      
      private function obf_E_W_2375() : void
      {
         if(this._owner == null)
         {
            return;
         }
         var _loc1_:Object = this.visualConfig.fly;
         if(_loc1_ == null || _loc1_.flyItem == null)
         {
            return;
         }
         var _loc2_:int = int(_loc1_.beginTimeAfterCast);
         if(_loc2_ <= 0)
         {
            this.showFlyEffect();
         }
         else
         {
            if(this.castTime != this.obf_w_1_952)
            {
               _loc2_ *= Number(this.castTime) / this.obf_w_1_952;
            }
            this.obf_0_5_4_652 = setTimeout(this.showFlyEffect,_loc2_);
         }
      }
      
      private function showFlyEffect() : void
      {
         var flyConfig:Object;
         var mc:MovieClip;
         var speed:int;
         var tmc:obf_W_E_4480;
         var flyMode:String;
         var beginPt:Point = null;
         var easeFun:Function = null;
         var flyTimeInSecond:Number = NaN;
         var endPt:Point = null;
         this.obf_0_5_4_652 = 0;
         if(this._owner == null)
         {
            return;
         }
         flyConfig = this.visualConfig.fly;
         if(flyConfig == null || flyConfig.flyItem == null)
         {
            return;
         }
         this.obf_q_x_2265 = this._owner.actionManager.obf_e_O_820;
         mc = obf_0_9_V_473.getEffectMC(flyConfig.flyItem,flyConfig.dirNum,this.obf_q_x_2265);
         if(mc == null)
         {
            obf_0_9_V_473.obf_T_k_1059(flyConfig.flyItem);
            return;
         }
         speed = int(flyConfig.flySpeed);
         tmc = new obf_6_t_3568(mc);
         tmc.rewind();
         tmc.autoRemove = true;
         flyMode = flyConfig.flyMode;
         if(flyMode == "fixed")
         {
            tmc.allowRepeat = false;
            if(this.targetObject == null)
            {
               tmc.x = this.targetPoint.x;
               tmc.y = this.targetPoint.y;
            }
            else
            {
               tmc.x = this.targetObject.rootPX;
               tmc.y = this.targetObject.rootPY;
            }
            try
            {
               this._owner.getMap().magicLayer.addChild(tmc);
            }
            catch(e:Error)
            {
            }
         }
         else
         {
            if(flyMode != "line")
            {
               return;
            }
            tmc.allowRepeat = true;
            beginPt = this._owner.centerPoint;
            tmc.x = beginPt.x;
            tmc.y = beginPt.y;
            try
            {
               this._owner.getMap().magicLayer.addChild(tmc);
               easeFun = Linear.easeOut;
               flyTimeInSecond = 0;
               if(this.targetObject == null)
               {
                  flyTimeInSecond = Point.distance(beginPt,this.targetPoint) / speed;
                  if(flyTimeInSecond <= 0.1)
                  {
                     flyTimeInSecond = 0.1;
                  }
                  tmc.maxPlayTime = flyTimeInSecond * 1000;
                  this.obf_0___Q_218 = TweenLite.to(tmc,flyTimeInSecond,{
                     "x":this.targetPoint.x,
                     "y":this.targetPoint.y,
                     "ease":easeFun
                  });
               }
               else
               {
                  endPt = this.targetObject.centerPoint;
                  flyTimeInSecond = Point.distance(beginPt,endPt) / speed;
                  if(flyTimeInSecond <= 0.1)
                  {
                     flyTimeInSecond = 0.1;
                  }
                  tmc.maxPlayTime = flyTimeInSecond * 1000;
                  this.obf_0___Q_218 = TweenLite.to(tmc,flyTimeInSecond,{
                     "x":endPt.x,
                     "y":endPt.y,
                     "ease":easeFun,
                     "onUpdate":this.obf_F_h_1426
                  });
               }
            }
            catch(e:Error)
            {
            }
         }
         if(tmc.parent != null)
         {
            tmc.addEventListener(Event.COMPLETE,this.obf_a_C_1712);
            this._flyVisualConfig = this.visualConfig;
            this._flyTargetObject = this.targetObject;
            this._flyTargetPoint = this.targetPoint;
         }
         obf_q_6_3634.obf_e_J_1876(flyConfig.effectSound,flyConfig.effectSoundLoop);
      }
      
      private function obf_F_h_1426() : void
      {
         var _loc2_:TweenInfo = null;
         if(this.obf_0___Q_218 == null)
         {
            return;
         }
         if(this._flyTargetObject == null)
         {
            return;
         }
         var _loc1_:Point = this._flyTargetObject.centerPoint;
         for each(_loc2_ in this.obf_0___Q_218.tweens)
         {
            if(_loc2_.name == "x")
            {
               _loc2_.change = _loc1_.x - _loc2_.start;
            }
            else if(_loc2_.name == "y")
            {
               _loc2_.change = _loc1_.y - _loc2_.start;
            }
         }
      }
      
      private function obf_a_C_1712(param1:Event) : void
      {
         var e:Event = param1;
         this.obf_0___Q_218 = null;
         this.showReachEffect();
         try
         {
            (e.target as Sprite).removeEventListener(Event.COMPLETE,this.obf_a_C_1712);
         }
         catch(e:Error)
         {
         }
      }
      
      private function showReachEffect() : void
      {
         if(this._owner == null)
         {
            return;
         }
         var _loc1_:Object = this._flyVisualConfig.reach;
         if(_loc1_ == null || _loc1_.effects == null)
         {
            return;
         }
         obf_0_9_V_473.showEffects(this._owner.getMap(),this._flyTargetObject,this._flyTargetPoint,_loc1_.effects,0,null,this.obf_q_x_2265);
         obf_q_6_3634.obf_e_J_1876(_loc1_.effectSound,_loc1_.effectSoundLoop);
      }
      
      public function showHitEffect(param1:Object, param2:Boolean) : void
      {
         if(this._owner == null || !this._owner.isInStage || !this._owner.obf_X_f_2691)
         {
            return;
         }
         var _loc3_:Object = param1.hit;
         if(_loc3_ == null || _loc3_.effects == null)
         {
            return;
         }
         obf_0_9_V_473.showEffects(this._owner.getMap(),this._owner,null,_loc3_.effects,0,param2 ? "_cs" : null);
         obf_q_6_3634.obf_e_J_1876(_loc3_.effectSound,_loc3_.effectSoundLoop);
      }
      
      public function showLuckySkillEffect() : void
      {
         if(this._owner == null || !this._owner.isInStage || !this._owner.obf_X_f_2691)
         {
            return;
         }
         obf_0_9_V_473.showEffectOnObject(this._owner.getMap(),this._owner,"C_LuckyAttack");
      }
      
      public function destroy() : void
      {
         this._owner = null;
         this.targetObject = null;
         this.targetPoint = null;
         this.obf_0___Q_218 = null;
         this._flyVisualConfig = null;
         this._flyTargetObject = null;
         this._flyTargetPoint = null;
         this._lastEffectList = null;
      }
      
      public function update() : void
      {
         if(!this.isRendering)
         {
            return;
         }
         var _loc1_:int = getTimer();
         if(!this.isCasting && _loc1_ >= this.obf_c_V_1498)
         {
            this.showCastEffect();
         }
         if(this.isCasting && _loc1_ >= this.obf_6_1_3390)
         {
            this.obf_c_S_4121();
         }
         if(this.isRendering && _loc1_ > this.obf_6_1_3390)
         {
            this.stop();
         }
      }
      
      private function obf_C_6_894() : void
      {
         var _loc1_:obf_W_E_4480 = null;
         if(this._lastEffectList == null)
         {
            return;
         }
         for each(_loc1_ in this._lastEffectList)
         {
            if(_loc1_ != null && _loc1_.parent != null)
            {
               _loc1_.stop();
               _loc1_.removeMe();
            }
         }
         this._lastEffectList = null;
      }
   }
}

