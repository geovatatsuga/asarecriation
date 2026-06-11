package com.sunweb.game.rpg.trade
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.netRole.RemotePlayer;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.script.ConditionScript;
   import com.sunweb.game.rpg.social.FriendManager;
   import com.sunweb.game.rpg.world.WorldConfig;
   import com.sunweb.game.rpg.worldZone.command.trade.CommandCodePlayerTrade;
   import com.sunweb.game.rpg.worldZone.command.trade.PlayerInviteTradeAnswer;
   import com.sunweb.game.rpg.worldZone.command.trade.PlayerInviteTradeRequest;
   import com.sunweb.game.rpg.worldZone.command.trade.PlayerProcessInviteTradeRequestReply;
   import com.sunweb.game.rpg.worldZone.command.trade.PlayerReceiveInviteTradeRequestNotify;
   import com.sunweb.game.rpg.worldZone.command.trade.PlayerTradeBeginNotify;
   import com.sunweb.game.rpg.worldZone.command.trade.PlayerTradeCancelRequest;
   import com.sunweb.game.rpg.worldZone.command.trade.PlayerTradeCheckAnswer;
   import com.sunweb.game.rpg.worldZone.command.trade.PlayerTradeCheckRequest;
   import com.sunweb.game.rpg.worldZone.command.trade.PlayerTradeConfirmNotify;
   import com.sunweb.game.rpg.worldZone.command.trade.PlayerTradeConfirmRequest;
   import com.sunweb.game.rpg.worldZone.command.trade.PlayerTradeEndNotify;
   import com.sunweb.game.rpg.worldZone.command.trade.PlayerTradeItemSubmitNotify;
   import com.sunweb.game.rpg.worldZone.command.trade.PlayerTradeItemSubmitRequest;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.obf_L_l_4100;
   
   public class obf_G_0_3203
   {
      
      public static const obf_v_W_4242:int = 0;
      
      public static const obf_0_2_0_227:int = 1;
      
      public static const obf_0_7_1_88:int = 2;
      
      public function obf_G_0_3203()
      {
         super();
      }
      
      public static function tradeToPlayer(param1:String) : void
      {
         if(!GameContext.currentMap)
         {
            return;
         }
         var _loc2_:RemotePlayer = GameContext.currentMap.remotePlayerSet.getObject(param1) as RemotePlayer;
         if(!_loc2_ || GameContext.localPlayer.getLineDistance(_loc2_) > WorldConfig.obf_J_9_4148)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("TradeUI","error_OutOfDistance"));
            return;
         }
         if(!ConditionScript.checkCondition(WorldConfig.getValue("tradeCond"),null,true))
         {
            return;
         }
         obf_N_l_3727(param1);
      }
      
      public static function obf_N_l_3727(param1:String) : void
      {
         var _loc2_:PlayerInviteTradeRequest = new PlayerInviteTradeRequest();
         _loc2_.targetPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
         obf_6_D_3816.print(DiversityManager.getString("TradeUI","prompt_TradeInvite",[param1]));
      }
      
      public static function obf_Y_W_4499(param1:String, param2:Boolean) : void
      {
         var _loc3_:PlayerProcessInviteTradeRequestReply = new PlayerProcessInviteTradeRequestReply();
         _loc3_.isAgreed = param2;
         _loc3_.sourcePlayerId = param1;
         if(param2 && !ConditionScript.checkCondition(WorldConfig.getValue("tradeCond"),null,true))
         {
            return;
         }
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      private static function confirmInviteTrade(param1:Object) : void
      {
         obf_Y_W_4499(param1.par,param1.confirm);
      }
      
      public static function sendSubmitItems(param1:String, param2:Array, param3:int) : void
      {
         var _loc4_:PlayerTradeItemSubmitRequest = new PlayerTradeItemSubmitRequest();
         _loc4_.otherPlayerId = param1;
         _loc4_.gold = param3;
         _loc4_.itemList = param2;
         GameContext.worldClient.sendCommand(_loc4_);
      }
      
      public static function obf_D_E_3035(param1:String) : void
      {
         var _loc2_:PlayerTradeCancelRequest = new PlayerTradeCancelRequest();
         _loc2_.otherPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function obf_D_L_3792(param1:String) : void
      {
         var _loc2_:PlayerTradeConfirmRequest = new PlayerTradeConfirmRequest();
         _loc2_.otherPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function sendConfirmTradeCheck(param1:String) : void
      {
         var _loc2_:PlayerTradeCheckRequest = new PlayerTradeCheckRequest();
         _loc2_.ans = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerTrade.PLAYER_RECEIVE_INVITE_TRADE_REQUEST_NOTIFY)
         {
            onReceiveInvite(param1 as PlayerReceiveInviteTradeRequestNotify);
         }
         else if(param1.code == CommandCodePlayerTrade.PLAYER_INVITE_TRADE_ANSWER)
         {
            obf_Q_K_3382(param1 as PlayerInviteTradeAnswer);
         }
         else if(param1.code == CommandCodePlayerTrade.PLAYER_TRADE_BEGIN_NOTIFY)
         {
            obf_o_1_736(param1 as PlayerTradeBeginNotify);
         }
         else if(param1.code == CommandCodePlayerTrade.PLAYER_TRADE_ITEM_SUBMIT_NOTIFY)
         {
            obf_7_i_4050(param1 as PlayerTradeItemSubmitNotify);
         }
         else if(param1.code == CommandCodePlayerTrade.PLAYER_TRADE_CONFIRM_NOTIFY)
         {
            onTradeConfirm(param1 as PlayerTradeConfirmNotify);
         }
         else if(param1.code == CommandCodePlayerTrade.PLAYER_TRADE_END_NOTIFY)
         {
            obf_r_6_4422(param1 as PlayerTradeEndNotify);
         }
         else if(param1.code == CommandCodePlayerTrade.PLAYER_TRADE_CHECK_ANSWER)
         {
            obf_W_X_2697(param1 as PlayerTradeCheckAnswer);
         }
      }
      
      private static function onReceiveInvite(param1:PlayerReceiveInviteTradeRequestNotify) : void
      {
         if(FriendManager.obf_0_2_R_182(param1.sourcePlayerId))
         {
            return;
         }
         if(GameContext.localPlayer.isDead)
         {
            return;
         }
         WindowManager.showConfirmSmallBox(DiversityManager.getString("TradeUI","prompt_ReceiveTradeInvite",[param1.sourcePlayerId]),confirmInviteTrade,param1.sourcePlayerId,"ReceiveTrade_" + param1.sourcePlayerId);
      }
      
      private static function obf_Q_K_3382(param1:PlayerInviteTradeAnswer) : void
      {
         if(!param1.isAgreed)
         {
            obf_6_D_3816.print(DiversityManager.getString("TradeUI","prompt_TradeRefused",[param1.targetPlayerId]));
         }
      }
      
      private static function obf_o_1_736(param1:PlayerTradeBeginNotify) : void
      {
         if(!obf_K_e_3075.tradeUI)
         {
            return;
         }
         obf_K_e_3075.tradeUI.showPlayerTrade(param1.otherPlayerId);
      }
      
      private static function obf_7_i_4050(param1:PlayerTradeItemSubmitNotify) : void
      {
         if(obf_L_l_4100.isEmpty(param1.playerId) || !obf_K_e_3075.tradeUI)
         {
            return;
         }
         if(obf_K_e_3075.tradeUI.visible && obf_K_e_3075.tradeUI.targetPlayer == param1.playerId)
         {
            obf_K_e_3075.tradeUI.showTargetPlayerItems(param1.itemList,param1.gold);
            obf_K_e_3075.tradeUI.targetIsReady = true;
         }
      }
      
      private static function onTradeConfirm(param1:PlayerTradeConfirmNotify) : void
      {
         if(obf_L_l_4100.isEmpty(param1.playerId) || !obf_K_e_3075.tradeUI)
         {
            return;
         }
         if(obf_K_e_3075.tradeUI.visible && obf_K_e_3075.tradeUI.targetPlayer == param1.playerId)
         {
            obf_K_e_3075.tradeUI.targetIsOK = true;
         }
      }
      
      private static function obf_r_6_4422(param1:PlayerTradeEndNotify) : void
      {
         if(obf_K_e_3075.tradeUI.visible && param1.otherPlayerId == obf_K_e_3075.tradeUI.targetPlayer)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.tradeUI);
         }
         if(param1.result == obf_v_W_4242)
         {
            obf_6_D_3816.print(DiversityManager.getString("TradeUI","prompt_TradeComplete"));
         }
         else if(param1.result == obf_0_2_0_227)
         {
            obf_6_D_3816.print(DiversityManager.getString("TradeUI","prompt_TradeCancle"));
         }
         else if(param1.result == obf_0_7_1_88)
         {
            obf_6_D_3816.print(DiversityManager.getString("TradeUI","prompt_TradeReadyError"));
         }
      }
      
      private static function obf_W_X_2697(param1:PlayerTradeCheckAnswer) : void
      {
         obf_K_e_3075.tradeCheckUI.txTradeString.text = param1.que;
         if(!obf_K_e_3075.tradeCheckUI)
         {
            return;
         }
         if(obf_K_e_3075.tradeCheckUI.visible)
         {
            obf_K_e_3075.closeUI(obf_K_e_3075.tradeCheckUI);
         }
         obf_K_e_3075.showUI(obf_K_e_3075.tradeCheckUI);
      }
   }
}

