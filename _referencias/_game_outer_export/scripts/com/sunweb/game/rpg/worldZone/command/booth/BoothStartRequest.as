package com.sunweb.game.rpg.worldZone.command.booth
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoothStartRequest extends obf_O_8_1034
   {
      
      public var boothTitle:String;
      
      public var itemList:Array;
      
      public var purchaseItemList:Array;
      
      public function BoothStartRequest()
      {
         super(CommandCodePlayerBooth.BOOTH_START_REQUEST);
      }
      
      override public function getFieldList() : Array
      {
         return ["boothTitle:string","itemList:array(com.sunweb.game.rpg.booth.BoothItemSellInfo)","purchaseItemList:array(com.sunweb.game.rpg.booth.BoothItemPurchaseInfo)"];
      }
      
      override public function getDigestKey() : int
      {
         return 64386;
      }
   }
}

