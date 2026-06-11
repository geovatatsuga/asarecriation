package com.sunweb.game.rpg.angel
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.worldZone.command.angel.CommandCodeAngel;
   import com.sunweb.game.rpg.worldZone.command.angel.PlayerAngelEnterRequest;
   import com.sunweb.game.rpg.worldZone.command.angel.PlayerAngelEquAnswer;
   import com.sunweb.game.rpg.worldZone.command.angel.PlayerAngelEquRequest;
   import com.sunweb.game.rpg.worldZone.command.angel.PlayerAngelGodNotify;
   import com.sunweb.game.rpg.worldZone.command.angel.PlayerAngelGodUpAnswer;
   import com.sunweb.game.rpg.worldZone.command.angel.PlayerAngelGodUpRequest;
   import com.sunweb.game.rpg.worldZone.command.angel.PlayerAngelInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.angel.PlayerAngelUpAnswer;
   import com.sunweb.game.rpg.worldZone.command.angel.PlayerAngelUpRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_O_7_1100
   {
      
      public static var _angelConfig:Object;
      
      public static var angelList:Array;
      
      private static var $angelFree:String = "$angelFree";
      
      private static var $angelItem:String = "$angelItem";
      
      public function obf_O_7_1100()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         _angelConfig = new Object();
         _angelConfig = param1;
      }
      
      public static function get angelOpenCond() : Object
      {
         return JSONUtil.getObject(_angelConfig,["openConditon"]);
      }
      
      public static function get angelGetAngelConf() : Array
      {
         return JSONUtil.getObject(_angelConfig,["angel"]) as Array;
      }
      
      public static function get angelExpList() : Array
      {
         return JSONUtil.getObject(_angelConfig,["expList"]) as Array;
      }
      
      public static function get angelGodExpList() : Array
      {
         return JSONUtil.getObject(_angelConfig,["godExpList"]) as Array;
      }
      
      public static function get angelRank() : Array
      {
         return JSONUtil.getObject(_angelConfig,["rank"]) as Array;
      }
      
      public static function get angelToCopy() : String
      {
         return JSONUtil.getStr(_angelConfig,["toCopy"]);
      }
      
      public static function get angelFreeDayTimes() : int
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter($angelFree);
         return JSONUtil.getInt(_angelConfig,["freeInto"]) - JSONUtil.getInt(_loc1_,["numOfDay"]);
      }
      
      public static function get angelChargeDayTimes() : int
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter($angelItem);
         return JSONUtil.getInt(_angelConfig,["intoByItem"]) - JSONUtil.getInt(_loc1_,["numOfDay"]);
      }
      
      public static function get angelItemCode() : String
      {
         return JSONUtil.getStr(_angelConfig,["itemCode"]);
      }
      
      public static function get angelMulByLv() : Object
      {
         return JSONUtil.getObject(_angelConfig,["mulByLv"]);
      }
      
      public static function get angelMulByRa() : Object
      {
         return JSONUtil.getObject(_angelConfig,["mulByRa"]);
      }
      
      public static function sendPlayerAngelUpReq(param1:String) : void
      {
         var _loc2_:PlayerAngelUpRequest = new PlayerAngelUpRequest();
         _loc2_.angelId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendPlayerAngelGodUpReq() : void
      {
         var _loc1_:PlayerAngelGodUpRequest = new PlayerAngelGodUpRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendPlayerAngelEquReq(param1:String, param2:String) : void
      {
         var _loc3_:PlayerAngelEquRequest = new PlayerAngelEquRequest();
         _loc3_.rankId = param1;
         _loc3_.angelId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendPlayerAngelEnterReq() : void
      {
         var _loc1_:PlayerAngelEnterRequest = new PlayerAngelEnterRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeAngel.PLAYER_ANGEL_EQU_ANSWER)
         {
            obf_1_u_2776(param1 as PlayerAngelEquAnswer);
         }
         else if(param1.code == CommandCodeAngel.PLAYER_ANGEL_GOD_NOTIFY)
         {
            obf_B_2_4493(param1 as PlayerAngelGodNotify);
         }
         else if(param1.code == CommandCodeAngel.PLAYER_ANGEL_GOD_UP_ANSWER)
         {
            obf_D_f_1480(param1 as PlayerAngelGodUpAnswer);
         }
         else if(param1.code == CommandCodeAngel.PLAYER_ANGEL_INFO_NOTIFY)
         {
            obf_S_e_878(param1 as PlayerAngelInfoNotify);
         }
         else if(param1.code == CommandCodeAngel.PLAYER_ANGEL_UP_ANSWER)
         {
            obf_p_T_1030(param1 as PlayerAngelUpAnswer);
         }
      }
      
      private static function obf_1_u_2776(param1:PlayerAngelEquAnswer) : void
      {
         obf_K_e_3075.angelBoxUI.angelEqu(param1.rankMap);
      }
      
      private static function obf_B_2_4493(param1:PlayerAngelGodNotify) : void
      {
         obf_K_e_3075.angelBoxUI.angelGodExp(param1.angelGodExp);
      }
      
      private static function obf_D_f_1480(param1:PlayerAngelGodUpAnswer) : void
      {
         obf_K_e_3075.angelBoxUI.angelGodLevel(param1.angelGodLevel);
         obf_K_e_3075.angelBoxUI.angelGodExp(param1.angelGodExp);
         obf_K_e_3075.angelBoxUI.angelEqu(param1.rankMap);
      }
      
      private static function obf_S_e_878(param1:PlayerAngelInfoNotify) : void
      {
         angelList = param1.angelList;
         obf_K_e_3075.angelBoxUI.angelListInfo(param1.angelList);
         obf_K_e_3075.angelBoxUI.angelGodLevel(param1.angelGodLevel);
         obf_K_e_3075.angelBoxUI.angelGodExp(param1.angelGodExp);
         obf_K_e_3075.angelBoxUI.angelEqu(param1.rankMap);
      }
      
      private static function obf_p_T_1030(param1:PlayerAngelUpAnswer) : void
      {
         angelList = param1.angelList;
         obf_K_e_3075.angelBoxUI.angelListInfo(param1.angelList);
      }
   }
}

