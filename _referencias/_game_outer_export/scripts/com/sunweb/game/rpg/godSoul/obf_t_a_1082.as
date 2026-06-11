package com.sunweb.game.rpg.godSoul
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemCDManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.lifeJob.LifeJobCode;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.playerUI.playerInfo.obf_W_l_2992;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.rpg.worldZone.command.player.godSoul.CommandPlayerGodSoul;
   import com.sunweb.game.rpg.worldZone.command.player.godSoul.GodSoulAddEquipmentRequest;
   import com.sunweb.game.rpg.worldZone.command.player.godSoul.GodSoulEquipmentNotify;
   import com.sunweb.game.rpg.worldZone.command.player.godSoul.GodSoulInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.player.godSoul.GodSoulRemoveEquipmentRequest;
   import com.sunweb.game.rpg.worldZone.command.player.godSoul.GodSoulUpLevelRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_t_a_1082
   {
      
      private static var _goulConfig:Object;
      
      public function obf_t_a_1082()
      {
         super();
      }
      
      public static function get goulConfig() : Object
      {
         return _goulConfig;
      }
      
      public static function set goulConfig(param1:Object) : void
      {
         _goulConfig = param1;
      }
      
      public static function getStuffNum(param1:int, param2:int) : int
      {
         if(param2 == obf_W_l_2992.obf_C_X_4367)
         {
            return param1 < 1 || param1 > _goulConfig.skySoul.num.length ? 0 : int(_goulConfig.skySoul.num[param1 - 1]);
         }
         if(param2 == obf_W_l_2992.obf_0_3_N_708)
         {
            return param1 < 1 || param1 > _goulConfig.terraSoul.num.length ? 0 : int(_goulConfig.terraSoul.num[param1 - 1]);
         }
         if(param2 == obf_W_l_2992.obf_i_q_2098)
         {
            return param1 < 1 || param1 > _goulConfig.deitySoul.num.length ? 0 : int(_goulConfig.deitySoul.num[param1 - 1]);
         }
         return 0;
      }
      
      public static function getSuffCode() : String
      {
         return JSONUtil.getValue(_goulConfig,["itemCode"]);
      }
      
      public static function getPlayerLevelNumber(param1:int, param2:int) : uint
      {
         if(param2 == obf_W_l_2992.obf_C_X_4367)
         {
            return param1 < 1 || param1 > _goulConfig.skySoul.expList.length ? 0 : uint(_goulConfig.skySoul.expList[param1 - 1]);
         }
         if(param2 == obf_W_l_2992.obf_0_3_N_708)
         {
            return param1 < 1 || param1 > _goulConfig.terraSoul.expList.length ? 0 : uint(_goulConfig.terraSoul.expList[param1 - 1]);
         }
         if(param2 == obf_W_l_2992.obf_i_q_2098)
         {
            return param1 < 1 || param1 > _goulConfig.deitySoul.expList.length ? 0 : uint(_goulConfig.deitySoul.expList[param1 - 1]);
         }
         return 0;
      }
      
      public static function getPlayerLevelNum(param1:int) : int
      {
         if(param1 == obf_W_l_2992.obf_C_X_4367)
         {
            return _goulConfig.skySoul.expList.length - 2;
         }
         if(param1 == obf_W_l_2992.obf_0_3_N_708)
         {
            return _goulConfig.terraSoul.expList.length - 2;
         }
         return 0;
      }
      
      public static function obf_D_n_3089(param1:String, param2:int, param3:Boolean = false) : Boolean
      {
         var _loc4_:Object = GameItemManager.getItemConfig(param1);
         if(!_loc4_ || !GameContext.localPlayer)
         {
            return false;
         }
         if(GameContext.localPlayer.isDead)
         {
            if(param3)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_Died"));
            }
            return false;
         }
         if(GameItemCDManager.checkItemCD(GameItemManager.getItemCDFlag(param1)))
         {
            if(param3)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_CD"));
            }
            return false;
         }
         if(_loc4_.playerLevel != null && obf_K_e_3075.obf_J_K_2135.getLv(param2) < _loc4_.playerLevel)
         {
            if(param3)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_SoulLevel",[_loc4_.playerLevel,obf_W_l_2992.getSoulName(param2)]));
            }
            return false;
         }
         if(_loc4_.honorLevel != null && GameContext.localPlayer.fullInfo.honorLevel < _loc4_.honorLevel)
         {
            if(param3)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_HonorLevel",[NumberConfig.getHonorLevelName(_loc4_.honorLevel)]));
            }
            return false;
         }
         if(_loc4_.playerSex != null && _loc4_.playerSex > -1 && _loc4_.playerSex != GameContext.localPlayer.fullInfo.sex)
         {
            if(param3)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_Sex",[_loc4_.playerSex == 0 ? DiversityManager.getString("EquipmentAttribute","woman") : DiversityManager.getString("EquipmentAttribute","man")]));
            }
            return false;
         }
         if(_loc4_.playerJob != null && _loc4_.playerJob.length > 0 && _loc4_.playerJob.indexOf(GameContext.localPlayer.fullInfo.jobCode) == -1)
         {
            if(param3)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_Job"));
            }
            return false;
         }
         if(_loc4_.playerLifeJob != null && _loc4_.playerLifeJob.length > 0 && GameContext.localPlayer.fullInfo.lifeJob != _loc4_.playerLifeJob)
         {
            if(param3)
            {
               obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_LifeJob",[LifeJobCode.getLifeJobName(_loc4_.playerLifeJob)]));
            }
            return false;
         }
         if(_loc4_.playerLifeLevel != null)
         {
            if(GameContext.localPlayer.fullInfo.lifeJob == 0 || GameContext.localPlayer.fullInfo.lifeLevel < _loc4_.playerLifeLevel)
            {
               if(param3)
               {
                  obf_K_e_3075.showTipInfo(DiversityManager.getString("ItemPrompt","useItemError_LifeLevel",[LifeJobCode.getLifeJobRankName(_loc4_.playerLifeLevel)]));
               }
               return false;
            }
         }
         return true;
      }
      
      public static function sendLvUP(param1:int) : void
      {
         var _loc2_:GodSoulUpLevelRequest = new GodSoulUpLevelRequest();
         _loc2_.soulType = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendSetEquip(param1:int, param2:int) : void
      {
         var _loc3_:GodSoulAddEquipmentRequest = new GodSoulAddEquipmentRequest();
         _loc3_.itemIndex = param1;
         _loc3_.soulType = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendRemoveEquip(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:GodSoulRemoveEquipmentRequest = new GodSoulRemoveEquipmentRequest();
         _loc4_.equipmentKind = param1;
         _loc4_.soulType = param2;
         _loc4_.toBagItemIndex = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandPlayerGodSoul.GOD_SOUL_EQUIPMENT_NOTIFY)
         {
            obf_I_1_1322(param1 as GodSoulEquipmentNotify);
         }
         else if(param1.code == CommandPlayerGodSoul.GOD_SOUL_INFO_NOTIFY)
         {
            obf_R_K_1488(param1 as GodSoulInfoNotify);
         }
      }
      
      private static function obf_I_1_1322(param1:GodSoulEquipmentNotify) : void
      {
         if(obf_K_e_3075.obf_J_K_2135)
         {
            obf_K_e_3075.obf_J_K_2135.setAllEquip(param1);
         }
      }
      
      private static function obf_R_K_1488(param1:GodSoulInfoNotify) : void
      {
         if(param1.soulType == 0)
         {
            obf_K_e_3075.obf_J_K_2135.skyLv = param1.skySoulLevel;
            obf_K_e_3075.obf_J_K_2135.terraLv = param1.terraSoulLevel;
            obf_K_e_3075.obf_J_K_2135.godLv = param1.deitySoulLevel;
            obf_K_e_3075.obf_J_K_2135.skyAttr = param1.skySoulAtrr;
            obf_K_e_3075.obf_J_K_2135.obf_9_4630 = param1.terraSoulAttr;
            obf_K_e_3075.obf_J_K_2135.obf_p_1_3777 = param1.deitySoulAttr;
            obf_K_e_3075.obf_J_K_2135.setMind(2);
         }
         else if(param1.soulType == 1)
         {
            obf_K_e_3075.obf_J_K_2135.skyLv = param1.skySoulLevel;
            obf_K_e_3075.obf_J_K_2135.skyAttr = param1.skySoulAtrr;
            obf_K_e_3075.obf_J_K_2135.setMind(1);
         }
         else if(param1.soulType == 2)
         {
            obf_K_e_3075.obf_J_K_2135.terraLv = param1.terraSoulLevel;
            obf_K_e_3075.obf_J_K_2135.obf_9_4630 = param1.terraSoulAttr;
            obf_K_e_3075.obf_J_K_2135.setMind(2);
         }
         else if(param1.soulType == 3)
         {
            obf_K_e_3075.obf_J_K_2135.godLv = param1.deitySoulLevel;
            obf_K_e_3075.obf_J_K_2135.obf_p_1_3777 = param1.deitySoulAttr;
            obf_K_e_3075.obf_J_K_2135.setMind(3);
         }
      }
   }
}

