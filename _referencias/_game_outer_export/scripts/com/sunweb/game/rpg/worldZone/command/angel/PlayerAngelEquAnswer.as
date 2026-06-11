package com.sunweb.game.rpg.worldZone.command.angel
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAngelEquAnswer extends obf_O_8_1034
   {
      
      public var rankMap:Object;
      
      public function PlayerAngelEquAnswer()
      {
         super(CommandCodeAngel.PLAYER_ANGEL_EQU_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["rankMap:map(string,string)"];
      }
   }
}

