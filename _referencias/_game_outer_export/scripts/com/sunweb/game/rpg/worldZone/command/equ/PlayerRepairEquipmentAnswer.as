package com.sunweb.game.rpg.worldZone.command.equ
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerRepairEquipmentAnswer extends obf_O_8_1034
   {
      
      public var equipmentId:String;
      
      public var isDone:Boolean;
      
      public function PlayerRepairEquipmentAnswer()
      {
         super(CommandCodePlayerEquip.PLAYER_REPAIR_EQUIPMENT_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["equipmentId:string","isDone:boolean"];
      }
   }
}

