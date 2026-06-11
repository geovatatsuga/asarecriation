package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LuckChangeConstellationAnswer extends obf_O_8_1034
   {
      
      public var luckLevel:int;
      
      public function LuckChangeConstellationAnswer()
      {
         super(CommandCodePlayerConstellation.LUCK_CHANGE_CONSTELLATION_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["luckLevel:ubyte"];
      }
   }
}

