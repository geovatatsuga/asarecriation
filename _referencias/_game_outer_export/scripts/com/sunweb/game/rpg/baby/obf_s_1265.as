package com.sunweb.game.rpg.baby
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.worldZone.command.baby.CommandCodeBaby;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyBloodUpAnswer;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyBloodUpRequest;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyBuyAttrMaxAnswer;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyBuyAttrMaxRequest;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyBuyCollegeRequest;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyEatAnswer;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyEatRequest;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyFastLearnRequest;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyFoodNotify;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyLevelAttrNotify;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyResetLuckLandRequest;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyStudyAnswer;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyStudyOverRequest;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyStudyRequest;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyTravelAnswer;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyTravelFastRequest;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyTravelOverRequest;
   import com.sunweb.game.rpg.worldZone.command.baby.PlayerBabyTravelRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_s_1265
   {
      
      private static var babyConfig:Object;
      
      public function obf_s_1265()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         babyConfig = param1;
      }
      
      public static function getBabyLevelConfig(param1:int) : Object
      {
         var _loc2_:Array = JSONUtil.getValue(babyConfig,["levelConfig"]) as Array;
         return _loc2_[param1 - 1];
      }
      
      public static function getMaterialCode() : String
      {
         var _loc2_:String = null;
         var _loc1_:Object = JSONUtil.getValue(babyConfig,["eatMap"]) as Object;
         var _loc3_:int = 0;
         var _loc4_:* = _loc1_;
         for(_loc2_ in _loc4_)
         {
            return _loc2_;
         }
         return null;
      }
      
      public static function getCollegeConfig() : Object
      {
         return JSONUtil.getValue(babyConfig,["collegeConfig"]) as Object;
      }
      
      public static function obf_Z_x_4178() : Boolean
      {
         var _loc1_:Object = JSONUtil.getValue(babyConfig,["openContion"]) as Object;
         if(!ConditionScript.checkCondition(_loc1_,null,true))
         {
            return false;
         }
         return true;
      }
      
      public static function getRandomConfig() : Object
      {
         return JSONUtil.getValue(babyConfig,["randomConfig"]) as Object;
      }
      
      public static function getTravelConfig() : Object
      {
         return JSONUtil.getValue(babyConfig,["travelConfig"]) as Object;
      }
      
      public static function getBloodConfig() : Object
      {
         return JSONUtil.getValue(babyConfig,["bloodConfig"]) as Object;
      }
      
      public static function getBuyAttr() : Object
      {
         return JSONUtil.getValue(babyConfig,["buyAttr"]) as Object;
      }
      
      public static function sendBabyEatRequest(param1:String) : void
      {
         var _loc2_:PlayerBabyEatRequest = new PlayerBabyEatRequest();
         _loc2_.itemCode = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendBabyBuyAttrMaxRequest(param1:int) : void
      {
         var _loc2_:PlayerBabyBuyAttrMaxRequest = new PlayerBabyBuyAttrMaxRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendBabyStudyRequest(param1:int, param2:int) : void
      {
         var _loc3_:PlayerBabyStudyRequest = new PlayerBabyStudyRequest();
         _loc3_.type = param1;
         _loc3_.area = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendBabyStudyOverRequest(param1:int, param2:int) : void
      {
         var _loc3_:PlayerBabyStudyOverRequest = new PlayerBabyStudyOverRequest();
         _loc3_.type = param1;
         _loc3_.area = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendBabyResetLuckLandRequest() : void
      {
         var _loc1_:PlayerBabyResetLuckLandRequest = new PlayerBabyResetLuckLandRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendTravelFastRequest() : void
      {
         var _loc1_:PlayerBabyTravelFastRequest = new PlayerBabyTravelFastRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendBabyTravelOverRequest() : void
      {
         var _loc1_:PlayerBabyTravelOverRequest = new PlayerBabyTravelOverRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function senBabyTravelRequest() : void
      {
         var _loc1_:PlayerBabyTravelRequest = new PlayerBabyTravelRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendBabyBloodUpRequest() : void
      {
         var _loc1_:PlayerBabyBloodUpRequest = new PlayerBabyBloodUpRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendBabyBuyCollegeRequest() : void
      {
         var _loc1_:PlayerBabyBuyCollegeRequest = new PlayerBabyBuyCollegeRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendBabyFastLearnRequest() : void
      {
         var _loc1_:PlayerBabyFastLearnRequest = new PlayerBabyFastLearnRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeBaby.PLAYER_BABY_INFO_NOTIFY)
         {
            obf_0_9_C_547(param1 as PlayerBabyInfoNotify);
            obf_K_e_3075.obf_7_S_4368.showData((param1 as PlayerBabyInfoNotify).babyInfo);
         }
         else if(param1.code == CommandCodeBaby.PLAYER_BABY_EAT_ANSWER)
         {
            obf_K_e_3075.obf_7_S_4368.obf_0_0_l_635((param1 as PlayerBabyEatAnswer).foodValue);
         }
         else if(param1.code == CommandCodeBaby.PLAYER_BABY_LV_AT_NOTIFY)
         {
            obf_K_e_3075.obf_7_S_4368.obf_y_J_818(param1 as PlayerBabyLevelAttrNotify);
         }
         else if(param1.code == CommandCodeBaby.PLAYER_BABY_STUDY_ANSWER)
         {
            obf_K_e_3075.obf_y_X_2167.getStopTime((param1 as PlayerBabyStudyAnswer).studyOver);
            obf_K_e_3075.obf_R_v_3742.reshShow((param1 as PlayerBabyStudyAnswer).collegeMap);
            obf_K_e_3075.obf_R_v_3742.reshAreaTime((param1 as PlayerBabyStudyAnswer).studyOver,(param1 as PlayerBabyStudyAnswer).collegeMap);
            obf_K_e_3075.systemListUI.obf_Y_P_3051((param1 as PlayerBabyStudyAnswer).studyOver);
         }
         else if(param1.code == CommandCodeBaby.PLAYER_BABY_TRAVEL_ANSWER)
         {
            obf_0_7_z_333(param1 as PlayerBabyTravelAnswer);
         }
         else if(param1.code == CommandCodeBaby.PLAYER_BABY_BLOOD_UP_ANSWER)
         {
            obf_5_7_3978(param1 as PlayerBabyBloodUpAnswer);
         }
         else if(param1.code == CommandCodeBaby.PLAYER_BABY_FOOD_NOTIFY)
         {
            obf_K_e_3075.obf_7_S_4368.obf_0_0_l_635((param1 as PlayerBabyFoodNotify).foodValue);
         }
         else if(param1.code == CommandCodeBaby.PLAYER_BABY_BUY_ATTR_MAX_ANSWER)
         {
            obf_K_e_3075.obf_7_S_4368.obf_V_x_2326(param1 as PlayerBabyBuyAttrMaxAnswer);
         }
      }
      
      private static function obf_0_9_C_547(param1:PlayerBabyInfoNotify) : void
      {
         var _loc2_:BabyInfo = param1.babyInfo;
         obf_K_e_3075.obf_y_X_2167.getStopTime(_loc2_.studyOver);
         obf_K_e_3075.worldUI.obf_9_U_906(_loc2_.luckLand,_loc2_.travelLand,_loc2_.travelOver);
         obf_K_e_3075.obf_R_v_3742.reshShow(_loc2_.collegeMap);
         obf_K_e_3075.obf_R_v_3742.reshAreaTime(_loc2_.studyOver,_loc2_.collegeMap);
         obf_K_e_3075.obf_g_7_4476.showData(_loc2_.bloodLevel,_loc2_.bloodExp);
         obf_K_e_3075.systemListUI.obf_Y_P_3051(_loc2_.studyOver);
         obf_K_e_3075.systemListUI.obf_0___E_374(_loc2_.travelOver,_loc2_.travelLand);
      }
      
      private static function obf_0_7_z_333(param1:PlayerBabyTravelAnswer) : void
      {
         obf_K_e_3075.worldUI.obf_9_U_906(param1.luckLand,param1.travelLand,param1.travelOver);
         obf_K_e_3075.systemListUI.obf_0___E_374(param1.travelOver,param1.travelLand);
      }
      
      private static function obf_5_7_3978(param1:PlayerBabyBloodUpAnswer) : void
      {
         obf_K_e_3075.obf_g_7_4476.showData(param1.bloodLevel,param1.bloodExp);
      }
   }
}

