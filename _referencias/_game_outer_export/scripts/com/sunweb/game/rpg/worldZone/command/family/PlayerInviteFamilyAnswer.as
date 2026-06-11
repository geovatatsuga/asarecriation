package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerInviteFamilyAnswer extends obf_O_8_1034
   {
      
      public var targetPlayerId:String;
      
      public var isAgreed:Boolean;
      
      public function PlayerInviteFamilyAnswer()
      {
         super(CommandCodePlayerFamily.PLAYER_INVITE_FAMILY_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["targetPlayerId:string","isAgreed:boolean"];
      }
   }
}

