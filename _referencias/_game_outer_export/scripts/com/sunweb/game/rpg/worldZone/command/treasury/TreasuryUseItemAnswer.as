package com.sunweb.game.rpg.worldZone.command.treasury
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TreasuryUseItemAnswer extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var diceNum:int;
      
      public var index:int;
      
      public function TreasuryUseItemAnswer()
      {
         super(CommandCodeTreasury.TREASURY_USE_ITEM_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","diceNum:ubyte","index:ubyte"];
      }
   }
}

