package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerReceiveInviteFamilyRequestNotify extends obf_O_8_1034
   {
      
      public var sourcePlayerId:String;
      
      public var familyName:String;
      
      public function PlayerReceiveInviteFamilyRequestNotify()
      {
         super(CommandCodePlayerFamily.PLAYER_RECEIVE_INVITE_FAMILY_REQUEST_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["sourcePlayerId:string","familyName:string"];
      }
   }
}

