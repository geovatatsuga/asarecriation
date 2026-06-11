package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FarmHarvestQueryRequest extends obf_O_8_1034
   {
      
      public var productCode:String;
      
      public function FarmHarvestQueryRequest()
      {
         super(CommandCodeFarm.FARM_HARVEST_QUERY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["productCode:string"];
      }
   }
}

