package com.sunweb.game.rpg.worldZone.command.shop
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ShopLeadItemInfoRequest extends obf_O_8_1034
   {
      
      public function ShopLeadItemInfoRequest()
      {
         super(CommandCodeShop.LEAD_ITEM_INFO_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return [];
      }
   }
}

