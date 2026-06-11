package com.sunweb.game.rpg.worldZone.command.trap
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapTrapRemovedNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var trapId:String;
      
      public function MapTrapRemovedNotify()
      {
         super(CommandCodeMapTrap.MAP_TRAP_REMOVED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","trapId:string"];
      }
   }
}

