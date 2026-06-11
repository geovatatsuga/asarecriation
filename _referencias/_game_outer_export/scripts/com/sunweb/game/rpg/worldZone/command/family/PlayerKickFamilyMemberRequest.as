package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerKickFamilyMemberRequest extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public function PlayerKickFamilyMemberRequest()
      {
         super(CommandCodePlayerFamily.PLAYER_KICK_FAMILY_MEMBER_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string"];
      }
   }
}

