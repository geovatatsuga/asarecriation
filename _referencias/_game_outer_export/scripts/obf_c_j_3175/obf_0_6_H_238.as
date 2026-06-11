package obf_c_j_3175
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.feedGod.CommandCodePlayerFeedGod;
   import com.sunweb.game.rpg.worldZone.command.feedGod.PlayerFeedGodAnswer;
   import com.sunweb.game.rpg.worldZone.command.feedGod.PlayerFeedGodNotify;
   import com.sunweb.game.rpg.worldZone.command.feedGod.PlayerFeedGodRequest;
   import com.sunweb.game.rpg.worldZone.command.feedGod.PlayerRefineGodAnswer;
   import com.sunweb.game.rpg.worldZone.command.feedGod.PlayerRefineGodRequest;
   import com.sunweb.game.rpg.worldZone.command.feedGod.PlayerSumGodAnswer;
   import com.sunweb.game.rpg.worldZone.command.feedGod.PlayerSumGodRequest;
   import com.sunweb.game.rpg.worldZone.command.feedGod.PlayerUseGodAnswer;
   import com.sunweb.game.rpg.worldZone.command.feedGod.PlayerUseGodRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_0_6_H_238
   {
      
      private static var feedGodConfig:Object;
      
      public function obf_0_6_H_238()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         feedGodConfig = param1;
      }
      
      public static function get obf_O_i_1541() : Object
      {
         return JSONUtil.getObject(feedGodConfig,["openCondition"]);
      }
      
      public static function get feedGodList() : Array
      {
         return JSONUtil.getObject(feedGodConfig,["godList"]) as Array;
      }
      
      public static function getFeedGodListLevel(param1:String) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < feedGodList.length)
         {
            if(param1 == feedGodList[_loc3_].name)
            {
               _loc2_ = int(feedGodList[_loc3_].levelList.length);
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public static function get feedGodUseGodItems() : Object
      {
         return JSONUtil.getObject(feedGodConfig,["useGodItems"]);
      }
      
      public static function get obf_8_t_4407() : Array
      {
         return JSONUtil.getObject(feedGodConfig,["sumGodLevels"]) as Array;
      }
      
      public static function get obf_s_K_1024() : String
      {
         return JSONUtil.getStr(feedGodConfig,["refineGodEquip"]);
      }
      
      public static function get feedGodRefineGodItems() : Object
      {
         return JSONUtil.getObject(feedGodConfig,["refineGodItems"]);
      }
      
      public static function sendPlayerFeedGodReq(param1:String) : void
      {
         var _loc2_:PlayerFeedGodRequest = new PlayerFeedGodRequest();
         _loc2_.godName = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendPlayerUseGodReq(param1:String) : void
      {
         var _loc2_:PlayerUseGodRequest = new PlayerUseGodRequest();
         _loc2_.useGodName = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendPlayerSumGodReq() : void
      {
         var _loc1_:PlayerSumGodRequest = new PlayerSumGodRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendPlayerRefineGodReq(param1:String, param2:String, param3:String) : void
      {
         var _loc4_:PlayerRefineGodRequest = new PlayerRefineGodRequest();
         _loc4_.equipmentId = param1;
         _loc4_.godName1 = param2;
         _loc4_.godName2 = param3;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerFeedGod.PLAYER_FEED_GOD_NOTIFY)
         {
            obf_0_5_a_345(param1 as PlayerFeedGodNotify);
         }
         else if(param1.code == CommandCodePlayerFeedGod.PLAYER_FEED_GOD_ANSWER)
         {
            obf_4_I_3746(param1 as PlayerFeedGodAnswer);
         }
         else if(param1.code == CommandCodePlayerFeedGod.PLAYER_USE_GOD_ANSWER)
         {
            obf_q_n_3151(param1 as PlayerUseGodAnswer);
         }
         else if(param1.code == CommandCodePlayerFeedGod.PLAYER_SUM_GOD_ANSWER)
         {
            obf_N_T_3858(param1 as PlayerSumGodAnswer);
         }
         else if(param1.code == CommandCodePlayerFeedGod.PLAYER_REFINE_GOD_ANSWER)
         {
            obf_x_P_1711(param1 as PlayerRefineGodAnswer);
         }
      }
      
      private static function obf_0_5_a_345(param1:PlayerFeedGodNotify) : void
      {
         obf_K_e_3075.obf_0_0_s_385.refreshList(param1.feedGodLevels);
         obf_K_e_3075.obf_0_0_s_385.useGodName(param1.useGodName);
         obf_K_e_3075.obf_0_0_s_385.sumGodLevel(param1.sumGodLevel);
      }
      
      private static function obf_4_I_3746(param1:PlayerFeedGodAnswer) : void
      {
         obf_K_e_3075.obf_0_0_s_385.refreshList(param1.feedGodLevels);
      }
      
      private static function obf_q_n_3151(param1:PlayerUseGodAnswer) : void
      {
         obf_K_e_3075.obf_0_0_s_385.useGodName(param1.useGodName);
      }
      
      private static function obf_N_T_3858(param1:PlayerSumGodAnswer) : void
      {
         obf_K_e_3075.obf_0_0_s_385.sumGodLevel(param1.sumGodLevel);
      }
      
      private static function obf_x_P_1711(param1:PlayerRefineGodAnswer) : void
      {
         obf_K_e_3075.obf_0_0_s_385.refreshList(param1.feedGodLevels);
      }
   }
}

