package com.sunweb.game.rpg.worldZone.command.family
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerListFamilyAnswer extends obf_O_8_1034
   {
      
      public var familyList:Array;
      
      public function PlayerListFamilyAnswer()
      {
         super(CommandCodePlayerFamily.PLAYER_LIST_FAMILY_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["familyList:array(com.sunweb.game.rpg.family.FamilyListInfo)"];
      }
   }
}

