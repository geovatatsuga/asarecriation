package com.sunweb.game.rpg.worldZone.command.shop
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class obf_r_y_4532 extends obf_O_8_1034
   {
      
      public var buyItemList:Array;
      
      public var giveToPlayerId:String;
      
      public function obf_r_y_4532()
      {
         super(CommandCodeShop.VIP_SHOP_BUY_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["buyItemList:array(com.sunweb.game.rpg.shop.BuyItemInfo)","giveToPlayerId:string"];
      }
   }
}

