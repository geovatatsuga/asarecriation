package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.farm.LocalPlayerFarmInfo;
   
   public class FarmListCheckNotify extends obf_O_8_1034
   {
      
      public var mainFarm:LocalPlayerFarmInfo;
      
      public var extraFarmArray:Array;
      
      public function FarmListCheckNotify()
      {
         super(CommandCodeFarm.FARM_LIST_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mainFarm:com.sunweb.game.rpg.farm.LocalPlayerFarmInfo","extraFarmArray:array(com.sunweb.game.rpg.farm.LocalPlayerFarmInfo)"];
      }
   }
}

