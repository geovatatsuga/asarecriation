package com.sunweb.game.rpg.worldZone.command.rideEquipment
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class RideSaveChangeRequest extends obf_O_8_1034
   {
      
      public var id:String;
      
      public var kind:int;
      
      public var type:int;
      
      public function RideSaveChangeRequest()
      {
         super(CommandCodePlayerRideEquipment.RIDE_SAVE_CHANGE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["id:string","kind:ubyte","type:ubyte"];
      }
   }
}

