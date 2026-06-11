package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyEatAnswer extends obf_O_8_1034
   {
      
      public var foodValue:int;
      
      public function PlayerBabyEatAnswer()
      {
         super(CommandCodeBaby.PLAYER_BABY_EAT_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["foodValue:ubyte"];
      }
   }
}

