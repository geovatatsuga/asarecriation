package com.sunweb.game.rpg.worldZone.command.divine
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerEquipmentDivineRequest extends obf_O_8_1034
   {
      
      public var equipId:String;
      
      public function PlayerEquipmentDivineRequest()
      {
         super(CommandCodePlayerDivine.PLAYER_EQUIPMENT_DIVINE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipId:string"];
      }
   }
}

