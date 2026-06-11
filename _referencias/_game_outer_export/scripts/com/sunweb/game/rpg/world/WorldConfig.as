package com.sunweb.game.rpg.world
{
   import com.sunweb.game.utils.JSONUtil;
   
   public class WorldConfig
   {
      
      private static var resListMap:Object;
      
      private static var worldConfig:Object;
      
      public static const MAX_NPC_TALK_DISTANCE:int = 150;
      
      public static const MAX_PICK_UP_ITEM_DISTANCE:int = 350;
      
      public static const obf_J_9_4148:int = 300;
      
      public static const MAX_DROP_ITEM_DISTANCE:int = 500;
      
      public static const MAX_PASSIVE_RIDE_DISTANCE:int = 200;
      
      public static var obf_j_U_2460:int = 6;
      
      public static var obf_0_z_1933:int = 8;
      
      public static var obf_s_1_2952:int = 8;
      
      public static var obf_B_1_3500:int = 6;
      
      public static var obf_G_H_2802:int = 6;
      
      public static var obf_P_7_1927:int = 6;
      
      public static var obf_6_r_3938:int = 6;
      
      public static var obf_K_L_4278:int = 15000;
      
      private static var obf_1_6_3127:Array = ["xj1","xj2","xj3","xj4","xj5","xj6","xj7"];
      
      public function WorldConfig()
      {
         super();
      }
      
      public static function initResList(param1:Array) : void
      {
         var _loc2_:Object = null;
         if(!param1)
         {
            return;
         }
         resListMap = new Object();
         for each(_loc2_ in param1)
         {
            resListMap[_loc2_.groupId] = _loc2_;
         }
      }
      
      public static function getResList(param1:String) : Array
      {
         return JSONUtil.getObject(resListMap,[param1,"resList"]) as Array;
      }
      
      public static function init(param1:Object) : void
      {
         worldConfig = param1;
         obf_j_U_2460 = JSONUtil.getInt(worldConfig,["wordLength","maxRoleNameLength"],6);
         obf_0_z_1933 = JSONUtil.getInt(worldConfig,["wordLength","maxFarmNameLength"],6);
         obf_s_1_2952 = JSONUtil.getInt(worldConfig,["wordLength","maxTeamNameLength"],6);
         obf_B_1_3500 = JSONUtil.getInt(worldConfig,["wordLength","maxFamilyNameLength"],6);
         obf_G_H_2802 = JSONUtil.getInt(worldConfig,["wordLength","maxFamilyPostNameLength"],6);
         obf_P_7_1927 = JSONUtil.getInt(worldConfig,["wordLength","maxFamilyTitleLength"],6);
         obf_6_r_3938 = JSONUtil.getInt(worldConfig,["wordLength","maxPetNameLength"],6);
      }
      
      public static function getStringSetting(param1:String) : String
      {
         if(worldConfig)
         {
            return worldConfig[param1] || "";
         }
         return "";
      }
      
      public static function getNumberSetting(param1:String) : Number
      {
         if(worldConfig)
         {
            return Number(worldConfig[param1]) || 0;
         }
         return 0;
      }
      
      public static function getObjectSetting(param1:String) : Object
      {
         if(worldConfig)
         {
            return worldConfig[param1];
         }
         return null;
      }
      
      public static function getValue(... rest) : *
      {
         return JSONUtil.getObject(worldConfig,rest);
      }
      
      public static function getDefaultAttackSkillCode(param1:int) : String
      {
         return obf_1_6_3127[param1];
      }
      
      public static function getCatchPetSkillCode() : String
      {
         return JSONUtil.getStr(worldConfig,["skillConfig","catchPetSkill"]);
      }
      
      public static function getCoefficient(param1:String) : Number
      {
         return JSONUtil.getNumber(worldConfig,["coefficients",param1]);
      }
   }
}

