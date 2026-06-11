package com.sunweb.game.rpg.playingCard
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.worldZone.command.playingCard.CommandCodePlayerNineCard;
   import com.sunweb.game.rpg.worldZone.command.playingCard.PlayerCardAddTimesRequest;
   import com.sunweb.game.rpg.worldZone.command.playingCard.PlayerCardBounAnswer;
   import com.sunweb.game.rpg.worldZone.command.playingCard.PlayerCardBounRequest;
   import com.sunweb.game.rpg.worldZone.command.playingCard.PlayerCardGameTimesNotify;
   import com.sunweb.game.rpg.worldZone.command.playingCard.PlayerCardStartAnswer;
   import com.sunweb.game.rpg.worldZone.command.playingCard.PlayerCardStartRequest;
   import com.sunweb.game.rpg.worldZone.command.playingCard.PlayerCardTurnAnswer;
   import com.sunweb.game.rpg.worldZone.command.playingCard.PlayerCardTurnNotify;
   import com.sunweb.game.rpg.worldZone.command.playingCard.PlayerCardTurnRequest;
   import com.sunweb.game.utils.JSONUtil;
   
   public class obf_V_N_2158
   {
      
      private static var _cardConfig:Object;
      
      private static var obf_l_m_3201:int;
      
      private static var obf_4_Q_4430:int;
      
      public static var _playingCardConfig:Object;
      
      public static var indexs:Array;
      
      public static var _ruleKind:Array;
      
      public static var bounIndexs:Array;
      
      public function obf_V_N_2158()
      {
         super();
      }
      
      public static function init(param1:Object) : void
      {
         _cardConfig = param1;
      }
      
      public static function get cardConfig() : Object
      {
         return _cardConfig;
      }
      
      public static function get obf_M_B_1743() : Array
      {
         return JSONUtil.getObject(_cardConfig,["bounRule"]) as Array;
      }
      
      public static function perDayNum() : int
      {
         return JSONUtil.getInt(_cardConfig,["freeGameTimes"]);
      }
      
      public static function perDayFreeNum() : int
      {
         return JSONUtil.getInt(_cardConfig,["freeTurnTimes"]);
      }
      
      public static function sixCost() : int
      {
         return JSONUtil.getInt(_cardConfig,["turnByMoney"]);
      }
      
      public static function get turnTimes() : int
      {
         return obf_l_m_3201;
      }
      
      public static function getIdConfig(param1:String) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:Array = JSONUtil.getObject(_cardConfig,["cards"]) as Array;
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_)
            {
               if(param1 == _loc3_.cardId)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
      
      public static function get ruleKind() : Array
      {
         if(!_ruleKind)
         {
            return [];
         }
         return _ruleKind;
      }
      
      public static function get rewardIndex() : Array
      {
         if(!bounIndexs)
         {
            return [];
         }
         return bounIndexs;
      }
      
      public static function sendStart() : void
      {
         var _loc1_:PlayerCardStartRequest = new PlayerCardStartRequest();
         _playingCardConfig = null;
         obf_K_e_3075.obf_0_3_j_588.showButtonState();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendAddTimes() : void
      {
         var _loc1_:PlayerCardAddTimesRequest = new PlayerCardAddTimesRequest();
         GameContext.worldClient.sendCommand(_loc1_);
      }
      
      public static function sendTurn(param1:int, param2:String) : void
      {
         var _loc3_:PlayerCardTurnRequest = new PlayerCardTurnRequest();
         _loc3_.index = param1;
         _loc3_.cardId = param2;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      public static function sendReward(param1:Array) : void
      {
         var _loc2_:PlayerCardBounRequest = new PlayerCardBounRequest();
         _loc2_.bounList = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayerNineCard.PLAYER_CARD_START_ANSWER)
         {
            obf_u_X_2288(param1 as PlayerCardStartAnswer);
         }
         else if(param1.code == CommandCodePlayerNineCard.PLAYER_CARD_TURN_ANSWER)
         {
            obf_Z_B_1435(param1 as PlayerCardTurnAnswer);
         }
         else if(param1.code == CommandCodePlayerNineCard.PLAYER_CARD_TURN_NOTIFY)
         {
            obf_I_L_3594(param1 as PlayerCardTurnNotify);
         }
         else if(param1.code == CommandCodePlayerNineCard.PLAYER_CARD_GAME_TIMES_NOTIFY)
         {
            obf_J_8_960(param1 as PlayerCardGameTimesNotify);
         }
         else if(param1.code == CommandCodePlayerNineCard.PLAYER_CARD_BOUN_ANSWER)
         {
            obf_G_h_4231(param1 as PlayerCardBounAnswer);
         }
      }
      
      private static function obf_u_X_2288(param1:PlayerCardStartAnswer) : void
      {
         obf_l_m_3201 = param1.turnTimes;
         GameContext.localPlayer.fullInfo.gameTimes = param1.gameTimes;
         _playingCardConfig = param1.cards;
         obf_K_e_3075.obf_0_3_j_588.showButtonState();
      }
      
      private static function obf_Z_B_1435(param1:PlayerCardTurnAnswer) : void
      {
         obf_l_m_3201 = param1.turnTimes;
         _ruleKind = param1.ruleKind;
         bounIndexs = param1.bounIndexs;
         obf_K_e_3075.obf_0_3_j_588.setShowAward(param1.ruleKind);
         obf_K_e_3075.obf_0_3_j_588.obf_0_1_Y_208 = param1.indexs;
         obf_K_e_3075.obf_0_3_j_588.obf_2_X_1632(param1.indexs);
         obf_K_e_3075.obf_0_3_j_588.showButtonState();
      }
      
      private static function obf_I_L_3594(param1:PlayerCardTurnNotify) : void
      {
         _playingCardConfig = param1.cards;
         obf_l_m_3201 = param1.turnTimes;
         GameContext.localPlayer.fullInfo.gameTimes = param1.gameTimes;
         _ruleKind = param1.ruleKind;
         bounIndexs = param1.bounIndexs;
         obf_K_e_3075.obf_0_3_j_588.obf_0_1_Y_208 = param1.indexs;
         obf_K_e_3075.obf_0_3_j_588.setShowAward(param1.ruleKind);
         obf_K_e_3075.obf_0_3_j_588.obf_2_X_1632(param1.indexs);
         obf_K_e_3075.obf_0_3_j_588.showButtonState();
      }
      
      private static function obf_J_8_960(param1:PlayerCardGameTimesNotify) : void
      {
         GameContext.localPlayer.fullInfo.gameTimes = param1.gameTimes;
         obf_K_e_3075.obf_0_3_j_588.showButtonState();
      }
      
      private static function obf_G_h_4231(param1:PlayerCardBounAnswer) : void
      {
         if(param1.isSucceed)
         {
            _playingCardConfig = null;
            _ruleKind = null;
            bounIndexs = null;
            indexs = null;
            obf_K_e_3075.obf_0_3_j_588.showButtonState();
            obf_K_e_3075.obf_0_3_j_588.obf_2_b_1076();
         }
      }
   }
}

