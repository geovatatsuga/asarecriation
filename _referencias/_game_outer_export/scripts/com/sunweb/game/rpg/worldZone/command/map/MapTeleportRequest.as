package com.sunweb.game.rpg.worldZone.command.map
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapTeleportRequest extends obf_O_8_1034
   {
      
      public var toMapId:String;
      
      public var useItem:Boolean;
      
      public function MapTeleportRequest()
      {
         super(CommandCodeMap.MAP_TELEPORT_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["toMapId:string","useItem:boolean"];
      }
   }
}

