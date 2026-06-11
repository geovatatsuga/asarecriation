package com.sunweb.game.rpg.worldZone.command.rideEquipment
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RideEquipRefineAnswer extends obf_O_8_1034
   {
      
      public var newAttr:Array;
      
      public var isLimit:Array;
      
      public var soul:int = 0;
      
      public function RideEquipRefineAnswer()
      {
         super(CommandCodePlayerRideEquipment.RIDE_EQUIP_REFINE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["newAttr:array(short)","isLimit:array(boolean)","soul:ubyte"];
      }
   }
}

