package com.sunweb.game.rpg.armory
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.iconItem.IconItem;
   import com.sunweb.game.rpg.iconItem.IconItemManager;
   import com.sunweb.game.rpg.playerBag.obf_a_f_2935;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.worldZone.command.armory.ArmoryPropertyNotify;
   import com.sunweb.game.rpg.worldZone.command.armory.ArmoryRemoveRequest;
   import com.sunweb.game.rpg.worldZone.command.armory.ArmoryUpgradeAnswer;
   import com.sunweb.game.rpg.worldZone.command.armory.ArmoryUpgradeNotify;
   import com.sunweb.game.rpg.worldZone.command.armory.ArmoryUpgrageRequest;
   import com.sunweb.game.rpg.worldZone.command.armory.CommandCodeArmory;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_S_M_1257
   {
      
      private static var obf_x_3_1372:uint;
      
      private static var obf_0_5_G_291:Array;
      
      private static var obf_s_M_2736:uint;
      
      private static var armoryConfig:Object;
      
      public function obf_S_M_1257()
      {
         super();
      }
      
      public static function get obf_r_M_3661() : uint
      {
         if(Boolean(GameContext.localPlayer) && Boolean(GameContext.localPlayer.fullInfo.armoryGridInfo))
         {
            return GameContext.localPlayer.fullInfo.armoryExp;
         }
         return 0;
      }
      
      public static function set obf_r_M_3661(param1:uint) : void
      {
         obf_s_M_2736 = param1;
      }
      
      public static function get obf_h_D_2022() : Array
      {
         if(Boolean(GameContext.localPlayer) && Boolean(GameContext.localPlayer.fullInfo.armoryGridInfo))
         {
            return GameContext.localPlayer.fullInfo.armoryGridInfo;
         }
         return [];
      }
      
      public static function set obf_h_D_2022(param1:Array) : void
      {
         obf_0_5_G_291 = param1;
      }
      
      public static function get obf_U_n_2740() : uint
      {
         if(GameContext.localPlayer)
         {
            return GameContext.localPlayer.fullInfo.armoryLevel;
         }
         return 0;
      }
      
      public static function set obf_U_n_2740(param1:uint) : void
      {
         obf_x_3_1372 = param1;
      }
      
      public static function init(param1:Object) : void
      {
         armoryConfig = param1;
      }
      
      public static function getConfigValue(... rest) : *
      {
         return JSONUtil.getObject(armoryConfig,rest);
      }
      
      public static function getUpGradeConfig(param1:uint) : Object
      {
         var _loc4_:Object = null;
         var _loc2_:Array = getConfigValue("armoryUpgrade") as Array;
         var _loc3_:uint = param1 + 1;
         for each(_loc4_ in _loc2_)
         {
            if(_loc4_.armoryLevel == _loc3_)
            {
               return _loc4_;
            }
         }
         return null;
      }
      
      public static function getArmoryNameByLvl(param1:uint) : String
      {
         var _loc2_:Object = getUpGradeConfig(param1 - 1);
         if(_loc2_)
         {
            return _loc2_.armoryName;
         }
         return "";
      }
      
      public static function getNeedItems(param1:Object) : Array
      {
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:IconItem = null;
         var _loc7_:uint = 0;
         if(!param1)
         {
            return [];
         }
         var _loc2_:Array = new Array();
         var _loc3_:Object = param1.armoryTerm;
         if(!_loc3_)
         {
            return [];
         }
         if(_loc3_.hasOwnProperty("equalItemsInBag"))
         {
            _loc4_ = _loc3_.equalItemsInBag;
            for(_loc5_ in _loc4_)
            {
               _loc6_ = IconItemManager.getIconItemByCode(_loc5_,"");
               _loc7_ = uint(_loc4_[_loc5_]);
               _loc6_.itemCount = _loc7_;
               _loc2_.push(_loc6_);
            }
         }
         return _loc2_;
      }
      
      public static function getNeedMaigicVal(param1:Object) : uint
      {
         if(!param1)
         {
            return 0;
         }
         var _loc2_:Object = param1.armoryTerm;
         if(!_loc2_)
         {
            return 0;
         }
         var _loc3_:uint = 0;
         if(_loc2_.hasOwnProperty("sp>="))
         {
            _loc3_ = uint(_loc2_["sp>="]);
         }
         return _loc3_;
      }
      
      public static function getNeedGoldBank(param1:Object) : Array
      {
         if(!param1)
         {
            return [];
         }
         var _loc2_:Object = param1.armoryTerm;
         if(!_loc2_)
         {
            return [];
         }
         var _loc3_:uint = 0;
         if(_loc2_.hasOwnProperty("gold>="))
         {
            _loc3_ = uint(_loc2_["gold>="]);
         }
         return obf_a_f_2935.getGoldRank(_loc3_);
      }
      
      public static function getEquipConfig() : Array
      {
         return getConfigValue("armoryEquip") as Array;
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         var _loc2_:ArmoryUpgradeAnswer = null;
         var _loc3_:ArmoryPropertyNotify = null;
         var _loc4_:ArmoryUpgradeNotify = null;
         switch(param1.code)
         {
            case CommandCodeArmory.PLAYER_ARMORY_UPGRADE_ANSWER:
               _loc2_ = param1 as ArmoryUpgradeAnswer;
               GameContext.localPlayer.fullInfo.armoryExp = _loc2_.armoryExp;
               obf_K_e_3075.armoryUpgradeUI.expChange(_loc2_.armoryExp,getArmoryNeedMaxExp(obf_U_n_2740));
               break;
            case CommandCodeArmory.PLAYER_ARMORY_PROPERTY_NOTIFY:
               _loc3_ = param1 as ArmoryPropertyNotify;
               obf_K_e_3075.armoryUpgradeUI.showArmoryEquip(_loc3_.changedArmorys);
               break;
            case CommandCodeArmory.PLAYER_ARMORY_UPGRADE_NOTIFY:
               _loc4_ = param1 as ArmoryUpgradeNotify;
               GameContext.localPlayer.fullInfo.armoryLevel = _loc4_.armoryLevel;
               GameContext.localPlayer.fullInfo.armoryGridInfo = _loc4_.opendArmoryGrids;
               obf_K_e_3075.armoryUpgradeUI.upDataArmoryBase();
         }
      }
      
      public static function sendArmoryUpgradeExp() : void
      {
         var _loc1_:ArmoryUpgrageRequest = new ArmoryUpgrageRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendArmoryRemove(param1:String, param2:int = -1) : void
      {
         var _loc3_:ArmoryRemoveRequest = new ArmoryRemoveRequest();
         _loc3_.gridToMCName = param1;
         _loc3_.toBagItemIndex = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function getArmoryNeedMaxExp(param1:uint) : int
      {
         var _loc2_:Object = getUpGradeConfig(param1);
         if(_loc2_)
         {
            return _loc2_.armoryUpgradeExp;
         }
         return 0;
      }
      
      public static function obf_a_3592(param1:Boolean = false) : Boolean
      {
         var _loc2_:Object = getConfigValue("armoryOpenTerm");
         if(!_loc2_)
         {
            return false;
         }
         if(!ConditionScript.checkCondition(_loc2_.armoryDefTerm,null,param1))
         {
            return false;
         }
         if(obf_U_n_2740 <= 0)
         {
            sendArmoryUpgradeExp();
         }
         return true;
      }
      
      public static function obf_9_N_2822(param1:Object, param2:Boolean = true) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(!ConditionScript.checkCondition(param1.armoryTerm,null,param2))
         {
            return false;
         }
         return true;
      }
   }
}

