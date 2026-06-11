package com.sunweb.game.rpg.worldZone.command.angel
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAngelEnterRequest extends obf_O_8_1034
   {
      
      public function PlayerAngelEnterRequest()
      {
         super(CommandCodeAngel.PLAYER_ANGEL_ENTER_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

