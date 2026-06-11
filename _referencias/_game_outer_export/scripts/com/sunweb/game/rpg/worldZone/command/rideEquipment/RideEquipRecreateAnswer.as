package com.sunweb.game.rpg.worldZone.command.rideEquipment
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RideEquipRecreateAnswer extends obf_O_8_1034
   {
      
      public var attrSoulTem:Array;
      
      public var attrTem:Array;
      
      public var attrFinalTem:Array;
      
      public function RideEquipRecreateAnswer()
      {
         super(CommandCodePlayerRideEquipment.RIDE_EQUIP_RECREATE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["attrSoulTem:array(ubyte)","attrTem:array(short)","attrFinalTem:array(short)"];
      }
   }
}

