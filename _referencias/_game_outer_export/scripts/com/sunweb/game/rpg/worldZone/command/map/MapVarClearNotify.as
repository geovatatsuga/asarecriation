package com.sunweb.game.rpg.worldZone.command.map
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapVarClearNotify extends obf_O_8_1034
   {
      
      public var boolVars:Array;
      
      public var intVars:Array;
      
      public function MapVarClearNotify()
      {
         super(CommandCodeMap.MAP_VAR_CLEAR_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["boolVars:array(string)","intVars:array(string)"];
      }
   }
}

