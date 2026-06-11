package com.sunweb.game.rpg.worldZone.command.map
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class MapNpcSayNotify extends obf_O_8_1034
   {
      
      public var npcSay:Object;
      
      public function MapNpcSayNotify()
      {
         super(CommandCodeMap.MAP_NPC_SAY_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcSay:map(string,string)"];
      }
   }
}

