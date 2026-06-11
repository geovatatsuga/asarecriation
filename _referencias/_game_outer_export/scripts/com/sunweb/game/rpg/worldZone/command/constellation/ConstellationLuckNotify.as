package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ConstellationLuckNotify extends obf_O_8_1034
   {
      
      public var luckLevel:int;
      
      public function ConstellationLuckNotify()
      {
         super(CommandCodePlayerConstellation.CONSTELLATION_LUCK_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["luckLevel:ubyte"];
      }
   }
}

