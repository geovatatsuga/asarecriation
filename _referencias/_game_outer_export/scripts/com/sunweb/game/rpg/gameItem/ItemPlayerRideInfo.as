package com.sunweb.game.rpg.gameItem
{
   import com.sunweb.game.net.framework.codec.diy.obf_2_M_853;
   
   public class ItemPlayerRideInfo extends obf_2_M_853
   {
      
      public var rideSpeed:int;
      
      public var level:int = 1;
      
      public var exp:int = 0;
      
      public var lifeAptAdded:int = 0;
      
      public var attackAptAdded:int = 0;
      
      public var defenseAptAdded:int = 0;
      
      public var cureAptAdded:int = 0;
      
      public var generation:int = 0;
      
      public var fusionLifeApt:int = 0;
      
      public var fusionAttackApt:int = 0;
      
      public var fusionDefenseApt:int = 0;
      
      public var fusionCureApt:int = 0;
      
      public var equipmenet:Object;
      
      public function ItemPlayerRideInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return ["rideSpeed:short","level:short","exp:short","lifeAptAdded:short","attackAptAdded:short","defenseAptAdded:short","cureAptAdded:short","generation:ubyte","fusionLifeApt:short","fusionAttackApt:short","fusionDefenseApt:short","fusionCureApt:short","equipmenet:map(ubyte,com.sunweb.game.rpg.rideEquip.RideEquipmentInfo)"];
      }
   }
}

