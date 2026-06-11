package com.sunweb.game.rpg.worldZone.command.armory
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ArmoryPropertyNotify extends obf_O_8_1034
   {
      
      public var changedArmorys:Array;
      
      public function ArmoryPropertyNotify()
      {
         super(CommandCodeArmory.PLAYER_ARMORY_PROPERTY_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["changedArmorys:array(com.sunweb.game.rpg.armory.ArmoryItemInfo)"];
      }
   }
}

