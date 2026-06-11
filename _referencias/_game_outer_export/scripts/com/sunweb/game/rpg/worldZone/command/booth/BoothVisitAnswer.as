package com.sunweb.game.rpg.worldZone.command.booth
{
   import com.sunweb.game.net.framework.codec.diy.obf_O_8_1034;
   
   public class BoothVisitAnswer extends obf_O_8_1034
   {
      
      public var boothOwnerId:String;
      
      public var isBooth:Boolean;
      
      public var boothTitle:String;
      
      public var itemList:Array;
      
      public var purchaseItemList:Array;
      
      public function BoothVisitAnswer()
      {
         super(CommandCodePlayerBooth.BOOTH_VISIT_ANSWER);
      }
      
      override public function getFieldList() : Array
      {
         return ["boothOwnerId:string","isBooth:boolean","boothTitle:string","itemList:array(com.sunweb.game.rpg.booth.BoothItemSellInfo)","purchaseItemList:array(com.sunweb.game.rpg.booth.BoothItemPurchaseInfo)"];
      }
   }
}

