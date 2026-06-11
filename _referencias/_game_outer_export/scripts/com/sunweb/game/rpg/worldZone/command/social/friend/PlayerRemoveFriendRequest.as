package com.sunweb.game.rpg.worldZone.command.social.friend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRemoveFriendRequest extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public function PlayerRemoveFriendRequest()
      {
         super(CommandCodePlayerFriend.PLAYER_REMOVE_FRIEND_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string"];
      }
   }
}

