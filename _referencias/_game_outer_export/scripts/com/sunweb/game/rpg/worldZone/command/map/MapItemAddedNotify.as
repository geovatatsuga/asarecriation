package com.sunweb.game.rpg.worldZone.command.map
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.world.map.MapItemInfo;
   
   public class MapItemAddedNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var item:MapItemInfo;
      
      public function MapItemAddedNotify()
      {
         super(CommandCodeMap.MAP_ITEM_ADDED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","item:com.sunweb.game.rpg.world.map.MapItemInfo"];
      }
   }
}

