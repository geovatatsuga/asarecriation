package com.sunweb.game.rpg.worldZone.event
{
   import com.sunweb.game.rpg.worldZone.command.social.friend.CommandCodePlayerFriend;
   
   public class FriendEvent
   {
      
      public static const PLAYER_ADD_FRIEND_ANSWER:String = CommandCodePlayerFriend.PLAYER_ADD_FRIEND_ANSWER.toString(16);
      
      public static const PLAYER_FRIEND_CHECK_NOTIFY:String = CommandCodePlayerFriend.PLAYER_FRIEND_CHECK_NOTIFY.toString(16);
      
      public static const PLAYER_RECEIVE_ADD_FRIEND_REQUEST_NOTIFY:String = CommandCodePlayerFriend.PLAYER_RECEIVE_ADD_FRIEND_REQUEST_NOTIFY.toString(16);
      
      public static const PLAYER_REMOVED_FRIEND_NOTIFY:String = CommandCodePlayerFriend.PLAYER_REMOVED_FRIEND_NOTIFY.toString(16);
      
      public static const PLAYER_RECEIVE_GIFT_NOTIFY:String = CommandCodePlayerFriend.PLAYER_RECEIVE_GIFT_NOTIFY.toString(16);
      
      public function FriendEvent()
      {
         super();
      }
   }
}

