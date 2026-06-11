package com.sunweb.game.rpg.worldZone.command.angel
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerAngelUpAnswer extends obf_O_8_1034
   {
      
      public var angelList:Array;
      
      public function PlayerAngelUpAnswer()
      {
         super(CommandCodeAngel.PLAYER_ANGEL_UP_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["angelList:array(com.sunweb.game.rpg.angel.AngelInfo)"];
      }
   }
}

