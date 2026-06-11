package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.family.FamilyMemberInfo;
   
   public class PlayerFamilyMemberInfoCheckNotify extends obf_O_8_1034
   {
      
      public var member:FamilyMemberInfo;
      
      public function PlayerFamilyMemberInfoCheckNotify()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_MEMBER_INFO_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["member:com.sunweb.game.rpg.family.FamilyMemberInfo"];
      }
   }
}

