package com.sunweb.game.rpg.worldZone.command.map
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapRefreshNotify extends obf_O_8_1034
   {
      
      public function MapRefreshNotify()
      {
         super(CommandCodeMap.MAP_REFRESH_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

