package com.sunweb.game.rpg.worldZone.command.map.clear
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapClearInfoCheckNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var usedTimeInSec:int;
      
      public var bestResultList:Array;
      
      public function MapClearInfoCheckNotify()
      {
         super(CommandCodeMapClear.MAP_CLEAR_INFO_CHECK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","usedTimeInSec:int","bestResultList:array(com.sunweb.game.rpg.worldZone.command.map.clear.MapClearResultInfo)"];
      }
   }
}

