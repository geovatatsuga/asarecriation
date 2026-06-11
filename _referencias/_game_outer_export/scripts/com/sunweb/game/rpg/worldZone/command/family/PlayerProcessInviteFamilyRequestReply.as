package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerProcessInviteFamilyRequestReply extends obf_O_8_1034
   {
      
      public var sourcePlayerId:String;
      
      public var isAgreed:Boolean;
      
      public function PlayerProcessInviteFamilyRequestReply()
      {
         super(CommandCodePlayerFamily.PLAYER_PROCESS_INVITE_FAMILY_REQUEST_REPLY);
      }
      
      override public function getFieldList() : Array
      {
         return ["sourcePlayerId:string","isAgreed:boolean"];
      }
   }
}

