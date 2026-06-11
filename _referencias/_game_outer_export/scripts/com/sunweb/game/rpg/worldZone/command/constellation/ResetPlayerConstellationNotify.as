package com.sunweb.game.rpg.worldZone.command.constellation
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ResetPlayerConstellationNotify extends obf_O_8_1034
   {
      
      public var constellationLevel:int;
      
      public var luckLevel:int;
      
      public var hartLevel:int;
      
      public var taskId:int;
      
      public function ResetPlayerConstellationNotify()
      {
         super(CommandCodePlayerConstellation.RESET_PLAYER_CONSTELLATION_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["constellationLevel:ubyte","luckLevel:ubyte","hartLevel:ubyte","taskId:ushort"];
      }
   }
}

