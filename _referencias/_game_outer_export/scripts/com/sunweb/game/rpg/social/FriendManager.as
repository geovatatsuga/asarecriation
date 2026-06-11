package com.sunweb.game.rpg.social
{
   import com.sunweb.game.net.framework.command.obf_C_m_1350;
   import com.sunweb.game.rpg.GameContext;
   import com.sunweb.game.rpg.obf_6_D_3816;
   import com.sunweb.game.rpg.diversity.DiversityManager;
   import com.sunweb.game.rpg.gameItem.GameItemManager;
   import com.sunweb.game.rpg.playerUI.managers.obf_K_e_3075;
   import com.sunweb.game.rpg.settingConfig.NumberConfig;
   import com.sunweb.game.rpg.worldZone.command.player.CommandCodePlayer;
   import com.sunweb.game.rpg.worldZone.command.player.PlayerEnterWorldAnswer;
   import com.sunweb.game.rpg.worldZone.command.social.friend.CommandCodePlayerFriend;
   import com.sunweb.game.rpg.worldZone.command.social.friend.PlayerAddFriendAnswer;
   import com.sunweb.game.rpg.worldZone.command.social.friend.PlayerAddFriendRequest;
   import com.sunweb.game.rpg.worldZone.command.social.friend.PlayerFriendCheckNotify;
   import com.sunweb.game.rpg.worldZone.command.social.friend.PlayerProcessAddFriendRequestReply;
   import com.sunweb.game.rpg.worldZone.command.social.friend.PlayerReceiveAddFriendRequestNotify;
   import com.sunweb.game.rpg.worldZone.command.social.friend.PlayerReceiveGiftNotify;
   import com.sunweb.game.rpg.worldZone.command.social.friend.PlayerRemoveFriendRequest;
   import com.sunweb.game.rpg.worldZone.command.social.friend.PlayerRemovedFriendNotify;
   import com.sunweb.game.rpg.worldZone.command.social.friend.PlayerSendGiftRequest;
   import com.sunweb.game.ui.WindowManager;
   import com.sunweb.game.utils.JSONUtil;
   
   public class FriendManager
   {
      
      private static var badList:Array;
      
      private static var friendObj:Object = new Object();
      
      public static var friendList:Array = new Array();
      
      public static var onlineFriendList:Array = new Array();
      
      public static var offlineFriendList:Array = new Array();
      
      public function FriendManager()
      {
         super();
      }
      
      public static function haveFriend(param1:String) : Boolean
      {
         return friendObj[param1] != null;
      }
      
      public static function getOnlineFriendNams() : Array
      {
         return onlineFriendList.map(getName);
      }
      
      public static function getOfflineFriendNams() : Array
      {
         return offlineFriendList.map(getName);
      }
      
      private static function getName(param1:FriendInfo, param2:int, param3:Array) : String
      {
         if(param1)
         {
            return param1.friendName;
         }
         return "";
      }
      
      public static function addFriend() : void
      {
      }
      
      public static function sortFriendList() : void
      {
         onlineFriendList.sortOn(["relationValue","level","friendName"],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING,Array.DESCENDING]);
         offlineFriendList.sortOn(["relationValue","level","friendName"],[Array.NUMERIC | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING,Array.DESCENDING]);
      }
      
      public static function getFriendInfoById(param1:String) : FriendInfo
      {
         return friendObj[param1];
      }
      
      public static function getFriendRelLevel(param1:int) : int
      {
         var _loc2_:Array = NumberConfig.getSettingObject("relLevelValues") as Array;
         if(!_loc2_)
         {
            return 1;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(param1 < _loc2_[_loc3_])
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return _loc2_.length;
      }
      
      public static function getFriendRelLevelName(param1:int) : String
      {
         var _loc2_:Array = NumberConfig.getSettingObject("relLevelNames") as Array;
         if(!_loc2_)
         {
            return DiversityManager.getString("FriendUI","unknownFriendName");
         }
         if(param1 > 0 && param1 <= _loc2_.length)
         {
            return _loc2_[param1 - 1];
         }
         return DiversityManager.getString("FriendUI","unknownFriendName");
      }
      
      public static function initBadPlayer(param1:Array) : void
      {
         badList = param1;
         if(obf_K_e_3075.obf_w_f_4556)
         {
            obf_K_e_3075.obf_w_f_4556.setBadPlayerList(param1);
         }
      }
      
      public static function obf_0_2_R_182(param1:String) : Boolean
      {
         if(!badList)
         {
            return false;
         }
         return badList.indexOf(param1) > -1;
      }
      
      public static function addBadPlayer(param1:String) : void
      {
         if(!badList || obf_0_2_R_182(param1))
         {
            return;
         }
         if(badList.length >= 50)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FriendUI","promptAddBadError_Full"));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("FriendUI","promptConfirmAddBadPlayer",[param1]),confirmAddBad,param1);
      }
      
      private static function confirmAddBad(param1:Object) : void
      {
         if(!param1.confirm)
         {
            return;
         }
         if(!GameContext.userConfig.hasOwnProperty("scl"))
         {
            GameContext.userConfig["scl"] = new Object();
         }
         if(!GameContext.userConfig.scl.hasOwnProperty("bps"))
         {
            GameContext.userConfig.scl["bps"] = badList;
         }
         badList.push(param1.par);
         if(obf_K_e_3075.obf_w_f_4556)
         {
            obf_K_e_3075.obf_w_f_4556.setBadPlayerList(badList);
         }
         GameContext.saveConfig();
      }
      
      public static function obf_G_1_4098(param1:String) : void
      {
         if(!badList || !obf_0_2_R_182(param1))
         {
            return;
         }
         badList.splice(badList.indexOf(param1),1);
         if(obf_K_e_3075.obf_w_f_4556)
         {
            obf_K_e_3075.obf_w_f_4556.setBadPlayerList(badList);
         }
         GameContext.saveConfig();
      }
      
      public static function destroy() : void
      {
         friendObj = new Object();
         friendList = new Array();
         onlineFriendList = new Array();
         offlineFriendList = new Array();
      }
      
      public static function sendAddFriend(param1:String) : void
      {
         if(haveFriend(param1))
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FriendUI","promptAddError_haveFriend"));
            return;
         }
         var _loc2_:PlayerAddFriendRequest = new PlayerAddFriendRequest();
         _loc2_.targetPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
         obf_6_D_3816.print(DiversityManager.getString("FriendUI","promptAddRequestSended"));
      }
      
      public static function sendAddFriendReply(param1:String, param2:Boolean) : void
      {
         var _loc3_:PlayerProcessAddFriendRequestReply = new PlayerProcessAddFriendRequestReply();
         _loc3_.isAgreed = param2;
         _loc3_.sourcePlayerId = param1;
         GameContext.worldClient.sendCommand(_loc3_);
      }
      
      private static function confirmAddFriend(param1:Object) : void
      {
         sendAddFriendReply(param1.par,param1.confirm);
      }
      
      public static function sendRemoveFriend(param1:String) : void
      {
         var _loc2_:PlayerRemoveFriendRequest = new PlayerRemoveFriendRequest();
         _loc2_.targetPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
      }
      
      public static function removeFriend(param1:String) : void
      {
         WindowManager.showConfirmBox(DiversityManager.getString("FriendUI","promptConfirmRemove",[param1]),confirmRemoveFriend,param1);
      }
      
      private static function confirmRemoveFriend(param1:Object) : void
      {
         if(param1.confirm)
         {
            sendRemoveFriend(param1.par);
         }
      }
      
      public static function sendGift(param1:String) : void
      {
         var _loc2_:FriendInfo = getFriendInfoById(param1);
         if(!obf_K_e_3075.playerBagUI || !_loc2_ || !_loc2_.isOnline)
         {
            return;
         }
         var _loc3_:String = JSONUtil.getStr(NumberConfig.getSettingObject("relMoodItems"),[_loc2_.moodIndex + ""]);
         if(obf_K_e_3075.playerBagUI.getItemCount(_loc3_) <= 0)
         {
            obf_K_e_3075.showTipInfo(DiversityManager.getString("FriendUI","promptGiftError_NotHaveItem",[GameItemManager.getItemName(_loc3_)]));
            return;
         }
         WindowManager.showConfirmBox(DiversityManager.getString("FriendUI","promptConfirmGift",[GameItemManager.getItemName(_loc3_)]),confirmGift,param1);
      }
      
      private static function confirmGift(param1:Object) : void
      {
         if(param1.confirm)
         {
            sendGiftCommand(param1.par);
         }
      }
      
      public static function sendGiftCommand(param1:String) : void
      {
         var _loc2_:PlayerSendGiftRequest = new PlayerSendGiftRequest();
         _loc2_.targetPlayerId = param1;
         GameContext.worldClient.sendCommand(_loc2_);
         obf_6_D_3816.print(DiversityManager.getString("FriendUI","promptGiftSended"));
      }
      
      public static function doCommand(param1:obf_C_m_1350) : void
      {
         if(param1.code == CommandCodePlayer.PLAYER_ENTER_WORLD_ANSWER)
         {
            onInitFriend(param1 as PlayerEnterWorldAnswer);
         }
         else if(param1.code == CommandCodePlayerFriend.PLAYER_ADD_FRIEND_ANSWER)
         {
            onFriendAddAnswer(param1 as PlayerAddFriendAnswer);
         }
         else if(param1.code == CommandCodePlayerFriend.PLAYER_FRIEND_CHECK_NOTIFY)
         {
            obf_L_M_3361(param1 as PlayerFriendCheckNotify);
         }
         else if(param1.code == CommandCodePlayerFriend.PLAYER_RECEIVE_ADD_FRIEND_REQUEST_NOTIFY)
         {
            onReceiveAddFriend(param1 as PlayerReceiveAddFriendRequestNotify);
         }
         else if(param1.code == CommandCodePlayerFriend.PLAYER_REMOVED_FRIEND_NOTIFY)
         {
            onRemoveFriend(param1 as PlayerRemovedFriendNotify);
         }
         else if(param1.code == CommandCodePlayerFriend.PLAYER_RECEIVE_GIFT_NOTIFY)
         {
            onReceiveGift(param1 as PlayerReceiveGiftNotify);
         }
      }
      
      private static function onInitFriend(param1:PlayerEnterWorldAnswer) : void
      {
         var _loc2_:FriendInfo = null;
         friendObj = new Object();
         GameContext.localPlayer.obf_Z_b_1393 = friendObj;
         onlineFriendList = new Array();
         offlineFriendList = new Array();
         friendList = param1.friendList;
         for each(_loc2_ in friendList)
         {
            friendObj[_loc2_.friendName] = _loc2_;
            if(_loc2_.isOnline)
            {
               onlineFriendList.push(_loc2_);
            }
            else
            {
               offlineFriendList.push(_loc2_);
            }
         }
         if(obf_K_e_3075.obf_w_f_4556)
         {
            obf_K_e_3075.obf_w_f_4556.addAllFriend();
         }
         initBadPlayer(JSONUtil.getObject(GameContext.userConfig,["scl","bps"],new Array()) as Array);
      }
      
      private static function obf_L_M_3361(param1:PlayerFriendCheckNotify) : void
      {
         var _loc2_:FriendInfo = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         if(!haveFriend(param1.friend.friendName))
         {
            friendObj[param1.friend.friendName] = param1.friend;
            friendList.push(param1.friend);
            if(param1.friend.isOnline)
            {
               onlineFriendList.push(param1.friend);
            }
            else
            {
               offlineFriendList.push(param1.friend);
            }
            if(obf_K_e_3075.obf_w_f_4556)
            {
               obf_K_e_3075.obf_w_f_4556.addFriend(param1.friend);
               obf_K_e_3075.obf_w_f_4556.refreshFriendList();
            }
         }
         else
         {
            _loc2_ = friendObj[param1.friend.friendName];
            _loc3_ = _loc2_.isOnline != param1.friend.isOnline;
            _loc4_ = _loc2_.relationValue != param1.friend.relationValue;
            _loc2_.isOnline = param1.friend.isOnline;
            _loc2_.level = param1.friend.level;
            _loc2_.relationValue = param1.friend.relationValue;
            _loc2_.moodIndex = param1.friend.moodIndex;
            if(_loc3_)
            {
               if(param1.friend.isOnline)
               {
                  offlineFriendList.splice(offlineFriendList.indexOf(_loc2_),1);
                  onlineFriendList.push(_loc2_);
                  obf_6_D_3816.print(DiversityManager.getString("FriendUI","promptOnline",[_loc2_.friendName]));
               }
               else
               {
                  onlineFriendList.splice(onlineFriendList.indexOf(_loc2_),1);
                  offlineFriendList.push(_loc2_);
                  obf_6_D_3816.print(DiversityManager.getString("FriendUI","promptOffline",[_loc2_.friendName]));
               }
            }
            if(_loc3_ || _loc4_)
            {
               if(obf_K_e_3075.obf_w_f_4556)
               {
                  obf_K_e_3075.obf_w_f_4556.refreshFriendList();
               }
            }
            else if(obf_K_e_3075.obf_w_f_4556)
            {
               obf_K_e_3075.obf_w_f_4556.refreshFriend(param1.friend.friendName);
            }
         }
      }
      
      private static function onFriendAddAnswer(param1:PlayerAddFriendAnswer) : void
      {
         if(param1.isAgreed)
         {
            obf_6_D_3816.print(DiversityManager.getString("FriendUI","promptAddAgree",[param1.targetPlayerId]));
         }
         else
         {
            obf_6_D_3816.print(DiversityManager.getString("FriendUI","promptAddNotAgree",[param1.targetPlayerId]));
         }
      }
      
      private static function onReceiveAddFriend(param1:PlayerReceiveAddFriendRequestNotify) : void
      {
         if(obf_0_2_R_182(param1.sourcePlayerId))
         {
            return;
         }
         WindowManager.showConfirmSmallBox(DiversityManager.getString("FriendUI","promptReceiveAddConfig",[param1.sourcePlayerId]),confirmAddFriend,param1.sourcePlayerId,"AddFriendConfirm_" + param1.sourcePlayerId);
      }
      
      private static function onRemoveFriend(param1:PlayerRemovedFriendNotify) : void
      {
         var _loc2_:FriendInfo = friendObj[param1.removedPlayerId];
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = friendList.indexOf(_loc2_);
         if(_loc3_ > -1)
         {
            friendList.splice(_loc3_,1);
         }
         var _loc4_:int = onlineFriendList.indexOf(_loc2_);
         if(_loc4_ > -1)
         {
            onlineFriendList.splice(_loc4_,1);
         }
         var _loc5_:int = offlineFriendList.indexOf(_loc2_);
         if(_loc5_ > -1)
         {
            offlineFriendList.splice(_loc5_,1);
         }
         delete friendObj[param1.removedPlayerId];
         if(obf_K_e_3075.obf_w_f_4556)
         {
            obf_K_e_3075.obf_w_f_4556.removeFriend(param1.removedPlayerId);
            obf_K_e_3075.obf_w_f_4556.refreshFriendList();
         }
         obf_6_D_3816.print(DiversityManager.getString("FriendUI","promptRemoved",[param1.removedPlayerId]));
      }
      
      private static function onReceiveGift(param1:PlayerReceiveGiftNotify) : void
      {
         var _loc2_:String = "";
         var _loc3_:FriendInfo = getFriendInfoById(param1.fromPlayerId);
         if(_loc3_)
         {
            _loc2_ = getFriendRelLevelName(getFriendRelLevel(_loc3_.relationValue));
         }
         obf_6_D_3816.print(DiversityManager.getString("FriendUI","promptReceivedGift",[param1.fromPlayerId,_loc2_]));
      }
   }
}

