package com.sunweb.game.rpg.worldZone.command.map.clear
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapClearBonusRequest extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var bonusIndex:int;
      
      public function MapClearBonusRequest()
      {
         super(CommandCodeMapClear.MAP_CLEAR_BONUS_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","bonusIndex:byte"];
      }
   }
}

