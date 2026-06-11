package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FarmHarvestQueryAnswer extends obf_O_8_1034
   {
      
      public var productCode:String;
      
      public var farmArray:Array;
      
      public function FarmHarvestQueryAnswer()
      {
         super(CommandCodeFarm.FARM_HARVEST_QUERY_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["productCode:string","farmArray:array(com.sunweb.game.rpg.farm.RemotePlayerFarmInfo)"];
      }
   }
}

