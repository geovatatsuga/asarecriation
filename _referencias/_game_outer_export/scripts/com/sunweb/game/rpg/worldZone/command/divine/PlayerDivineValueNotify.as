package com.sunweb.game.rpg.worldZone.command.divine
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerDivineValueNotify extends obf_O_8_1034
   {
      
      public var divineValue:int;
      
      public function PlayerDivineValueNotify()
      {
         super(CommandCodePlayerDivine.PLAYER_DIVINE_VALUE_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["divineValue:int"];
      }
   }
}

