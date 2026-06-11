package com.sunweb.game.rpg.worldZone.command.devilGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class DevilGodUseMoneyRequest extends obf_O_8_1034
   {
      
      public var useMoney:int;
      
      public function DevilGodUseMoneyRequest()
      {
         super(CommandCodeDevilGod.DEVIL_GOD_USE_MONEY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["useMoney:int"];
      }
   }
}

