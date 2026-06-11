package com.sunweb.game.rpg.worldZone.command.social.friend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.social.FriendInfo;
   
   public class PlayerFriendCheckNotify extends obf_O_8_1034
   {
      
      public var friend:FriendInfo;
      
      public function PlayerFriendCheckNotify()
      {
         super(CommandCodePlayerFriend.PLAYER_FRIEND_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["friend:com.sunweb.game.rpg.social.FriendInfo"];
      }
   }
}

