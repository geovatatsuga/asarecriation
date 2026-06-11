package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class LuckGetConstellationRequest extends obf_O_8_1034
   {
      
      public var luckLevel:int;
      
      public function LuckGetConstellationRequest()
      {
         super(CommandCodePlayerConstellation.LUCK_GET_CONSTELLATION_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["luckLevel:ubyte"];
      }
   }
}

