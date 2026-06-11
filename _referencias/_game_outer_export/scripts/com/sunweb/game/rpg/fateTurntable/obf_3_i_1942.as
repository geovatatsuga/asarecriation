package com.sunweb.game.rpg.fateTurntable
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.worldZone.command.fateTurntable.CommandCodeFateTurntable;
   import com.sunweb.game.rpg.worldZone.command.fateTurntable.FateTurntableInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.fateTurntable.FateTurntableValueNotify;
   import com.sunweb.game.rpg.worldZone.command.fateTurntable.FateUpLevelAnswer;
   import com.sunweb.game.rpg.worldZone.command.fateTurntable.FateUpLevelRequest;
   import com.sunweb.game.rpg.worldZone.command.fateTurntable.StartTurntableAnswer;
   import com.sunweb.game.rpg.worldZone.command.fateTurntable.StartTurntableRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_3_i_1942
   {
      
      private static var _fateTurntableConfig:Object;
      
      private static var obf_C_c_3220:Array;
      
      private static var $freeDayTimes:String = "$fateTurn";
      
      public function obf_3_i_1942()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         _fateTurntableConfig = new Object();
         _fateTurntableConfig = param1;
         getAllFateArr();
      }
      
      public static function get fateTurntableConfig() : Object
      {
         return _fateTurntableConfig;
      }
      
      public static function get freeDayTimes() : int
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter($freeDayTimes);
         var _loc2_:Object = JSONUtil.getValue(fateTurntableConfig,"turnConfig");
         return JSONUtil.getInt(_loc2_,["freeInDay"]) - JSONUtil.getInt(_loc1_,["numOfDay"]);
      }
      
      public static function get allFateArr() : Array
      {
         return obf_C_c_3220;
      }
      
      public static function getAllFateArr() : void
      {
         var _loc1_:Array = new Array();
         var _loc2_:Array = JSONUtil.getValue(fateTurntableConfig,"month") as Array;
         var _loc3_:Array = JSONUtil.getValue(fateTurntableConfig,"day") as Array;
         var _loc4_:Array = JSONUtil.getValue(fateTurntableConfig,"time") as Array;
         obf_C_c_3220 = _loc1_.concat(_loc2_,_loc3_,_loc4_);
      }
      
      public static function sendFateUpLevelRequest(param1:int) : void
      {
         var _loc2_:FateUpLevelRequest = new FateUpLevelRequest();
         _loc2_.id = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendStartTurntableRequest() : void
      {
         var _loc1_:StartTurntableRequest = new StartTurntableRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeFateTurntable.START_TURNTABLE_ANSWER)
         {
            obf_K_e_3075.obf_P_2_4217.onStart((param1 as StartTurntableAnswer).result);
            obf_K_e_3075.obf_P_2_4217.obf_0_1_U_421((param1 as StartTurntableAnswer).fateValue);
         }
         else if(param1.code == CommandCodeFateTurntable.FATE_UP_LEVEL_ANSWER)
         {
            obf_K_e_3075.obf_P_2_4217.obf_0_1_U_421((param1 as FateUpLevelAnswer).fateValue);
            obf_K_e_3075.obf_P_2_4217.getMoulageArr((param1 as FateUpLevelAnswer).fateList);
         }
         else if(param1.code == CommandCodeFateTurntable.FATE_TURNTABLE_VALUE_NOTIFY)
         {
            obf_K_e_3075.obf_P_2_4217.obf_0_1_U_421((param1 as FateTurntableValueNotify).fateValue);
         }
         else if(param1.code == CommandCodeFateTurntable.FATE_TURNTABLE_INFO_NOTIFY)
         {
            obf_K_e_3075.obf_P_2_4217.refurbishResult((param1 as FateTurntableInfoNotify).result);
            obf_K_e_3075.obf_P_2_4217.obf_0_1_U_421((param1 as FateTurntableInfoNotify).fateValue);
            obf_K_e_3075.obf_P_2_4217.getMoulageArr((param1 as FateTurntableInfoNotify).fateList);
         }
      }
   }
}

