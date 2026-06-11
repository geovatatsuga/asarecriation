package com.sunweb.game.rpg.worldZone.command.treasury
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class TreasuryUseItemRequest extends obf_O_8_1034
   {
      
      public var type:int;
      
      public function TreasuryUseItemRequest()
      {
         super(CommandCodeTreasury.TREASURY_USE_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["type:ubyte"];
      }
   }
}

