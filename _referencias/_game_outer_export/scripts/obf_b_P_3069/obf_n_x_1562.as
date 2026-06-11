package obf_b_P_3069
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.lottery.CommandCodeLottery;
   import com.sunweb.game.rpg.worldZone.command.lottery.GambleStartAnswer;
   import com.sunweb.game.rpg.worldZone.command.lottery.GambleStartRequest;
   import com.sunweb.game.rpg.worldZone.command.lottery.GambleStopAnswer;
   import com.sunweb.game.rpg.worldZone.command.lottery.GambleStopRequest;
   import com.sunweb.game.rpg.worldZone.command.lottery.LotteryAnswer;
   import com.sunweb.game.rpg.worldZone.command.lottery.LotteryLogNotify;
   import com.sunweb.game.rpg.worldZone.command.lottery.LotteryRequest;
   import com.sunweb.game.rpg.worldZone.command.lottery.PlayerFetchOnlineAwardRequest;
   import com.sunweb.game.rpg.worldZone.command.lottery.PlayerFetchedOnlineAwardNotify;
   import com.sunweb.game.rpg.worldZone.command.lottery.PlayerFinishDrawRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_n_x_1562
   {
      
      private static var lotterConfig:Object;
      
      private static var obf_W_4_3218:Object;
      
      private static var gambleKindSetting:Object;
      
      public function obf_n_x_1562()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         lotterConfig = param1;
      }
      
      public static function get config() : Object
      {
         return lotterConfig;
      }
      
      public static function get drgLength() : int
      {
         return JSONUtil.getInt(lotterConfig,["lotteryRules","length"]);
      }
      
      public static function getDrgTreasurtConfig(param1:int) : Object
      {
         return JSONUtil.getObject(lotterConfig,["lotteryRules",param1]);
      }
      
      public static function initGamble(param1:Object) : void
      {
         var _loc2_:Object = null;
         obf_W_4_3218 = new Object();
         for each(_loc2_ in param1.gambleRuleList)
         {
            obf_W_4_3218[_loc2_.ruleId] = _loc2_;
         }
         gambleKindSetting = param1.gambleKindSetting;
      }
      
      public static function getGembleConfig(param1:String) : Object
      {
         return obf_W_4_3218[param1];
      }
      
      public static function getGembleKindSetting(param1:String) : Object
      {
         return gambleKindSetting[param1];
      }
      
      public static function sendStartGambleRoull() : void
      {
         var _loc1_:PlayerFetchOnlineAwardRequest = new PlayerFetchOnlineAwardRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendFinishDraw() : void
      {
         var _loc1_:PlayerFinishDrawRequest = new PlayerFinishDrawRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendLotteryDrg(param1:String, param2:int) : void
      {
         var _loc3_:LotteryRequest = new LotteryRequest();
         _loc3_.ruleId = param1;
         _loc3_.index = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendStartGamble(param1:String, param2:int, param3:Boolean) : void
      {
         var _loc4_:GambleStartRequest = new GambleStartRequest();
         _loc4_.ruleId = param1;
         _loc4_.stakeLevel = param2;
         _loc4_.keepLast = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function sendStopGamble(param1:String) : void
      {
         var _loc2_:GambleStopRequest = new GambleStopRequest();
         _loc2_.ruleId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodeLottery.LOTTERY_LOG_NOTIFY)
         {
            obf_j_z_2562(param1 as LotteryLogNotify);
         }
         else if(param1.code == CommandCodeLottery.LOTTERY_ANSWER)
         {
            obf_f_H_2023(param1 as LotteryAnswer);
         }
         else if(param1.code == CommandCodeLottery.GAMBLE_START_ANSWER)
         {
            obf_6_o_3680(param1 as GambleStartAnswer);
         }
         else if(param1.code == CommandCodeLottery.GAMBLE_STOP_ANSWER)
         {
            obf_3_E_4453(param1 as GambleStopAnswer);
         }
         else if(param1.code == CommandCodeLottery.PLAYER_FETCHED_ONLINEAWARD_NOTIFY)
         {
            obf_i_2_1786(param1 as PlayerFetchedOnlineAwardNotify);
         }
      }
      
      private static function obf_j_z_2562(param1:LotteryLogNotify) : void
      {
         var _loc2_:String = null;
         if(!obf_K_e_3075.drgTreasureUI)
         {
            return;
         }
         for each(_loc2_ in param1.logs)
         {
            obf_K_e_3075.drgTreasureUI.obf_i_J_3003(_loc2_);
         }
      }
      
      private static function obf_f_H_2023(param1:LotteryAnswer) : void
      {
         if(!obf_K_e_3075.drgTreasureUI)
         {
            return;
         }
         obf_K_e_3075.drgTreasureUI.onHaveItems(param1.items);
      }
      
      private static function obf_6_o_3680(param1:GambleStartAnswer) : void
      {
         if(obf_K_e_3075.wheelAwardUI.haveResult)
         {
            obf_K_e_3075.wheelAwardUI.showGetResultEffect();
         }
         obf_K_e_3075.wheelAwardUI.clearResultItems();
         obf_K_e_3075.wheelAwardUI.startWheel(param1.gambleItemList,param1.resultItemList);
      }
      
      private static function obf_3_E_4453(param1:GambleStopAnswer) : void
      {
         if(obf_K_e_3075.wheelAwardUI.obf_I_E_3420 == param1.ruleId)
         {
            if(obf_K_e_3075.wheelAwardUI.haveResult)
            {
               obf_K_e_3075.wheelAwardUI.showGetResultEffect();
            }
            obf_K_e_3075.wheelAwardUI.clearResultItems();
         }
      }
      
      private static function obf_i_2_1786(param1:PlayerFetchedOnlineAwardNotify) : void
      {
         var _loc2_:String = param1.fetchedItem;
         obf_K_e_3075.obf_y_P_4288.obf_m_r_2254(_loc2_);
      }
   }
}

