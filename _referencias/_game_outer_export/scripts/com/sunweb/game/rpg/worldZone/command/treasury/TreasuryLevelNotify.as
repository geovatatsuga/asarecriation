package com.sunweb.game.rpg.worldZone.command.treasury
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TreasuryLevelNotify extends obf_O_8_1034
   {
      
      public var type:int;
      
      public var level:int;
      
      public function TreasuryLevelNotify()
      {
         super(CommandCodeTreasury.TREASURY_LEVEL_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte","level:ubyte"];
      }
   }
}

