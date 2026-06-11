package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerInviteFamilyRequest extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public function PlayerInviteFamilyRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_INVITE_FAMILY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string"];
      }
   }
}

