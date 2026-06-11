package com.sunweb.game.rpg.worldZone.command.map.tower
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapTowerNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var resultTimeInSec:int;
      
      public var resultGrade:String;
      
      public function MapTowerNotify()
      {
         super(CommandCodeMapTower.MAP_TOWER_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","resultTimeInSec:int","resultGrade:string"];
      }
   }
}

