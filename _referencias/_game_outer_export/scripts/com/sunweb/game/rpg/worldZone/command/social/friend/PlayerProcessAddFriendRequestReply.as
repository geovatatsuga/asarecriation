package com.sunweb.game.rpg.worldZone.command.social.friend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerProcessAddFriendRequestReply extends obf_O_8_1034
   {
      
      public var sourcePlayerId:String;
      
      public var isAgreed:Boolean;
      
      public function PlayerProcessAddFriendRequestReply()
      {
         super(CommandCodePlayerFriend.PLAYER_PROCESS_ADD_FRIEND_REQUEST_REPLY);
      }
      
      override public function getFieldList() : Array
      {
         return ["sourcePlayerId:string","isAgreed:boolean"];
      }
   }
}

