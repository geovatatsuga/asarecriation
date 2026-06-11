package com.sunweb.game.rpg.worldZone.command.dragon
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class DragonBuyUpChanceNumAnswer extends obf_O_8_1034
   {
      
      public var dragonUpChanceNum:int;
      
      public var addNum:int;
      
      public function DragonBuyUpChanceNumAnswer()
      {
         super(CommandCodeDragon.PLAYER_BUY_UP_CHANCE_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["dragonUpChanceNum:vint","addNum:vint"];
      }
   }
}

