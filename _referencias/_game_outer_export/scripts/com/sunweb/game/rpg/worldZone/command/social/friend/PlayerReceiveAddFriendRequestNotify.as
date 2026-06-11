package com.sunweb.game.rpg.worldZone.command.social.friend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReceiveAddFriendRequestNotify extends obf_O_8_1034
   {
      
      public var sourcePlayerId:String;
      
      public function PlayerReceiveAddFriendRequestNotify()
      {
         super(CommandCodePlayerFriend.PLAYER_RECEIVE_ADD_FRIEND_REQUEST_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["sourcePlayerId:string"];
      }
   }
}

