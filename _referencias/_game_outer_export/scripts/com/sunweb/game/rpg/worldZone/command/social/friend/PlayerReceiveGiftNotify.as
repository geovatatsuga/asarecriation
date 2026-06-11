package com.sunweb.game.rpg.worldZone.command.social.friend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReceiveGiftNotify extends obf_O_8_1034
   {
      
      public var fromPlayerId:String;
      
      public function PlayerReceiveGiftNotify()
      {
         super(CommandCodePlayerFriend.PLAYER_RECEIVE_GIFT_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["fromPlayerId:string"];
      }
   }
}

