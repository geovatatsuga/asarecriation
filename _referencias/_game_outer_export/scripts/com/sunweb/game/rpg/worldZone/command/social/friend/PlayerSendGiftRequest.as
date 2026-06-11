package com.sunweb.game.rpg.worldZone.command.social.friend
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerSendGiftRequest extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public function PlayerSendGiftRequest()
      {
         super(CommandCodePlayerFriend.PLAYER_SEND_GIFT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string"];
      }
   }
}

