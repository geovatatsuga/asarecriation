package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.family.FamilyInfo;
   
   public class PlayerFamilyInfoCheckNotify extends obf_O_8_1034
   {
      
      public var familyInfo:FamilyInfo;
      
      public function PlayerFamilyInfoCheckNotify()
      {
         super(CommandCodePlayerFamily.PLAYER_FAMILY_INFO_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["familyInfo:com.sunweb.game.rpg.family.FamilyInfo"];
      }
   }
}

