package com.sunweb.game.rpg.worldZone.command.map.clear
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapClearRankingAnswer extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var bestResultList:Array;
      
      public function MapClearRankingAnswer()
      {
         super(CommandCodeMapClear.MAP_CLEAR_RANKING_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","bestResultList:array(com.sunweb.game.rpg.worldZone.command.map.clear.MapClearResultInfo)"];
      }
   }
}

