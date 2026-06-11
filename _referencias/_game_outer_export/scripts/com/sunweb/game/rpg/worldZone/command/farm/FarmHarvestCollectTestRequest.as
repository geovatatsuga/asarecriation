package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FarmHarvestCollectTestRequest extends obf_O_8_1034
   {
      
      public var farmHarvestId:String;
      
      public function FarmHarvestCollectTestRequest()
      {
         super(CommandCodeFarm.FARM_HARVEST_COLLECT_TEST_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["farmHarvestId:string"];
      }
   }
}

