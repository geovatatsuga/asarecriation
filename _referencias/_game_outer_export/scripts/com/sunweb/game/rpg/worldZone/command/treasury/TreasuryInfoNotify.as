package com.sunweb.game.rpg.worldZone.command.treasury
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   import com.sunweb.game.rpg.treasury.TreasuryDepotInfo;
   
   public class TreasuryInfoNotify extends obf_O_8_1034
   {
      
      public var depot1:TreasuryDepotInfo;
      
      public var depot2:TreasuryDepotInfo;
      
      public function TreasuryInfoNotify()
      {
         super(CommandCodeTreasury.TREASURY_INFO_NOTIFY);
      }
      
      override public function getFieldList() : Array
      {
         return ["depot1:com.sunweb.game.rpg.treasury.TreasuryDepotInfo","depot2:com.sunweb.game.rpg.treasury.TreasuryDepotInfo"];
      }
   }
}

