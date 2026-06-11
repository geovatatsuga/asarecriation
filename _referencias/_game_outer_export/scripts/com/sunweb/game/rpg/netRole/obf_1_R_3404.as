package com.sunweb.game.rpg.netRole
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.buff.BuffInfo;
   import com.sunweb.game.rpg.buff.BuffManager;
   import com.sunweb.game.rpg.map.Map;
   import com.sunweb.game.rpg.map.MapInteractiveObject;
   import com.sunweb.game.rpg.playerUI.managers.obf_0_3_0_538;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.role.obf_0_0_8_669;
   import com.sunweb.game.rpg.role.obf_0_9_V_473;
   import com.sunweb.game.rpg.skill.SkillCDManager;
   import com.sunweb.game.rpg.world.map.MapPoint;
   import com.sunweb.game.rpg.worldZone.command.animal.AnimalAttributesChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.animal.AnimalBuffChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.animal.AnimalEnterMapAnswer;
   import com.sunweb.game.rpg.worldZone.command.animal.AnimalHpChangeNotify;
   import com.sunweb.game.rpg.worldZone.command.animal.AnimalMoveNotify;
   import com.sunweb.game.rpg.worldZone.command.animal.AnimalUseSkillNotify;
   import com.sunweb.game.rpg.worldZone.command.animal.CommandCodePlayerAnimal;
   import com.sunweb.game.rpg.worldZone.command.animal.PlayerSetAnimalActionModeRequest;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class obf_1_R_3404
   {
      
      public function obf_1_R_3404()
      {
         super();
      }
      
      public static function sendAnimalActionModeChange(param1:int) : void
      {
         var _loc2_:PlayerSetAnimalActionModeRequest = new PlayerSetAnimalActionModeRequest();
         _loc2_.animalActionMode = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function dispatchCommand(param1:obf_C_m_1350, param2:Map) : void
      {
         var cmd:obf_C_m_1350 = param1;
         var map:Map = param2;
         try
         {
            if(cmd.code == CommandCodePlayerAnimal.ANIMAL_MOVE_NOTIFY)
            {
               obf_j_a_2365(cmd as AnimalMoveNotify,map);
            }
            else if(cmd.code == CommandCodePlayerAnimal.ANIMAL_USE_SKILL_NOTIFY)
            {
               obf_h_P_1252(cmd as AnimalUseSkillNotify);
            }
            else if(cmd.code == CommandCodePlayerAnimal.ANIMAL_HP_CHANGE_NOTIFY)
            {
               obf_0_8_b_692(cmd as AnimalHpChangeNotify);
            }
            else if(cmd.code == CommandCodePlayerAnimal.ANIMAL_ATTRIBUTES_CHANGE_NOTIFY)
            {
               obf_z_X_1887(cmd as AnimalAttributesChangeNotify);
            }
            else if(cmd.code == CommandCodePlayerAnimal.ANIMAL_ENTER_TRAINER_NOTIFY)
            {
               obf_f_G_2469(cmd as AnimalEnterMapAnswer);
            }
            else if(cmd.code == CommandCodePlayerAnimal.ANIMAL_BUFF_CHANGE_NOTIFY)
            {
               obf_0_0_R_438(cmd as AnimalBuffChangeNotify);
            }
         }
         catch(err:Error)
         {
            trace("Command Error:" + cmd.code + "\n" + err);
         }
      }
      
      private static function obf_j_a_2365(param1:AnimalMoveNotify, param2:Map) : void
      {
         if(!param2 || param1.mapId != param2.mapId)
         {
            return;
         }
         var _loc3_:obf_9_c_4534 = param2.animalSet.getObject(param1.animalId) as obf_9_c_4534;
         if(_loc3_)
         {
            _loc3_.doCommand(param1);
         }
      }
      
      private static function obf_h_P_1252(param1:AnimalUseSkillNotify) : void
      {
         var _loc2_:obf_Y_E_3667 = null;
         var _loc3_:MapInteractiveObject = null;
         var _loc4_:String = null;
         if(!GameContext.currentMap)
         {
            return;
         }
         if(obf_L_l_4100.isEmpty(param1.animalOwnerName) || param1.animalOwnerName == GameContext.localPlayer.id)
         {
            _loc2_ = GameContext.localPlayer;
         }
         else
         {
            _loc2_ = GameContext.currentMap.remotePlayerSet.getObject(param1.animalOwnerName) as obf_Y_E_3667;
         }
         if(Boolean(_loc2_) && Boolean(_loc2_.obf_F_o_1931))
         {
            if(_loc2_.obf_F_o_1931.isUsingSkill)
            {
               _loc2_.obf_F_o_1931.stopAction();
            }
            _loc3_ = GameContext.currentMap.getObjectById(param1.targetId);
            if(_loc3_)
            {
               _loc2_.obf_F_o_1931.useSkillOnObject(0,param1.skillCode,_loc3_,param1.singTime,param1.castTime);
            }
            else if(param1.targetPoint)
            {
               _loc2_.obf_F_o_1931.useSkillOnPoint(0,param1.skillCode,MapPoint.MapPointToPoint(param1.targetPoint),param1.singTime,param1.castTime);
            }
            else
            {
               _loc2_.obf_F_o_1931.useSkillOnObject(0,param1.skillCode,_loc2_.obf_F_o_1931,param1.singTime,param1.castTime);
            }
            if(_loc2_ == GameContext.localPlayer)
            {
               _loc4_ = SkillCDManager.getSkillCDFlag(param1.skillCode);
               SkillCDManager.setSkillCD(_loc4_,SkillCDManager.getSkillCDTime(param1.skillCode,1) + param1.singTime + param1.castTime,0);
            }
         }
      }
      
      private static function obf_0_8_b_692(param1:AnimalHpChangeNotify) : void
      {
         var _loc2_:obf_Y_E_3667 = null;
         var _loc3_:String = null;
         if(!GameContext.currentMap)
         {
            return;
         }
         if(obf_L_l_4100.isEmpty(param1.animalOwnerName) || param1.animalOwnerName == GameContext.localPlayer.id)
         {
            _loc2_ = GameContext.localPlayer;
            GameContext.localPlayer.doCommand(param1);
            obf_K_e_3075.obf_G_K_2049.setHp(param1.hpCurrent,param1.hpMax);
            obf_K_e_3075.animalBoxUI.setHp(param1.hpCurrent,param1.hpMax);
            _loc3_ = param1.isCriticalStrike ? obf_0_0_8_669.obf_v_e_4597 : obf_0_0_8_669.obf_o_0_932;
            if(Boolean(_loc2_.obf_F_o_1931) && param1.hpChanged == 0)
            {
               obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,_loc2_.obf_F_o_1931,"C_NumberDodge");
            }
         }
         else
         {
            _loc2_ = GameContext.currentMap.remotePlayerSet.getObject(param1.animalOwnerName) as obf_Y_E_3667;
            _loc3_ = param1.isCriticalStrike ? obf_0_0_8_669.obf_w_d_3136 : obf_0_0_8_669.obf_F_F_4169;
            if(Boolean(_loc2_.obf_F_o_1931) && param1.hpChanged == 0)
            {
               obf_0_9_V_473.showEffectOnObject(GameContext.currentMap,_loc2_.obf_F_o_1931,"C_NumberMiss");
            }
            _loc2_.obf_F_o_1931.animalInfull.animalAtr.hp = param1.hpCurrent;
         }
         if(_loc2_.obf_F_o_1931)
         {
            if(param1.hpChanged < 0)
            {
               _loc2_.obf_F_o_1931.showNumberEffect(Math.abs(param1.hpChanged),_loc3_);
            }
            else if(param1.hpChanged > 0)
            {
               _loc2_.obf_F_o_1931.showNumberEffect(param1.hpChanged,obf_0_0_8_669.obf_0___1_276);
            }
            if(GameContext.localPlayer.obf_0_6_a_430 == _loc2_.obf_F_o_1931)
            {
               obf_K_e_3075.targetInfoUI.setHpPercent(_loc2_.obf_F_o_1931.animalInfull.animalAtr.hpPercent);
            }
         }
      }
      
      private static function obf_z_X_1887(param1:AnimalAttributesChangeNotify) : void
      {
         if(!GameContext.localPlayer.obf_F_o_1931 || !GameContext.localPlayer.trainerFullInfo)
         {
            return;
         }
         obf_K_e_3075.animalBoxUI.updataAttrAnimal(param1.animal);
      }
      
      private static function obf_f_G_2469(param1:AnimalEnterMapAnswer) : void
      {
         if(!GameContext.localPlayer.obf_F_o_1931 || !GameContext.localPlayer.trainerFullInfo || !GameContext.currentMap)
         {
            return;
         }
         GameContext.localPlayer.trainerFullInfo.x = param1.toPosition.x;
         GameContext.localPlayer.trainerFullInfo.y = param1.toPosition.y;
         GameContext.localPlayer.obf_F_o_1931.moveToPixel(param1.toPosition.x,param1.toPosition.y);
      }
      
      public static function getColor(param1:int) : uint
      {
         var _loc2_:uint = 0;
         if(param1 > 5)
         {
            _loc2_ = uint(obf_0_3_0_538.obf_P_E_4108);
         }
         else if(param1 > 4)
         {
            _loc2_ = uint(obf_0_3_0_538.obf_T_N_2235);
         }
         else if(param1 > 3)
         {
            _loc2_ = uint(obf_0_3_0_538.obf_I_Z_1269);
         }
         else if(param1 > 2)
         {
            _loc2_ = uint(obf_0_3_0_538.obf_W_x_3750);
         }
         else if(param1 > 1)
         {
            _loc2_ = uint(obf_0_3_0_538.obf_o_2_4266);
         }
         else if(param1 > 0)
         {
            _loc2_ = uint(obf_0_3_0_538.ITEM_RANK_NOMAL);
         }
         else
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      private static function obf_0_0_R_438(param1:AnimalBuffChangeNotify) : void
      {
         var _loc2_:obf_Y_E_3667 = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:BuffInfo = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         if(!GameContext.currentMap)
         {
            return;
         }
         if(obf_L_l_4100.isEmpty(param1.animalOwnerName) || param1.animalOwnerName == GameContext.localPlayer.id)
         {
            _loc2_ = GameContext.localPlayer;
         }
         else
         {
            _loc2_ = GameContext.currentMap.remotePlayerSet.getObject(param1.animalOwnerName) as obf_Y_E_3667;
         }
         if(Boolean(_loc2_) && Boolean(_loc2_.obf_F_o_1931))
         {
            _loc3_ = GameContext.localPlayer.obf_0_6_a_430 == _loc2_.obf_F_o_1931;
            for each(_loc4_ in param1.buffsRemoved)
            {
               _loc6_ = BuffManager.getBuffConfigById(_loc4_);
               if(_loc6_)
               {
                  if(!_loc6_.isDebuff)
                  {
                     _loc2_.obf_F_o_1931.removeBuffInfo(_loc4_);
                     if(Boolean(obf_K_e_3075.targetInfoUI) && Boolean(_loc3_) && _loc2_ != GameContext.localPlayer)
                     {
                        obf_K_e_3075.targetInfoUI.buffUI.removeBuff(_loc4_);
                     }
                     if(Boolean(obf_K_e_3075.obf_G_K_2049) && _loc2_ == GameContext.localPlayer)
                     {
                        obf_K_e_3075.obf_G_K_2049.buffUI.removeBuff(_loc4_);
                     }
                  }
                  else
                  {
                     _loc2_.obf_F_o_1931.removeDebuffInfo(_loc4_);
                     if(Boolean(obf_K_e_3075.targetInfoUI) && Boolean(_loc3_) && _loc2_ != GameContext.localPlayer)
                     {
                        obf_K_e_3075.targetInfoUI.debuffUI.removeBuff(_loc4_);
                     }
                     if(Boolean(obf_K_e_3075.obf_G_K_2049) && _loc2_ == GameContext.localPlayer)
                     {
                        obf_K_e_3075.obf_G_K_2049.debuffUI.removeBuff(_loc4_);
                     }
                  }
               }
            }
            for each(_loc5_ in param1.buffsAdded)
            {
               _loc7_ = BuffManager.getBuffConfigById(_loc5_.buffId);
               if(_loc7_)
               {
                  if(!_loc7_.isDebuff)
                  {
                     _loc2_.obf_F_o_1931.obf_a_8_4261(_loc5_);
                     if(Boolean(obf_K_e_3075.targetInfoUI) && Boolean(_loc3_) && _loc2_ != GameContext.localPlayer)
                     {
                        obf_K_e_3075.targetInfoUI.buffUI.addBuff(_loc5_);
                     }
                     if(Boolean(obf_K_e_3075.obf_G_K_2049) && _loc2_ == GameContext.localPlayer)
                     {
                        obf_K_e_3075.obf_G_K_2049.buffUI.addBuff(_loc5_);
                     }
                  }
                  else
                  {
                     _loc2_.obf_F_o_1931.obf_i_b_872(_loc5_);
                     if(Boolean(obf_K_e_3075.targetInfoUI) && Boolean(_loc3_) && _loc2_ != GameContext.localPlayer)
                     {
                        obf_K_e_3075.targetInfoUI.debuffUI.addBuff(_loc5_);
                     }
                     if(Boolean(obf_K_e_3075.obf_G_K_2049) && _loc2_ == GameContext.localPlayer)
                     {
                        obf_K_e_3075.obf_G_K_2049.debuffUI.addBuff(_loc5_);
                     }
                  }
               }
            }
         }
      }
   }
}

