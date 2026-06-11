package com.sunweb.game.rpg.worldZone.command.shop
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class ShopSellItemRequest extends obf_O_8_1034
   {
      
      public var npcId:String;
      
      public var funcMenuFullIndex:Array;
      
      public var bagIndex:int;
      
      public var itemIndexList:Array;
      
      public var ssKey:int = Math.random() * 10000;
      
      public function ShopSellItemRequest()
      {
         super(CommandCodeShop.SHOP_SELL_ITEM_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["npcId:string","funcMenuFullIndex:array(byte)","bagIndex:byte","itemIndexList:array(ubyte)","ssKey:short"];
      }
      
      override public function getDigestKey() : int
      {
         return 8293;
      }
   }
}

