package com.sunweb.game.rpg.role.action
{
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_b_8_4256;
   import com.sunweb.game.rpg.role.RoleModel;
   import com.sunweb.game.rpg.role.obf_0_Y_3475;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class obf_b_Y_1298
   {
      
      private static var obf_K_n_1127:Object = new Object();
      
      public var defaultAction:String = "stand";
      
      protected var obf_k_O_3850:obf_0_Y_3475 = null;
      
      protected var _owner:Sprite;
      
      protected var obf_0_0_S_254:String;
      
      protected var obf_z_8_4533:int;
      
      protected var obf_p_F_1458:int;
      
      public var obf_F_q_3857:Boolean = false;
      
      protected var obf_7_W_2405:Array;
      
      protected var obf_2_z_770:Object = new Object();
      
      public var isLazyLoading:Boolean;
      
      private var _onDoneCallback:Function = null;
      
      public function obf_b_Y_1298(param1:Sprite, param2:Array = null, param3:Boolean = false)
      {
         super();
         if(param1.parent != null && param1.parent is obf_0_Y_3475)
         {
            this.obf_k_O_3850 = param1.parent as obf_0_Y_3475;
            this.defaultAction = this.obf_k_O_3850.isInCombat ? obf_S_c_3330.obf_R_z_4156 : obf_S_c_3330.obf_r_q_3113;
         }
         this._owner = param1;
         this.obf_7_W_2405 = param2;
         this.initDirection();
         this.isLazyLoading = param3;
         if(!param3 || this._owner.stage != null)
         {
            this.checkAndCreateActions();
         }
      }
      
      public static function obf_B_y_3372(param1:Object) : obf_S_c_3330
      {
         var _loc6_:MovieClip = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc11_:Boolean = false;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:obf_S_c_3330 = new obf_S_c_3330();
         _loc2_.name = param1.name;
         _loc2_.dirNum = param1.dirNum == null ? 8 : int(param1.dirNum);
         var _loc3_:String = param1.res;
         var _loc4_:obf_b_8_4256 = new obf_b_8_4256(_loc3_);
         var _loc5_:String = _loc4_.name;
         _loc2_.obf_o_S_1886 = new Object();
         if(_loc2_.dirNum == 8 || _loc2_.dirNum == 4 || _loc2_.dirNum == 2)
         {
            _loc7_ = 8 / _loc2_.dirNum;
            _loc8_ = 0;
            while(_loc8_ < _loc2_.dirNum)
            {
               _loc9_ = _loc8_ * _loc7_;
               _loc11_ = false;
               if(_loc9_ == obf_D_0_1300.RIGHT)
               {
                  _loc11_ = true;
                  _loc10_ = obf_e_G_3911.LEFT;
               }
               else if(_loc9_ == obf_D_0_1300.obf_J_j_3523)
               {
                  _loc11_ = true;
                  _loc10_ = obf_e_G_3911.obf_S_d_907;
               }
               else if(_loc9_ == obf_D_0_1300.obf_m_g_3030)
               {
                  _loc11_ = true;
                  _loc10_ = obf_e_G_3911.obf_3_3_2145;
               }
               else
               {
                  _loc10_ = obf_D_0_1300.directionToSuffix(_loc9_);
               }
               _loc4_.name = _loc5_ + _loc10_;
               _loc6_ = ResourceManager.instance.getMovieClip(_loc4_.toString());
               if(_loc6_ == null)
               {
                  throw new Error("Can not find resource: " + _loc4_.toString() + " for " + _loc2_.name);
               }
               _loc2_.setAnimation(_loc9_,new obf_6_t_3568(_loc6_,_loc11_));
               _loc8_++;
            }
         }
         else
         {
            _loc6_ = ResourceManager.instance.getMovieClip(_loc3_);
            if(_loc6_ == null)
            {
               throw new Error("Can not find resource: " + _loc4_.toString() + " for " + _loc2_.name);
            }
            _loc2_.setAnimation(obf_D_0_1300.NONE,new obf_6_t_3568(_loc6_));
         }
         return _loc2_;
      }
      
      public static function obf_t_g_1334(param1:Object) : obf_S_c_3330
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:Boolean = false;
         var _loc9_:Array = null;
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:obf_S_c_3330 = new obf_S_c_3330();
         _loc2_.actionInfo = param1;
         _loc2_.name = param1.name;
         _loc2_.dirNum = param1.dirNum == null ? 8 : int(param1.dirNum);
         var _loc3_:Object = param1.dirAnimations;
         _loc2_.obf_o_S_1886 = new Object();
         if(_loc2_.dirNum == 8 || _loc2_.dirNum == 4 || _loc2_.dirNum == 2)
         {
            _loc4_ = 8 / _loc2_.dirNum;
            _loc5_ = 0;
            while(_loc5_ < _loc2_.dirNum)
            {
               _loc6_ = _loc5_ * _loc4_;
               _loc8_ = false;
               if(_loc6_ == obf_D_0_1300.RIGHT)
               {
                  _loc8_ = true;
                  _loc7_ = obf_0_4_9_162.LEFT;
               }
               else if(_loc6_ == obf_D_0_1300.obf_J_j_3523)
               {
                  _loc8_ = true;
                  _loc7_ = obf_0_4_9_162.obf_S_d_907;
               }
               else if(_loc6_ == obf_D_0_1300.obf_m_g_3030)
               {
                  _loc8_ = true;
                  _loc7_ = obf_0_4_9_162.obf_3_3_2145;
               }
               else
               {
                  _loc7_ = obf_D_0_1300.directionToName(_loc6_);
               }
               _loc9_ = _loc3_[_loc7_];
               _loc2_.setAnimation(_loc6_,new obf_L_S_1960(_loc9_,_loc8_));
               _loc5_++;
            }
         }
         else
         {
            _loc2_.setAnimation(obf_D_0_1300.NONE,new obf_L_S_1960(_loc3_[""]));
         }
         return _loc2_;
      }
      
      public static function fastCreatePlayerActionManager(param1:Sprite, param2:String) : obf_b_Y_1298
      {
         var _loc4_:Object = null;
         var _loc3_:obf_b_Y_1298 = obf_K_n_1127[param2];
         if(_loc3_ == null)
         {
            _loc4_ = RoleModel.getPlayerModel(param2);
            if(_loc4_ == null)
            {
               return null;
            }
            _loc3_ = new obf_b_Y_1298(new Sprite(),_loc4_.actions);
            obf_K_n_1127[param2] = _loc3_;
         }
         return _loc3_.clone(param1);
      }
      
      public function initDirection() : void
      {
         this.obf_z_8_4533 = int(Math.random() * 360);
         this.obf_p_F_1458 = obf_D_0_1300.getDirectionByAngle(this.obf_z_8_4533,8);
      }
      
      public function checkAndCreateActions() : Boolean
      {
         var _loc2_:Object = null;
         if(this.obf_F_q_3857 || this.obf_7_W_2405 == null)
         {
            return false;
         }
         this.obf_F_q_3857 = true;
         var _loc1_:String = this.obf_7_W_2405[0].res != null && this.obf_7_W_2405[0].res != "" ? "mc" : "is";
         for each(_loc2_ in this.obf_7_W_2405)
         {
            this.obf_2_z_770[_loc2_.name] = _loc1_ == "mc" ? obf_B_y_3372(_loc2_) : obf_t_g_1334(_loc2_);
         }
         this.refreshAction();
         return true;
      }
      
      public function clone(param1:Sprite) : obf_b_Y_1298
      {
         var _loc3_:String = null;
         var _loc4_:obf_S_c_3330 = null;
         var _loc2_:obf_b_Y_1298 = new obf_b_Y_1298(param1);
         for(_loc3_ in this.obf_2_z_770)
         {
            _loc4_ = this.obf_2_z_770[_loc3_];
            _loc2_.actionMap[_loc3_] = _loc4_.clone();
         }
         return _loc2_;
      }
      
      public function get obf_Q_s_1889() : Sprite
      {
         return this.obf_k_O_3850;
      }
      
      public function get owner() : Sprite
      {
         return this._owner;
      }
      
      public function set owner(param1:Sprite) : void
      {
         this._owner = param1;
      }
      
      public function get currentAction() : String
      {
         return this.obf_0_0_S_254;
      }
      
      public function get obf_e_O_820() : int
      {
         return this.obf_z_8_4533;
      }
      
      public function get currentDirection() : int
      {
         return this.obf_p_F_1458;
      }
      
      public function get currentAnimation() : obf_W_E_4480
      {
         var ani:obf_W_E_4480 = null;
         try
         {
            ani = this.getAction(this.obf_0_0_S_254).getAnimation(this.obf_p_F_1458);
         }
         catch(e:Error)
         {
         }
         return ani;
      }
      
      public function get actionMap() : Object
      {
         return this.obf_2_z_770;
      }
      
      public function getAction(param1:String) : obf_S_c_3330
      {
         return this.obf_2_z_770[param1];
      }
      
      public function getActionAnyWay(param1:String) : obf_S_c_3330
      {
         var _loc2_:obf_S_c_3330 = this.getAction(param1);
         if(_loc2_ == null)
         {
            param1 = obf_S_c_3330.getAlterActionName(param1);
            _loc2_ = this.getAction(param1);
         }
         if(_loc2_ == null)
         {
            param1 = obf_S_c_3330.getAlterActionName(param1);
            _loc2_ = this.getAction(param1);
         }
         return _loc2_;
      }
      
      public function obf_E_5_1913() : void
      {
         if(this.obf_k_O_3850 == null)
         {
            return;
         }
         this.defaultAction = this.obf_k_O_3850.isInCombat ? obf_S_c_3330.obf_R_z_4156 : obf_S_c_3330.obf_r_q_3113;
         if(this.obf_0_0_S_254 == obf_S_c_3330.obf_r_q_3113 || this.obf_0_0_S_254 == obf_S_c_3330.obf_R_z_4156)
         {
            this.stopAction();
         }
      }
      
      public function obf_T_2_4324() : void
      {
         this.obf_E_5_1913();
      }
      
      public function doActionByAngle(param1:String, param2:int = -1, param3:Boolean = false, param4:int = 0, param5:Function = null, param6:Boolean = false, param7:Number = 1) : void
      {
         var action:obf_S_c_3330;
         var direction:int;
         var mc:obf_W_E_4480;
         var actionName:String = param1;
         var angle:int = param2;
         var isLoop:Boolean = param3;
         var maxPlayTime:int = param4;
         var onDone:Function = param5;
         var autoSpeed:Boolean = param6;
         var speedModifier:Number = param7;
         if(angle <= -1)
         {
            angle = this.obf_z_8_4533;
         }
         this.obf_0_0_S_254 = actionName;
         this.obf_z_8_4533 = angle;
         this.obf_p_F_1458 = obf_D_0_1300.getDirectionByAngle(angle,8);
         action = this.getActionAnyWay(actionName);
         if(action == null)
         {
            try
            {
               if(onDone != null)
               {
                  onDone();
               }
            }
            catch(e:Error)
            {
            }
            return;
         }
         direction = obf_D_0_1300.getDirectionByAngle(angle,action.dirNum);
         this.obf_p_F_1458 = direction;
         mc = action.getAnimation(direction);
         if(mc == null)
         {
            try
            {
               if(onDone != null)
               {
                  onDone();
               }
            }
            catch(e:Error)
            {
            }
            return;
         }
         this._onDoneCallback = onDone;
         mc.obf_J_f_4443(1);
         if(autoSpeed && maxPlayTime > 0)
         {
            mc.obf_N_B_1760(maxPlayTime);
         }
         if(!autoSpeed && speedModifier != 1)
         {
            mc.obf_J_f_4443(speedModifier);
         }
         this.showAnimation(mc,isLoop,maxPlayTime);
      }
      
      public function doAction(param1:String, param2:int = -1, param3:Boolean = false, param4:int = 0, param5:Function = null, param6:Boolean = false, param7:Number = 1) : void
      {
         var _loc8_:int = 0;
         if(param2 <= -1)
         {
            _loc8_ = this.obf_z_8_4533;
         }
         else
         {
            _loc8_ = 360 - param2 * 45;
         }
         this.doActionByAngle(param1,_loc8_,param3,param4,param5,param6,param7);
      }
      
      public function stopAction() : void
      {
         this.doActionByAngle(this.defaultAction,this.obf_z_8_4533,true);
      }
      
      public function refreshAction() : void
      {
         var action:obf_S_c_3330;
         var direction:int;
         var mc:obf_W_E_4480;
         var oldMc:obf_W_E_4480 = null;
         try
         {
            oldMc = this._owner.getChildAt(0) as obf_W_E_4480;
         }
         catch(e:Error)
         {
         }
         action = this.getAction(this.obf_0_0_S_254);
         if(action == null)
         {
            return;
         }
         direction = obf_D_0_1300.getDirectionByAngle(this.obf_z_8_4533,action.dirNum);
         mc = action.getAnimation(direction);
         if(mc == null)
         {
            return;
         }
         if(oldMc == null)
         {
            if(this.obf_0_0_S_254 == obf_S_c_3330.obf_r_q_3113 || this.obf_0_0_S_254 == obf_S_c_3330.obf_R_z_4156 || this.obf_0_0_S_254 == obf_S_c_3330.obf_h_4_3537 || this.obf_0_0_S_254 == obf_S_c_3330.obf_0_3_U_524 || this.obf_0_0_S_254 == obf_S_c_3330.DIE)
            {
               this.showAnimation(mc,true,0);
            }
            else
            {
               this.showAnimation(mc,false);
            }
         }
         else
         {
            this.showAnimation(mc,oldMc.allowRepeat,oldMc.maxPlayTime);
         }
      }
      
      private function showAnimation(param1:obf_W_E_4480, param2:Boolean, param3:int = 0) : void
      {
         this.removeChildren(this._owner);
         param1.rewind();
         param1.allowRepeat = param2;
         param1.maxPlayTime = param3;
         this._owner.addChild(param1);
         if(!param2 || param3 > 0)
         {
            param1.addEventListener(Event.COMPLETE,this.obf_K_v_1919);
         }
      }
      
      private function obf_K_v_1919(param1:Event) : void
      {
         var e:Event = param1;
         var onDone:Function = this._onDoneCallback;
         this._onDoneCallback = null;
         this.stopAction();
         try
         {
            (e.target as obf_W_E_4480).removeEventListener(Event.COMPLETE,this.obf_K_v_1919);
         }
         catch(ex:Error)
         {
         }
         try
         {
            if(onDone != null)
            {
               onDone();
            }
         }
         catch(ex:Error)
         {
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:String = null;
         this.removeChildren(this._owner);
         this._owner = null;
         this.obf_k_O_3850 = null;
         if(this.obf_2_z_770 != null)
         {
            for(_loc1_ in this.obf_2_z_770)
            {
               delete this.obf_2_z_770[_loc1_];
            }
            this.obf_2_z_770 = null;
         }
         this._onDoneCallback = null;
      }
      
      public function removeChildren(param1:Sprite) : void
      {
         var c:Sprite = param1;
         var i:int = c.numChildren - 1;
         while(i >= 0)
         {
            try
            {
               (c.getChildAt(i) as obf_W_E_4480).removeEventListener(Event.COMPLETE,this.obf_K_v_1919);
            }
            catch(e:Error)
            {
            }
            c.removeChildAt(i);
            i--;
         }
      }
   }
}

