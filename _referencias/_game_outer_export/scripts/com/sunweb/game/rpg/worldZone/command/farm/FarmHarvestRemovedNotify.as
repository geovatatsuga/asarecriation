package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FarmHarvestRemovedNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var harvestId:String;
      
      public function FarmHarvestRemovedNotify()
      {
         super(CommandCodeFarm.FARM_HARVEST_REMOVED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","harvestId:string"];
      }
   }
}

