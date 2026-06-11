package com.sunweb.game.rpg.worldZone.command.farm
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class FarmLevelUpRequest extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var farmId:String;
      
      public function FarmLevelUpRequest()
      {
         super(CommandCodeFarm.FARM_LEVEL_UP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","farmId:string"];
      }
   }
}

