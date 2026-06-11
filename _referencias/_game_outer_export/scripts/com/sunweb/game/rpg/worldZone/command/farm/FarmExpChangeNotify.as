package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FarmExpChangeNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var farmId:String;
      
      public var expChanged:int;
      
      public var expCurrent:int;
      
      public function FarmExpChangeNotify()
      {
         super(CommandCodeFarm.FARM_EXP_CHANGE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","farmId:string","expChanged:int","expCurrent:int"];
      }
   }
}

