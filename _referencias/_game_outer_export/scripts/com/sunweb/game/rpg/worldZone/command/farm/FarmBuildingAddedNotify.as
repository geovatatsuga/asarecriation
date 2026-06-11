package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.farm.FarmBuildingInfo;
   
   public class FarmBuildingAddedNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var building:FarmBuildingInfo;
      
      public function FarmBuildingAddedNotify()
      {
         super(CommandCodeFarm.FARM_BUILDING_ADDED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","building:com.sunweb.game.rpg.farm.FarmBuildingInfo"];
      }
   }
}

