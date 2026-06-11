package com.sunweb.game.rpg.worldZone.command.map.clear
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapClearedDoMacroRequest extends obf_O_8_1034
   {
      
      public var mapId:String;
      
      public function MapClearedDoMacroRequest()
      {
         super(CommandCodeMapClear.MAP_CLEAR_DO_MACRO_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["mapId:string"];
      }
   }
}

