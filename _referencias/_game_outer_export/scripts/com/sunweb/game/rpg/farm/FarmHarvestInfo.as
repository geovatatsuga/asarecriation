package com.sunweb.game.rpg.farm
{
   public class FarmHarvestInfo extends FarmHarvestCheckInfo
   {
      
      public var createrId:String;
      
      public var code:String;
      
      public var x:int;
      
      public var y:int;
      
      public function FarmHarvestInfo()
      {
         super();
      }
      
      override public function getFieldList() : Array
      {
         return super.getFieldList().concat(["createrId:string","code:string","x:short","y:short"]);
      }
   }
}

