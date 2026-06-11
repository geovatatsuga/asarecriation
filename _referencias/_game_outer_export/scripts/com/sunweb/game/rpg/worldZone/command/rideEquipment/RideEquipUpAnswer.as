package com.sunweb.game.rpg.worldZone.command.rideEquipment
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.rideEquip.RideEquipmentInfo;
   
   public class RideEquipUpAnswer extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var info:RideEquipmentInfo;
      
      public function RideEquipUpAnswer()
      {
         super(CommandCodePlayerRideEquipment.RIDE_EQUIP_UP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","info:com.sunweb.game.rpg.rideEquip.RideEquipmentInfo"];
      }
   }
}

