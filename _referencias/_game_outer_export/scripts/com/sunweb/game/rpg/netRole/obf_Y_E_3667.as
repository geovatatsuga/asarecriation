package com.sunweb.game.rpg.netRole
{
   import obf_g_A_3629.obf_M_z_1692;
   import obf_g_A_3629.obf_r_Y_1874;
   import com.sunweb.game.res.ResourceBag;
   import com.sunweb.game.res.ResourceManager;
   import com.sunweb.game.res.obf_b_8_4256;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.animal.AnimalInfo;
   import com.sunweb.game.rpg.buff.BuffInfo;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.playerUI.managers.obf_N_g_4386;
   import com.sunweb.game.rpg.role.RoleModel;
   import com.sunweb.game.rpg.role.obf_0_M_3913;
   import com.sunweb.game.rpg.role.obf_E_k_1445;
   import com.sunweb.game.rpg.role.obf_I_5_1944;
   import com.sunweb.game.rpg.role.obf_e_1465;
   import com.sunweb.game.rpg.role.action.obf_D_0_1300;
   import com.sunweb.game.rpg.role.action.obf_S_c_3330;
   import com.sunweb.game.rpg.role.action.obf_b_Y_1298;
   import com.sunweb.game.rpg.skill.SkillManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.world.obf_2_V_3982;
   import com.sunweb.game.util.TimeLimiter;
   import com.sunweb.game.utils.JSONUtil;
   import com.sunweb.game.utils.obf_L_l_4100;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   import playerUI.BlessBar;
   import playerUI.BoothTitleBar;
   
   public class obf_Y_E_3667 extends obf_0_M_3913
   {
      
      private static var hairConfig:Object;
      
      protected var obf_r_h_2193:obf_t_T_3981;
      
      protected var obf_w_n_4158:obf_Z_L_1552;
      
      protected var obf_P_H_2816:obf_q_Z_3851;
      
      protected var obf_R_N_734:obf_J_D_1836;
      
      public var playerTitleId:int;
      
      protected var obf_v_H_3187:obf_9_c_4534;
      
      protected var obf_l_D_4435:int;
      
      private var obf_M_U_3712:TimeLimiter;
      
      private var obf_O_x_3734:TimeLimiter;
      
      private var petMaxFollowDistance:int = 150;
      
      private var petPathArray:Array;
      
      private var geniePathArray:Array;
      
      private var devilPathArray:Array;
      
      private var lineDistance:int = 30;
      
      private var trainerMaxFollowDistance:int = 200;
      
      private var trainerPathArray:Array;
      
      private var obf_3_M_2622:Boolean;
      
      private var obf_F_s_1710:String;
      
      private var obf_J_x_769:BoothTitleBar;
      
      private var _isBlessing:Boolean;
      
      private var _blessCode:String;
      
      private var obf_C_H_3079:BlessBar;
      
      private var faceShow:obf_M_z_1692;
      
      public function obf_Y_E_3667(param1:int, param2:int, param3:int, param4:String = "")
      {
         var _loc5_:ResourceBag = null;
         var _loc6_:Array = null;
         var _loc7_:String = null;
         this.obf_M_U_3712 = new TimeLimiter(500);
         this.obf_O_x_3734 = new TimeLimiter(3000);
         super(obf_I_5_1944.getJobName(param1,param2),ResourceManager.instance.getDisplayObject("LoadMoodel@loadMoodel"),param4);
         if(!obf_L_l_4100.isEmpty(param4))
         {
            _loc5_ = ResourceManager.instance.getBag("common",true);
            _loc6_ = getEquipmentImageRes(obf_E_k_1445.HAT,obf_Y_E_3667.getHairModelCode(param1,param2,param3),obf_I_5_1944.getJobName(param1,param2));
            for each(_loc7_ in _loc6_)
            {
               _loc5_.obf_z_U_2156(_loc7_);
            }
            _loc5_.obf_z_U_2156(JSONUtil.getStr(RoleModel.getPlayerModel(obf_I_5_1944.getJobName(param1,param2)),["res"]));
         }
         this.obf_l_D_4435 = param1;
         this.setHatDefaultModel(param1,param2,param3,false);
         this.addListener();
      }
      
      public static function initHairConfig(param1:Object) : void
      {
         hairConfig = param1;
      }
      
      public static function getHairModelCode(param1:int, param2:int, param3:int) : String
      {
         if(!hairConfig)
         {
            return "";
         }
         var _loc4_:Array = JSONUtil.getObject(hairConfig,[obf_I_5_1944.getJobName(param1,param2)]) as Array;
         return JSONUtil.getStr(_loc4_,[param3]);
      }
      
      public static function getHairModelList(param1:int, param2:int) : Array
      {
         return JSONUtil.getObject(hairConfig,[obf_I_5_1944.getJobName(param1,param2)]) as Array;
      }
      
      public static function getEquipmentImageRes(param1:String, param2:String, param3:String) : Array
      {
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         var _loc9_:obf_b_8_4256 = null;
         var _loc10_:String = null;
         var _loc4_:Array = new Array();
         var _loc5_:Object = obf_E_k_1445.getEquipmentImagesForPlayerModel(param1,param2,param3);
         if(_loc5_ == null)
         {
            return _loc4_;
         }
         for each(_loc6_ in _loc5_)
         {
            for each(_loc7_ in _loc6_)
            {
               for each(_loc8_ in _loc7_)
               {
                  _loc9_ = new obf_b_8_4256(_loc8_.img);
                  _loc10_ = _loc9_.resIdToImport;
                  if(_loc10_ != null && _loc10_ != "")
                  {
                     if(_loc4_.indexOf(_loc10_) < 0)
                     {
                        _loc4_.push(_loc10_);
                     }
                     break;
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function get playerJobCode() : int
      {
         return this.obf_l_D_4435;
      }
      
      private function addListener() : void
      {
         this.addEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
      }
      
      private function removeListener() : void
      {
         this.removeEventListener(Event.ADDED_TO_STAGE,this.onAddToStage);
      }
      
      private function onAddToStage(param1:Event) : void
      {
      }
      
      override protected function obf_0_2_b_567() : void
      {
         if(this.obf_r_h_2193)
         {
            this.obf_r_h_2193.visible = this.obf_X_f_2691;
         }
         if(this.obf_w_n_4158)
         {
            this.obf_w_n_4158.visible = this.obf_X_f_2691;
         }
         if(this.obf_R_N_734)
         {
            this.obf_R_N_734.visible = this.obf_X_f_2691;
         }
         if(this.obf_v_H_3187)
         {
            this.obf_v_H_3187.visible = this.obf_X_f_2691;
         }
      }
      
      public function resetPosition(param1:int, param2:int, param3:Boolean = true) : void
      {
         if(param3)
         {
            this.resetPetPosition();
            this.resetGeniePosition();
            this.resetDevilPosition();
            this.resetDragonPosition();
            this.resetTrainerPosition();
         }
         this.stopWalking();
         this.moveToPixel(param1,param2);
         this.obf_9_0_4119();
      }
      
      public function get obf_y_G_2458() : obf_t_T_3981
      {
         return this.obf_r_h_2193;
      }
      
      private function obf_0_7_L_545() : void
      {
         var _loc2_:Point = null;
         if(this.obf_r_h_2193.isUsingSkill)
         {
            return;
         }
         var _loc1_:int = this.getLineDistance(this.obf_r_h_2193);
         if(_loc1_ > this.petMaxFollowDistance)
         {
            this.obf_r_h_2193.walkSpeed = this.walkSpeed;
            _loc2_ = new Point(this.rootPX,this.rootPY);
            if(Boolean(this.obf_z_M_1523) && this.obf_z_M_1523.length > 0)
            {
               _loc2_ = this.obf_z_M_1523[this.obf_z_M_1523.length - 1];
            }
            if(!this.petPathArray || this.petPathArray.length == 0 || !_loc2_.equals(this.petPathArray[this.petPathArray.length - 1]))
            {
               this.petPathArray = [new Point(this.obf_r_h_2193.rootPX,this.obf_r_h_2193.rootPY),new Point(this.rootPX,this.rootPY)];
               if(this.obf_z_M_1523)
               {
                  this.petPathArray = this.petPathArray.concat(this.obf_z_M_1523.slice(this._lastMoveIndex + 1));
               }
               this.obf_r_h_2193.walkAlongPath(this.petPathArray,true);
            }
         }
         else
         {
            this.petPathArray = null;
            if(this.obf_r_h_2193.isWalking())
            {
               this.obf_r_h_2193.stopWalking();
            }
         }
      }
      
      public function resetPetPosition() : void
      {
         if(!GameContext.currentMap || !this.obf_r_h_2193)
         {
            return;
         }
         var _loc1_:Point = Point.polar(Math.random() * this.petMaxFollowDistance,Math.random() * 360 * Math.PI / 180);
         this.obf_r_h_2193.stopWalking();
         this.obf_r_h_2193.stopAction();
         this.obf_r_h_2193.moveToPixel(this.rootPX + _loc1_.x,this.rootPY + _loc1_.y);
         this.obf_r_h_2193.obf_9_0_4119();
      }
      
      public function setPet(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:String = null;
         var _loc5_:DisplayObject = null;
         if(!GameContext.currentMap)
         {
            return;
         }
         if(Boolean(this.obf_r_h_2193) && !this.obf_r_h_2193.isDestroyed())
         {
            if(this.obf_r_h_2193.id == param3)
            {
               return;
            }
            GameContext.currentMap.petSet.removeObject(this.obf_r_h_2193,true);
         }
         this.obf_r_h_2193 = new obf_t_T_3981(param1);
         this.obf_r_h_2193.setName(param2,this.id);
         this.obf_r_h_2193.id = param3;
         this.obf_r_h_2193.initCommand(WorldConfig.getObjectSetting("effectCommand") as Array);
         if(!this.obf_r_h_2193)
         {
            return;
         }
         this.resetPetPosition();
         if(GameContext.currentMap)
         {
            GameContext.currentMap.petSet.addObject(this.obf_r_h_2193);
         }
         if(GameContext.localPlayer.obf_y_G_2458 == this.obf_r_h_2193)
         {
            for(_loc4_ in this.obf_r_h_2193.flagMap)
            {
               _loc5_ = this.obf_r_h_2193.flagMap[_loc4_] as DisplayObject;
               if((Boolean(_loc5_)) && Boolean(obf_K_e_3075.systemSettingUI))
               {
                  if(obf_K_e_3075.systemSettingUI.openEffMap[_loc4_])
                  {
                     _loc5_.visible = false;
                  }
                  else
                  {
                     _loc5_.visible = true;
                  }
               }
            }
         }
      }
      
      public function setPetBuff(param1:Array) : void
      {
         var _loc2_:BuffInfo = null;
         if(!this.obf_r_h_2193 || this.obf_r_h_2193.isDestroyed())
         {
            return;
         }
         this.obf_r_h_2193.obf_S_s_4252();
         for each(_loc2_ in param1)
         {
            this.obf_r_h_2193.obf_a_8_4261(_loc2_);
         }
      }
      
      public function removePet() : void
      {
         if(!this.obf_r_h_2193 || this.obf_r_h_2193.isDestroyed() || !GameContext.currentMap)
         {
            return;
         }
         GameContext.currentMap.petSet.removeObject(this.obf_r_h_2193,true);
      }
      
      public function get obf_0_8_F_362() : obf_Z_L_1552
      {
         return this.obf_w_n_4158;
      }
      
      private function obf_K_l_3510() : void
      {
         var _loc2_:Point = null;
         var _loc1_:int = this.getLineDistance(this.obf_w_n_4158);
         if(_loc1_ > 80)
         {
            this.obf_w_n_4158.walkSpeed = this.walkSpeed;
            _loc2_ = new Point(this.rootPX,this.rootPY);
            if(Boolean(this.obf_z_M_1523) && this.obf_z_M_1523.length > 0)
            {
               _loc2_ = this.obf_z_M_1523[this.obf_z_M_1523.length - 1];
            }
            if(!this.geniePathArray || this.geniePathArray.length == 0 || !_loc2_.equals(this.geniePathArray[this.geniePathArray.length - 1]))
            {
               this.geniePathArray = [new Point(this.obf_w_n_4158.rootPX,this.obf_w_n_4158.rootPY),new Point(this.rootPX,this.rootPY)];
               if(this.obf_z_M_1523)
               {
                  this.geniePathArray = this.geniePathArray.concat(this.obf_z_M_1523.slice(this._lastMoveIndex + 1));
               }
               this.obf_w_n_4158.walkAlongPath(this.geniePathArray,true);
            }
         }
         else
         {
            this.geniePathArray = null;
            if(this.obf_w_n_4158.isWalking())
            {
               this.obf_w_n_4158.stopWalking();
            }
         }
      }
      
      public function resetGeniePosition() : void
      {
         if(!GameContext.currentMap || !this.obf_w_n_4158)
         {
            return;
         }
         this.obf_w_n_4158.stopWalking();
         this.obf_w_n_4158.stopAction();
         this.obf_w_n_4158.moveToPixel(this.rootPX,this.rootPY);
         this.obf_w_n_4158.obf_9_0_4119();
      }
      
      public function setGenie(param1:String, param2:String) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         if(this.obf_w_n_4158)
         {
            GameContext.currentMap.petSet.removeObject(this.obf_w_n_4158,true);
         }
         this.obf_w_n_4158 = new obf_Z_L_1552(param1);
         this.obf_w_n_4158.id = param2;
         if(!this.obf_w_n_4158)
         {
            return;
         }
         this.resetGeniePosition();
         if(GameContext.currentMap)
         {
            GameContext.currentMap.petSet.addObject(this.obf_w_n_4158);
         }
      }
      
      public function removeGenie() : void
      {
         if(!this.obf_w_n_4158 || this.obf_w_n_4158.isDestroyed() || !GameContext.currentMap)
         {
            return;
         }
         GameContext.currentMap.petSet.removeObject(this.obf_w_n_4158,true);
      }
      
      public function get obf_p_o_4531() : obf_q_Z_3851
      {
         return this.obf_P_H_2816;
      }
      
      private function obf_T_U_1505() : void
      {
         var _loc2_:Point = null;
         var _loc1_:int = this.getLineDistance(this.obf_P_H_2816);
         if(_loc1_ > 80)
         {
            this.obf_P_H_2816.walkSpeed = this.walkSpeed;
            _loc2_ = new Point(this.rootPX,this.rootPY);
            if(Boolean(this.obf_z_M_1523) && this.obf_z_M_1523.length > 0)
            {
               _loc2_ = this.obf_z_M_1523[this.obf_z_M_1523.length - 1];
            }
            if(!this.devilPathArray || this.devilPathArray.length == 0 || !_loc2_.equals(this.devilPathArray[this.devilPathArray.length - 1]))
            {
               this.devilPathArray = [new Point(this.obf_P_H_2816.rootPX,this.obf_P_H_2816.rootPY),new Point(this.rootPX,this.rootPY)];
               if(this.obf_z_M_1523)
               {
                  this.devilPathArray = this.devilPathArray.concat(this.obf_z_M_1523.slice(this._lastMoveIndex + 1));
               }
               this.obf_P_H_2816.walkAlongPath(this.devilPathArray,true);
            }
         }
         else
         {
            this.devilPathArray = null;
            if(this.obf_P_H_2816.isWalking())
            {
               this.obf_P_H_2816.stopWalking();
            }
         }
      }
      
      public function resetDevilPosition() : void
      {
         if(!GameContext.currentMap || !this.obf_P_H_2816)
         {
            return;
         }
         this.obf_P_H_2816.stopWalking();
         this.obf_P_H_2816.stopAction();
         this.obf_P_H_2816.moveToPixel(this.rootPX,this.rootPY);
         this.obf_P_H_2816.obf_9_0_4119();
      }
      
      public function setDevil(param1:String, param2:String) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         if(this.obf_P_H_2816)
         {
            GameContext.currentMap.petSet.removeObject(this.obf_P_H_2816,true);
         }
         this.obf_P_H_2816 = new obf_q_Z_3851(param1);
         this.obf_P_H_2816.id = param2;
         if(!this.obf_P_H_2816)
         {
            return;
         }
         this.resetDevilPosition();
         if(GameContext.currentMap)
         {
            GameContext.currentMap.petSet.addObject(this.obf_P_H_2816);
         }
      }
      
      public function removeDevil() : void
      {
         if(!this.obf_P_H_2816 || this.obf_P_H_2816.isDestroyed() || !GameContext.currentMap)
         {
            return;
         }
         GameContext.currentMap.petSet.removeObject(this.obf_P_H_2816,true);
      }
      
      public function get obf_R_i_4463() : obf_J_D_1836
      {
         return this.obf_R_N_734;
      }
      
      private function obf_w_h_i_l_e_293() : void
      {
         var _loc1_:int = this.getLineDistance(this.obf_R_N_734);
         if(_loc1_ >= 800)
         {
            this.resetDragonPosition();
         }
         else if(_loc1_ > this.lineDistance)
         {
            this.obf_R_N_734.walkSpeed = this.walkSpeed;
            switch(this.actionManager.currentDirection)
            {
               case obf_D_0_1300.DOWN:
                  this.obf_R_N_734.walkToPixel(this.rootPX - this.lineDistance,this.rootPY + this.lineDistance / 2,this.getMap());
                  break;
               case obf_D_0_1300.LEFT:
                  this.obf_R_N_734.walkToPixel(this.rootPX,this.rootPY + this.lineDistance,this.getMap());
                  break;
               case obf_D_0_1300.UP:
                  this.obf_R_N_734.walkToPixel(this.rootPX + this.lineDistance,this.rootPY,this.getMap());
                  break;
               case obf_D_0_1300.RIGHT:
                  this.obf_R_N_734.walkToPixel(this.rootPX,this.rootPY + this.lineDistance,this.getMap());
                  break;
               case obf_D_0_1300.obf_3_3_2145:
                  this.obf_R_N_734.walkToPixel(this.rootPX + Math.sqrt(this.lineDistance * this.lineDistance / 2),this.rootPY + Math.sqrt(this.lineDistance * this.lineDistance / 2),this.getMap());
                  break;
               case obf_D_0_1300.obf_m_g_3030:
                  this.obf_R_N_734.walkToPixel(this.rootPX - Math.sqrt(this.lineDistance * this.lineDistance / 2),this.rootPY + Math.sqrt(this.lineDistance * this.lineDistance / 2),this.getMap());
                  break;
               case obf_D_0_1300.obf_S_d_907:
                  this.obf_R_N_734.walkToPixel(this.rootPX + Math.sqrt(this.lineDistance * this.lineDistance / 2),this.rootPY + Math.sqrt(this.lineDistance * this.lineDistance / 2),this.getMap());
                  break;
               case obf_D_0_1300.obf_J_j_3523:
                  this.obf_R_N_734.walkToPixel(this.rootPX - Math.sqrt(this.lineDistance * this.lineDistance / 2),this.rootPY + Math.sqrt(this.lineDistance * this.lineDistance / 2),this.getMap());
            }
         }
         else if(this.obf_R_N_734.isWalking())
         {
            this.obf_R_N_734.stopWalking();
         }
      }
      
      public function resetDragonPosition() : void
      {
         if(!GameContext.currentMap || !this.obf_R_N_734)
         {
            return;
         }
         this.obf_R_N_734.stopWalking();
         this.obf_R_N_734.stopAction();
         this.obf_R_N_734.moveToPixel(this.rootPX,this.rootPY + this.lineDistance);
         this.obf_R_N_734.obf_9_0_4119();
      }
      
      public function setDragon(param1:int) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         if(this.obf_R_N_734)
         {
            GameContext.currentMap.petSet.removeObject(this.obf_R_N_734,true);
         }
         this.obf_R_N_734 = new obf_J_D_1836(param1);
         ++GameContext.localPlayer.dragonSn;
         if(GameContext.localPlayer.dragonSn > 65535)
         {
            GameContext.localPlayer.dragonSn = 0;
         }
         this.obf_R_N_734.id = "dragon" + GameContext.localPlayer.dragonSn;
         if(!this.obf_R_N_734)
         {
            return;
         }
         this.resetDragonPosition();
         if(GameContext.currentMap)
         {
            GameContext.currentMap.petSet.addObject(this.obf_R_N_734);
         }
      }
      
      public function removeDragon() : void
      {
         if(!this.obf_R_N_734 || this.obf_R_N_734.isDestroyed() || !GameContext.currentMap)
         {
            return;
         }
         GameContext.currentMap.petSet.removeObject(this.obf_R_N_734,true);
      }
      
      public function get obf_F_o_1931() : obf_9_c_4534
      {
         return this.obf_v_H_3187;
      }
      
      private function obf_B_6_3905() : void
      {
         var _loc2_:Point = null;
         if(this.obf_v_H_3187.isUsingSkill)
         {
            return;
         }
         var _loc1_:int = this.getLineDistance(this.obf_v_H_3187);
         if(_loc1_ > this.trainerMaxFollowDistance)
         {
            this.obf_v_H_3187.walkSpeed = this.walkSpeed;
            _loc2_ = new Point(this.rootPX,this.rootPY);
            if(Boolean(this.obf_z_M_1523) && this.obf_z_M_1523.length > 0)
            {
               _loc2_ = this.obf_z_M_1523[this.obf_z_M_1523.length - 1];
            }
            if(!this.trainerPathArray || this.trainerPathArray.length == 0 || !_loc2_.equals(this.trainerPathArray[this.trainerPathArray.length - 1]))
            {
               this.trainerPathArray = [new Point(this.obf_v_H_3187.rootPX,this.obf_v_H_3187.rootPY),new Point(this.rootPX,this.rootPY)];
               if(this.obf_z_M_1523)
               {
                  this.trainerPathArray = this.trainerPathArray.concat(this.obf_z_M_1523.slice(this._lastMoveIndex + 1));
               }
               this.obf_v_H_3187.walkAlongPath(this.trainerPathArray,true);
            }
         }
         else
         {
            this.trainerPathArray = null;
            if(this.obf_v_H_3187.isWalking())
            {
               this.obf_v_H_3187.stopWalking();
            }
         }
      }
      
      public function resetTrainerPosition() : void
      {
         if(!GameContext.currentMap || !this.obf_v_H_3187)
         {
            return;
         }
         var _loc1_:Point = Point.polar(Math.random() * this.petMaxFollowDistance,Math.random() * 360 * Math.PI / 180);
         this.obf_v_H_3187.stopWalking();
         this.obf_v_H_3187.stopAction();
         this.obf_v_H_3187.moveToPixel(this.rootPX + _loc1_.x,this.rootPY + _loc1_.y);
         this.obf_v_H_3187.obf_9_0_4119();
      }
      
      public function setTrainer(param1:AnimalInfo) : void
      {
         if(!GameContext.currentMap || this.obf_l_D_4435 != obf_I_5_1944.obf_0_1_133)
         {
            return;
         }
         if(Boolean(this.obf_v_H_3187) && !this.obf_v_H_3187.isDestroyed())
         {
            if(this.obf_v_H_3187.id == param1.id)
            {
               return;
            }
            GameContext.currentMap.animalSet.removeObject(this.obf_v_H_3187,true);
         }
         var _loc2_:String = obf_2_V_3982.getTrianerMode(param1.animalCode);
         this.obf_v_H_3187 = new obf_9_c_4534(_loc2_,param1);
         this.obf_v_H_3187.setName();
         this.obf_v_H_3187.id = param1.id;
         this.obf_v_H_3187.walkSpeed = param1.walkSpeed;
         this.obf_v_H_3187.moveToPixel(param1.x,param1.y);
         if(!this.obf_v_H_3187)
         {
            return;
         }
         this.resetTrainerPosition();
         if(GameContext.currentMap)
         {
            GameContext.currentMap.animalSet.addObject(this.obf_v_H_3187);
         }
      }
      
      public function setTrainerBuff(param1:Array) : void
      {
         var _loc2_:BuffInfo = null;
         if(!this.obf_v_H_3187 || this.obf_v_H_3187.isDestroyed())
         {
            return;
         }
         this.obf_v_H_3187.obf_S_s_4252();
         for each(_loc2_ in param1)
         {
            this.obf_v_H_3187.obf_a_8_4261(_loc2_);
         }
      }
      
      public function removeTrainer() : void
      {
         if(!this.obf_v_H_3187 || this.obf_v_H_3187.isDestroyed() || !GameContext.currentMap)
         {
            return;
         }
         GameContext.currentMap.animalSet.removeObject(this.obf_v_H_3187,true);
      }
      
      override public function onUpdate() : void
      {
         super.onUpdate();
         if(this.obf_M_U_3712.checkTimeout())
         {
            if(Boolean(this.obf_r_h_2193) && !this.obf_r_h_2193.isDestroyed())
            {
               this.obf_0_7_L_545();
            }
            if(Boolean(this.obf_w_n_4158) && !this.obf_w_n_4158.isDestroyed())
            {
               this.obf_K_l_3510();
            }
            if(Boolean(this.obf_P_H_2816) && !this.obf_P_H_2816.isDestroyed())
            {
               this.obf_T_U_1505();
            }
            if(Boolean(this.obf_R_N_734) && !this.obf_R_N_734.isDestroyed())
            {
               this.obf_w_h_i_l_e_293();
            }
         }
      }
      
      public function get isBooth() : Boolean
      {
         return this.obf_3_M_2622;
      }
      
      public function setBooth(param1:Boolean, param2:String) : void
      {
         if(this.obf_3_M_2622 != param1)
         {
            if(Boolean(this.obf_J_x_769) && this.contains(this.obf_J_x_769))
            {
               this.removeChild(this.obf_J_x_769);
               this.obf_J_x_769 = null;
            }
            if(param1)
            {
               this.sit();
               this.obf_J_x_769 = new BoothTitleBar();
               this.obf_J_x_769.txtTitle.text = param2;
               this.obf_J_x_769.y = -100;
               this.addChild(this.obf_J_x_769);
            }
            else
            {
               this.stand();
            }
         }
         this.obf_3_M_2622 = param1;
         this.obf_F_s_1710 = param2;
         this.obf_F_s_1710 = param2;
      }
      
      public function get isBlessing() : Boolean
      {
         return this._isBlessing;
      }
      
      public function setBlessing(param1:Boolean, param2:String, param3:int) : void
      {
         if(Boolean(this.obf_C_H_3079) && this.contains(this.obf_C_H_3079))
         {
            this.removeChild(this.obf_C_H_3079);
            this.obf_C_H_3079 = null;
         }
         if(param1)
         {
            this.doAction(obf_S_c_3330.MAGIC,-1,true);
            this.obf_C_H_3079 = new BlessBar();
            this.obf_C_H_3079.txtBlessName.text = SkillManager.getSkillName(param2) + " Lv" + param3;
            this.addChild(this.obf_C_H_3079);
         }
         else
         {
            this.stand();
         }
         this._isBlessing = param1;
      }
      
      public function setHatDefaultModel(param1:int, param2:int, param3:int, param4:Boolean = true) : void
      {
         this.setDefaultEquipmentModel(obf_E_k_1445.HAT,getHairModelCode(param1,param2,param3));
         if(param4)
         {
            this.obf_X_l_842();
         }
      }
      
      public function getEquipmentModels() : Object
      {
         return _equipmentModelInUse;
      }
      
      public function setEquipmentModels(param1:Object) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:Array = null;
         var _loc4_:String = null;
         obf_K_r_3562();
         if(isTransfiguration)
         {
            this.setMonsterModelCode(obf_0_4_F_680);
            return;
         }
         for(_loc2_ in param1)
         {
            _loc3_ = param1[_loc2_].split(",");
            for each(_loc4_ in _loc3_)
            {
               setUsingEquipmentModel(obf_E_k_1445.getEquipmentModelKind(_loc4_),_loc4_);
            }
         }
         obf_A_j_2560();
      }
      
      public function setMonsterModelCode(param1:String) : void
      {
         obf_0_4_F_680 = param1;
         if(obf_8_J_2121 != null)
         {
            obf_8_J_2121.destroy();
            obf_8_J_2121 = null;
         }
         useMonsterModel(param1,obf_e_1465.obf_M_o_2357,true);
         obf_c_a_s_e_1538 = true;
         this.obf_B_B_1787();
      }
      
      private function obf_B_B_1787() : void
      {
         var _loc1_:ResourceBag = AIObjectsBufferManager.getResBag("m_" + obf_0_4_F_680);
         _loc1_.obf_z_U_2156(RoleModel.getMonsterModelResId(obf_0_4_F_680));
         _loc1_.load();
      }
      
      public function obf_g_O_774(param1:Event) : void
      {
         var _loc2_:Object = RoleModel.getMonsterModel(obf_0_4_F_680);
         if(_loc2_ == null)
         {
            throw new Error("Can not find monster model: " + obf_0_4_F_680);
         }
         obf_v_3985 = _loc2_.maxModelHeight;
         actionManager.destroy();
         useMonsterModel(obf_0_4_F_680,obf_e_1465.obf_M_o_2357,true);
         obf_c_a_s_e_1538 = true;
      }
      
      public function setPlayerModelCode(param1:String) : void
      {
         if(obf_8_J_2121 != null)
         {
            obf_8_J_2121.destroy();
            obf_8_J_2121 = null;
         }
         var _loc2_:Object = RoleModel.getPlayerModel(param1);
         obf_v_3985 = _loc2_.maxModelHeight;
         obf_8_J_2121 = new obf_b_Y_1298(_bodySprite,_loc2_.actions,true);
         obf_p_c_1558 = true;
         obf_c_a_s_e_1538 = false;
         obf_M_E_3819 = true;
         obf_A_j_2560();
         stopAction();
      }
      
      override public function say(param1:String, param2:int = 5) : void
      {
         param1 = "<textformat leading=\'10\'>" + param1 + "</textformat>";
         param1 = obf_r_Y_1874.obf_y_Q_3915(param1);
         super.say(param1,param2);
         if(!this.faceShow)
         {
            this.faceShow = new obf_M_z_1692(this.obf_C_a_2892.txtLabel);
            this.faceShow.getFace = obf_N_g_4386.getFaceDisplay;
         }
         this.faceShow.refresh();
      }
      
      override protected function updateSayLabel() : void
      {
         super.updateSayLabel();
         if(this.obf_C_a_2892 == null && Boolean(this.faceShow))
         {
            this.faceShow.destroy();
            this.faceShow = null;
         }
      }
      
      override public function destroy() : void
      {
         this.removeListener();
         if(this.faceShow)
         {
            this.faceShow.destroy();
         }
         if(Boolean(this.obf_r_h_2193) && !this.obf_r_h_2193.isDestroyed())
         {
            this.obf_r_h_2193.destroy();
         }
         if(Boolean(this.obf_w_n_4158) && !this.obf_w_n_4158.isDestroyed())
         {
            this.obf_w_n_4158.destroy();
         }
         if(Boolean(this.obf_R_N_734) && !this.obf_R_N_734.isDestroyed())
         {
            this.obf_R_N_734.destroy();
         }
         if(Boolean(this.obf_v_H_3187) && !this.obf_v_H_3187.isDestroyed())
         {
            this.obf_v_H_3187.destroy();
         }
      }
   }
}

