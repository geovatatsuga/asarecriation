package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FarmBuildingRemovedNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var buildingId:String;
      
      public function FarmBuildingRemovedNotify()
      {
         super(CommandCodeFarm.FARM_BUILDING_REMOVED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","buildingId:string"];
      }
   }
}

