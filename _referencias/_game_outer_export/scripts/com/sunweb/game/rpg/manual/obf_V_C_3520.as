package com.sunweb.game.rpg.manual
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.worldZone.command.monsterManual.CommandCodeMonsterManual;
   import com.sunweb.game.rpg.worldZone.command.monsterManual.ManualAbsorbAnswer;
   import com.sunweb.game.rpg.worldZone.command.monsterManual.ManualAbsorbRequest;
   import com.sunweb.game.rpg.worldZone.command.monsterManual.ManualViewAnswer;
   import com.sunweb.game.rpg.worldZone.command.monsterManual.ManualViewRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_V_C_3520
   {
      
      private static var obf_j_R_2626:int;
      
      private static var configObj:Object = new Object();
      
      public function obf_V_C_3520()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         configObj = param1;
      }
      
      public static function get dayTimes() : int
      {
         return JSONUtil.getInt(configObj,["allowTimesByDay"]);
      }
      
      public static function get getManual() : Array
      {
         return JSONUtil.getObject(configObj,["manualList"]) as Array;
      }
      
      public static function obf_m_Z_1822(param1:Boolean = false) : Boolean
      {
         var _loc2_:Object = openCondition;
         if(!_loc2_)
         {
            return true;
         }
         if(!ConditionScript.checkCondition(_loc2_,null,param1))
         {
            return false;
         }
         return true;
      }
      
      public static function get openCondition() : Object
      {
         return JSONUtil.getObject(configObj,["openManualCondition"]);
      }
      
      public static function set obf_0_8_9_477(param1:int) : void
      {
         obf_j_R_2626 = param1;
      }
      
      public static function get obf_0_8_9_477() : int
      {
         return obf_j_R_2626;
      }
      
      public static function sendManualAbsorb(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:ManualAbsorbRequest = new ManualAbsorbRequest();
         _loc3_.isMoney = param2;
         _loc3_.manualCode = param1;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendShowUI() : void
      {
         var _loc1_:ManualViewRequest = new ManualViewRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function getHaveAllTimes(param1:String) : int
      {
         var _loc2_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("$" + param1);
         return dayTimes - JSONUtil.getInt(_loc2_,["numOfDay"]);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeMonsterManual.MANUAL_ABSORB_ANSWER)
         {
            obf_0_3_F_335(param1 as ManualAbsorbAnswer);
         }
         else if(param1.code == CommandCodeMonsterManual.MANUAL_VIEW_ANSWER)
         {
            obf_0_4_j_197(param1 as ManualViewAnswer);
         }
      }
      
      private static function obf_0_3_F_335(param1:ManualAbsorbAnswer) : void
      {
         if(param1.manualInfo)
         {
            obf_K_e_3075.manualUI.obf_S_D_3371(param1.manualInfo.code,param1.manualInfo.absorbTimes);
         }
      }
      
      private static function obf_0_4_j_197(param1:ManualViewAnswer) : void
      {
         var _loc2_:String = null;
         obf_K_e_3075.manualUI.obf_A_W_3451(param1.manualList);
         obf_j_R_2626 = 0;
         for(_loc2_ in param1.manualList)
         {
            ++obf_j_R_2626;
         }
      }
   }
}

