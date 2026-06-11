package com.sunweb.game.rpg.worldZone.command.angel
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAngelGodUpRequest extends obf_O_8_1034
   {
      
      public function PlayerAngelGodUpRequest()
      {
         super(CommandCodeAngel.PLAYER_ANGEL_GOD_UP_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

