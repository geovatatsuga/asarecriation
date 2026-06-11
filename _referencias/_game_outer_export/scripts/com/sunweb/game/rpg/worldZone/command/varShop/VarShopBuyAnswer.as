package com.sunweb.game.rpg.worldZone.command.varShop
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class VarShopBuyAnswer extends obf_O_8_1034
   {
      
      public function VarShopBuyAnswer()
      {
         super(CommandCodeVarShop.VAR_SHOP_BUY_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

