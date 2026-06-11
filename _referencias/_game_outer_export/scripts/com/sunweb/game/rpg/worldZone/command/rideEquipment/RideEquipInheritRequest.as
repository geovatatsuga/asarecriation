package com.sunweb.game.rpg.worldZone.command.rideEquipment
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RideEquipInheritRequest extends obf_O_8_1034
   {
      
      public var doId:String;
      
      public var passiveId:String;
      
      public function RideEquipInheritRequest()
      {
         super(CommandCodePlayerRideEquipment.RIDE_EQUIP_INHERIT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["doId:string","passiveId:string"];
      }
   }
}

