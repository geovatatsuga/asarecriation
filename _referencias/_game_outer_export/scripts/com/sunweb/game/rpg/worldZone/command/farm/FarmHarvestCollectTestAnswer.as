package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FarmHarvestCollectTestAnswer extends obf_O_8_1034
   {
      
      public var farmHarvestId:String;
      
      public var canCollect:Boolean;
      
      public var hasNoProduct:Boolean;
      
      public var collectTimes:int;
      
      public var cdTimeLeftInSec:int;
      
      public function FarmHarvestCollectTestAnswer()
      {
         super(CommandCodeFarm.FARM_HARVEST_COLLECT_TEST_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["farmHarvestId:string","canCollect:boolean","hasNoProduct:boolean","collectTimes:short","cdTimeLeftInSec:int"];
      }
   }
}

