package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerViewJoinFamilyListAnswer extends obf_O_8_1034
   {
      
      public var joinRequestList:Array;
      
      public function PlayerViewJoinFamilyListAnswer()
      {
         super(CommandCodePlayerFamily.PLAYER_VIEW_JOIN_FAMILY_LIST_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["joinRequestList:array(com.sunweb.game.rpg.family.FamilyJoinRequestInfo)"];
      }
   }
}

