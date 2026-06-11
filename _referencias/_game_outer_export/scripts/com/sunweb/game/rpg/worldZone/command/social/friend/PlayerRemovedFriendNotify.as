package com.sunweb.game.rpg.worldZone.command.social.friend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRemovedFriendNotify extends obf_O_8_1034
   {
      
      public var removedPlayerId:String;
      
      public function PlayerRemovedFriendNotify()
      {
         super(CommandCodePlayerFriend.PLAYER_REMOVED_FRIEND_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["removedPlayerId:string"];
      }
   }
}

