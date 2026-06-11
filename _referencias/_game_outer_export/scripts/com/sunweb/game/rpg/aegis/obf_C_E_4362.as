package com.sunweb.game.rpg.aegis
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.aegis.AegisEventType;
   import com.sunweb.game.rpg.worldZone.command.aegis.AegisPlayerNotify;
   import com.sunweb.game.rpg.worldZone.command.aegis.AegisPlayerRequest;
   import com.sunweb.game.rpg.worldZone.command.aegis.AegisPrayAnswer;
   import com.sunweb.game.rpg.worldZone.command.aegis.AegisUpLevelAnswer;
   import com.sunweb.game.rpg.worldZone.command.aegis.AegisUpdateAnswer;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_C_E_4362
   {
      
      public static var aegisConfig:Object;
      
      public static var obf_i_P_1289:int;
      
      public static var aegisPoint:int;
      
      public static var obf_0_5_o_582:int;
      
      public static var obf_7_m_2787:int;
      
      public static var rankList:Array = new Array();
      
      public static var openCardArray:Array = new Array();
      
      public function obf_C_E_4362()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         aegisConfig = param1;
         rankList = [aegisConfig.normal,aegisConfig.fine,aegisConfig.perfect,aegisConfig.legend];
      }
      
      public static function getRank(param1:int) : Array
      {
         if(param1 < 0 || param1 >= rankList.length)
         {
            return null;
         }
         return rankList[param1];
      }
      
      public static function getLevel(param1:int, param2:int) : Object
      {
         if(param2 == 0 || param1 == 0)
         {
            return null;
         }
         return JSONUtil.getObject(getRank(param1 - 1),[param2 - 1]);
      }
      
      public static function getLevelStr(param1:int, param2:int) : Array
      {
         var _loc4_:Object = null;
         var _loc3_:Array = new Array();
         _loc4_ = getLevel(param1,param2);
         if(_loc4_ == null)
         {
            return [];
         }
         return String(_loc4_.explain).split(",");
      }
      
      public static function get getExplain() : String
      {
         return JSONUtil.getStr(aegisConfig,["explain"]);
      }
      
      public static function getOpenLevel() : int
      {
         return JSONUtil.getInt(aegisConfig,["openLv"]);
      }
      
      public static function get getCode() : String
      {
         return JSONUtil.getStr(aegisConfig,["itemCode"]);
      }
      
      public static function getUpValues(param1:int) : int
      {
         return JSONUtil.getInt(aegisConfig,["upValues",param1 - 1]);
      }
      
      public static function getItemNums(param1:int) : int
      {
         var _loc2_:Array = null;
         _loc2_ = JSONUtil.getValue(aegisConfig,["itemNums"]) as Array;
         if(param1 >= _loc2_.length)
         {
            return _loc2_[_loc2_.length - 1];
         }
         return _loc2_[param1];
      }
      
      public static function maxLevel(param1:int) : int
      {
         if(param1 == 0)
         {
            return 0;
         }
         var _loc2_:Array = getRank(param1 - 1);
         return _loc2_ == null ? 0 : int(_loc2_.length);
      }
      
      public static function sendAegis(param1:int) : void
      {
         var _loc2_:AegisPlayerRequest = new AegisPlayerRequest();
         _loc2_.type = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == AegisEventType.PLAYER_UPDATE_ANSWER)
         {
            obf_q_B_1576(param1 as AegisUpdateAnswer);
         }
         if(param1.code == AegisEventType.PLAYER_AEGIS_NOTIFY)
         {
            obf_l_9_1013(param1 as AegisPlayerNotify);
         }
         if(param1.code == AegisEventType.PLAYER_UP_LEVEL_ANSWER)
         {
            obf_j_D_4412(param1 as AegisUpLevelAnswer);
         }
         if(param1.code == AegisEventType.PLAYER_PRAY_ANSWER)
         {
            obf_j_u_3017(param1 as AegisPrayAnswer);
         }
      }
      
      public static function obf_q_B_1576(param1:AegisUpdateAnswer) : void
      {
         obf_i_P_1289 = param1.aegisPray;
         obf_0_5_o_582 = param1.aegisRank;
         openCardArray = param1.aegisList;
         obf_7_m_2787 = param1.aegisLevel;
         if(openCardArray == null)
         {
            openCardArray = [];
         }
         obf_K_e_3075.obf_L_G_3097.obf_s_B_4526(param1);
      }
      
      public static function obf_l_9_1013(param1:AegisPlayerNotify) : void
      {
         obf_i_P_1289 = param1.aegisPray;
         aegisPoint = param1.aegisValue;
         obf_0_5_o_582 = param1.aegisRank;
         openCardArray = param1.aegisList;
         obf_7_m_2787 = param1.aegisLevel;
         if(openCardArray == null)
         {
            openCardArray = [];
         }
         obf_K_e_3075.obf_L_G_3097.refurbish(param1);
      }
      
      public static function obf_j_D_4412(param1:AegisUpLevelAnswer) : void
      {
         aegisPoint = param1.aegisValue;
         obf_7_m_2787 = param1.aegisLevel;
         obf_K_e_3075.obf_L_G_3097.obf_t_c_4393(param1);
      }
      
      public static function obf_j_u_3017(param1:AegisPrayAnswer) : void
      {
         obf_i_P_1289 = param1.aegisPray;
         aegisPoint = param1.aegisValue;
         obf_K_e_3075.obf_L_G_3097.obf_T_W_1546(param1);
         openCardArray = param1.aegisList;
         if(openCardArray == null)
         {
            openCardArray = [];
         }
      }
   }
}

