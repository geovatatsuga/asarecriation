package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.family.FamilyViewInfo;
   
   public class PlayerViewFamilyAnswer extends obf_O_8_1034
   {
      
      public var familyInfo:FamilyViewInfo;
      
      public function PlayerViewFamilyAnswer()
      {
         super(CommandCodePlayerFamily.PLAYER_VIEW_FAMILY_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["familyInfo:com.sunweb.game.rpg.family.FamilyViewInfo"];
      }
   }
}

