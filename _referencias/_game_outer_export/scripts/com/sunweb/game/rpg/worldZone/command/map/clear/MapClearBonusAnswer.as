package com.sunweb.game.rpg.worldZone.command.map.clear
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapClearBonusAnswer extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var bonusIndex:int;
      
      public var bonusItems:Array;
      
      public function MapClearBonusAnswer()
      {
         super(CommandCodeMapClear.MAP_CLEAR_BONUS_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","bonusIndex:byte","bonusItems:array(com.sunweb.game.rpg.gameItem.GameItemBriefInfo)"];
      }
   }
}

