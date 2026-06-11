package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class UpPlayerConstellationAnswer extends obf_O_8_1034
   {
      
      public var constellationLevel:int;
      
      public var hartLevel:int;
      
      public function UpPlayerConstellationAnswer()
      {
         super(CommandCodePlayerConstellation.UP_PLAYER_CONSTELLATION_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["constellationLevel:ubyte","hartLevel:ubyte"];
      }
   }
}

