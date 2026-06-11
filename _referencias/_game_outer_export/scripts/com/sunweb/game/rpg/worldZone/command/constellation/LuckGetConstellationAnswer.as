package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LuckGetConstellationAnswer extends obf_O_8_1034
   {
      
      public var hartLevel:int;
      
      public function LuckGetConstellationAnswer()
      {
         super(CommandCodePlayerConstellation.LUCK_GET_CONSTELLATION_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["hartLevel:ubyte"];
      }
   }
}

