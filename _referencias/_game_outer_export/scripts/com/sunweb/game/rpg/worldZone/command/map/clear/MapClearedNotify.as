package com.sunweb.game.rpg.worldZone.command.map.clear
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapClearedNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var resultTimeInSec:int;
      
      public var resultRank:int;
      
      public function MapClearedNotify()
      {
         super(CommandCodeMapClear.MAP_CLEARED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","resultTimeInSec:int","resultRank:ushort"];
      }
   }
}

