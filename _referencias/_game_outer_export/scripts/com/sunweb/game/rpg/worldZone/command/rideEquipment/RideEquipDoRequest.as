package com.sunweb.game.rpg.worldZone.command.rideEquipment
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RideEquipDoRequest extends obf_O_8_1034
   {
      
      public var id:String;
      
      public var kind:int;
      
      public var type:int;
      
      public var isMoneyRefine:Boolean;
      
      public function RideEquipDoRequest()
      {
         super(CommandCodePlayerRideEquipment.RIDE_EQUIP_DO_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["id:string","kind:ubyte","type:ubyte","isMoneyRefine:boolean"];
      }
   }
}

