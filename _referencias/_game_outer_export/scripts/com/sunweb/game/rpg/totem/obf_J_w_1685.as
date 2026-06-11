package com.sunweb.game.rpg.totem
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.activity.obf_J_F_3431;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.totem.CommandCodePlayerTotem;
   import com.sunweb.game.rpg.worldZone.command.totem.TotemEnterMapRequest;
   import com.sunweb.game.rpg.worldZone.command.totem.TotemInfoNotify;
   import com.sunweb.game.rpg.worldZone.command.totem.TotemUpLevelStageAnswer;
   import com.sunweb.game.rpg.worldZone.command.totem.TotemUpLevelStageRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_J_w_1685
   {
      
      private static var totemConfig:Object;
      
      private static var $freeDayTimes:String = "$totemMap";
      
      public function obf_J_w_1685()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         totemConfig = param1;
      }
      
      public static function get totemList() : Array
      {
         return JSONUtil.getValue(totemConfig,["totem"]) as Array;
      }
      
      public static function get mapId() : String
      {
         return JSONUtil.getStr(totemConfig,["enterTo"]);
      }
      
      public static function get playerLv() : int
      {
         return JSONUtil.getInt(totemConfig,["roleLevel"]);
      }
      
      public static function get isOpen() : Boolean
      {
         if(obf_J_F_3431.obf_4_4696(JSONUtil.getStr(totemConfig,["activityCode"])))
         {
            return true;
         }
         return false;
      }
      
      public static function get obf_R_I_2427() : Object
      {
         return JSONUtil.getObject(totemConfig,["enterCopyWorldCon"],new Object());
      }
      
      public static function sendEnterMapRequest() : void
      {
         var _loc1_:TotemEnterMapRequest = new TotemEnterMapRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendUpLv(param1:int, param2:int) : void
      {
         var _loc3_:TotemUpLevelStageRequest = new TotemUpLevelStageRequest();
         _loc3_.totemType = param1;
         _loc3_.type = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerTotem.TOTEM_INFO_NOTIFY)
         {
            obf_0_3_7_364(param1 as TotemInfoNotify);
         }
         else if(param1.code == CommandCodePlayerTotem.TOTEM_UP_LEVEL_STAGE_ANSWER)
         {
            obf_N_E_1119(param1 as TotemUpLevelStageAnswer);
         }
      }
      
      private static function obf_0_3_7_364(param1:TotemInfoNotify) : void
      {
         obf_K_e_3075.totemBoxUI.getTotemMap(param1.infoMap);
      }
      
      private static function obf_N_E_1119(param1:TotemUpLevelStageAnswer) : void
      {
         var _loc2_:TotemInfo = null;
         if(obf_K_e_3075.totemBoxUI.list.selectedIndex >= 0 && Boolean(param1.infoMap[obf_K_e_3075.totemBoxUI.list.selectedIndex]))
         {
            _loc2_ = param1.infoMap[obf_K_e_3075.totemBoxUI.list.selectedIndex] as TotemInfo;
            obf_K_e_3075.totemBoxUI.getTotemMap(param1.infoMap);
            obf_K_e_3075.totemBoxUI.obf_E_N_1183(_loc2_.stage,_loc2_.level);
            obf_K_e_3075.totemOfferUI.obf_0_4_u_689(_loc2_.stage,_loc2_.level);
            obf_K_e_3075.totemEvolveUI.obf_0_4_u_689(_loc2_.stage,_loc2_.level);
         }
      }
   }
}

