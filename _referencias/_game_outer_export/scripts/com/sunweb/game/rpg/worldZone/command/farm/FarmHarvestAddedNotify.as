package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.farm.FarmHarvestInfo;
   
   public class FarmHarvestAddedNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var harvest:FarmHarvestInfo;
      
      public function FarmHarvestAddedNotify()
      {
         super(CommandCodeFarm.FARM_HARVEST_ADDED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","harvest:com.sunweb.game.rpg.farm.FarmHarvestInfo"];
      }
   }
}

