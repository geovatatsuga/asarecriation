package com.sunweb.game.rpg.worldZone.command.angel
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAngelGodNotify extends obf_O_8_1034
   {
      
      public var angelGodExp:int;
      
      public function PlayerAngelGodNotify()
      {
         super(CommandCodeAngel.PLAYER_ANGEL_GOD_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["angelGodExp:int"];
      }
   }
}

