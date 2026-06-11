package com.sunweb.game.rpg.challenge
{
   import obf_b_m_2084.obf_W_9_2222;
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.task.PeriodCounterItemInfo;
   import com.sunweb.game.rpg.task.obf_Y_F_1424;
   import com.sunweb.game.rpg.worldZone.command.challenge.CommandCodeArenaRobot;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotAddChanceAnswer;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotAddChanceRequest;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotAwardNotify;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotAwardRequest;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotChallengeRequest;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotChallengeResultNotify;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotOpenAnswer;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotOpenRequest;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotPlayerOutMapRequest;
   import com.sunweb.game.rpg.worldZone.command.challenge.RobotReportNotify;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerViewRemoteRequest;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_0_5_f_69
   {
      
      private static var challengeConfig:Object;
      
      public function obf_0_5_f_69()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         challengeConfig = param1;
      }
      
      public static function getTime12() : String
      {
         return JSONUtil.getStr(challengeConfig,["drawTime"]);
      }
      
      public static function getMoney() : int
      {
         return JSONUtil.getInt(challengeConfig,["addChanceMoney"]);
      }
      
      public static function getAwardConfig() : Array
      {
         return JSONUtil.getValue(challengeConfig,["awardConfig"]) as Array;
      }
      
      public static function getOpenLevel() : int
      {
         return JSONUtil.getInt(challengeConfig,["openLevel"]);
      }
      
      public static function get challengeMapIdList() : Array
      {
         var _loc1_:Array = JSONUtil.getValue(challengeConfig,["challengeWorldMapID"]) as Array;
         if(_loc1_)
         {
            return _loc1_;
         }
         return new Array();
      }
      
      public static function getNoChallgeMapIdList() : Array
      {
         var _loc1_:Array = JSONUtil.getValue(challengeConfig,["noEnterMap"]) as Array;
         if(_loc1_)
         {
            return _loc1_;
         }
         return new Array();
      }
      
      public static function getCanChallgeMapIdList() : Array
      {
         var _loc1_:Array = JSONUtil.getValue(challengeConfig,["enterMap"]) as Array;
         if(_loc1_)
         {
            return _loc1_;
         }
         return [];
      }
      
      public static function get isAddRobotNum() : Boolean
      {
         var _loc1_:PeriodCounterItemInfo = obf_Y_F_1424.getCounter("addrobotnum");
         return JSONUtil.getInt(_loc1_,["numOfDay"]) < 10;
      }
      
      public static function sendRobotOpenRequest() : void
      {
         var _loc1_:RobotOpenRequest = new RobotOpenRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendRobotChallengeRequest(param1:int) : void
      {
         var _loc2_:RobotChallengeRequest = new RobotChallengeRequest();
         _loc2_.robotLevel = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendRobotAddChanceRequest() : void
      {
         var _loc1_:RobotAddChanceRequest = new RobotAddChanceRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendViewRemote(param1:String) : void
      {
         var _loc2_:PlayerViewRemoteRequest = new PlayerViewRemoteRequest();
         _loc2_.remotePlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendOutMap() : void
      {
         var _loc1_:RobotPlayerOutMapRequest = new RobotPlayerOutMapRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendAward() : void
      {
         var _loc1_:RobotAwardRequest = new RobotAwardRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeArenaRobot.ROBOT_OPEN_ANSWER)
         {
            obf_K_e_3075.obf_v_3_1831.showChallengeInfo(param1 as RobotOpenAnswer);
         }
         else if(param1.code == CommandCodeArenaRobot.ROBOT_ADD_CHANCE_ANSWER)
         {
            obf_K_e_3075.obf_v_3_1831.obf_m_K_3062(param1 as RobotAddChanceAnswer);
         }
         else if(param1.code == CommandCodeArenaRobot.ROBOT_CHALLENGE_RESULT_NOTIFY)
         {
            WindowManager.showModalWindow(new obf_W_9_2222((param1 as RobotChallengeResultNotify).result));
         }
         else if(param1.code == CommandCodeArenaRobot.ROBOT_REPORT_NOTIFY)
         {
            obf_K_e_3075.obf_v_3_1831.obf_9_z_3052(param1 as RobotReportNotify);
         }
         else if(param1.code == CommandCodeArenaRobot.ROBOT_AWARD_NOTIFY)
         {
            obf_K_e_3075.obf_v_3_1831.obf_f_w_1077(param1 as RobotAwardNotify);
         }
      }
   }
}

