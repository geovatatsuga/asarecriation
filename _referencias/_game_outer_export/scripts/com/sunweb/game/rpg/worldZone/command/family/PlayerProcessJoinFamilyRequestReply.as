package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerProcessJoinFamilyRequestReply extends obf_O_8_1034
   {
      
      public var sourcePlayerId:String;
      
      public var isAgreed:Boolean;
      
      public function PlayerProcessJoinFamilyRequestReply()
      {
         super(CommandCodePlayerFamily.PLAYER_PROCESS_JOIN_FAMILY_REQUEST_REPLY);
      }
      
      override public function getFieldList() : Array
      {
         return ["sourcePlayerId:string","isAgreed:boolean"];
      }
   }
}

