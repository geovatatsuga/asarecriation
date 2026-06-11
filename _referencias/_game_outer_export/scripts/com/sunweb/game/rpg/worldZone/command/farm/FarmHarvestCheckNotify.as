package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.farm.FarmHarvestCheckInfo;
   
   public class FarmHarvestCheckNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var harvest:FarmHarvestCheckInfo;
      
      public function FarmHarvestCheckNotify()
      {
         super(CommandCodeFarm.FARM_HARVEST_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","harvest:com.sunweb.game.rpg.farm.FarmHarvestCheckInfo"];
      }
   }
}

