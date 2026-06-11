package com.sunweb.game.rpg.worldZone.command.equ
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRepairEquipmentRequest extends obf_O_8_1034
   {
      
      public var equipmentId:String;
      
      public var isPerfectRepair:Boolean;
      
      public function PlayerRepairEquipmentRequest()
      {
         super(CommandCodePlayerEquip.PLAYER_REPAIR_EQUIPMENT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentId:string","isPerfectRepair:boolean"];
      }
   }
}

