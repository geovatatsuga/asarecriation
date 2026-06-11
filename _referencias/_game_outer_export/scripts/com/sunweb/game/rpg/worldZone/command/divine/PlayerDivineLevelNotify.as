package com.sunweb.game.rpg.worldZone.command.divine
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerDivineLevelNotify extends obf_O_8_1034
   {
      
      public var divineLevel:int;
      
      public function PlayerDivineLevelNotify()
      {
         super(CommandCodePlayerDivine.PLAYER_DIVINE_LEVEL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["divineLevel:ubyte"];
      }
   }
}

