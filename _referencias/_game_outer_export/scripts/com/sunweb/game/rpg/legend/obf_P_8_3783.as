package com.sunweb.game.rpg.legend
{
   import obf_x_O_4078.obf_A_V_935;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemInfoManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.worldZone.command.legend.CommandCodeLegendStone;
   import com.sunweb.game.rpg.worldZone.command.legend.LegendEmbedAnswer;
   import com.sunweb.game.rpg.worldZone.command.legend.LegendEmbedRequest;
   import com.sunweb.game.rpg.worldZone.command.legend.LegendHoleAnswer;
   import com.sunweb.game.rpg.worldZone.command.legend.LegendHoleRequest;
   import com.sunweb.game.rpg.worldZone.command.legend.LegendRemoveAnswer;
   import com.sunweb.game.rpg.worldZone.command.legend.LegendRemoveRequest;
   import com.sunweb.game.rpg.worldZone.command.legend.LegendUpLevelAnswer;
   import com.sunweb.game.rpg.worldZone.command.legend.LegendUpLevelRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_P_8_3783
   {
      
      private static var $freeDayTimes:String = "$gemUpgrade";
      
      public function obf_P_8_3783()
      {
         super();
      }
      
      public static function get goldUpLvNmu() : int
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter($freeDayTimes);
         return JSONUtil.getInt(obf_A_V_935.legendConfig,["num"]) - JSONUtil.getInt(_loc1_,["numOfDay"]);
      }
      
      public static function get num() : int
      {
         return JSONUtil.getInt(obf_A_V_935.legendConfig,["num"]);
      }
      
      public static function get costMoney() : int
      {
         return JSONUtil.getInt(obf_A_V_935.legendConfig,["disembed"]);
      }
      
      public static function get upMul() : int
      {
         return JSONUtil.getInt(obf_A_V_935.legendConfig,["upMul"]);
      }
      
      public static function getUpLevelConfig(param1:int) : Object
      {
         var _loc2_:Array = JSONUtil.getValue(obf_A_V_935.legendConfig,"upLevel") as Array;
         return _loc2_[param1 - 1];
      }
      
      public static function getHoleConfig(param1:int) : Object
      {
         var _loc2_:Array = JSONUtil.getValue(obf_A_V_935.legendConfig,"holeConfig") as Array;
         return _loc2_[param1 - 1];
      }
      
      public static function getGemTypeConfg() : Object
      {
         return JSONUtil.getObject(obf_A_V_935.legendConfig,["embedTypes"]);
      }
      
      public static function sendHoleReques(param1:String) : void
      {
         var _loc2_:LegendHoleRequest = new LegendHoleRequest();
         _loc2_.id = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendEmbedRequest(param1:String, param2:int, param3:int) : void
      {
         var _loc4_:LegendEmbedRequest = new LegendEmbedRequest();
         _loc4_.id = param1;
         _loc4_.index = param2;
         _loc4_.gemItemIndex = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function sendRemoveRequest(param1:String, param2:int) : void
      {
         var _loc3_:LegendRemoveRequest = new LegendRemoveRequest();
         _loc3_.holeIndex = param2;
         _loc3_.equipmentItemId = param1;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendUpLevelRequest(param1:String, param2:Object, param3:Boolean) : void
      {
         var _loc4_:LegendUpLevelRequest = new LegendUpLevelRequest();
         _loc4_.itemCode = param1;
         _loc4_.needList = param2;
         _loc4_.isMoney = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeLegendStone.LEGEND_EMBED_ANSWER)
         {
            obf_l_5_931(param1 as LegendEmbedAnswer);
         }
         else if(param1.code == CommandCodeLegendStone.LEGEND_HOLE_ANSWER)
         {
            obf_0_8_M_409(param1 as LegendHoleAnswer);
         }
         else if(param1.code == CommandCodeLegendStone.LEGEND_REMOVE_ANSWER)
         {
            obf_9_1_4184(param1 as LegendRemoveAnswer);
         }
         else if(param1.code == CommandCodeLegendStone.LEGENG_UP_LEVEL_ANSWER)
         {
            obf_v_g_1699(param1 as LegendUpLevelAnswer);
         }
      }
      
      private static function obf_0_8_M_409(param1:LegendHoleAnswer) : void
      {
         GameItemInfoManager.removeItemInfo(param1.equipmentItemId);
         obf_6_D_3816.print(DiversityManager.getString("EnchaseUI","prompt_HoleComplete"));
         if(obf_K_e_3075.obf_8_C_1943)
         {
            obf_K_e_3075.obf_8_C_1943.clearContent(true);
         }
      }
      
      private static function obf_l_5_931(param1:LegendEmbedAnswer) : void
      {
         GameItemInfoManager.removeItemInfo(param1.equipmentItemId);
         obf_6_D_3816.print(DiversityManager.getString("EnchaseUI","prompt_EmbedComplete"));
         if(obf_K_e_3075.obf_8_C_1943)
         {
            obf_K_e_3075.obf_8_C_1943.clearContent(true);
         }
      }
      
      private static function obf_9_1_4184(param1:LegendRemoveAnswer) : void
      {
         GameItemInfoManager.removeItemInfo(param1.equipmentItemId);
         obf_6_D_3816.print(DiversityManager.getString("EnchaseUI","prompt_DisembedComplete"));
         if(obf_K_e_3075.obf_8_C_1943)
         {
            obf_K_e_3075.obf_8_C_1943.clearContent(true);
         }
      }
      
      private static function obf_v_g_1699(param1:LegendUpLevelAnswer) : void
      {
         obf_K_e_3075.upgradeUI.obf_v_g_1699();
         if(param1.isSucceeded)
         {
            obf_K_e_3075.upgradeUI.clear();
            if(obf_K_e_3075.upgradeUI)
            {
               obf_K_e_3075.upgradeUI.obf_J_7_2424(true);
            }
            obf_6_D_3816.print(DiversityManager.getString("UpgradeUI","prompt_UpLvComplete"));
         }
         else
         {
            obf_K_e_3075.upgradeUI.obf_J_7_2424();
            obf_6_D_3816.print(DiversityManager.getString("UpgradeUI","prompt_UpLvNoComplete"));
         }
      }
   }
}

