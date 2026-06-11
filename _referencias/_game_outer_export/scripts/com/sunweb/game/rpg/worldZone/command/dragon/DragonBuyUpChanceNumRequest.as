package com.sunweb.game.rpg.worldZone.command.dragon
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class DragonBuyUpChanceNumRequest extends obf_O_8_1034
   {
      
      public var nowNum:int;
      
      public function DragonBuyUpChanceNumRequest()
      {
         super(CommandCodeDragon.PLAYER_BUY_UP_CHANCE_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["nowNum:vint"];
      }
   }
}

