package com.sunweb.game.rpg.worldZone.command.varShop
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class VarShopBuyRequest extends obf_O_8_1034
   {
      
      public var shopId:String;
      
      public var kind:int;
      
      public var itemCode:String;
      
      public function VarShopBuyRequest()
      {
         super(CommandCodeVarShop.VAR_SHOP_BUY_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["shopId:string","kind:int","itemCode:string"];
      }
   }
}

