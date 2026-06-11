package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FarmBuildingRemoveRequest extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var farmBuildingId:String;
      
      public function FarmBuildingRemoveRequest()
      {
         super(CommandCodeFarm.FARM_BUILDING_REMOVE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","farmBuildingId:string"];
      }
   }
}

