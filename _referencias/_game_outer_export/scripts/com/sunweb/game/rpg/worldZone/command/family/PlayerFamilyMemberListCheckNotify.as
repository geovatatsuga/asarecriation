package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerFamilyMemberListCheckNotify extends obf_O_8_1034
   {
      
      public var memberList:Array;
      
      public function PlayerFamilyMemberListCheckNotify()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_MEMBER_LIST_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["memberList:array(com.sunweb.game.rpg.family.FamilyMemberInfo)"];
      }
   }
}

