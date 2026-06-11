package com.sunweb.game.rpg.worldZone.command.social.friend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAddFriendRequest extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public function PlayerAddFriendRequest()
      {
         super(CommandCodePlayerFriend.PLAYER_ADD_FRIEND_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string"];
      }
      
      override public function getDigestKey() : int
      {
         return 62210;
      }
   }
}

