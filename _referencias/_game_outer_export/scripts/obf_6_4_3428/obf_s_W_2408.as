package obf_6_4_3428
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.runningMan.CommandCodePlayerRunConfig;
   import com.sunweb.game.rpg.worldZone.command.runningMan.PlayerRunAwardNotify;
   import com.sunweb.game.rpg.worldZone.command.runningMan.PlayerRunAwardRequest;
   import com.sunweb.game.rpg.worldZone.command.runningMan.PlayerRunOnlineTimeNotify;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_s_W_2408
   {
      
      public function obf_s_W_2408()
      {
         super();
      }
      
      public static function get runConfig() : Object
      {
         return WorldConfig.getObjectSetting("runConfig") as Object;
      }
      
      public static function awardObj(param1:int) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:Array = JSONUtil.getValue(runConfig,["awardList"]) as Array;
         for each(_loc3_ in _loc2_)
         {
            if(int(_loc3_.id) == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function obf_k_b_2296(param1:String) : void
      {
         var _loc2_:PlayerRunAwardRequest = new PlayerRunAwardRequest();
         _loc2_.awardId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerRunConfig.PLAYER_RUN_ONLINE_TIME_NOTIFY)
         {
            obf_y_u_2781(param1 as PlayerRunOnlineTimeNotify);
         }
         else if(param1.code == CommandCodePlayerRunConfig.PLAYER_RUN_AWARD_NOTIFY)
         {
            obf_N_R_2500(param1 as PlayerRunAwardNotify);
         }
      }
      
      private static function obf_y_u_2781(param1:PlayerRunOnlineTimeNotify) : void
      {
         obf_K_e_3075.runningMan.setRunNum(param1.onlineTime);
      }
      
      private static function obf_N_R_2500(param1:PlayerRunAwardNotify) : void
      {
         obf_K_e_3075.runningMan.setAwardFettle(param1.awardType);
      }
   }
}

