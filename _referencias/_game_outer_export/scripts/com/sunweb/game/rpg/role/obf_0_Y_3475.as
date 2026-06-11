package com.sunweb.game.rpg.role
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.map.MapObject;
   import com.sunweb.game.rpg.map.obf_1_q_4613;
   import com.sunweb.game.rpg.role.action.obf_6_t_3568;
   import com.sunweb.game.rpg.role.action.obf_D_0_1300;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.role.action.obf_W_s_2093;
   import com.sunweb.game.rpg.role.action.obf_b_Y_1298;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.util.obf_3_9_3148;
   import com.sunweb.game.util.debug.obf_x_0_1295;
   import com.sunweb.game.utils.JSONUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import mapCommon.CreatureSelectionRing;
   import mapCommon.CreatureShadowRing;
   import numberEffect.NumberDamageCS;
   import numberEffect.NumberDamageNormal;
   import numberEffect.NumberDamageSelf;
   import numberEffect.NumberDamageSelfCS;
   import numberEffect.NumberExpAdded;
   import numberEffect.NumberFarmExp;
   import numberEffect.NumberHeal;
   import numberEffect.NumberItemAdded;
   import numberEffect.NumberSkillExp;
   
   public class obf_0_Y_3475 extends MapInteractiveObject
   {
      
      public static var selectionRing:CreatureSelectionRing = new CreatureSelectionRing();
      
      public var level:int;
      
      public var hpPercent:int = -1;
      
      public var side:int;
      
      protected var obf_0_0_Y_618:DisplayObject;
      
      protected var obf_g_e_2940:Object;
      
      public var buffList:Array = new Array();
      
      public var debuffList:Array = new Array();
      
      private var obf_D_Q_834:Object = new Object();
      
      private var notShowEffectMap:Object = new Object();
      
      private var obf_o_N_748:Object = new Object();
      
      public var statusFlags:int;
      
      private var _isInCombat:Boolean = false;
      
      public var walkSpeed:int = 100;
      
      public var walkStepLength:int = 80;
      
      protected var obf_z_M_1523:Array;
      
      protected var _lastMoveTime:int;
      
      protected var _lastMoveIndex:int;
      
      protected var _lastMovePixel:Point;
      
      protected var _lastMoveLengthRest:Number = 0;
      
      protected var obf_n_6_2658:Boolean = false;
      
      protected var _onDiedCallback:Function = null;
      
      protected var obf_r_t_1891:Boolean = false;
      
      public var obf_6_U_3121:Function = null;
      
      protected var obf_J_J_1930:obf_W_s_2093 = null;
      
      private var listEffectTimeInv:TimeLimiter = new TimeLimiter(200);
      
      private var listEffect:Array = new Array();
      
      protected var _bodySprite:Sprite = new Sprite();
      
      protected var obf_8_J_2121:obf_b_Y_1298;
      
      private var obf_0_8_6_403:Boolean = false;
      
      protected var obf_0_4_F_680:String;
      
      protected var obf_I_v_2665:Boolean = false;
      
      protected var obf_n_o_3282:TimeLimiter = new TimeLimiter(500);
      
      public function obf_0_Y_3475()
      {
         super();
         rootX = rootY = 0;
         rootPXYAvailable = true;
         this.x = rootPX = Map.obf_7_7_3297 / 2;
         this.y = rootPY = Map.TILE_HEIGHT_IN_PIXEL - 1;
         this.obf_0_0_Y_618 = new CreatureShadowRing();
         this.addChild(this.obf_0_0_Y_618);
         this.addChild(this._bodySprite);
      }
      
      public function initCommand(param1:Array) : void
      {
         var effectInfo:Object = null;
         var effectSprite:Sprite = null;
         var config:Array = param1;
         this.obf_g_e_2940 = new Object();
         for each(effectInfo in config)
         {
            effectSprite = new Sprite();
            this.obf_g_e_2940[effectInfo.coverFlag] = effectSprite;
            if(!JSONUtil.getBoolean(effectInfo,["isBelow"]))
            {
               try
               {
                  this.addChild(effectSprite);
               }
               catch(e:Error)
               {
                  obf_x_0_1295.obf_r_w_3556("Creature.initCommand() error: " + e);
               }
               continue;
            }
            try
            {
               this.addChildAt(effectSprite,0);
            }
            catch(e:Error)
            {
               obf_x_0_1295.obf_r_w_3556("Creature.initCommand() error: " + e);
            }
         }
      }
      
      public function get flagMap() : Object
      {
         return this.obf_g_e_2940;
      }
      
      override public function getTopmostY() : int
      {
         if(this._bodySprite.numChildren == 0)
         {
            return super.getTopmostY();
         }
         var _loc1_:Rectangle = this._bodySprite.getRect(this);
         return _loc1_.height > 0 ? int(_loc1_.top) : int(super.getTopmostY());
      }
      
      public function setShadow(param1:DisplayObject) : void
      {
         var idx:int = 0;
         var obj:DisplayObject = param1;
         if(this.obf_0_0_Y_618 == null)
         {
            if(obj != null)
            {
               this.addChildAt(obj,0);
               this.obf_0_0_Y_618 = obj;
            }
         }
         else if(obj == null)
         {
            try
            {
               this.removeChild(this.obf_0_0_Y_618);
            }
            catch(e:Error)
            {
            }
            this.obf_0_0_Y_618 = null;
         }
         else
         {
            try
            {
               idx = this.getChildIndex(this.obf_0_0_Y_618);
            }
            catch(e:Error)
            {
               idx = -1;
            }
            if(idx > -1)
            {
               this.removeChildAt(idx);
               this.addChildAt(obj,idx);
            }
            else
            {
               this.addChildAt(obj,0);
            }
            this.obf_0_0_Y_618 = obj;
         }
      }
      
      public function getShadow() : DisplayObject
      {
         return this.obf_0_0_Y_618;
      }
      
      public function obf_a_8_4261(param1:Object) : void
      {
         var _loc2_:int = this.buffList.indexOf(param1);
         if(_loc2_ > -1)
         {
            this.buffList.splice(_loc2_,1,param1);
         }
         else
         {
            this.buffList.push(param1);
         }
         if(Boolean(param1) && Boolean(param1.buffConfig) && Boolean(param1.buffConfig.effectCodeOnce))
         {
            obf_0_9_V_473.showEffectOnObject(this.getMap(),this,param1.buffConfig.effectCodeOnce);
         }
         if(Boolean(param1) && Boolean(param1.buffConfig) && Boolean(param1.buffConfig.effectCodeAlways))
         {
            this.showAlwaysEffect(param1.buffId + "",param1.buffConfig.effectCodeAlways);
         }
      }
      
      public function removeBuffInfo(param1:int) : void
      {
         this.obf_0_8_h_66(param1 + "");
         var _loc2_:int = 0;
         while(_loc2_ < this.buffList.length)
         {
            if(this.buffList[_loc2_].buffId == param1)
            {
               this.buffList.splice(_loc2_,1);
               return;
            }
            _loc2_++;
         }
      }
      
      public function obf_S_s_4252() : void
      {
         var _loc1_:Object = null;
         for each(_loc1_ in this.buffList)
         {
            if(_loc1_)
            {
               this.obf_0_8_h_66(_loc1_.buffId + "");
            }
         }
         this.buffList = new Array();
      }
      
      public function getBuffInfo(param1:int) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.buffList)
         {
            if(_loc2_.buffId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function obf_i_b_872(param1:Object) : void
      {
         var _loc2_:int = this.debuffList.indexOf(param1);
         if(_loc2_ > -1)
         {
            this.debuffList.splice(_loc2_,1,param1);
         }
         else
         {
            this.debuffList.push(param1);
         }
         if(Boolean(param1) && Boolean(param1.buffConfig) && Boolean(param1.buffConfig.effectCodeOnce))
         {
            obf_0_9_V_473.showEffectOnObject(this.getMap(),this,param1.buffConfig.effectCodeOnce);
         }
         if(Boolean(param1) && Boolean(param1.buffConfig) && Boolean(param1.buffConfig.effectCodeAlways))
         {
            this.showAlwaysEffect(param1.buffId + "",param1.buffConfig.effectCodeAlways);
         }
      }
      
      public function removeDebuffInfo(param1:int) : void
      {
         this.obf_0_8_h_66(param1 + "");
         var _loc2_:int = 0;
         while(_loc2_ < this.debuffList.length)
         {
            if(this.debuffList[_loc2_].buffId == param1)
            {
               this.debuffList.splice(_loc2_,1);
               return;
            }
            _loc2_++;
         }
      }
      
      public function getDebuffInfo(param1:int) : Object
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.debuffList)
         {
            if(_loc2_.buffId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function haveBuff(param1:int) : Boolean
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.buffList)
         {
            if(_loc2_.buffId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function obf_G_3_787(param1:int) : Boolean
      {
         var _loc2_:Object = null;
         for each(_loc2_ in this.debuffList)
         {
            if(_loc2_.buffId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function showAlwaysEffect(param1:String, param2:String) : void
      {
         if(!param2 || param2 == "")
         {
            return;
         }
         if(this.obf_D_Q_834.hasOwnProperty(param1))
         {
            obf_0_9_V_473.obf_0_8_h_66(this.obf_D_Q_834[param1]);
            delete this.obf_D_Q_834[param1];
         }
         if(this.bodySprite.numChildren == 0)
         {
            this.notShowEffectMap[param1] = param2;
            return;
         }
         var _loc3_:String = obf_0_9_V_473.showAlwaysEffect(this.getMap(),this,param2);
         if(!_loc3_ || _loc3_ == "")
         {
            this.notShowEffectMap[param1] = param2;
            return;
         }
         delete this.notShowEffectMap[param1];
         this.obf_D_Q_834[param1] = _loc3_;
         if(obf_0_9_V_473.getEffectRaw(param2))
         {
            this.obf_o_N_748[param1] = param2;
         }
      }
      
      public function obf_0_8_h_66(param1:String) : void
      {
         var _loc2_:String = this.obf_D_Q_834[param1];
         delete this.obf_D_Q_834[param1];
         if(this.obf_o_N_748[param1])
         {
            delete this.obf_o_N_748[param1];
         }
         delete this.notShowEffectMap[param1];
         if(!_loc2_ || _loc2_ == "")
         {
            return;
         }
         obf_0_9_V_473.obf_0_8_h_66(_loc2_);
      }
      
      public function obf_P_D_2228() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this.notShowEffectMap)
         {
            this.showAlwaysEffect(_loc1_,this.notShowEffectMap[_loc1_]);
         }
      }
      
      public function obf_B_H_3690() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this.obf_D_Q_834)
         {
            obf_0_9_V_473.obf_0_8_h_66(this.obf_D_Q_834[_loc1_]);
         }
         this.obf_D_Q_834 = new Object();
         this.notShowEffectMap = new Object();
         this.obf_o_N_748 = new Object();
      }
      
      public function get obf_M_n_3303() : Object
      {
         return this.obf_o_N_748;
      }
      
      public function obf_K_s_1124(param1:int) : void
      {
         this.statusFlags |= param1;
      }
      
      public function removeStatus(param1:int) : void
      {
         this.statusFlags &= ~param1;
      }
      
      public function obf_I_z_3437(param1:int) : Boolean
      {
         return (this.statusFlags & param1) != 0;
      }
      
      public function obf_v_O_1419(param1:int) : Boolean
      {
         return (this.statusFlags & param1) == param1;
      }
      
      public function isCloaking() : Boolean
      {
         return this.obf_I_z_3437(obf_c_y_957.obf_U_U_4127);
      }
      
      public function obf_Q_W_1326() : Boolean
      {
         return this.obf_I_z_3437(obf_c_y_957.obf_O_n_2990) || this.walkSpeed <= 0;
      }
      
      public function get isInCombat() : Boolean
      {
         return this._isInCombat;
      }
      
      public function set isInCombat(param1:Boolean) : void
      {
         if(this._isInCombat == param1)
         {
            return;
         }
         this._isInCombat = param1;
         if(this.obf_8_J_2121 != null)
         {
            this.obf_8_J_2121.obf_T_2_4324();
         }
      }
      
      public function walkToTile(param1:int, param2:int, param3:Map = null) : Array
      {
         var _loc4_:Point = obf_1_q_4613.obf_0_3_l_190(new Point(param1,param2));
         return this.walkToPixel(_loc4_.x,_loc4_.y,param3);
      }
      
      public function walkToPixel(param1:int, param2:int, param3:Map = null) : Array
      {
         if(param3 == null)
         {
            if(this.getMap() == null)
            {
               return null;
            }
            param3 = this.getMap();
         }
         if(this.isWalking())
         {
            this.walkByStep();
         }
         var _loc4_:Point = new Point(param1,param2);
         var _loc5_:Point = obf_1_q_4613.obf_0_7_i_369(_loc4_);
         if(!param3.obf_0_3_m_391(_loc5_.x,_loc5_.y))
         {
            return null;
         }
         var _loc6_:Point = new Point(this.rootPX,this.rootPY);
         var _loc7_:Array = obf_1_q_4613.pathfindAuto(param3,_loc6_,_loc4_);
         if(_loc7_ != null && _loc7_.length > 0)
         {
            this.obf_z_M_1523 = _loc7_;
            this._lastMoveTime = getTimer();
            this._lastMoveIndex = 0;
            this._lastMovePixel = this.obf_z_M_1523[0];
            return _loc7_;
         }
         return null;
      }
      
      public function walkToObject(param1:MapObject, param2:Map = null) : Array
      {
         if(param1.rootPXYAvailable)
         {
            return this.walkToPixel(param1.rootPX,param1.rootPY,param2);
         }
         return this.walkToTile(param1.rootX,param1.rootY,param2);
      }
      
      public function walkAlongPath(param1:Array, param2:Boolean) : void
      {
         if(param1 == null || param1.length == 0)
         {
            this.stopWalking();
            return;
         }
         var _loc3_:Point = param1[0];
         if(param2)
         {
            if(this.rootPX != _loc3_.x || this.rootPY != _loc3_.y)
            {
               _loc3_.x = this.rootPX;
               _loc3_.y = this.rootPY;
            }
         }
         else
         {
            this.moveToPixel(_loc3_.x,_loc3_.y);
         }
         this.obf_z_M_1523 = param1;
         this._lastMoveTime = getTimer();
         this._lastMoveIndex = 0;
         this._lastMovePixel = this.obf_z_M_1523[0];
      }
      
      public function walkToward(param1:int) : void
      {
      }
      
      public function walkByStep() : void
      {
         var _loc6_:Point = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Point = null;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:obf_S_c_3330 = null;
         var _loc13_:int = 0;
         if(this.obf_z_M_1523 == null)
         {
            return;
         }
         if(this._lastMoveIndex >= this.obf_z_M_1523.length - 1)
         {
            return;
         }
         var _loc1_:Point = this._lastMovePixel.clone();
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this._lastMoveTime;
         var _loc4_:Number = this.walkSpeed * (_loc3_ / 1000) + this._lastMoveLengthRest;
         if(_loc4_ < 1)
         {
            return;
         }
         this._lastMoveTime = _loc2_;
         while(true)
         {
            _loc6_ = this.obf_z_M_1523[this._lastMoveIndex + 1];
            _loc7_ = Point.distance(this._lastMovePixel,_loc6_);
            if(_loc4_ < _loc7_)
            {
               _loc8_ = _loc4_ / _loc7_;
               _loc9_ = Point.interpolate(_loc6_,this._lastMovePixel,_loc8_);
               this._lastMoveLengthRest = _loc4_ - Point.distance(this._lastMovePixel,_loc9_);
               this._lastMovePixel = _loc9_;
               break;
            }
            _loc4_ -= _loc7_;
            ++this._lastMoveIndex;
            this._lastMovePixel = _loc6_;
            if(this._lastMoveIndex == this.obf_z_M_1523.length - 1)
            {
               this._lastMoveLengthRest = 0;
               break;
            }
         }
         this.moveToPixel(Math.round(this._lastMovePixel.x),Math.round(this._lastMovePixel.y));
         this.obf_9_0_4119();
         if(this.obf_8_J_2121 == null)
         {
            return;
         }
         var _loc5_:String = this.obf_8_J_2121.currentAction;
         if(this._lastMoveIndex >= this.obf_z_M_1523.length - 1)
         {
            if(_loc5_ == null || _loc5_ == "" || _loc5_ == obf_S_c_3330.obf_r_q_3113 || _loc5_ == obf_S_c_3330.obf_R_z_4156 || _loc5_ == obf_S_c_3330.obf_h_4_3537)
            {
               this.stopAction();
            }
         }
         else if(_loc5_ == null || _loc5_ == "" || _loc5_ == obf_S_c_3330.obf_r_q_3113 || _loc5_ == obf_S_c_3330.obf_R_z_4156 || _loc5_ == obf_S_c_3330.obf_h_4_3537 || _loc5_ == obf_S_c_3330.obf_0_3_U_524)
         {
            _loc10_ = obf_D_0_1300.getAngle2(_loc1_,this._lastMovePixel);
            if(this is obf_0_M_3913 && (this as obf_0_M_3913).isActiveOrPassiveRiding)
            {
               _loc11_ = 1;
            }
            else if(this.walkStepLength <= 0)
            {
               _loc11_ = 1;
            }
            else
            {
               _loc11_ = 1 + (this.walkSpeed - this.walkStepLength) / (this.walkStepLength * 2);
            }
            _loc12_ = this.obf_8_J_2121.getAction(obf_S_c_3330.obf_h_4_3537);
            _loc13_ = obf_D_0_1300.getDirectionByAngle(_loc10_,_loc12_ == null ? 8 : _loc12_.dirNum);
            if(!(this.obf_8_J_2121.currentAction == obf_S_c_3330.obf_h_4_3537 && this.obf_8_J_2121.currentDirection == _loc13_))
            {
               this.doActionByAngle(obf_S_c_3330.obf_h_4_3537,_loc10_,true,0,null,false,_loc11_);
            }
         }
      }
      
      public function isWalking() : Boolean
      {
         if(this.obf_z_M_1523 == null || this._lastMoveIndex >= this.obf_z_M_1523.length - 1)
         {
            return false;
         }
         return true;
      }
      
      public function stopWalking() : void
      {
         var _loc1_:String = null;
         if(this.isWalking())
         {
            this.obf_z_M_1523 = null;
            this._lastMoveIndex = 0;
            if(this.obf_8_J_2121 == null)
            {
               return;
            }
            _loc1_ = this.obf_8_J_2121.currentAction;
            if(_loc1_ == null || _loc1_ == "" || _loc1_ == obf_S_c_3330.obf_r_q_3113 || _loc1_ == obf_S_c_3330.obf_R_z_4156 || _loc1_ == obf_S_c_3330.obf_h_4_3537)
            {
               this.stopAction();
            }
         }
      }
      
      public function get pathArray() : Array
      {
         return this.obf_z_M_1523;
      }
      
      protected function obf_C_Z_3054() : void
      {
      }
      
      public function turnTowardsObject(param1:MapInteractiveObject) : void
      {
         if(param1 == null || param1 == this)
         {
            return;
         }
         this.obf_g_2_2378(param1.rootPX,param1.rootPY);
      }
      
      public function obf_g_2_2378(param1:int, param2:int) : void
      {
         var _loc3_:Point = new Point(this.rootPX,this.rootPY);
         var _loc4_:Point = new Point(param1,param2);
         if(_loc3_.equals(_loc4_))
         {
            return;
         }
         var _loc5_:int = obf_D_0_1300.getAngle2(_loc3_,_loc4_);
         if(this.obf_8_J_2121 == null)
         {
            return;
         }
         this.obf_8_J_2121.doActionByAngle(this.obf_8_J_2121.defaultAction,_loc5_,true);
      }
      
      public function obf_t_F_1534(param1:int) : void
      {
         if(this.obf_8_J_2121 == null)
         {
            return;
         }
         this.obf_8_J_2121.doAction(this.obf_8_J_2121.defaultAction,param1,true);
      }
      
      public function sit(param1:int = -1) : void
      {
         this.stopWalking();
         this.doAction(obf_S_c_3330.obf_0_3_U_524,param1,true);
      }
      
      public function stand(param1:int = -1) : void
      {
         this.doAction(this.isInCombat ? obf_S_c_3330.obf_R_z_4156 : obf_S_c_3330.obf_r_q_3113,param1,true);
      }
      
      public function die(param1:Boolean = true, param2:Function = null, param3:int = 0) : void
      {
         this.obf_n_6_2658 = true;
         this.obf_r_t_1891 = param1;
         this._onDiedCallback = param2;
         this.stopWalking();
         this.stopSkill();
         if(param3 <= 0)
         {
            this.doAction(obf_S_c_3330.DIE,-1,false,0,this.obf_0_2_2429);
         }
         else
         {
            this.doAction(obf_S_c_3330.DIE,-1,true,param3,this.obf_0_2_2429);
         }
      }
      
      protected function obf_0_2_2429() : void
      {
         if(this._onDiedCallback != null)
         {
            try
            {
               this._onDiedCallback(this);
            }
            catch(e:Error)
            {
            }
            this._onDiedCallback = null;
         }
         if(this.obf_r_t_1891)
         {
            this.removeMe();
            this.destroy();
         }
      }
      
      public function get isDead() : Boolean
      {
         return this.obf_n_6_2658;
      }
      
      public function rebirth() : void
      {
         this.obf_n_6_2658 = false;
         this.stopAction();
      }
      
      protected function useSkill(param1:int, param2:String, param3:int, param4:MapInteractiveObject, param5:Point, param6:int, param7:int) : void
      {
         if(this.obf_J_J_1930 == null)
         {
            this.obf_J_J_1930 = new obf_W_s_2093(this);
         }
         else
         {
            this.obf_J_J_1930.reset();
         }
         this.obf_J_J_1930.skillSn = param1;
         this.obf_J_J_1930.skillCode = param2;
         this.obf_J_J_1930.skillLevel = param3;
         this.obf_J_J_1930.targetObject = param4;
         this.obf_J_J_1930.targetPoint = param5;
         this.obf_J_J_1930.singTime = param6;
         this.obf_J_J_1930.castTime = param7;
         this.obf_J_J_1930.start();
      }
      
      public function useSkillOnObject(param1:int, param2:String, param3:MapInteractiveObject, param4:int, param5:int, param6:int = 1) : void
      {
         var skillSn:int = param1;
         var skillCode:String = param2;
         var targetObject:MapInteractiveObject = param3;
         var singTime:int = param4;
         var castTime:int = param5;
         var skillLevel:int = param6;
         try
         {
            this.useSkill(skillSn,skillCode,skillLevel,targetObject,null,singTime,castTime);
         }
         catch(e:Error)
         {
            obf_x_0_1295.obf_r_w_3556("Creature.useSkillOnObject() error: " + e);
         }
      }
      
      public function useSkillOnPoint(param1:int, param2:String, param3:Point, param4:int, param5:int, param6:int = 1) : void
      {
         var skillSn:int = param1;
         var skillCode:String = param2;
         var targetPoint:Point = param3;
         var singTime:int = param4;
         var castTime:int = param5;
         var skillLevel:int = param6;
         try
         {
            this.useSkill(skillSn,skillCode,skillLevel,null,targetPoint,singTime,castTime);
         }
         catch(e:Error)
         {
            obf_x_0_1295.obf_r_w_3556("Creature.useSkillOnPoint() error: " + e);
         }
      }
      
      public function get isUsingSkill() : Boolean
      {
         if(this.obf_J_J_1930 == null)
         {
            return false;
         }
         return this.obf_J_J_1930.isRendering;
      }
      
      public function get isCastingSkill() : Boolean
      {
         if(this.obf_J_J_1930 == null)
         {
            return false;
         }
         return this.obf_J_J_1930.isCasting;
      }
      
      public function get obf_3_y_4486() : int
      {
         return this.isUsingSkill ? this.obf_J_J_1930.skillSn : -1;
      }
      
      public function get skillRenderer() : obf_W_s_2093
      {
         return this.obf_J_J_1930;
      }
      
      public function stopSkill() : void
      {
         if(this.isUsingSkill)
         {
            this.obf_J_J_1930.stop();
         }
      }
      
      public function showEffect(param1:String, param2:String = "") : void
      {
         var tmc:obf_6_t_3568;
         var effect:String = param1;
         var contentText:String = param2;
         var mc:MovieClip = null;
         if(effect == EffectEnum.AVOID_ATTACK)
         {
            mc = new NumberHeal();
            mc.numberMC.numberLabel.text = contentText;
         }
         else
         {
            if(effect != EffectEnum.MISS_ATTACK)
            {
               return;
            }
            mc = new NumberDamageNormal();
            mc.numberMC.numberLabel.text = contentText;
         }
         tmc = new obf_6_t_3568(mc);
         tmc.allowRepeat = false;
         tmc.x = this.rootPX;
         tmc.y = this.rootPY;
         tmc.autoRemove = true;
         try
         {
            this.getMap().magicLayer.addChild(tmc);
         }
         catch(e:Error)
         {
         }
      }
      
      public function showLuckySkillEffect() : void
      {
         if(this.isUsingSkill)
         {
            this.obf_J_J_1930.showLuckySkillEffect();
         }
      }
      
      public function showHitEffect(param1:String, param2:Boolean = false) : void
      {
         var visualConfig:Object = null;
         var skillCode:String = param1;
         var isCriticalStrike:Boolean = param2;
         if(this.obf_J_J_1930 == null)
         {
            this.obf_J_J_1930 = new obf_W_s_2093(this);
         }
         try
         {
            visualConfig = SkillConfig.getSkillConfig(skillCode).visual;
            this.obf_J_J_1930.showHitEffect(visualConfig,isCriticalStrike);
         }
         catch(e:Error)
         {
         }
      }
      
      public function showNumberEffect(param1:Number, param2:String, param3:String = "") : void
      {
         var tmc:obf_6_t_3568;
         var num:Number = param1;
         var effect:String = param2;
         var numberTitle:String = param3;
         var mc:MovieClip = null;
         if(effect == obf_0_0_8_669.obf_0___1_276)
         {
            mc = new NumberHeal();
            mc.numberMC.numberLabel.text = numberTitle + num;
         }
         else if(effect == obf_0_0_8_669.obf_F_F_4169)
         {
            mc = new NumberDamageNormal();
            mc.numberMC.numberLabel.text = numberTitle + num;
         }
         else if(effect == obf_0_0_8_669.obf_w_d_3136)
         {
            mc = new NumberDamageCS();
            mc.numberMC.numberLabel.text = numberTitle + num;
         }
         else if(effect == obf_0_0_8_669.obf_o_0_932)
         {
            mc = new NumberDamageSelf();
            mc.numberMC.numberLabel.text = numberTitle + num;
         }
         else if(effect == obf_0_0_8_669.obf_v_e_4597)
         {
            mc = new NumberDamageSelfCS();
            mc.numberMC.numberLabel.text = numberTitle + num;
         }
         else if(effect == obf_0_0_8_669.obf_0_5_l_412)
         {
            mc = new NumberExpAdded();
            mc.numberMC.numberLabel.text = numberTitle + num;
         }
         else if(effect == obf_0_0_8_669.obf_0_0_C_314)
         {
            mc = new NumberSkillExp();
            mc.numberMC.numberLabel.text = numberTitle + num;
         }
         else if(effect == obf_0_0_8_669.obf_D_F_4414)
         {
            mc = new NumberSkillExp();
            mc.numberMC.numberLabel.text = numberTitle + num;
         }
         else if(effect == obf_0_0_8_669.obf_d_c_2580)
         {
            mc = new NumberSkillExp();
            mc.numberMC.numberLabel.text = numberTitle + num;
         }
         else if(effect == obf_0_0_8_669.obf_q_4633)
         {
            mc = new NumberSkillExp();
            mc.numberMC.numberLabel.text = numberTitle + num;
         }
         else
         {
            if(effect != obf_0_0_8_669.obf_0_x_2302)
            {
               return;
            }
            mc = new NumberFarmExp();
            mc.numberMC.numberLabel.text = numberTitle + num;
         }
         tmc = new obf_6_t_3568(mc);
         tmc.allowRepeat = false;
         tmc.x = this.rootPX;
         tmc.y = this.rootPY;
         tmc.autoRemove = true;
         try
         {
            this.getMap().magicLayer.addChild(tmc);
         }
         catch(e:Error)
         {
         }
      }
      
      public function showIconTextEffect(param1:DisplayObject, param2:String) : void
      {
         var tmc:obf_6_t_3568;
         var icon:DisplayObject = param1;
         var text:String = param2;
         var mc:NumberItemAdded = new NumberItemAdded();
         if(icon != null)
         {
            mc.numberMC.numberIcon.addChild(icon);
         }
         if(text == null)
         {
            text = "";
         }
         mc.numberMC.numberLabel.text = text;
         tmc = new obf_6_t_3568(mc);
         tmc.allowRepeat = false;
         tmc.x = this.rootPX;
         tmc.y = this.rootPY;
         tmc.autoRemove = true;
         try
         {
            this.getMap().magicLayer.addChild(tmc);
         }
         catch(e:Error)
         {
         }
      }
      
      public function showNumberEffectAsync(param1:String, ... rest) : void
      {
         this.showEffectAsync(param1,0,null,-1,false,false,-1,rest);
      }
      
      public function showEffectAsync(param1:String, param2:int = 0, param3:String = null, param4:int = -1, param5:Boolean = false, param6:Boolean = false, param7:int = -1, param8:Array = null) : void
      {
         this.listEffect.push([this.getMap(),this,param1,param2,param3,param4,param5,param6,param7,param8]);
      }
      
      protected function obf_R_T_3648() : void
      {
         var effPar:Array = null;
         if(this.listEffect.length > 0 && this.listEffectTimeInv.checkTimeout())
         {
            effPar = this.listEffect.shift();
            try
            {
               obf_0_9_V_473.showEffectOnObject.apply(null,effPar);
            }
            catch(e:Error)
            {
            }
            this.listEffectTimeInv.timelimit = 2000 / this.listEffect.length;
            this.listEffectTimeInv.timelimit = Math.min(200,this.listEffectTimeInv.timelimit);
         }
      }
      
      public function showStrickenAction() : void
      {
      }
      
      public function obf_O_3_1449(param1:String) : void
      {
      }
      
      public function removeBuffEffect(param1:String) : void
      {
      }
      
      public function obf_r_B_1365(param1:String) : void
      {
      }
      
      public function doAction(param1:String, param2:int = -1, param3:Boolean = false, param4:int = 0, param5:Function = null, param6:Boolean = false, param7:Number = 1) : void
      {
         if(this.obf_8_J_2121 == null)
         {
            return;
         }
         this.obf_8_J_2121.doAction(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function doActionByAngle(param1:String, param2:int = -1, param3:Boolean = false, param4:int = 0, param5:Function = null, param6:Boolean = false, param7:Number = 1) : void
      {
         if(this.obf_8_J_2121 == null)
         {
            return;
         }
         this.obf_8_J_2121.doActionByAngle(param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function stopAction() : void
      {
         if(this.obf_8_J_2121 == null)
         {
            return;
         }
         this.obf_8_J_2121.stopAction();
      }
      
      public function get actionManager() : obf_b_Y_1298
      {
         return this.obf_8_J_2121;
      }
      
      public function get bodySprite() : Sprite
      {
         return this._bodySprite;
      }
      
      protected function obf_0_2_b_567() : void
      {
      }
      
      public function set obf_X_f_2691(param1:Boolean) : void
      {
         var _loc3_:DisplayObject = null;
         if(this._bodySprite.visible == param1)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.numChildren)
         {
            _loc3_ = this.getChildAt(_loc2_) as DisplayObject;
            if(Boolean(_loc3_) && _loc3_ is DisplayObject)
            {
               if(_loc3_ == _labelSprite || _loc3_ == this.obf_0_0_Y_618)
               {
                  _loc3_.visible = true;
               }
               else
               {
                  _loc3_.visible = param1;
               }
            }
            _loc2_++;
         }
         this.obf_0_2_b_567();
      }
      
      public function get obf_X_f_2691() : Boolean
      {
         return this._bodySprite.visible;
      }
      
      public function get bodySpriteIndex() : int
      {
         try
         {
            return this.getChildIndex(this.bodySprite);
         }
         catch(e:Error)
         {
         }
         return -1;
      }
      
      override public function get centerPoint() : Point
      {
         return new Point(this.rootPX,this.rootPY + this.getTopmostY() / 2);
      }
      
      override public function onUpdate() : void
      {
         this.walkByStep();
         updateSayLabel();
         if(this.obf_n_o_3282.checkTimeout())
         {
            this.obf_y_6_3529();
            this.obf_P_D_2228();
         }
         if(this.obf_J_J_1930 != null && this.obf_J_J_1930.isRendering)
         {
            this.obf_J_J_1930.update();
         }
         var _loc1_:Boolean = this.isWalking();
         if(this.obf_0_8_6_403 && !_loc1_)
         {
            this.obf_C_Z_3054();
         }
         this.obf_0_8_6_403 = _loc1_;
         this.obf_R_T_3648();
      }
      
      override public function release() : void
      {
      }
      
      override public function destroy() : void
      {
         try
         {
            this.removeEventListener(Event.ADDED_TO_STAGE,this.checkAndCreateActions);
         }
         catch(e:Error)
         {
         }
         this.obf_B_H_3690();
         this.obf_D_Q_834 = null;
         this.obf_o_N_748 = null;
         this.buffList = null;
         this.debuffList = null;
         this._onDiedCallback = null;
         this.obf_6_U_3121 = null;
         if(this.obf_8_J_2121 != null)
         {
            this.obf_8_J_2121.destroy();
            this.obf_8_J_2121 = null;
         }
         if(this.obf_J_J_1930 != null)
         {
            this.obf_J_J_1930.destroy();
            this.obf_J_J_1930 = null;
         }
         obf_C_a_2892 = null;
         obf_3_9_3148.removeChildren(this);
         super.destroy();
      }
      
      override public function set isTracked(param1:Boolean) : void
      {
         var _loc2_:Array = null;
         obf_D_I_1250 = param1;
         if(this.bodySprite == null)
         {
            return;
         }
         if(param1)
         {
            _loc2_ = [1.8,0,0,0,0,0,1.8,0,0,0,0,0,1.8,0,0,0,0,0,1,0];
            this.bodySprite.filters = [new ColorMatrixFilter(_loc2_)];
         }
         else
         {
            this.bodySprite.filters = null;
         }
      }
      
      override public function set isSelected(param1:Boolean) : void
      {
         var v:Boolean = param1;
         obf_V_l_1928 = v;
         if(v)
         {
            this.addChildAt(selectionRing,1);
         }
         else
         {
            try
            {
               this.removeChild(selectionRing);
            }
            catch(e:Error)
            {
            }
         }
      }
      
      public function useMonsterModel(param1:String, param2:String, param3:Boolean = false) : void
      {
         var info:Object;
         var modelCode:String = param1;
         var alternateModelCode:String = param2;
         var isLazyLoading:Boolean = param3;
         this.obf_0_4_F_680 = modelCode;
         info = null;
         if(this.isMonsterModelResLoaded())
         {
            this.obf_I_v_2665 = false;
            info = RoleModel.getMonsterModel(this.obf_0_4_F_680);
         }
         else
         {
            this.obf_I_v_2665 = true;
            info = RoleModel.getMonsterModel(alternateModelCode);
         }
         if(info == null)
         {
            throw new Error("Can not find creature model: " + this.obf_0_4_F_680);
         }
         this.obf_8_J_2121 = new obf_b_Y_1298(this._bodySprite,info.actions,isLazyLoading);
         if(isLazyLoading)
         {
            try
            {
               this.addEventListener(Event.ADDED_TO_STAGE,this.checkAndCreateActions);
            }
            catch(e:Error)
            {
            }
         }
         this.stopAction();
         updateLabelPosition();
      }
      
      public function get obf_4_g_1977() : String
      {
         return this.obf_0_4_F_680;
      }
      
      protected function isMonsterModelResLoaded() : Boolean
      {
         var _loc1_:String = RoleModel.getMonsterModelResId(this.obf_0_4_F_680);
         return _loc1_ == null ? false : ResourceManager.instance.isResourceLoaded(_loc1_);
      }
      
      protected function obf_y_6_3529() : void
      {
         if(!this.obf_I_v_2665)
         {
            return;
         }
         if(!this.isMonsterModelResLoaded())
         {
            return;
         }
         this.obf_I_v_2665 = false;
         var _loc1_:obf_b_Y_1298 = this.obf_8_J_2121;
         if(this.obf_8_J_2121 != null)
         {
            this.obf_8_J_2121.destroy();
            this.obf_8_J_2121 = null;
         }
         var _loc2_:Object = RoleModel.getMonsterModel(this.obf_0_4_F_680);
         this.obf_8_J_2121 = new obf_b_Y_1298(this._bodySprite,_loc2_.actions,true);
         if(_loc1_ == null)
         {
            this.stopAction();
         }
         else
         {
            this.doAction(_loc1_.currentAction,_loc1_.currentDirection);
         }
         updateLabelPosition();
         this.obf_K_Y_3943();
      }
      
      protected function obf_K_Y_3943() : void
      {
      }
      
      protected function checkAndCreateActions(param1:Event) : void
      {
         if(this.obf_8_J_2121 != null)
         {
            if(this.obf_8_J_2121.checkAndCreateActions())
            {
               this.updateLabelPosition();
            }
         }
      }
   }
}

