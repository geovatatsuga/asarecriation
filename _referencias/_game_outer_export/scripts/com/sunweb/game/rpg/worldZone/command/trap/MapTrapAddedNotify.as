package com.sunweb.game.rpg.worldZone.command.trap
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.role.MapTrapInfo;
   
   public class MapTrapAddedNotify extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public var trap:MapTrapInfo;
      
      public function MapTrapAddedNotify()
      {
         super(CommandCodeMapTrap.MAP_TRAP_ADDED_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string","trap:com.sunweb.game.rpg.role.MapTrapInfo"];
      }
   }
}

