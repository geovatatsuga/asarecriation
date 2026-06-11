package com.sunweb.game.rpg.worldZone.command.baby
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class PlayerBabyFoodNotify extends obf_O_8_1034
   {
      
      public var foodValue:int;
      
      public function PlayerBabyFoodNotify()
      {
         super(CommandCodeBaby.PLAYER_BABY_FOOD_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["foodValue:ubyte"];
      }
   }
}

