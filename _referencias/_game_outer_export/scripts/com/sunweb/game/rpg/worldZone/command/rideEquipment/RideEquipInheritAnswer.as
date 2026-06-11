package com.sunweb.game.rpg.worldZone.command.rideEquipment
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.gameItem.ItemPlayerRideInfo;
   
   public class RideEquipInheritAnswer extends obf_O_8_1034
   {
      
      public var doInfo:ItemPlayerRideInfo;
      
      public var passiveInfo:ItemPlayerRideInfo;
      
      public function RideEquipInheritAnswer()
      {
         super(CommandCodePlayerRideEquipment.RIDE_EQUIP_INHERIT_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["doInfo:com.sunweb.game.rpg.gameItem.ItemPlayerRideInfo","passiveInfo:com.sunweb.game.rpg.gameItem.ItemPlayerRideInfo"];
      }
   }
}

