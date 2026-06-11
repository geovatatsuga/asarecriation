package com.sunweb.game.rpg.worldZone.command.devilGod
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class DevilGodUseMoneyAnswer extends obf_O_8_1034
   {
      
      public var devilGodGrow:int;
      
      public function DevilGodUseMoneyAnswer()
      {
         super(CommandCodeDevilGod.DEVIL_GOD_USE_MONEY_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["devilGodGrow:int"];
      }
   }
}

