package com.sunweb.game.rpg.worldZone.command.equ
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerEquipDurCheckNotify extends obf_O_8_1034
   {
      
      public var equipmentDurMap:Object;
      
      public function PlayerEquipDurCheckNotify()
      {
         super(CommandCodePlayerEquip.PLAYER_EQUIP_DUR_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentDurMap:map(string,byte)"];
      }
   }
}

