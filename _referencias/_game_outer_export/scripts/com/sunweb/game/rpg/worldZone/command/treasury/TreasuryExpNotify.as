package com.sunweb.game.rpg.worldZone.command.treasury
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TreasuryExpNotify extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var exp:int;
      
      public function TreasuryExpNotify()
      {
         super(CommandCodeTreasury.TREASURY_EXP_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","exp:int"];
      }
   }
}

