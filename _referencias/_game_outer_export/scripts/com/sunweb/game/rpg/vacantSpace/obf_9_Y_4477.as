package com.sunweb.game.rpg.vacantSpace
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.player.vacantSpace.CommandCodeVacantSpace;
   import com.sunweb.game.rpg.worldZone.command.player.vacantSpace.VacantSpaceBallInAnswer;
   import com.sunweb.game.rpg.worldZone.command.player.vacantSpace.VacantSpaceBallInRequest;
   import com.sunweb.game.rpg.worldZone.command.player.vacantSpace.VacantSpaceBallUpAnswer;
   import com.sunweb.game.rpg.worldZone.command.player.vacantSpace.VacantSpaceBallUpRequest;
   import com.sunweb.game.rpg.worldZone.command.player.vacantSpace.VacantSpaceInfoNotify;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_9_Y_4477
   {
      
      private static var vsConfig:Object;
      
      public function obf_9_Y_4477()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         vsConfig = param1;
      }
      
      public static function get openCon() : Object
      {
         return JSONUtil.getObject(vsConfig,["openCon"]);
      }
      
      public static function get balls() : Array
      {
         return JSONUtil.getValue(vsConfig,["balls"]) as Array;
      }
      
      public static function getBallConfig(param1:int) : Object
      {
         if(param1 < 0 || param1 >= balls.length)
         {
            return null;
         }
         return balls[param1];
      }
      
      public static function get ballLevels() : Array
      {
         return JSONUtil.getValue(vsConfig,["ballLevels"]) as Array;
      }
      
      public static function getBallLevelConfig(param1:int) : Object
      {
         if(param1 < 0 || param1 >= ballLevels.length)
         {
            return null;
         }
         return ballLevels[param1];
      }
      
      public static function get attrAdd() : Object
      {
         return JSONUtil.getObject(vsConfig,["attrAdd"]);
      }
      
      public static function get disUse() : Boolean
      {
         return JSONUtil.getBoolean(vsConfig,["disUse"]);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeVacantSpace.VACANT_SPACE_INFO_NOTIFY)
         {
            obf_o_y_3208(param1 as VacantSpaceInfoNotify);
         }
         else if(param1.code == CommandCodeVacantSpace.VACANT_SPACE_BALL_UP_ANSWER)
         {
            obf_U_9_1213(param1 as VacantSpaceBallUpAnswer);
         }
         else if(param1.code == CommandCodeVacantSpace.VACANT_SPACE_BALL_IN_ANSWER)
         {
            obf_J_B_2141(param1 as VacantSpaceBallInAnswer);
         }
      }
      
      public static function obf_o_y_3208(param1:VacantSpaceInfoNotify) : void
      {
         obf_K_e_3075.vacantSpaceUI.balls = param1.ballInfos;
         obf_K_e_3075.vacantSpaceUI.refresh();
      }
      
      public static function obf_U_9_1213(param1:VacantSpaceBallUpAnswer) : void
      {
         if(!obf_K_e_3075.vacantSpaceUI.balls)
         {
            obf_K_e_3075.vacantSpaceUI.balls = new Object();
         }
         obf_K_e_3075.vacantSpaceUI.balls[param1.index] = param1.ballInfo;
         obf_K_e_3075.vacantSpaceUI.refresh();
         if(obf_K_e_3075.vacantSpaceBallUI.visible && obf_K_e_3075.vacantSpaceBallUI.index == param1.index)
         {
            obf_K_e_3075.vacantSpaceBallUI.ballInfo = param1.ballInfo;
            obf_K_e_3075.vacantSpaceBallUI.refresh();
         }
      }
      
      public static function obf_J_B_2141(param1:VacantSpaceBallInAnswer) : void
      {
         if(!obf_K_e_3075.vacantSpaceUI.balls)
         {
            obf_K_e_3075.vacantSpaceUI.balls = new Object();
         }
         obf_K_e_3075.vacantSpaceUI.balls[param1.index] = param1.ballInfo;
         obf_K_e_3075.vacantSpaceUI.refresh();
         if(obf_K_e_3075.vacantSpaceBallUI.visible && obf_K_e_3075.vacantSpaceBallUI.index == param1.index)
         {
            obf_K_e_3075.vacantSpaceBallUI.ballInfo = param1.ballInfo;
            obf_K_e_3075.vacantSpaceBallUI.refresh();
         }
      }
      
      public static function sendVacantSpaceBallUpRequest(param1:int) : void
      {
         var _loc2_:VacantSpaceBallUpRequest = new VacantSpaceBallUpRequest();
         _loc2_.index = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendVacantSpaceBallInRequest(param1:int, param2:String, param3:String, param4:int) : void
      {
         var _loc5_:VacantSpaceBallInRequest = new VacantSpaceBallInRequest();
         _loc5_.index = param1;
         _loc5_.itemId = param2;
         _loc5_.itemCode = param3;
         _loc5_.itemCount = param4;
         GameContext.worldClient.sendCommand(_loc5_);
      }
   }
}

