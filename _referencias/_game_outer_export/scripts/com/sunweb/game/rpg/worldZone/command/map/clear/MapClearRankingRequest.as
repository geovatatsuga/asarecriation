package com.sunweb.game.rpg.worldZone.command.map.clear
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapClearRankingRequest extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var num:int;
      
      public function MapClearRankingRequest()
      {
         super(CommandCodeMapClear.MAP_CLEAR_RANKING_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","num:ubyte"];
      }
   }
}

