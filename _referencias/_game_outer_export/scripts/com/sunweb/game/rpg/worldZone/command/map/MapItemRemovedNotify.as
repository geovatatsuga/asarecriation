package com.sunweb.game.rpg.worldZone.command.map
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapItemRemovedNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var itemId:String;
      
      public function MapItemRemovedNotify()
      {
         super(CommandCodeMap.MAP_ITEM_REMOVED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","itemId:string"];
      }
   }
}

